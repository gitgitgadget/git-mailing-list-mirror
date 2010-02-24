From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv4 6/6] is_submodule_modified(): clear environment properly
Date: Wed, 24 Feb 2010 11:07:01 +0100
Message-ID: <cb7bb73a1002240207u39176830scfa773b3e7d5c56@mail.gmail.com>
References: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<1266996196-25978-7-git-send-email-giuseppe.bilotta@gmail.com> 
	<4B84DDE9.8000301@viscovery.net> <cb7bb73a1002240055v58953dcfh3be7c4589523b14b@mail.gmail.com> 
	<4B84EEF2.2030502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 24 11:07:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkE9T-0007sj-Ma
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 11:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756411Ab0BXKHZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 05:07:25 -0500
Received: from mail-ew0-f212.google.com ([209.85.219.212]:49176 "EHLO
	mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756415Ab0BXKHW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 05:07:22 -0500
Received: by ewy4 with SMTP id 4so764147ewy.28
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 02:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=aTAp8StnnRxON6E8I7BAl+57JOurBkV1imLWbWmmRfs=;
        b=tJTS9qN6gMBCULLxSt81uQzdH+kpiYvZ//sq9AgmveJ6e+p1pChGrB3221ofBv5PjW
         hiR388Xsh+aG4vxigytVCAQ6z8It9jn2rFxZsschRpcJpNwwfGdfXe9yaYatCSkifmDj
         yIZAk30e6Tyx8eS0WjHfkRp7hHGZSZ3q4TgtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gyZOdl3O1UYqvUow7vKd6lY5jLpQsn+sRSf041c5sQF/vb6K8FpjkRb2kIjWm7QBp4
         KS7FX6UJA+FWS4wwLLel2hPJAf4zjLbmlDK4wWanC2nNOdT5maRh9r8KPd+wbWWnNoNm
         mH2Tms40tpAKfNFph/jaI4q8FM1Mv86fuPd4E=
Received: by 10.213.50.140 with SMTP id z12mr4785351ebf.89.1267006041122; Wed, 
	24 Feb 2010 02:07:21 -0800 (PST)
In-Reply-To: <4B84EEF2.2030502@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140923>

On Wed, Feb 24, 2010 at 10:18 AM, Johannes Sixt <j.sixt@viscovery.net> =
wrote:
> Giuseppe Bilotta schrieb:
>> On Wed, Feb 24, 2010 at 9:06 AM, Johannes Sixt <j.sixt@viscovery.net=
> wrote:
>>> Giuseppe Bilotta schrieb:
>>>> + =A0 =A0 const char *env[local_repo_env_size+2];
>>> Variable sized arrays are prohibited.
>>
>> Ah, sorry. Is alloca() allowed? I don't see it being used anywhere
>> else in the code, and malloc would be a little too much for this cas=
e.
>
> in cache.h:
>
> #define LOCAL_REPO_ENV_CAPACITY 20
> const char *const l_r_e[];
>
> in environtment.c:
>
> const char *const l_r_e[LOCAL_REPO_ENV_CAPACITY] =3D { ..., NULL };

What I don't like about this approach is that (1) it allocates more
memory than necessary and (2) it requires recompiling everything if
LOCAL_REPO_ENV_CAPACITY changes (since it's defined in cache.h which
is included basically everywhere. Admittedly (2) is _very_ unlikely to
happen if the #define is set large enough, but still ...

> and the compiler will croak if the constant becomes too small. (Oh, I
> know, you must use the 'inconsistent mode' that I nit-picked if you u=
se
> this approach.)

(BTW, that approach requires slightly less index juggling and less C
code than a indexed for loop, so I kept it anyway, with a slightly
more expanded comment).


--=20
Giuseppe "Oblomov" Bilotta
