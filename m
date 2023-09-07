Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419CFEC8742
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 15:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbjIGPrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344179AbjIGPci (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 11:32:38 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB03CE7
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 08:32:09 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-501be2d45e0so1790094e87.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 08:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694100674; x=1694705474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Cbku0d5FhZ8o4lNqUvCu77IIGuA+U2HqkGrXEHTDBA=;
        b=AYyvMJMbdKAOY0IuEdrWE0ifNE0QB7YXArNSrF3sj1e/WIk1rt9tpKJ+BlCsCUSFvO
         jOqEibPqcSkMH0T9gh50q8ACK3Qs58PuiCqmWsyOx07CcMjrdpdEEFCvG0MErzGUrHnh
         8a82MyceVqZKAJF9XhSaKbAE6fRI4CogBCTpZcxD8faE3RHpVI0XClThbZeIsfOBzpP5
         1oTqR2ffuWwMmh2H+qSBVKmwyYzBQHKm3GmP+Wz7qnwkBc0+q/s1JuXrClGPOKyK6Jay
         tFIuRPSXvgt91aQaV61iy/CBq7WUrywRBUFaNeoPFVmNB21tHSvSJDnrOG2iDsOS+F4s
         0AhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100674; x=1694705474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Cbku0d5FhZ8o4lNqUvCu77IIGuA+U2HqkGrXEHTDBA=;
        b=htXG/pRwY75I44kbSBxwI19HCPHeH8ydG2Eu20vo43MoJygyG7mC1FlayoHVTc63jL
         yDfDaKoMqCpus/V6rfGtlFHEU1+EsLMaBTXPo+5F2TwvcYMSnUTxg5dWJZUB6rh0V1Vu
         aqcSEm/f/sBWttWZ0GUgksVMCDU01oczK42POXoBdnvHDwTga0jUlKLu87ckboEQ/jm2
         Ijp2SS0vlqByLABAIiVyrwnywvNDgOc9xQiGekgxs2lCki/pkRs9ZzRQcva0lq+0ye0F
         SFYBIcMzLgl6BZi7RyulgG5/FL33XdkkVg64s7i382mAdwLRi5UPIw3wHGXzZ+A+IyW+
         dyZw==
X-Gm-Message-State: AOJu0YxGW8QpMJ6q1EGYgaATTSL3Cx9rqbEvXPlV93L37k0EREAAw7QB
        MbeMF/VXVLl5NVA6taHkgYhhPttsZ+Y=
X-Google-Smtp-Source: AGHT+IG4ZX6Z53W7V+8yM6VSWkRUIJI8WPjbtLeKvU873Lt9CxHaCFvd0xbsimtN9LIY0gleFnZqlA==
X-Received: by 2002:a5d:5911:0:b0:317:7af4:5294 with SMTP id v17-20020a5d5911000000b003177af45294mr3785192wrd.44.1694078815181;
        Thu, 07 Sep 2023 02:26:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:3385:ce2d:69dd:303e])
        by smtp.gmail.com with ESMTPSA id y8-20020adff148000000b00317c742ca9asm22491522wro.43.2023.09.07.02.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:26:54 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 04/15] replay: die() instead of failing assert()
Date:   Thu,  7 Sep 2023 11:25:10 +0200
Message-ID: <20230907092521.733746-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.126.gcf8c984877
In-Reply-To: <20230907092521.733746-1-christian.couder@gmail.com>
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com>
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
2.42.0.126.gcf8c984877

