Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4433CC4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 14:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23C923899
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 14:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYGXuHxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgI0O0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 10:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0O03 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 10:26:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63663C0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 07:26:29 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b79so4006523wmb.4
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 07:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=yb0b8FwSwNvCKYOTEG19u2+yeeNAcVhxmFb93YRc/Q4=;
        b=pYGXuHxtfquW/3Jo9is54dNQ4WVaqBmNfs9YrdTVPGt1SWO8cOq7C6NKr7Q5rPcfrS
         1XI5xFLdja1Z2LUDb7FSugQ7yqOVZsD58AuAtNrzEHZ719Pj8j0CGb/rQnxFE1KgjoVX
         1HDvX159fq52mC9kLmLHfR6IrZ1BveEVWsl66cPlUv18qYjMykG2pzSy11X3ECOxy6GH
         5XVY1E7KwSo79J0viwCWY+Y/bFnsr3BWfUgq0QVqKw+NsijQTLv72NQer3yfuacTHrZ6
         +6nnmLx4i2NUE+c6pYwYxuiV6HOQ6JSVVBgWYJFlXylK4izZzGZ1mExN9QeNYw3Alf1Y
         N+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yb0b8FwSwNvCKYOTEG19u2+yeeNAcVhxmFb93YRc/Q4=;
        b=Fc38/FaxG/Agidm0eZqcZLgD/dv43Jj8uDLL3m6BcXZqutcgpSl8rEAH7q+Jp9G2GH
         FhUNaxc2kY73GGFX1J8H0i58D5OTu0JgJMK24JulXBeY+pgy2Z6SzZGnIz+A1N0JINhV
         t5xn2VFo8z+/qHrLVvvb0aEzEyXpDEVghy9lgvlpCIbyP6DE0+q/uRndxmBd5kCKU1zB
         J6l/EZSpOiUCGzh5hGkOeylAiPSn1hZXzahiqqoZtpETre0wB0CtsgmznrTVGnnPCcUR
         lpeDjlszUIhpr9VxWM3qtTiebzLCqz4hQjSoF7HBiQ2G2eqlWNiMS8KadD+iNFizv2JH
         75sw==
X-Gm-Message-State: AOAM5309UOJZNg+2IjMmNYM7voOwLjrg90X9/AlMLJS/4ia98VImegcw
        xFd2WzAMrF+TCagtKU63DfEogtgM6r0gp+ppdh4ztuKSoFE=
X-Google-Smtp-Source: ABdhPJyd4/12xzJHacOzgUAiLiJVlTvxmnie1TR/0mU85HOTV0e7Xa4r4Qdb3h0YM5cav7S38oAdv6QU2Wx+N9fimLM=
X-Received: by 2002:a1c:b388:: with SMTP id c130mr7231299wmf.175.1601216786547;
 Sun, 27 Sep 2020 07:26:26 -0700 (PDT)
MIME-Version: 1.0
From:   Matthew Timothy Kennerly <mtkennerly@gmail.com>
Date:   Sun, 27 Sep 2020 10:26:16 -0400
Message-ID: <CAKqNo6RJqp94uLMf8Biuo=ZvMZB9Mq6RRMrUgsLW4u1ks+mnOA@mail.gmail.com>
Subject: Differences in compound tag sorting between 2.27.0 and 2.21.0
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I've run into a difference in the results for a compound tag sort
between 2.21.0 and 2.27.0 (I believe also applies to 2.28.0), and I'm
not sure if it's an intentional difference or if there's still some
way to achieve the old behavior with newer Git versions. For
reference, I'm using Windows.

I need to sort tags first by the date of the pointed commit, then by
the date of the tag creation when available (I understand that
lightweight tags don't store their creation date, so multiple
lightweight tags on a single commit may not sort consistently). Let me
give a concrete example.

Given a repository with this setup, using annotated tags:


git init
echo hi > foo.txt
git add .
git commit -m "first"
git tag v0.1.0 -m "A"
echo bye > foo.txt
git add .
git commit -m "second"
git tag v0.2.0 -m "B"
git tag v0.1.1 HEAD~1 -m "C"


I get the desired sort results in 2.21.0:


$ git tag --merged HEAD --sort -taggerdate --sort -committerdate
v0.2.0
v0.1.1
v0.1.0


However, in 2.27.0, the first listed tag is the tag that was most
recently created, rather than the one pointing to the newest commit:


$ git tag --merged HEAD --sort -taggerdate --sort -committerdate
v0.1.1
v0.2.0
v0.1.0


Swapping the sort options in 2.27.0 does not affect the result,
whereas swapping them in 2.21.0 produces the same result as 2.27.0.
That makes it seem like 2.27.0 is ignoring the precedence order of the
sort options.

If this is intentional, how can I achieve the desired sort order in
newer versions of Git?

Thanks,

MTK
