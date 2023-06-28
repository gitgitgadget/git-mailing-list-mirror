Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A7CEB64DC
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 13:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjF1NDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 09:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjF1NDx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 09:03:53 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E12B2110
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 06:03:51 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b6985de215so62116841fa.2
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 06:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687957429; x=1690549429;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3F3wrWE/tsPswdqVLwnIT9B8uD2vPreGu9M2WdbPn0=;
        b=OdyXXrb8wsjEVyomqjtaY0F1RQ5BSiBVUq9CbIOARmtWVnzI7ObF9Q96LxD7WDtGKq
         ZF05uBj/O/p3snX5NrivhuvsbkrV79C6RkuXRbTTLY9aYa9d1BsyBRNAGprjx2rGDzhi
         WrX8YriOxpYt6RDzoXw5ULzuZrvpxx2juVp3cYX0lCo/yVAj97dfmE/d3eDux4d7cIRb
         cEullB9+U6PjwGMv3WeuXia2tjqWD9MIp3FjxFaSilmebrqPPFMdQMhiGKzlGwyyeDbW
         BWpD7yUxl32P6HYpXqqPlV3MRem4u1IsOKN1mkAdxPlFZpw54E0pXKROGx612V7DSPFr
         pgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687957429; x=1690549429;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3F3wrWE/tsPswdqVLwnIT9B8uD2vPreGu9M2WdbPn0=;
        b=EWcyWnOMnI5O5KUpKaCF3PFV2QmJmqoRO22C7J83bDGIvzjzCw+mCtsUY+KjUEDHFh
         xkgHu1+/zQD6Im4Yl5e2uq8Qru9peqjIoJJFXOTE4qm24oaaIaR/mHGUOZsdqLrMnRQ7
         xqTSygGz62jNmLh5FydEeKdecMf0EeAFf/tug5RzkYhDVCZRVq5QJSeVtZmImSLIaRYf
         6sL81p/P8GwQYZL28fyGozwMcqBB+BwBO8tOavqk9tEEo1XuUB608EdisKpQg/7tiRs/
         7XNOzl60eJ4eVc3J2Q5ZDeMrVcOA/f3oLyjcCvrS1O+o6eb+Rwpu4hqOkDwE4m8KC+RW
         cDkA==
X-Gm-Message-State: AC+VfDwutIg578cV+Aouc0pjsGH23fq4DQdibSoujnj+06dpz6CH59X8
        ZXQa0GG1v5QhqWrUr1NqNHWXEUaRqVnZ21rf2U1TSWG/Czw3pw==
X-Google-Smtp-Source: ACHHUZ5m3rDI+/61HjtPRpLue3qCi5lDvPSGktIKB6DmLzrBNyLWVdGGfKZtywn+3EXFTwDChXsmY6Cg5te79Yn5JL0=
X-Received: by 2002:a2e:a1c9:0:b0:2b6:a841:e690 with SMTP id
 c9-20020a2ea1c9000000b002b6a841e690mr4979415ljm.42.1687957429445; Wed, 28 Jun
 2023 06:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <CACmJb3yoHagaU1wb4qRT-nZV4Wptao8boaUXCAYrFxfrxcmUYg@mail.gmail.com>
In-Reply-To: <CACmJb3yoHagaU1wb4qRT-nZV4Wptao8boaUXCAYrFxfrxcmUYg@mail.gmail.com>
From:   Namikaze Minato <LLoydsensei+git@gmail.com>
Date:   Wed, 28 Jun 2023 15:03:22 +0200
Message-ID: <CACmJb3xWh+0BR_V6sxfMK7iMSdWfvY9d2rjt1hnZhFw70zWweA@mail.gmail.com>
Subject: git-switch history and checkout compatibility
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have been waiting for people to report this but it never came so I'm doing it:

I have trouble with getting used to git-switch instead of
git-checkout, but have even more trouble to get people to adopt it.

Please consider the two following git-switch statements:

git switch remote/branch # fatal: a branch is expected, got remote
branch 'remote/branch'
#and
git switch -d remote/branch
git switch master
git switch - # fatal: a branch is expected, got commit 'commit_id_here'

Both as retro-compatibility with checkout and for user-friendliness, I
would expect both to work.
Maybe a setting checkout.autoDetach could control such behavior if the
current implementation should be kept?

What do you think?

Kind regards,
Minato
