Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14605C433E6
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB08364E4A
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhBQTnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhBQTnr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:43:47 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B99C061756
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:07 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id g5so20849856ejt.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qlSv3FJGfnahlMf3GQa6RyUZQW2vxjTloj5EoPjtJv8=;
        b=RxrtFsC8mv96J8vXgUSB589hr9IgPOCpaGDzUhh1tpsZ8cL4B7KVu9TpKgQoXw1BIY
         ui+FRlr4zTCi8kQXc9CveXceVslrqJwHndT/Jx2fFACoeiLnuxZaTOpjJRMWfNSA3nWx
         YewFSk0bFQEcMekEtE99HYXlheaCleiFCehmoBxRbFhN/OTNJjpPcr6C1fDOChG81jCw
         cF3aNdeBBh8/sDuE/2+DrL/E0FRInQ9U+3rZj6me9gzMc5dK5Hiqrd+rjJfrlmwJ7vCA
         qXcOgATf1xub9bYwmKK4H/d5C7EIqpiRux/pg9NA6TKmTlTJBJvfbVXnxqY0CQS+7t4S
         k3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qlSv3FJGfnahlMf3GQa6RyUZQW2vxjTloj5EoPjtJv8=;
        b=cNbVj4xlgjdpcy2YGfPPnwzgsuVjES5+NYbA7n2mbRAK/nFfo3nXIr7W67kJwQMQ9W
         2v7dOleO3gXf8Vg6DOAcwr9AsyfW87eKq/dQ34cYPqA9Fkt+f+gq7GDBPLWtSzEbNCJo
         uDrlL6bn0D4kRlEBaDXqX7gdrJqfBwQ6NakbOQZws6ZJGb99WHvZXFbOjjtrCsz7f6Gy
         Fv+X5hynFa0M8vKOXXebTlTjTsmw532otXPiNgZvDBUBU6+w79eybxBgY2E7D1ync26Z
         zsp68cLUSXP6fCXT5GpBpscrDIHT1Ja2vIZBGosGE86Jp7DvZv0dk9EWRH63oFDcd03I
         a8oA==
X-Gm-Message-State: AOAM533dyTu1Y7QaQrfsXWFnzI35T8kfYXHlFXmTanNPJckQPbU5C7QD
        NFqN/lsXyLb5BrRVaq0NYQsr7cFBnwZA4g==
X-Google-Smtp-Source: ABdhPJwhSzJHkpC4u/JkEaNwvKsIMsu4jBbPIGaH5FQm3c3hkC+ErqtiUmi6cUnhV+vwm4REg2aSSA==
X-Received: by 2002:a17:906:388a:: with SMTP id q10mr526462ejd.496.1613590985557;
        Wed, 17 Feb 2021 11:43:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o10sm1479706eju.89.2021.02.17.11.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:43:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/14] fsck.c: rename variables in fsck_set_msg_type() for less confusion
Date:   Wed, 17 Feb 2021 20:42:35 +0100
Message-Id: <20210217194246.25342-4-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87blcja2ha.fsf@evledraar.gmail.com>
References: <87blcja2ha.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename variables in a function added in 0282f4dced0 (fsck: offer a
function to demote fsck errors to warnings, 2015-06-22).

It was needlessly confusing that it took a "msg_type" argument, but
then later declared another "msg_type" of a different type.

Let's rename that to "tmp", and rename "id" to "msg_id" and "msg_id"
to "msg_id_str" etc. This will make a follow-up change smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fsck.c b/fsck.c
index 4b7f0b73d73..acccad243ec 100644
--- a/fsck.c
+++ b/fsck.c
@@ -203,27 +203,27 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type)
 }
 
 void fsck_set_msg_type(struct fsck_options *options,
-		const char *msg_id, const char *msg_type)
+		const char *msg_id_str, const char *msg_type_str)
 {
-	int id = parse_msg_id(msg_id), type;
+	int msg_id = parse_msg_id(msg_id_str), msg_type;
 
-	if (id < 0)
-		die("Unhandled message id: %s", msg_id);
-	type = parse_msg_type(msg_type);
+	if (msg_id < 0)
+		die("Unhandled message id: %s", msg_id_str);
+	msg_type = parse_msg_type(msg_type_str);
 
-	if (type != FSCK_ERROR && msg_id_info[id].msg_type == FSCK_FATAL)
-		die("Cannot demote %s to %s", msg_id, msg_type);
+	if (msg_type != FSCK_ERROR && msg_id_info[msg_id].msg_type == FSCK_FATAL)
+		die("Cannot demote %s to %s", msg_id_str, msg_type_str);
 
 	if (!options->msg_type) {
 		int i;
-		int *msg_type;
-		ALLOC_ARRAY(msg_type, FSCK_MSG_MAX);
+		int *tmp;
+		ALLOC_ARRAY(tmp, FSCK_MSG_MAX);
 		for (i = 0; i < FSCK_MSG_MAX; i++)
-			msg_type[i] = fsck_msg_type(i, options);
-		options->msg_type = msg_type;
+			tmp[i] = fsck_msg_type(i, options);
+		options->msg_type = tmp;
 	}
 
-	options->msg_type[id] = type;
+	options->msg_type[msg_id] = msg_type;
 }
 
 void fsck_set_msg_types(struct fsck_options *options, const char *values)
-- 
2.30.0.284.gd98b1dd5eaa7

