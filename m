Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35728C7EE29
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 10:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbjFBK2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjFBK15 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 06:27:57 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6397F268E
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 03:26:14 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f60bc818d7so1774418e87.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 03:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685701557; x=1688293557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+WAD0bNtCqZf8cEoH7eJlDDTc5MjxUTnqrq6G9eSF8=;
        b=Ab9v8abN41UHBInqX/30veEXBEvxP3sX21nwbHshQXdRqKyRD1XzCKyPsBz5Z148zw
         7wQs21Ty8f/kLGT/q7R/xDj9hfwPjX61bPapx6R1zhDJ7GKsandcDHXfTs13CCWwhNx1
         utdmKmhv7Pm57PyhRdenxM4Iu5ISRHVXefZkX7XhnwkGFZ7uOoXDkkmNLsDR5NmbuFJ2
         iF+TU187XBuN9aYl5BnGRH+x0LDefwD6V7813lLgOpry1MKeX8Uy+HNUAvR7aWRBxbGB
         VUZt73uSojuiN/mOEv1Pj72jS0CO7AJ5Jjvw8F2fAAnjYxRH+KnDZJsshlw4TwKOT8aC
         DINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701557; x=1688293557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+WAD0bNtCqZf8cEoH7eJlDDTc5MjxUTnqrq6G9eSF8=;
        b=Tjq9jnOjjxRN9oR4eUKd1I51/V4l5uKtYnV/i7HO4A/j+GnB3FAn3gzMfxjQSOAQGJ
         qCOrWmHQXDVaELmiGDHRBOLoig6jGHc/J6MptkFgDrUzxD9TGk0rg8g/tlB4Jtbmh9Cc
         h056SpifonVwXc3OXzm/5ixEBUkWT0oKQL2rOlPmRdYnufRRlZz5wdPuTsAtv7lmE/wQ
         YWxms/8xCPA/UVj9Dl2J6V0JjCwdk1exLOxKyoBbbU+qWtfm45efF0A19vVN4oZ2gBz4
         ZKrBmqRnFUfPyY9Oirnx55WELpoWcilL81fRnoJx5YaIHbLrCLewwnHIAxLx/abl3y7a
         Kc8w==
X-Gm-Message-State: AC+VfDx0ws57X3znbgJfUVY8h0pP6tD01+6BlGT4xyGA5CgUuze6045C
        RZyFRcp/0zs+a+9J133m2wOvQbNCkGt4Fw==
X-Google-Smtp-Source: ACHHUZ6+MOW/cZK7dC9hCzw0PSFK7ikuHSGykOLQLfqjSN0DFyKyPFq4yJfW2tqO7lWtFUK8kF3rug==
X-Received: by 2002:a19:ac43:0:b0:4f3:9868:bee4 with SMTP id r3-20020a19ac43000000b004f39868bee4mr1621541lfc.32.1685701556708;
        Fri, 02 Jun 2023 03:25:56 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1169:70dc:520b:5de9:c23d:7cde])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c029200b003f601a31ca2sm1468035wmk.33.2023.06.02.03.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:25:56 -0700 (PDT)
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
Subject: [PATCH v3 04/15] replay: die() instead of failing assert()
Date:   Fri,  2 Jun 2023 12:25:22 +0200
Message-ID: <20230602102533.876905-5-christian.couder@gmail.com>
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

It's not a good idea for regular Git commands to use an assert() to
check for things that could happen but are not supported.

Let's die() with an explanation of the issue instead.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 7eb05048a5..2537adbaea 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -178,7 +178,12 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
 		fprintf(stderr, "Rebasing %s...\r",
 			oid_to_hex(&commit->object.oid));
-		assert(commit->parents && !commit->parents->next);
+
+		if (!commit->parents)
+			die(_("replaying down to root commit is not supported yet!"));
+		if (commit->parents->next)
+			die(_("replaying merge commits is not supported yet!"));
+
 		base = commit->parents->item;
 
 		next_tree = repo_get_commit_tree(the_repository, commit);
-- 
2.41.0.15.ga6d88fc8f0

