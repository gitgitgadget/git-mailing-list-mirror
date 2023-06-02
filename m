Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AA7C7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 10:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbjFBK2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbjFBK2C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 06:28:02 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE5E26AA
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 03:26:24 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so2533738e87.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 03:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685701562; x=1688293562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giikQtTdogrSg/BbfYz+hkhwJOgoL3VsNe1CrYfp5nc=;
        b=RA4yWlWhv/jC70hPUgHRvZfqSl+Et7PVorfkvyV30eiW1ypqjLOOYv2DgJqI65t8ny
         ykXzYOjYZKjgNw7+cXDFhVzIx0fQvVFDkzxDEMhEtY02Fek1WapU7vl5rllcj3MFt09g
         PzOuFlSeg9LRqavhPPbrP+OlRg3Gt9hLzNmjRminq8HJBHz36b7BFry4v2HDtbPAxdYL
         Zq5a/08wa+Iy38es9LUYCiyMKmS6IfzRZj1Ud3LT1Kj5OCqOn8evGgsGF973Z43nepqg
         DEocEAqvPKx49vv5F3/j+EX4LWmmppq9YaLpVpKLSlOfM/Pan767/gWl2hV1bh5Jaicn
         AtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701562; x=1688293562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giikQtTdogrSg/BbfYz+hkhwJOgoL3VsNe1CrYfp5nc=;
        b=L244Y3eW+EuWDAa/Ve4O3LFGF8ztpEJXWBXd9rBsOiCOG35fFFp+TSNvlUIOBTYzlF
         v5wZ6KDmzTZ+c6Wl4CVg1mVumtrfl9e3WtHwblV3kjFSiWGgOH/bnd8waACbQJ+q/nhg
         WGYCMcDw3BSgiNLEqY/UL+0/b9wIQ+xbrOfD9Zr4tcVfuafFBiqT/DBurDzM1CCp1mSI
         an6C1LerHGMkjRUD8aIznaqBlnDRO0WvDne9SMV5oSZdh+dEKOW6jTFjuw17Cz8KPwbz
         VpJwjpLdgAr6O6NcRbLrY69z7dP8hF+37HNk7SvE0FXoR+iaEz+RuVncE+WXiBV7eJ74
         3I5w==
X-Gm-Message-State: AC+VfDwbSBvZbAih7OXPSoc9az0dl5NpVjepIYiwYHcrDIatNPuTRVC5
        zdULJvTmI3w6IOXeZVdFOQ9xSMOWzSszCA==
X-Google-Smtp-Source: ACHHUZ764SjkTVCC7i4bLUKJRUv312HE5NydgH2P0+Fs6fflFal2zEi+iYm5v8zk1xVMqTlp6dAOjw==
X-Received: by 2002:ac2:47e4:0:b0:4f3:a1db:ad4 with SMTP id b4-20020ac247e4000000b004f3a1db0ad4mr1367417lfp.66.1685701561695;
        Fri, 02 Jun 2023 03:26:01 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1169:70dc:520b:5de9:c23d:7cde])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c029200b003f601a31ca2sm1468035wmk.33.2023.06.02.03.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:26:01 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 07/15] replay: add an important FIXME comment about gpg signing
Date:   Fri,  2 Jun 2023 12:25:25 +0200
Message-ID: <20230602102533.876905-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.15.ga6d88fc8f0
In-Reply-To: <20230602102533.876905-1-christian.couder@gmail.com>
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We want to be able to handle signed commits in some way in the future,
but we are not ready to do it now. So for the time being let's just add
a FIXME comment to remind us about it.

These are different ways we could handle them:

  - in case of a cli user and if there was an interactive mode, we could
    perhaps ask if the user wants to sign again
  - we could add an option to just fail if there are signed commits

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index d28d468008..52db8e0941 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -61,7 +61,7 @@ static struct commit *create_commit(struct tree *tree,
 	struct object *obj;
 	struct commit_list *parents = NULL;
 	char *author;
-	char *sign_commit = NULL;
+	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
 	struct commit_extra_header *extra;
 	struct strbuf msg = STRBUF_INIT;
 	const char *out_enc = get_commit_output_encoding();
-- 
2.41.0.15.ga6d88fc8f0

