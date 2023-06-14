Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95067EB64D9
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 19:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbjFNT0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236703AbjFNT01 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 15:26:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CD926A1
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:26:13 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f8ca80e889so10120035e9.3
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686770771; x=1689362771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2hVlUib114K1vh7cLAEePRmblkimNleZ0RKnEw6gKU=;
        b=NHnCyqOw37icp1TMn5LVHjO2WG/QYx43uviFCwaMgrvNyXVy0tfklSM7fHZAs53nyA
         rIkXaNZ+O9MEkZOaiH56wp5RSrtRyDsXVZCWcSXWTogOhdT6VnRZwOQjDb7kapHpa8ic
         WwpX6PdyCeZ7dzxmJ29EO0hyNRwfhb65M3V5ofVYXtb1t98DDJ+erodOYOIlw/uJsBli
         jaUZPOvAyGmGvs2/ylzSn1eHlV9VBE0UeXKWs+SqT0Fw22c17QDxSk4UR6RZAKovoVHq
         e5Fl6ujvI/amzAHzWG+dKy+keluwhesy5ykIdveI83e4ZNsV7Nq9qhg8TWsQntGR9wWp
         NCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770771; x=1689362771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2hVlUib114K1vh7cLAEePRmblkimNleZ0RKnEw6gKU=;
        b=CnUAqBb4vHMmBmiK2Ts3mV/LxINU/l8EXuKqvrSLPdmKucntJ0VEeD3N3J/eOmbzeb
         W6crpVd+eQkwFNyOzOTf8BF71epIG1a4CO69cKPQLkyvPkoA1DgA3uqZhhOHcQn+dfeZ
         a9Gq5QnbsdwAR+ZO/PyCY0YH+jKUAE7RsAzCpYCVD/zJZOYRwDjtpRl1vVrhGxgrRcPK
         n91cJ3JVgeWnbunSE1PZJrQd5pO9B9heEym5lkFB2GsV2NYxrOoD6KTcD289RQDRICES
         ttIw8jdNOr8Gm+rEwb8mfwXlawrdz/rr2nD8/P/zHph32qUD4dMOB0FO23uS94rsk09W
         7Z/Q==
X-Gm-Message-State: AC+VfDxIGekhJj+3mUQnbNw74oMu4Tone5TJE4fBmkkeWECCUdfSmj2v
        QYX91TtaEsEp6TXGwZYkvTu23a8VvbI=
X-Google-Smtp-Source: ACHHUZ5hDiGck/pJb5ryOta+FtuHuSar/00XWculhFXC/ox5Yu2NF28L7f9mPweTh0gQvVdE71y6MA==
X-Received: by 2002:a1c:7715:0:b0:3f8:153b:a51e with SMTP id t21-20020a1c7715000000b003f8153ba51emr8069606wmi.36.1686770771558;
        Wed, 14 Jun 2023 12:26:11 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:e164:efe0:8fdb:6ba])
        by smtp.gmail.com with ESMTPSA id u26-20020a05600c00da00b003eddc6aa5fasm18370365wmm.39.2023.06.14.12.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:26:10 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 8/9] repack: implement `--filter-to` for storing filtered out objects
Date:   Wed, 14 Jun 2023 21:25:40 +0200
Message-ID: <20230614192541.1599256-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.37.gae45d9845e
In-Reply-To: <20230614192541.1599256-1-christian.couder@gmail.com>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A previous commit has implemented `git repack --filter=<filter-spec>` to
allow users to filter out some objects from the main pack and move them
into a new different pack.

It would be nice if this new different pack could be created in a
different directory than the regular pack. This would make it possible
to move large blobs into a pack on a different kind of storage, for
example cheaper storage. Even in a different directory this pack can be
accessible if, for example, the Git alternates mechanism is used to
point to it.

If users want to remove a pack that contains filtered out objects after
checking that they are all already on a promisor remote, creating the
pack in a different directory makes it easier to do so.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-repack.txt |  6 ++++++
 builtin/repack.c             | 17 ++++++++++++-----
 t/t7700-repack.sh            | 27 +++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index aa29c7e648..070dd22610 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -148,6 +148,12 @@ depth is 4095.
 	resulting packfile and put them into a separate packfile. See
 	linkgit:git-rev-list[1] for valid `<filter-spec>` forms.
 
+--filter-to=<dir>::
+	Write the pack containing filtered out objects to the
+	directory `<dir>`. This can be used for putting the pack on a
+	separate object directory that is accessed through the Git
+	alternates mechanism. Only useful with `--filter`.
+
 -b::
 --write-bitmap-index::
 	Write a reachability bitmap index as part of the repack. This
diff --git a/builtin/repack.c b/builtin/repack.c
index b13d7196de..8c71e8fd51 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -838,7 +838,8 @@ static void prepare_pack_filtered_cmd(struct child_process *cmd,
 }
 
 static void finish_pack_filtered_cmd(struct child_process *cmd,
-				     struct string_list *names)
+				     struct string_list *names,
+				     const char *destination)
 {
 	if (cmd->in == -1) {
 		/* No packed objects; cmd was never started */
@@ -848,7 +849,7 @@ static void finish_pack_filtered_cmd(struct child_process *cmd,
 
 	close(cmd->in);
 
-	if (finish_pack_objects_cmd(cmd, names, NULL, NULL))
+	if (finish_pack_objects_cmd(cmd, names, destination, NULL))
 		die(_("could not finish pack-objects to pack filtered objects"));
 }
 
@@ -877,6 +878,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	const char *cruft_expiration = NULL;
 	const char *expire_to = NULL;
 	struct child_process pack_filtered_cmd = CHILD_PROCESS_INIT;
+	const char *filter_to = NULL;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -930,6 +932,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			   N_("write a multi-pack index of the resulting packs")),
 		OPT_STRING(0, "expire-to", &expire_to, N_("dir"),
 			   N_("pack prefix to store a pack containing pruned objects")),
+		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
+			   N_("pack prefix to store a pack containing filtered out objects")),
 		OPT_END()
 	};
 
@@ -1073,8 +1077,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		strvec_push(&cmd.args, "--incremental");
 	}
 
-	if (po_args.filter)
-		prepare_pack_filtered_cmd(&pack_filtered_cmd, &po_args, packtmp);
+	if (po_args.filter) {
+		if (!filter_to)
+			filter_to = packtmp;
+		prepare_pack_filtered_cmd(&pack_filtered_cmd, &po_args, filter_to);
+	}
 
 	if (geometry)
 		cmd.in = -1;
@@ -1169,7 +1176,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	}
 
 	if (po_args.filter)
-		finish_pack_filtered_cmd(&pack_filtered_cmd, &names);
+		finish_pack_filtered_cmd(&pack_filtered_cmd, &names, filter_to);
 
 	string_list_sort(&names);
 
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 9e7654090f..898f8a01b4 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -286,6 +286,33 @@ test_expect_success 'repacking with a filter works' '
 	test "$blob_pack2" = "$blob_pack"
 '
 
+test_expect_success '--filter-to stores filtered out objects' '
+	git -C bare.git repack -a -d &&
+	test_stdout_line_count = 1 ls bare.git/objects/pack/*.pack &&
+
+	git init --bare filtered.git &&
+	git -C bare.git -c repack.writebitmaps=false repack -a -d \
+		--filter=blob:none \
+		--filter-to=../filtered.git/objects/pack/pack &&
+	test_stdout_line_count = 1 ls bare.git/objects/pack/pack-*.pack &&
+	test_stdout_line_count = 1 ls filtered.git/objects/pack/pack-*.pack &&
+
+	commit_pack=$(test-tool -C bare.git find-pack HEAD) &&
+	test -n "$commit_pack" &&
+	blob_pack=$(test-tool -C bare.git find-pack HEAD:file1) &&
+	test -z "$blob_pack" &&
+	blob_hash=$(git -C bare.git rev-parse HEAD:file1) &&
+	test -n "$blob_hash" &&
+	blob_pack=$(test-tool -C filtered.git find-pack $blob_hash) &&
+	test -n "$blob_pack" &&
+
+	echo $(pwd)/filtered.git/objects >bare.git/objects/info/alternates &&
+	blob_pack=$(test-tool -C bare.git find-pack HEAD:file1) &&
+	test -n "$blob_pack" &&
+	blob_content=$(git -C bare.git show $blob_hash) &&
+	test "$blob_content" = "content1"
+'
+
 objdir=.git/objects
 midx=$objdir/pack/multi-pack-index
 
-- 
2.41.0.37.gae45d9845e

