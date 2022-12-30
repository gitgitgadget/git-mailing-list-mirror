Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F9FC4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 02:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbiL3CT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 21:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiL3CS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 21:18:56 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3E1175B9
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:53 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id r26so23668682edc.5
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lrs563dAEATCYIKh5dag6CODDZIJfrY3R84jSz3aTco=;
        b=bWBKoEQ/x+FZ+qwKuu72X9JXQd2RAwOXf8PDuXg26oX7uTgdMan7nL4fyBCwjjgvlA
         6IA+xlX0RvAZ6rHcm8yzJRqPzv7JMqtkBkdqh1uhIP4AppTSaaid4YjetKhP8IqIKoy3
         I1x7/k9g4urBzMP1XAbVezQ7eh+YDyWAarKSHKB0myPpcTMHUGsa3B69ibfQcAhBxxoh
         H6IUdaKp49FoUWCn/Mr+Fy5AxrdGu7e39r+bwKoYxEaLOb4FVrtM2mk8eEI5w25BUqvC
         NUSnMKxwsvMXwNSHkXxGTL+BA/cJweDU997IeMDZVHcLp3lqihMC0Fu87p7E9/SqZWtm
         fChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lrs563dAEATCYIKh5dag6CODDZIJfrY3R84jSz3aTco=;
        b=F7e9dwCRS2X6Pg9Tk4k37JATrRbsh07BTeQoGf6IO9MSmFX+tYR7qt7TK+D1U2MbIP
         lFxs1rjaAK2zqXWsiSPbmNi/CMVm614JwrqBLAREuev6rNglLsPE4RTDvLvu3+qmrd9c
         TPIzq/4/jjmkTMeAOA9pnDJuGHhZUx28oxp+5b/8S3mNlgrWrdZGa2y8pqFyWUTwD+hi
         5Uk9JRcdnJh4WVsMMSSGsJOGBv2ycRkfyEFzi3Zgyz4ZHKiJMuBsvexBVsRtxbf91s6I
         GkKcDbjrq1t/2Sz1yfbaDwFDHkh7omgTtFKlUKLa6UK4MKeSE6Yxo5P20EfayvZHim/N
         92dQ==
X-Gm-Message-State: AFqh2krupbXA8tHKTqWB2zaprd3gDz8+nlBTkts6vDDwacWi9cFCEDPu
        ZsXf8OzBSBnce4jOV3cgLVAa9ycKmq8VTA==
X-Google-Smtp-Source: AMrXdXveYUrpx/+9uxHaCiVW0HlB8ZeUFV1ZF18gsXN/G8wNziwVuHzRp9DdE4lQs+h7xCMNFKiihg==
X-Received: by 2002:a05:6402:299b:b0:480:cbe7:9ee2 with SMTP id eq27-20020a056402299b00b00480cbe79ee2mr22076841edb.22.1672366731369;
        Thu, 29 Dec 2022 18:18:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b0046dd0c2a08esm8861991edb.36.2022.12.29.18.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:18:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/20] builtin/merge.c: always free "struct strbuf msg"
Date:   Fri, 30 Dec 2022 03:18:28 +0100
Message-Id: <patch-v2-13.20-b157092e8d0-20221230T020341Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com> <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
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
2.39.0.1153.g589e4efe9dc

