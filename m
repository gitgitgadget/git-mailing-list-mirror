Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8196C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjARMr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjARMqY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:46:24 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44BA8CE58
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:47 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m21so49308942edc.3
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVTn2r0i+8AIzxKvh7W+2HtTrXcgAylSzXmEKCHhhwo=;
        b=hYNb7HC+eLxft5xsM0VOF32zmY+3Jl7Ve4iwtkGcsksBmSdnv0D82HTiYFOMyma63f
         iE6L+mmMSF18gTcmecCMYqyHo5FfFUNtdnXW0iRhF0O+K+HRbEH4UjvC/Rj02IqTFsQm
         h+BLyei/JqtQaEIzb92VEEGkiXyOuYQeWAmJDm9GFdbPfKJvEtvsdCkzmEZrti359HpF
         8pYrjnJOW/3Pe6EydwmmvxrSddIU1s4fuJo45plZP4PHwWOgBX1uVxNvLNUkIKCRumVd
         AsCwepYruzIuvju6P6QeqeeyrHza0D++5vOtxmQL4wfpnW9iGeeGQ5KrPV6SS/LY/L4p
         2huA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVTn2r0i+8AIzxKvh7W+2HtTrXcgAylSzXmEKCHhhwo=;
        b=7tddWhxcLPW+PWEpY39vEjk/z50OBk6FMf4G2AJqTKEmx4dGpu9Slv2sEmIg4Wq1jM
         drSDp7ZBKG29N9WDRNSZsAPPxCAgK6gXY1GVO8Z/uOMhbjgt1y1U0opZjQaq4U+FFWXm
         vnw+bacX17Cg/R2v4hdS9kgoziHcXTi03nqY0gaP6z/6L2Kh5zKdFyCqfksbv9tpP5Nd
         3SLTuYY+vgfMChamDTK8JXgCPE2cVjbKmk4rfHlaQBSCxZ3IeGxx7rmjs0mtQ4BOC/Tl
         N2IcTZLsPYAQd24aRwy4dlvWAeFkuEagZWyP3rpbbMm43R4R70JH7fLUni1VJ0hmYhd+
         iyyA==
X-Gm-Message-State: AFqh2kpFc86X/EOwsKGEcNLQd1o+jGhnFyRPidtRExcu44Bi1rlli+w2
        l694zo0V8t6VFXibFMWaRvxrYxnfT5y+4g==
X-Google-Smtp-Source: AMrXdXt8tCwrM5ATCxp93J3F8G5h6EC5NaTXsvKdEbG4LxrKp4XAF6vfmhPRz+AM3bGXEi1tuIm0vg==
X-Received: by 2002:aa7:c0d4:0:b0:49d:9bd8:6253 with SMTP id j20-20020aa7c0d4000000b0049d9bd86253mr7439304edp.17.1674043725938;
        Wed, 18 Jan 2023 04:08:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm14120053edt.8.2023.01.18.04.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 04:08:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 13/19] builtin/merge.c: use fixed strings, not "strbuf", fix leak
Date:   Wed, 18 Jan 2023 13:08:26 +0100
Message-Id: <patch-v5-13.19-1f3e3524580-20230118T120334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com> <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
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
2.39.0.1225.g30a3d88132d

