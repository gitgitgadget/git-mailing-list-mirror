Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13956CD80C1
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjJJMj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjJJMjP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:39:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D02AC
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:12 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405524e6768so54137525e9.2
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696941550; x=1697546350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNQ39VxswEN3jDWQEH+KmUcn3hK4HhGnFM8vEePDN9o=;
        b=PYS1zbUElq7GJJ4qBgUH3bgeroRBSGVJL3tsq9FDCYbj5TeGDDxKZrvYRowwQU9q+t
         jEWdf6r3gYq28gdQR4jjfPN/Om6mII4l9117dnzHISZfvYvoiMkA6S216tHDv9Jqo89m
         sDDPNbg7wT3bHnCpfbT4n1w/kxCRJFrVYyA9obdoHo4bIztEwJYx6cNEWhtCN+VjpFkO
         Lw7sHJKgBQ15EUoIIc5I6v8AGnT+E/4+E2n6J450PBgx9Io7h0Y+ey4Z1ZeOj3CxpAKE
         I7WhDzyZrwgjBO/o/hgY3L3xumKBUqaQquKO2gKRsuNfHX1KZp98Ymh6IZlWVqObty5b
         0QEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696941550; x=1697546350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNQ39VxswEN3jDWQEH+KmUcn3hK4HhGnFM8vEePDN9o=;
        b=t/ovOkvHLRZ4llB6l5WMBPb47q96baitu0E3SF9q5rDdxGof0Jf7jYxwSlvqsLchrL
         QnduMJMBsEsPaNjPMqc038Xl+WQmajHZrj6lLpp78FLM5GHgzbJMuylvt0PmL+gX2XHD
         wE3P+GhjUOKha2IOEpUmJFlvlqrX2GiSahAvmoRJtQ6g0cAObAr/IF8kbP4QwBJEi9rc
         Kv7Lh3c4qO8iuaZu6L+TfAwJbj8Z9teAxwvPtPkbugaJoadz6NP+dsjiEoO6dB2s8Dkt
         +9OcA33ppQZj2N05lkBmJFgyHhciuDt8g77pCJbjt1Hbnav/xwO358ECzUb3fY3y8yrG
         ahGg==
X-Gm-Message-State: AOJu0YzzkWU0CyW+0RMFQZglgUbfmMA741Mp2p/e9/BDI34od1nHH40+
        meP78GRVY3L+rKB0ab0gbv77yecpBXRa8w==
X-Google-Smtp-Source: AGHT+IGWn6Bgnx2k8FwwE5Ody4l6ipoWTHVyYHiJyQLq8IRvmKJL2nAvP5N4QdrY0VdXzwBhaY8RvQ==
X-Received: by 2002:a05:600c:211:b0:401:bf56:8ba6 with SMTP id 17-20020a05600c021100b00401bf568ba6mr15177609wmi.28.1696941549557;
        Tue, 10 Oct 2023 05:39:09 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:516d:299b:cbff:be05])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcc8f000000b003fee6e170f9sm14071689wma.45.2023.10.10.05.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:39:08 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Dragan Simic <dsimic@manjaro.org>,
        Linus Arver <linusa@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 04/14] replay: die() instead of failing assert()
Date:   Tue, 10 Oct 2023 14:38:37 +0200
Message-ID: <20231010123847.2777056-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.339.g663cbc8ab1
In-Reply-To: <20231010123847.2777056-1-christian.couder@gmail.com>
References: <20230907092521.733746-1-christian.couder@gmail.com>
 <20231010123847.2777056-1-christian.couder@gmail.com>
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
index d6dec7c866..f3fdbe48c9 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -179,7 +179,12 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
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
2.42.0.339.g663cbc8ab1

