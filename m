From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3 3/8] mingw: make failures to unlink or move raise a question
Date: Wed, 15 Dec 2010 10:09:28 +0100
Message-ID: <AANLkTi=vkkHmzmmGshn6v5E0e5mVkt0PMCkdhk=Mvn4u@mail.gmail.com>
References: <20101214220604.GA4084@sandbox> <20101214222122.GD4084@sandbox>
 <AANLkTi=cHb2kV2MaYu72nXVOksO7O9HhJLEo-fU0sV5N@mail.gmail.com>
 <alpine.DEB.1.00.1012150109340.1461@bonsai2> <7v1v5jrb1f.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Heiko Voigt <hvoigt@hvoigt.net>, Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Albert Dvornik <dvornik+git@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 10:09:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSnN1-0003kd-Cy
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 10:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756Ab0LOJJx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 04:09:53 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:50913 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab0LOJJv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Dec 2010 04:09:51 -0500
Received: by fxm18 with SMTP id 18so1768725fxm.2
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 01:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=zSD6cwSQqgosN/HmNvvAUDVVYjUR1Uor1kvb1rcxFsY=;
        b=X+h7xjmaAV7K7MjMqnKn/8BsZ1CcPtqIdOqNWZIuz2x5nczgz0N9eZFemSHDvESwTM
         ChPiSJu1z4twCbfQWyyYRsgOUNYCi92qwotIEaVAIBPpPJnuET0KYnZElRzsklwWBNPa
         CiJf3K6lunlCdH5Ggd1tK5cv4rDJ8B3+k0wSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=DnuDnv2Pfi9kKP/EtpoiuwyHeG7NAs8gsImD5jBtBK6fGWw6BF1hNmQaWF+lr2PS7/
         SCzO2Ti9+pSm+d8UM/LJWiGTuAol8w99HgLh59X2w/I2Vf8nrW7Ghq0ybnDw/UNVjtlw
         teCGqD3WBuVVUAMiJP/g8LfPSc/rdaeq4CQtc=
Received: by 10.223.73.199 with SMTP id r7mr7201859faj.76.1292404189999; Wed,
 15 Dec 2010 01:09:49 -0800 (PST)
Received: by 10.223.96.71 with HTTP; Wed, 15 Dec 2010 01:09:28 -0800 (PST)
In-Reply-To: <7v1v5jrb1f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163747>

On Wed, Dec 15, 2010 at 4:05 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> > @@ -129,6 +130,78 @@ static inline int is_file_in_use_error(DWORD=
 errcode)
>>> > =A0 =A0 =A0 =A0return 0;
>>> > =A0}
>>> >
>>> > +static int read_yes_no_answer()
>>>
>>> Perhaps "static int read_yes_no_answer(void)" for portability?
>>
>> LOL. This file is called compat/mingw.c... :-)
>
> I had the same reaction. =A0Maybe MinGW will get a different compiler
> someday ;-)
>

We already have; compat/msvc.c includes compat/mingw.c. mingw.c is
called mingw.c because it was the first native windows port, not
because it will always be compiled with MinGW. So this file is REALLY
more about the OS than the compiler.

I don't think MSVC has a problem with this declaration either, but
wouldn't it be nicer if we had Windows-code that was as portable as
possible across compilers? I've also been playing around with the idea
of using LLVM's clang for Git on Windows, because it's support for
cross compiling between 32bit and 64bit is a bit less nasty than
MinGW's. This might never come happen, and I don't know if clang
supports this or not. And then there's Intel's ICC that some times
outperforms GCC. I don't think it would hurt fixing it in case people
will port - one less trip-wire in the code.

But I of course only suggest this because this is new code. It's easy
to change it to be slightly more portable (and more consistent with
the rest of the code base), so why not?
