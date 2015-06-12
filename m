From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Fix power checking on OS X
Date: Thu, 11 Jun 2015 23:46:42 -0400
Message-ID: <CAPig+cRzKpCePO0gXy7Rok4X7=r6tas28tv48g92YzP9tVP2AA@mail.gmail.com>
References: <1434033445-35903-1-git-send-email-pastith@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, vmiklos@frugalware.org,
	jon.delStrother@bestbefore.tv, Jonathan Nieder <jrnieder@gmail.com>
To: Panagiotis Astithas <pastith@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 05:46:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3Fvc-0001HL-Gj
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 05:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbbFLDqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 23:46:44 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:34099 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbbFLDqn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 23:46:43 -0400
Received: by ykfl8 with SMTP id l8so11790262ykf.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 20:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=kvQ3lijo6F5LgfX+/zAsktp2hiFQ1Xj9ScpuqF6W9YM=;
        b=O7dyYOiRQyfPuw+5BxeivKUsu7bMjioTZVKI0UXEaNDaLuElM8F5HeIslq60FETyQt
         Sx5XU/sooTtQxvcOh8FfdVepuTM0QetjbNDpCMX1FF7vyWlMC9d9Looq0OrHdtREL3gw
         c5Pi8/cdpHYcd0Y4tWFg6/fyOduyzTBuv9Tr+VpfGe9dq+b/qNaBEBxGQ52+h51aY7hQ
         sRhzSrhkJYiHBhcbhqwYYsjiPjv+DFW/cxPhCqD4Csp7t+Qliy0YZVXEjg11vldd0+Z9
         hXww8VC2A+y96FhiDwL/skbtAcyasm8rZtPV7nBNgvUxbHXtvhW9+dnIvnphL5D1DZhL
         2wVQ==
X-Received: by 10.13.219.198 with SMTP id d189mr15887946ywe.163.1434080802889;
 Thu, 11 Jun 2015 20:46:42 -0700 (PDT)
Received: by 10.37.36.214 with HTTP; Thu, 11 Jun 2015 20:46:42 -0700 (PDT)
In-Reply-To: <1434033445-35903-1-git-send-email-pastith@gmail.com>
X-Google-Sender-Auth: juTaSFu0lgqpwX7qIIKpI8HszWk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271468>

On Thu, Jun 11, 2015 at 10:37 AM, Panagiotis Astithas <pastith@gmail.com> wrote:
> The output of "pmset -g batt" changed at some point from
> "Currently drawing from 'AC Power'" to the slightly different
> "Now drawing from 'AC Power'". Starting the match from "drawing"
> makes the check work in both old and new versions of OS X.

Would it make sense to try to future-proof this further by searching
only for "'AC" (including the leading single-quote) or just "AC"
(without the leading quote)?

(Genuine question. I don't have a strong feeling about it.)

> Signed-off-by: Panagiotis Astithas <pastith@gmail.com>
> ---
> diff --git a/contrib/hooks/pre-auto-gc-battery b/contrib/hooks/pre-auto-gc-battery
> index 9d0c2d1..6a2cdeb 100755
> --- a/contrib/hooks/pre-auto-gc-battery
> +++ b/contrib/hooks/pre-auto-gc-battery
> @@ -33,7 +33,7 @@ elif grep -q "AC Power \+: 1" /proc/pmu/info 2>/dev/null
>  then
>         exit 0
>  elif test -x /usr/bin/pmset && /usr/bin/pmset -g batt |
> -       grep -q "Currently drawing from 'AC Power'"
> +       grep -q "drawing from 'AC Power'"
>  then
>         exit 0
>  fi
> --
> 2.4.1
