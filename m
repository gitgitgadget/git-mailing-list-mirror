Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F737C433F5
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 10:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhLRKMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Dec 2021 05:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhLRKMY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Dec 2021 05:12:24 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09CBC061574
        for <git@vger.kernel.org>; Sat, 18 Dec 2021 02:12:23 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bt1so9775029lfb.13
        for <git@vger.kernel.org>; Sat, 18 Dec 2021 02:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d+ZB7r7E6rOZFm87WlY9/9cx6W5Mqy2PpAicuixb+Bw=;
        b=Rt+lS9Xws+upHiMlaP43NuYe1Dnvh0BzDY7NiS6zw4WFzuFvcf0v3pOlVD5X+9phUt
         7lMHnKxtt9FhxBt4bm25+ZYKPpjpqu9JjOYAmKcvDqThjY9+z0LL1M+lQqER16oZKY2/
         JvPtllkGbYXIpmwOIJpc7Vp0bmzpxhjJ3gPtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+ZB7r7E6rOZFm87WlY9/9cx6W5Mqy2PpAicuixb+Bw=;
        b=UpQsbwpWL1UyY7i7Jfpi646tUnUwuL846svXuqi0afwleoAJ5xxwQwIAcmKTSIV6R2
         FF9Ygn0Tet9a5zTu39icxsgCXHXMy+6bWJXKKG75peaNBMnunvYeLuI8q23eu6cz1/oH
         RmNir4cybWeOWsJno4MNX9WL8qWWqji8GYwpzWUYilZJxuOcuOM7FVtQmj7m0QABq+pK
         IfBVRXiBLrTT2JA1XOmrDis2D1yKrD9D76eYtE+HXzEOWjXs3ysL3M0PmbQ6Nj0n1TvA
         7D8HHxPXkjZc5XgGfrbj+6IpCO5lPsjQ96iB3VjVgwiSqGvoUoP19VgfwfywTR+fog/G
         /6jg==
X-Gm-Message-State: AOAM533saeA7E5ZoUoBfFLB9NFKlh1Otvk1uTOqYT/ybhgw36cNsjoKu
        T88gXY3uzrqA6YUPNQCiDe7roK5QF+MJuA86bqEOIQ==
X-Google-Smtp-Source: ABdhPJzzZ4GnIKGuGU1Z2DVratsUTz1sfq7JMJ/xKuMMl6E6Eyx44fGGD+Nzx+M8VsYaEM2dd+u01955IvcRvobx4eQ=
X-Received: by 2002:a19:e046:: with SMTP id g6mr6444495lfj.176.1639822342019;
 Sat, 18 Dec 2021 02:12:22 -0800 (PST)
MIME-Version: 1.0
References: <20211217203856.2339161-1-jholdsworth@nvidia.com> <20211217203856.2339161-3-jholdsworth@nvidia.com>
In-Reply-To: <20211217203856.2339161-3-jholdsworth@nvidia.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sat, 18 Dec 2021 10:12:11 +0000
Message-ID: <CAE5ih7_uq2xos46tH_dR+gietA_5bhr3JzYNJOLmrjhuijy1Ng@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] git-p4: show progress as an integer
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     Git Users <git@vger.kernel.org>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 17 Dec 2021 at 20:39, Joel Holdsworth <jholdsworth@nvidia.com> wrote:
>
> When importing files from Perforce, git-p4 periodically logs the
> progress of file transfers as a percentage. However, the value is
> printed as a float with an excessive number of decimal places.
>
> For example a typical update might contain the following message:
>
> Importing revision 12345 (26.199617677553135%)
>
> This patch simply rounds the value down to the nearest integer
> percentage value, greatly improving readability.
>
> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
> ---
>  git-p4.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 4d8a249b85..3c621a6efd 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -3635,7 +3635,8 @@ def importChanges(self, changes, origin_revision=0):
>              self.updateOptionDict(description)
>
>              if not self.silent:
> -                sys.stdout.write("\rImporting revision %s (%s%%)" % (change, cnt * 100 / len(changes)))
> +                sys.stdout.write("\rImporting revision %s (%d%%)" % (
> +                    change, (cnt * 100) // len(changes)))
>                  sys.stdout.flush()
>              cnt = cnt + 1

Thanks for fixing this - this is one of those small python2->python3
bugs that's still left over.

Looks good to me, ack.

Luke
