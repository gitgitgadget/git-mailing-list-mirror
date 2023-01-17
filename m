Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E82C54E76
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 17:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjAQRMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjAQRL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 12:11:56 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4434442F0
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:38 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w14so28690092edi.5
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVTn2r0i+8AIzxKvh7W+2HtTrXcgAylSzXmEKCHhhwo=;
        b=iaz6dPZXe1PzciEKTbR7o9OuDFDhE7b4xujSaXXq9j/ioxYN0cRy+KHvXBGNL7lb94
         R0S2v/syNapzJVHKsjMASBWJUmnAQeX/Rx5JijxJNWWJmNi1Isxlv7yDnzF3UIAAVD6r
         s46JInvyMBkVofnsL1lvaON1s1G1TC+aD+Ae4Bnivz+LNYBkgBmcmSbkUn6GjNNFfn4t
         Codnf36JjVCqsQxsxaCuUnS9+LGPdTjS3rZg2BdM41Y+GUF65bUpD3Z6pPWJxrYP05nQ
         UUyFYJxYU+EfRDX4ekcJmhWp7TmdBntiHnzHuRHbCjdqZWWvTq5OGx5Hd6ZeUvRktGSY
         h1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVTn2r0i+8AIzxKvh7W+2HtTrXcgAylSzXmEKCHhhwo=;
        b=az+PuKmsCw6oViM/o2smpxdxLPCc17zCWoRP2bxSbKXppNi8WiNvhJs32XfuS/OGZi
         bTEpI4JFGLq6GQkOhhP4rL/M4X24g1L9JZVAGx8sqxNX8QmJZOkUixEKTZpCuepNsOrE
         sQTtnTsZHQ7XSWJEwI4gft1WVLjmhV+ogFt+jmqwstyobN1oQKYgP+gIX2/iDTAXADwq
         I4bSnv5AYfdim1loYJegF/9pF2f+AXM9VNPQkNPgGBmJE2tTOwnaPHhbVPGhYrnjCyhE
         xRfZIO7BQH0nKrdo9k6nD45rxZJ2csGyy5FIvxB2rJSPVTIb96ltrUASL5c6tCSnpfF7
         naMQ==
X-Gm-Message-State: AFqh2koEXb2OzVFmWlueWuDvaQIWqzf3c+k19mV/EiaasPf4YTMde6IX
        qpd5K7jiRQ+iblLTyb8LMWnwYbcM7zGv1w==
X-Google-Smtp-Source: AMrXdXuFxbE1Ezrb3sakwE4qIC6NSUi4pvx3jMi7Q5XfVNtWrhR87o08RDUFG77vd+ZBAj4LkG9a3Q==
X-Received: by 2002:aa7:d887:0:b0:499:1ed2:6461 with SMTP id u7-20020aa7d887000000b004991ed26461mr3957584edq.17.1673975496824;
        Tue, 17 Jan 2023 09:11:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2-20020a509302000000b0046892e493dcsm13191268eda.26.2023.01.17.09.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:11:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 13/19] builtin/merge.c: use fixed strings, not "strbuf", fix leak
Date:   Tue, 17 Jan 2023 18:11:18 +0100
Message-Id: <patch-v4-13.19-05836b08e0f-20230117T151202Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com> <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
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

