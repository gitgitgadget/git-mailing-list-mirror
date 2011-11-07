From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/3] apply: get rid of useless x < 0 comparison on a
 size_t type
Date: Mon, 7 Nov 2011 20:09:23 +0100
Message-ID: <CAOxFTcxyOK=0rCeZtwQ5DOWu=T-h0qFo155+an+mYNCgWeyP8Q@mail.gmail.com>
References: <1320581184-4557-1-git-send-email-avarab@gmail.com>
 <1320581184-4557-2-git-send-email-avarab@gmail.com> <7vsjm15cap.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org, Jim Meyering <jim@meyering.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 20:09:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNUZr-0004KT-BN
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 20:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968Ab1KGTJq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 14:09:46 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53549 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888Ab1KGTJp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 14:09:45 -0500
Received: by iage36 with SMTP id e36so6171249iag.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 11:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=V45QsCno5zwAWkFVwJO8pCoWPHSfXkrw3mRUlJYGT0c=;
        b=OEZ9T1+q6nDFBEkIBicF1fnfHmRbezqPnB/xVnyMr+nocnlCsXQ7VfckWG5/usePTG
         6B7JWvKst+HbWqb7WmrjyJM6Mz8pgVq7EDdcgpsNrLPDylhfvsmWxx8kd4qqXNSQjOLE
         kfnitId3GduU6Yf2R7m2qpFz7Q7gtSY0YNm7A=
Received: by 10.231.3.225 with SMTP id 33mr11260888ibo.87.1320692985106; Mon,
 07 Nov 2011 11:09:45 -0800 (PST)
Received: by 10.231.17.13 with HTTP; Mon, 7 Nov 2011 11:09:23 -0800 (PST)
In-Reply-To: <7vsjm15cap.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185017>

On Sun, Nov 6, 2011 at 7:35 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> =C6var Arnfj=F6r=F0 Bjarmason =A0<avarab@gmail.com> writes:
>>
>> This check was originally added in v1.6.5-rc0~53^2 by Giuseppe Bilot=
ta
>> while adding an option to git-apply to ignore whitespace differences=
=2E
>
> I agree that these quantities can never be negative, so I'll apply th=
e
> patch as is.

I agree too. In fact I spotted this some time ago when I started
compiling git with Clang but never found the time to look into it.

> But I have this suspicion that this was a rather sloppy defensive che=
ck to
> protect this codepath against potential breakage in another codepath =
(most
> likely update_pre_post_images() touched by the same patch) that adjus=
ts
> image->line[].len the caller of this function uses to feed these two
> parameters. Giuseppe may have been not confident enough that the code
> added to that function ensures not to undershoot when it reduces "len=
", or
> something.
>
> Giuseppe, can you explain what is going on?

No, I can't, so I guess the sloppy coding is the right motivation. I
remember working this patch from a rather older submission that was
never followed-up to, so my guess is that I just forgot to clean it up
properly, and during review the focus was obviously on other aspects
of the submission too. Also, having a look at the current caller of
the function, I don't see how the check would even be needed.

--=20
Giuseppe "Oblomov" Bilotta
