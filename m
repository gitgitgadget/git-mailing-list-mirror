From: =?UTF-8?B?cnllbnVzIOKXhw==?= <ryenus@gmail.com>
Subject: Re: [PATCH] repack: find -> /usr/bin/find, as for cygwin
Date: Sun, 20 Mar 2011 08:31:38 +0800
Message-ID: <AANLkTinPCeg3NU2bRvk8rwWSWnu4b0PHwya9+PWAc3DB@mail.gmail.com>
References: <AANLkTimHof_MNSGbU2KGX=7Q3MQpjkzXK+xyGGVjbngR@mail.gmail.com>
 <AANLkTimPbz2s=Maafhqg-7wOk_TT4fFSh7AQ-3rWY0A3@mail.gmail.com>
 <AANLkTinxyp=PbvzRkyyxXin5aOFm1NP4Be6U2Dv0aD6d@mail.gmail.com> <7vsjujq8kf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 01:32:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q16Yu-0008LR-CI
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 01:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab1CTAcA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 20:32:00 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:45753 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab1CTAb7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 20:31:59 -0400
Received: by yia27 with SMTP id 27so2006506yia.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 17:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=96odGact8qZ219F/JSI7goqROzKslGzvyxYHO8hRqmU=;
        b=iBXdF5ZF1yLQ+9m6ZGDtIM4a7+M9FmjIqtul7YuOiUmPT3EPyp413zsvXFFBf+/Wlg
         kmzAz+wv4J6wtLidRkCZyFq19X1cRVA5uhUO31VutyauOzsCYLrO0ith2btZox0fZYFe
         OIxpeUU4gFXC9EVN2W9c5yFvU41Da7ZCltP98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BlU4t4JsVwKjpAA5lH0sEGxPSi1GzF7/exg7jX4G8anwhZ0u/JVjClM7NOAuXZF6Wq
         6q63XeBircucxLjhJ+mAMRCb4r7yigp8g07/XnMEtpyc8Z4mCDspI/i8XR6tM9BEIi3i
         ex5H3lTkns6wn9oTRqew2jjFjP5jGPHQpDunQ=
Received: by 10.101.116.19 with SMTP id t19mr1858693anm.161.1300581118209;
 Sat, 19 Mar 2011 17:31:58 -0700 (PDT)
Received: by 10.100.121.3 with HTTP; Sat, 19 Mar 2011 17:31:38 -0700 (PDT)
In-Reply-To: <7vsjujq8kf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169479>

I'm not sure if there's a set of tests for Cygwin/MinGW among all the
test cases in GIT, here is a simple one:

#!/bin/sh
echo $(uname -s)
case $(uname -s) in
*MINGW*|*CYGWIN*)
  echo "detected MinGW/Cygwin"
  ;;
*MinGW*)
  echo "detected MinGW"
  ;;
*Cygwin*)
  echo "detected Cygwin"
  ;;
esac

Run with dash, the output is

CYGWIN_NT-6.1
detected MinGW/Cygwin

While I don't have MinGW, so someone has it please give it a shot.

Thanks

2011/3/20 Junio C Hamano <gitster@pobox.com>:
> ryenus =E2=97=87 <ryenus@gmail.com> writes:
>
>> Thank you, Duy, you're almost right, I just checked git-sh-setup.sh,
>> in the bottom, sort and find are defined as functions like what you
>> pointed out, but only for MinGW, therefore a better fix is to check
>> for cygwin as well:
>>
>> ---
>> =C2=A0git-sh-setup.sh | =C2=A0 =C2=A02 +-
>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
>> index aa16b83..5c52ae4 100644
>> --- a/git-sh-setup.sh
>> +++ b/git-sh-setup.sh
>> @@ -227,7 +227,7 @@ fi
>>
>> =C2=A0# Fix some commands on Windows
>> =C2=A0case $(uname -s) in
>> -*MINGW*)
>> +*MINGW*|*CYGWIN*)
>
> This looks like a more sensible alternative than forbidding the use o=
f
> "find", privided if the new pattern is an appropriate one to catch cy=
gwin.
>
> I don't have any Windows boxes, so I cannot verify, but the patch sme=
lls
> correct.
>
>
>
