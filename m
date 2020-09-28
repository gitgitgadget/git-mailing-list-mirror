Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6503C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 16:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC05206DB
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 16:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiPm0fdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgI1QVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 12:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgI1QVy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 12:21:54 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6FEC061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 09:21:53 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id z26so1914685oih.12
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 09:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vq4IMjF+VP94si1N+Z7upCKrl/UBhns5MF8CjdDM58Y=;
        b=AiPm0fdI2iZxX2pHII3MpBV/B0nMKje+HPpOjVeEybyxZxyrfS0VueyUmCRlga/1OA
         HWKkxH2Bl3EeTW67JEK64sahd/K+rAcNyGW5JHMnK+AYlzpst0RbVjJPBAtMXlEo5SvR
         SH1vVf/fUzfn9kMw6ZbgQpgC1WoHNDa2l09Q6NOCR5i938JFBSTPC02GcBRNWXyTHYqA
         1GHGhHbzfyySjN9SzJI7MrOnFnN9W7GO26yczI2O4YBdeYIuevNfeqBASIbh4fnZli+z
         yWFij5UVUU56DUTb2wo5Socp2m0yAaSElkfn+fUXtW19er6zP/g+PNpaYsARw5hIESGP
         ZFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vq4IMjF+VP94si1N+Z7upCKrl/UBhns5MF8CjdDM58Y=;
        b=eDBCXH7krkqLYDjn/ysC0VjXskR31kHx+ywobYlxvZ0pNUFIsM98OgprTm+oA2q5/V
         FVXc8uEFz0qoo9n6T3Wd/fwMQ/QDxLq5YbHP4lf6O8q5+9tEz9VUgZY/SpoP91UJP5w5
         fkmtXlE7mUPqnAXvaRr1y2KgDndJrxZCtgIffzjdJbZAKjoN57c8y3OPfu6+3q6RqqGk
         0bnTeUn1tIWMka4+A7R3MNkSH0+oPY6xSl4tk8pw8DNQ2p0If+jHQLpYPiuNNnYJnLwx
         BqzbCn6Ai+IT/4lB7x8zfIUWdaUHNSwG6CwalvquUuEewqeDd8y8NQCXehSHMqLODkVC
         ddXQ==
X-Gm-Message-State: AOAM5330MD6isSKtodOgZBXfBsjb/8TWZh2GmZriuByFxDx7DISkeLUl
        WhJjQq9aBNNZQimbJw1gk2w9gQYJe54eGV78Fs6hWRlclJRz9g==
X-Google-Smtp-Source: ABdhPJyUI22fNYkkmyK4WWUeV1apDWTl+JBYrYGEgBrW8uPN3B9g4QUSeu657zuBfcSyLTHEJc12LWRCtejfak1aDHY=
X-Received: by 2002:a05:6808:3d0:: with SMTP id o16mr1355991oie.156.1601310112970;
 Mon, 28 Sep 2020 09:21:52 -0700 (PDT)
MIME-Version: 1.0
From:   Evan Grim <evangrim@gmail.com>
Date:   Mon, 28 Sep 2020 10:21:42 -0600
Message-ID: <CABX4Un0NQV1wkx-AKTFs12agLiBLEe+Y_FDHgQwgxUT=wnFDmA@mail.gmail.com>
Subject: git commit-tree does not honor commit.gpgSign config
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is it a bug that `git-commit-tree` doesn't honor the `commit.gpgSign`
configuration option?

I'm considering working up a patch to fix this, but want a quick check
from more knowledgeable sources first on what the desired behavior is.
