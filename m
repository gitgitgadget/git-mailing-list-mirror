From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 17/21] bisect: rename count_distance() to compute_weight()
Date: Wed, 13 Apr 2016 15:32:22 +0200
Message-ID: <CAP8UFD2s_Wm76HSrZmK9OcKbU6-2GcCo-REbTAXMfSy_E9cpbA@mail.gmail.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-18-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Apr 13 15:32:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKuC-0005VN-Qq
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758203AbcDMNcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 09:32:25 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36022 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756423AbcDMNcY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:32:24 -0400
Received: by mail-wm0-f43.google.com with SMTP id v188so174974695wme.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=gFnZdo+D2NGPzM/K99vp8GFSb8qFpRWvKnUVFaOioHw=;
        b=m9zMZaLd51toGD9ygpL3h2xvUWi2JWyUV0ohgFa7E46EGG+RrixglNzivQs2SywFKD
         MJHwdEcOR38pGmI5V+ZR+DnVrqT+wkwIlLEf8TRdP2vM0kI1NOL0TSY+6ImQfbrdZTE3
         1GsUVeMYAyapS9HOSPIAOf3UWoDA4SFipq9Aq1HEkRJV+ORGyY9vHxc3Nh/ebdTDqtXY
         bS1ppj4f2pziyBdF6aBvVN1t8K58ioO/B6L7+48woXwPnDH5ayehalEcGGRecnUL7F5h
         E6aMPL3VC2VMqAVFreeOCWXp289uqUQBsafJ9SqV21/HYZwrfyAl56T28gRTLEsTSV9v
         FJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=gFnZdo+D2NGPzM/K99vp8GFSb8qFpRWvKnUVFaOioHw=;
        b=ZonT3JD4EXAj3BYw9yvvMnVNc/EOPnwnG3l1fbPiJgJ9S/MnqQBWhDBCMJKd8RSGnB
         T90jAruYZw0WxVau+L49+qdHjCpnu53OtW2DcHITj7XG00dcmmHlECrKgQu3Bjcsn6nA
         tz9mRbnPDpCMphG8tcONOpawmdMoAGBPOC1KYnuEnVBMn228BjvXXjcknIjA+NafapJv
         Q2pBjXjqZYA0hcBWBg6/sR1lp+Y13zW0EQYLGp3KKMq8/Z0qweuLvaBqu6I6/weAVYeY
         BOJwj6KhZMdwfpd/Bou5dqntbNFLSwH5EEe1Q4Qn1DPhrSINsyvbQ9wDXG6AqeuypQ6n
         TM3w==
X-Gm-Message-State: AOPr4FW/vjfgNziAbiX6bC979VE+9t265PmBKPtIlFo/0aBHR9kd5ZIKzaReEa86mLhvUtl8AETAx19qynToww==
X-Received: by 10.28.26.73 with SMTP id a70mr10827424wma.89.1460554342605;
 Wed, 13 Apr 2016 06:32:22 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Wed, 13 Apr 2016 06:32:22 -0700 (PDT)
In-Reply-To: <1460294354-7031-18-git-send-email-s-beyer@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291449>

On Sun, Apr 10, 2016 at 3:19 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
>
> @@ -70,7 +70,7 @@ static inline int distance_direction(struct commit *commit)
>         return 0;
>  }
>
> -static int count_distance(struct commit *elem)
> +static int compute_weight(struct commit *elem)
>  {
>         int nr = 0;
>         struct commit_list *todo = NULL;
> @@ -93,6 +93,7 @@ static int count_distance(struct commit *elem)
>                 }
>         }
>
> +       node_data(elem)->weight = nr;
>         return nr;
>  }

As the return value is not used below, I am not sure it is still worth
it to return the weight.

> @@ -241,7 +242,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list)
>   * be computed.
>   *
>   * weight = -2 means it has more than one parent and its distance is
> - * unknown.  After running count_distance() first, they will get zero
> + * unknown.  After running compute_weight() first, they will get zero
>   * or positive distance.
>   */
>  static struct commit_list *do_find_bisection(struct commit_list *list,
> @@ -286,7 +287,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>          * If you have only one parent in the resulting set
>          * then you can reach one commit more than that parent
>          * can reach.  So we do not have to run the expensive
> -        * count_distance() for single strand of pearls.
> +        * compute_weight() for single strand of pearls.
>          *
>          * However, if you have more than one parent, you cannot
>          * just add their distance and one for yourself, since
> @@ -299,7 +300,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
>         for (p = list; p; p = p->next) {
>                 if (!(p->item->object.flags & UNINTERESTING)
>                  && (node_data(p->item)->weight == -2)) {
> -                       node_data(p->item)->weight = count_distance(p->item);
> +                       compute_weight(p->item);
>
>                         /* Does it happen to be at exactly half-way? */
>                         if (!find_all && halfway(p->item))
