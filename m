Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFFEC54EBE
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 05:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjAJFpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjAJFo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 00:44:29 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724DC41A78
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 21:44:04 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id az20so6730703ejc.1
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 21:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvVz6LFCFaVeRms1Rh9TNN0SLNxSr/CyENoT9POliGU=;
        b=CCOh2MkjItdOF5a7iuMDUzZ01i81c1h7iYjao6eswKMq4f6j0czMpWgvN+mY6G2SsN
         bIYcPouUYDYTtKe2KV0cxVTZmuv9v0uRO11oO3iwANtDIPIZ5RJAoSgdstZhjGoUM+zD
         zafC19zaqXtniCkBT5jo8eqS8n+KixRG1Wu0eGZ0nYCSVh107eyd2f55fT48z/0rO0eY
         9PHdvFkeB/d9UbNsUU/0Bj2zp0TGRCFQtwG2vLyRwEWiF9cH2CBU+8KfaI2e7tywsrr6
         40nuIsHdDyYjxgnDRr+udtL3YyEYRYQZda5dPo7GxpgTQAU9gqVsCpoPBP9vXDplOQuP
         Olmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvVz6LFCFaVeRms1Rh9TNN0SLNxSr/CyENoT9POliGU=;
        b=gUdircxneotADhViezhkWkStNr/c9osZ/RKuGO1CS7Ssu428TzU0EVZ1yNi/CeXh/9
         /k97H62xA4tUOC5BbkrfOVg3AB9c+EbRimJjjvjPpEufupphzS5DnKD6Qciiz+qMnsZq
         CZLcp0raKLkLHvQS3Cj+4dXrNE0AVWIv3zYngzYeuSghLTxQp0D5BR3fWJaGDNuTSH3S
         xlTzkKxXheLfN5FbDgr5l5Ck1LBDAC75M6CpL7WobdfUNQJCRwEFi+AnA+hPjhz1drwW
         UDRfCRclTCVxtmT8F4ssy8+kiVP6jD71QIPE9l0prHL1/Ng8X61kJq/+5zxRYmd6uX4T
         K4Jg==
X-Gm-Message-State: AFqh2kr3XtEWDYXVQ51v2rVVgePQ557XN7M7Ocw6EmOEltz6c72uVcok
        cP/Kx8rZvJIf9MfNTbbGGwsIDyk0bz3KXA==
X-Google-Smtp-Source: AMrXdXu803YhZDgBP9BRhjSEEvbzH8TSpNyukv1N4gReRe8OXle/sAmwIM27vl0VKBsrGlLhJ4drQA==
X-Received: by 2002:a17:906:8447:b0:7c8:9f04:ae7e with SMTP id e7-20020a170906844700b007c89f04ae7emr56714908ejy.22.1673329442518;
        Mon, 09 Jan 2023 21:44:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906869500b0084d36fd208esm3428423ejx.18.2023.01.09.21.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:44:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 13/19] builtin/merge.c: always free "struct strbuf msg"
Date:   Tue, 10 Jan 2023 06:43:33 +0100
Message-Id: <patch-v3-13.19-6d99fdcc44e-20230110T054138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com> <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up 465028e0e25 (merge: add missing strbuf_release(),
2021-10-07) and address the "msg" memory leak in this block. We could
free "&msg" before the "goto done" here, but even better is to avoid
allocating it in the first place.

By repeating the "Fast-forward" string here we can avoid using a
"struct strbuf" altogether.

Suggested-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c                | 11 ++++-------
 t/t6439-merge-co-error-msgs.sh |  1 +
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 0f093f2a4f2..91dd5435c59 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1560,7 +1560,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			!common->next &&
 			oideq(&common->item->object.oid, &head_commit->object.oid)) {
 		/* Again the most common case of merging one remote. */
-		struct strbuf msg = STRBUF_INIT;
+		const char *msg = have_message ?
+			"Fast-forward (no commit created; -m option ignored)" :
+			"Fast-forward";
 		struct commit *commit;
 
 		if (verbosity >= 0) {
@@ -1570,10 +1572,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			       find_unique_abbrev(&remoteheads->item->object.oid,
 						  DEFAULT_ABBREV));
 		}
-		strbuf_addstr(&msg, "Fast-forward");
-		if (have_message)
-			strbuf_addstr(&msg,
-				" (no commit created; -m option ignored)");
 		commit = remoteheads->item;
 		if (!commit) {
 			ret = 1;
@@ -1592,9 +1590,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			goto done;
 		}
 
-		finish(head_commit, remoteheads, &commit->object.oid, msg.buf);
+		finish(head_commit, remoteheads, &commit->object.oid, msg);
 		remove_merge_branch_state(the_repository);
-		strbuf_release(&msg);
 		goto done;
 	} else if (!remoteheads->next && common->next)
 		;
diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs.sh
index 52cf0c87690..0cbec57cdab 100755
--- a/t/t6439-merge-co-error-msgs.sh
+++ b/t/t6439-merge-co-error-msgs.sh
@@ -5,6 +5,7 @@ test_description='unpack-trees error messages'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
-- 
2.39.0.1195.gabc92c078c4

