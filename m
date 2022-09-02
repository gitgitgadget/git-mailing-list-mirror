Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6336ECAAD5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 18:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbiIBSBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 14:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbiIBSBo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 14:01:44 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C8DF997B
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 11:01:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bq23so4356765lfb.7
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 11:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dqdL8p5LcwVKgLR0aZl87E3SjlggEsKlu5zg5n72Gbs=;
        b=aUgNQgRm7hah8/LYu18vJPJa0FS+e+KJqsxaeJyvXyhvPHlH6RenmZ5c3K6kGlJzAo
         yeDf7pXrKQDazzlYKBS1YJDSG5RV1yIrLCOa88GCPHdl6keMYTPltkKcgwSOHh3sR336
         wfIjahAMXf1ySjTz3wjdJL0yI1gF1Wn43uX4brWo9qj6A+J67eRvAHmYlpzdAAYEYAuR
         GrEOX/mrCv5Bdrc3d2SB2MG4OY6aUBIxIw6HmH7OYLXUOyV5ksP3/P2M/S59n6a/TwtK
         mDvxunqvJfTg5FyELjPHFbyFJLkxlLVQuxyPYT+gKnN6QN6rVep/B0Mh4x+dDUSXayYw
         RpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dqdL8p5LcwVKgLR0aZl87E3SjlggEsKlu5zg5n72Gbs=;
        b=gVRr5ROkLc2pxR+ISULvMiI6G3kXvecc8eRfd03Nl4QIeqMTjHfsUx9SS3Dc2wKLjz
         d5L8w5E4lCNo7JISZF9FtnRTpy+/uZeIOCSOvbPzU3h2q1vpQWhjXf1/ceeOX0lOlxoW
         3AwephvdTBX2GtB40zHfzzFeDdK0t0esrgLGYySM4Pfyik4+y5/UQrB+Chmz9BrsrG1i
         dfosL5zehG6O5doCjTgzYrX1OoHYhKNPyL11aDRe1CZ8ksYJVROSX5nYOJSHvBAtrZsS
         hWqAq+EOns1FQBnuV6GUyDZmn2BjxnFglcYq63nAFb+bzPdFZ9q1S8ycbtUuO7ufX5m2
         ljlg==
X-Gm-Message-State: ACgBeo1khNuwfBcB0kj8eZs5IRrpedYLC6XrJkVv/s/bqCXZzCqsUQl9
        /dDLhYR081X/7kaa8XIiims=
X-Google-Smtp-Source: AA6agR45xfhdUbBvvOR0ZUL0aY5/nhATATmtYvKN6mU+792CZEK+MUqLqNv38Ijd5yqGVqCWoh9LLA==
X-Received: by 2002:a05:6512:2589:b0:48a:f56d:2912 with SMTP id bf9-20020a056512258900b0048af56d2912mr13878020lfb.370.1662141702101;
        Fri, 02 Sep 2022 11:01:42 -0700 (PDT)
Received: from paasan.lan (150.37-191-137.fiber.lynet.no. [37.191.137.150])
        by smtp.gmail.com with ESMTPSA id be32-20020a05651c172000b00268a0ada6d7sm263010ljb.25.2022.09.02.11.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 11:01:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     oystwa@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, ingy@ingy.net,
        szeder.dev@gmail.com
Subject: [PATCH] rev-parse --parseopt: detect missing opt-spec 
Date:   Fri,  2 Sep 2022 20:01:34 +0200
Message-Id: <20220902180134.23225-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902175902.22346-1-oystwa@gmail.com>
References: <20220902175902.22346-1-oystwa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damnit, forgot the v3. Hope that's okay.

Øsse
