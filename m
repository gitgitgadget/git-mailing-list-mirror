From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v8 3/3] bisect--helper: `write_terms` shell function in C
Date: Wed, 25 May 2016 00:01:29 +0530
Message-ID: <CAFZEwPMiNNB5CKOYWmHGR=sU8i1t9qb+-RTSrcNVkVZW14UMFg@mail.gmail.com>
References: <1464014928-31548-1-git-send-email-pranit.bauva@gmail.com>
	<20160524072124.2945-1-pranit.bauva@gmail.com>
	<20160524072124.2945-4-pranit.bauva@gmail.com>
	<CAP8UFD1WZ=5e9u5awrHDG-vhMR5dw5NNY_yVEkp2o0rgx59nnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 24 20:31:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5H78-0007se-QF
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 20:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbcEXSba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 14:31:30 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36725 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbcEXSba (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 14:31:30 -0400
Received: by mail-yw0-f196.google.com with SMTP id l126so3450486ywe.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 11:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=o32MtXJgiPn/9e0juodRJ3NBSFx8NOcH5b73SqAuVBk=;
        b=Q4Egjfx4aKHMvDmsWHVDWnEpQ6MfhFMXjn/Nil3L9+ymVHHWO0ODJ8SwzyDFy0FYOa
         ZMD6DKoBTDrgV2NwC2AFUZsJ137bYrSY0xY7k1jEgMtqqYoUvvWC1TkWF8rM+tRV7acW
         W6Zx3tT5VTIG3G65WfdsFRgh18Q+HdbVhADiG3afoVRfKXY+eJXUzkEMeGzMpYWx2ee1
         SUUe9r3Jj92PkyO7fz9cViUGQvikmaVBZHp+gWStKgAKYmgkXXnEAH9UnLRvRj6FkGyq
         KdSlViFEOtGwU23OcnPl1DFQ5fArqGap51/9qZnFGy3ZlonE1W9m5GDID7WVdV3D6O05
         KtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=o32MtXJgiPn/9e0juodRJ3NBSFx8NOcH5b73SqAuVBk=;
        b=NaLP1AMHUzJY/P34yZDlPTtc+je4TsBcEUIIhRTJtx6TkwpzkSIcwjwP8kO1mjx9ho
         6u0uOiLE+tEJezqGAS/rX+mLSpQEsf+0eJpX5fl14NhBhCgZQx0hDibSVQVNq2P4nM9p
         gnbkzgnkmQ/cuRfyBbqlxxYAHXNRuwVjOOZuPXmQt/HpbqCnI3egwnYYpUMH6sYS1oiU
         bTyccjoqJp/uKgufxan+iD0RuFTgMEkdltZw+dzCXUEWBVuXze13X0Ho5fE3x9Uape5n
         ScZyocsU9ybZjJCOeo3uzUes75pMpSMh1VPI7cbPdv4VYlxrNg8Wx74n+kUWkBQs+4r7
         K/YA==
X-Gm-Message-State: ALyK8tLvWFTe8cnOVb7LvAR++DZY/Ka89HPO7D3IfMyzPOpsRew/C11oYaObFm0D0ofLz0K/yJ5rM1AMTzWybg==
X-Received: by 10.129.90.135 with SMTP id o129mr3802717ywb.20.1464114689223;
 Tue, 24 May 2016 11:31:29 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Tue, 24 May 2016 11:31:29 -0700 (PDT)
In-Reply-To: <CAP8UFD1WZ=5e9u5awrHDG-vhMR5dw5NNY_yVEkp2o0rgx59nnQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295514>

Hey Christian,

On Tue, May 24, 2016 at 1:03 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, May 24, 2016 at 9:21 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> diff --git a/git-bisect.sh b/git-bisect.sh
>> index 7d7965d..cd39bd0 100755
>> --- a/git-bisect.sh
>> +++ b/git-bisect.sh
>> @@ -210,7 +210,7 @@ bisect_start() {
>>         eval "$eval true" &&
>>         if test $must_write_terms -eq 1
>>         then
>> -               write_terms "$TERM_BAD" "$TERM_GOOD"
>> +               git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD" || exit
>
> This `|| exit` is not needed because...
>
>>         fi &&
>>         echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
>
> ... there is an `|| exit` on the line above (which is chained using
> `&&` to the previous lines).

Nice notice. I will send a re-roll

Regards,
Pranit Bauva
