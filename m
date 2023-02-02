Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35801C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjBBJx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjBBJx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:53:28 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCAE8A6F
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:53:10 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so3284131wmb.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCBJZiYhxnFipdNMubM2tB1sHl8TfZPdL6BTmJzIwPg=;
        b=pR0HLwrB9jBU0Yt0hUCnzbj2Hjkw/E++4hhHxRastbGU4Y131DZHiye9rUrL/KqsOW
         FwY51L4rLC/sFBzeENlom8s0YNVAc/qghX2KQah9cc7T6qWsMtnRy3GtTUZYo0m0KvmV
         YmKAg52fIzMtOfak2xvUypfJl80qjqPjfj62EHMkawIdfMit/ztvxs0rD505XvoX4D+h
         WN8j5xnDjqiL2UPIplJUIh+3r7DVUg4aOUQKhrrKd8yQC8BNXJ+qjbIcHoyDDQkJ70xh
         jxEnLinI+EXtaI0cOrtsR8bdOEjXmV//29jxtOUlEMSuvg2tMgJi7URhoSAwg7RPBV9f
         njnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCBJZiYhxnFipdNMubM2tB1sHl8TfZPdL6BTmJzIwPg=;
        b=W+TjjphAwi18X8qpmjKuiwM7if4T7sYp1p5zGDGtXFJd/wFaUrBxT/g0rR/ZwFz8Zz
         tetN267Eq9hGg7zq74vTD6F+7bXwIlEFSChTHco3B9lyLUGXrKPYarIPXqgfuo2tCC84
         VveCXF7qdL8sywgO7se0qEVSD/Uw8xzAXSaaX7PQMtTPFkIJk6rtPwa1z7KT25pe1Pwu
         v5AyAjcmx83cBiTufJ6wRg8Gs2cacPHRwGn49tNui1KyPAEj7A636KFNR9E+DOAb+20T
         sh2gvQTDJmcQ9gpXWI06CuBWXiQYkFzVNnoeOse31b+4egSx2p+ack6TxHoldUhxDqDP
         yqsQ==
X-Gm-Message-State: AO0yUKUb0QvBzEmKs4p6TlXiFh3/t1ny6RGSdsq800TwhhO63jDS7V1j
        36quhM8fZDiCJVAwWXf0SVm+ZShOflpHkepd
X-Google-Smtp-Source: AK7set/TBMSqRX9JrgAFHAHVgldjOs1gfCUjnbQeHkHG4W9Ahdbcz+wW1IrN4ZtGehzDhLyFhb9kJA==
X-Received: by 2002:a05:600c:3556:b0:3db:331b:bd57 with SMTP id i22-20020a05600c355600b003db331bbd57mr5417035wmq.23.1675331589898;
        Thu, 02 Feb 2023 01:53:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13-20020a1c540d000000b003db03725e86sm4356234wmb.8.2023.02.02.01.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:53:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 13/19] builtin/merge.c: use fixed strings, not "strbuf", fix leak
Date:   Thu,  2 Feb 2023 10:52:44 +0100
Message-Id: <patch-v6-13.19-a85e5f3b14e-20230202T094704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
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
index 74de2ebd2b3..32733e551d4 100644
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
2.39.1.1392.g63e6d408230

