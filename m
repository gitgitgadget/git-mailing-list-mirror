From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 2/2] version-gen: fix versions
Date: Sun, 13 Oct 2013 21:42:22 -0500
Message-ID: <CAMP44s2o5O=zKBef5Jn486yYkYYvuLSZRQokZAUQVN+EE=3+3Q@mail.gmail.com>
References: <1381561628-20665-1-git-send-email-felipe.contreras@gmail.com>
	<1381561628-20665-3-git-send-email-felipe.contreras@gmail.com>
	<CAJDDKr5K0UjcbhUpAjHjGcEk6=E2+cAVC8-RpxY+C1atSVj-Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 04:42:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVY79-0000dS-II
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 04:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755811Ab3JNCm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 22:42:26 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:62445 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755691Ab3JNCmY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 22:42:24 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so5055273lbh.23
        for <git@vger.kernel.org>; Sun, 13 Oct 2013 19:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HEXBNA1qfpVskfl19zM+j1frt/tQcpQY2gM8HlniHj8=;
        b=DXZv+onAYD17mU0ya1eK4DpcC0Q/zEKm0jJkhIhoWGQl6hzHH7wr+h4U7ym8l4/KUc
         IQDjo+zx2Y7IWihHyX9egeYDXOgOZRRlvPgPSFfUDKhP3Og/7HAos2NVWoM+GJ0Vv2hJ
         Bja2LPq1H9kEmKV2b3aMJpSh6YgYjWHmXSx1E8/+WtPbyZ4DpYR45nEItdLOP9Y5/Yi+
         5TMVoyXKn+x5enw5nSWQ+CwrFTSKGNZqmbgI34SZCPycYSYLj6dyZlowZpiaQD2mgLXR
         /pPRR05EjAn52QnfaPwVJSxwlHBEUUBAdmmHBGEo7MR51gTHGyAA/ILSwA8Sf3mIkuFm
         o3lA==
X-Received: by 10.152.22.198 with SMTP id g6mr28301540laf.5.1381718542670;
 Sun, 13 Oct 2013 19:42:22 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sun, 13 Oct 2013 19:42:22 -0700 (PDT)
In-Reply-To: <CAJDDKr5K0UjcbhUpAjHjGcEk6=E2+cAVC8-RpxY+C1atSVj-Tg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236090>

On Sun, Oct 13, 2013 at 4:56 PM, David Aguilar <davvid@gmail.com> wrote:
> On Sat, Oct 12, 2013 at 12:07 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Virtually all packaging guidelines would prefer 1.8.4~rc1, over
>> 1.8.4.rc1 or 1.8.4-rc1, so it makes sense to use that instead.
>>
>> In particular, the only packaging we provide, git.spec, generates a
>> wrong version, because git-1.8.4 < git-1.8.4.rc1, changing to ~rc1 fixes
>> the problem as it's considered newer.
>>
>> The same happens in dpkg.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  GIT-VERSION-GEN | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
>> index e96538d..c04c4de 100755
>> --- a/GIT-VERSION-GEN
>> +++ b/GIT-VERSION-GEN
>> @@ -28,7 +28,7 @@ then
>>         VN=$(cat version) || VN="$DEF_VER"
>>  elif test -d ${GIT_DIR:-.git} -o -f .git && describe
>>  then
>> -       VN=$(echo "$VN" | sed -e 's/-/./g')
>> +       VN=$(echo "$VN" | sed -e 's/-/~/g')
>>  else
>>         VN="$DEF_VER"
>>  fi
>> --
>
> This seems related:
>
> http://lintian.debian.org/tags/rc-version-greater-than-expected-version.html
>
> Should the RC tags in the Git repo be named v1.2.3~rc4 (tilde-rc#)
> instead of dash-rc#, or does that not matter?

I thought so first, but then I realized ~ is not allowed in a ref.

> If so, would that change anything about this patch, or is it better to
> normalize it all here?
>
> The input is subtly different sometimes so I'm curious whether whether
> "~" is preferred in all cases (particularly, by all package managers).
>  e.g.

All package managers I investigated do handle ~ specially, and thus
recommend it for rc versioning, except pacman. So in pacman,
v1.5.0~rc4 would remain newer than v1.5.0, but that's not different
from the current situation, and there isn't much we can do about that.

> $ git describe v1.5.0^
> v1.5.0-rc4-372-g26cfcfb
>
> $ git describe v1.5.0.1^
> v1.5.0-27-g38eb932

At least both in RPM and dpkg, 1.5.0~27 is newer than 1.5.0~rc4.

-- 
Felipe Contreras
