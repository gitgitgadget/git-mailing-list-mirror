Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F13C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjBFXI4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjBFXIj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:39 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E357E32513
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:08:23 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id e22so9426543ejb.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9TikU5Ol8piO7gSFpe+vOIY+Xlo7g1YhRGNfttIxYc=;
        b=Iok4GXOAsL4Nn3POMmQ6Z4wIhecjDymOeSIwHARUZUpnyIoADCkK1eod4vJ8u2YChS
         IsDxH8a8OVrbX5FxLw7yox/oQ+v3MaWXOKuDbyWhQzMCoszev8md5uiMBb+IRfA0Gri9
         Wbs6bH9tG4lfijaZNut5XuIRQJSC/bibrQRtdDKjkxyY/P0JvnMdFqoqhOvhek95d+e0
         r9w26tsvcnaY2LuxfU3+AnqoPMprr2ty0X+jgOR51GXbM1ac8UNXUIjzDIdoXe8afDKp
         bkyAI72TXUO40L+brtpDtMzn2WZScb+uou5KeEwYQkocgBkbGLz2BgXVc/dbuIBXN4Ps
         Qj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9TikU5Ol8piO7gSFpe+vOIY+Xlo7g1YhRGNfttIxYc=;
        b=jaPP4ZEB1xTCE3LbjONgl0d9zbo5x7Cm8ZglIMHeobWCL+LSr/KHIfuvXERpgBRe63
         u8NaB8sooO7gpMjdW+eASKYqx96ObP3ygtwZ7k3iVND2Eyywvymxszq72tMNAIWYQRGI
         azuJue063IabsMsRcqKzN7RCO1Aa4eQcu5duA768YAbdnZcNEH/QdbDnDnbJ8LDjLp4L
         XL9zrCUBjeLQBKBeS6L+haonFp9qSr5CEhJI0ek84GYXWSrSLI2P+/81/9kM0gUyHm8W
         5fvvV2JgxqoL2aw82UKXEWaGs7/gj7G7oTpC8TnrN0wIo6h3dhaj17zBSU12DwJfIGv6
         TSkw==
X-Gm-Message-State: AO0yUKWzgcjqbYdem7KL73984WzgDIPLej9IWY1UUMlT5tkJTRsnpG2L
        ZeLkmPaSBm5KDuW4cFAgJMa/iLuA+bFnP3xm
X-Google-Smtp-Source: AK7set/Jq5joDAmybzVOkDqSVc0hF237zyTyC/+W/Yx+dtTw87Z1biD1kHWnxr3MrXW1E/Y5hgI9qA==
X-Received: by 2002:a17:906:90cc:b0:878:7d2c:6ba7 with SMTP id v12-20020a17090690cc00b008787d2c6ba7mr1166641ejw.62.1675724902088;
        Mon, 06 Feb 2023 15:08:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906a18f00b0089d5aaf85besm2673586ejy.219.2023.02.06.15.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:08:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 13/19] builtin/merge.c: use fixed strings, not "strbuf", fix leak
Date:   Tue,  7 Feb 2023 00:07:48 +0100
Message-Id: <patch-v7-13.19-b33d61deaf9-20230206T230142Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
References: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com> <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
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
2.39.1.1425.gac85d95d48c

