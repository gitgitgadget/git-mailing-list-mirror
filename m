Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A6DC433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 14:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbhLTO50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 09:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbhLTOz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 09:55:28 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66804C08EC6F
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 06:48:21 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id g132so4206357wmg.2
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 06:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=viV05ECn3yXTQJKvdp3nVCqxOIRQk+2LXBWPBXwsFus=;
        b=T8Ksi7sS+tFR6l2MSFht/faLe4rK7YfUF5Fx3W6vpmhS6Ja/eQogasl7XIVeeP+6ZU
         DqoGNSkSBfPhZfvugsmzBDm7VWNlWktpMUf6XvrNB6ige7rjoi22zGNxSzIGJtiTCN/T
         yPqNjd8g1GkRrQgA5UyWKKg1voVLsE+MiqLjGXYvEcxBcf0FgPsfpa3MXrbpQxdJaYA0
         JxPJCtNyUZpFl9Wo0ZSCgaUKp4FUzOO2A/DKd4XOrZ4hnWdftKYzg/51XQRMKAj7b+xD
         Ajxb9SmdhIJOs1HVmm1b2FS8qdDB8G9fSDJd8RClpYTxx6RqFw83qzGtLS6/nDMUtNZ3
         /uIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=viV05ECn3yXTQJKvdp3nVCqxOIRQk+2LXBWPBXwsFus=;
        b=xaIUePPHQAO48J4WBxoW0d0+tU2Wr/k8rvdJy7BbXywhLdneabkK2Gi1yAeH9VGGHs
         fmim/CXKs26hOC77wtz3FsgoH++raaFYmdSJQgRNuBUYOf7SVmIvhXoy2m1vJ5I3FivE
         4GsNYjpjEHVFPLcKnOE42IcvcJX4Qj2wb3tZyorIZvJjMfQ3wGHegQgnf9qjHquJ1NOh
         ZONdEiEBggALOUAGB/lZyreD7ZdoU8aLqwiR1pL1txVcXuXoG2xOBa2HyKkw7xmA1fRP
         8OeJxAuvUonZPXFKD4wfx2ZxVU8azBtjkzXa2icV2G/BS2CGYE0a83YPXCwIeK8PrnoQ
         uGww==
X-Gm-Message-State: AOAM530NwLDo4yiQQDK2pMc5FoPjqdLEvMEzcS8Qn/FzXEjZBdEymmQO
        oNHCgLBvBul0RWxhZsYrGb5a8SzqUrk=
X-Google-Smtp-Source: ABdhPJxlHXMFjas2PYW6fVoNGo0vwAuXr7eeB5QF/x9Uto5OZUhRNWZW9jokugM+KHQxoA+Ov79MOg==
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr14607677wmg.20.1640011694505;
        Mon, 20 Dec 2021 06:48:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u9sm14403589wmm.7.2021.12.20.06.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 06:48:14 -0800 (PST)
Message-Id: <41260bf0829970eeb27bec2cb41cabeffa54dabb.1640011691.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1098.v2.git.1640011691.gitgitgadget@gmail.com>
References: <pull.1098.git.1639758526.gitgitgadget@gmail.com>
        <pull.1098.v2.git.1640011691.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 14:48:11 +0000
Subject: [PATCH v2 2/2] repack: make '--quiet' disable progress
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

While testing some ideas in 'git repack', I ran it with '--quiet' and
discovered that some progress output was still shown. Specifically, the
output for writing the multi-pack-index showed the progress.

The 'show_progress' variable in cmd_repack() is initialized with
isatty(2) and is not modified at all by the '--quiet' flag. The
'--quiet' flag modifies the po_args.quiet option which is translated
into a '--quiet' flag for the 'git pack-objects' child process. However,
'show_progress' is used to directly send progress information to the
multi-pack-index writing logic which does not use a child process.

The fix here is to modify 'show_progress' to be false if po_opts.quiet
is true, and isatty(2) otherwise. This new expectation simplifies a
later condition that checks both.

Update the documentation to make it clear that '-q' will disable all
progress in addition to ensuring the 'git pack-objects' child process
will receive the flag.

Use 'test_terminal' to check that this works to get around the isatty(2)
check.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-repack.txt | 5 +++--
 builtin/repack.c             | 6 ++++--
 t/t7700-repack.sh            | 7 +++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 7183fb498f4..ee30edc178a 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -76,8 +76,9 @@ to the new separate pack will be written.
 	linkgit:git-pack-objects[1].
 
 -q::
-	Pass the `-q` option to 'git pack-objects'. See
-	linkgit:git-pack-objects[1].
+--quiet::
+	Show no progress over the standard error stream and pass the `-q`
+	option to 'git pack-objects'. See linkgit:git-pack-objects[1].
 
 -n::
 	Do not update the server information with
diff --git a/builtin/repack.c b/builtin/repack.c
index 1f128b7c90b..c393a5db774 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -612,7 +612,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct tempfile *refs_snapshot = NULL;
 	int i, ext, ret;
 	FILE *out;
-	int show_progress = isatty(2);
+	int show_progress;
 
 	/* variables to be filled by option parsing */
 	int pack_everything = 0;
@@ -725,6 +725,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	prepare_pack_objects(&cmd, &po_args);
 
+	show_progress = !po_args.quiet && isatty(2);
+
 	strvec_push(&cmd.args, "--keep-true-parents");
 	if (!pack_kept_objects)
 		strvec_push(&cmd.args, "--honor-pack-keep");
@@ -926,7 +928,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			}
 			strbuf_release(&buf);
 		}
-		if (!po_args.quiet && show_progress)
+		if (show_progress)
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(opts);
 
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 63c9a247f57..fe2b493d0ee 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -5,6 +5,7 @@ test_description='git repack works correctly'
 . ./test-lib.sh
 . "${TEST_DIRECTORY}/lib-bitmap.sh"
 . "${TEST_DIRECTORY}/lib-midx.sh"
+. "${TEST_DIRECTORY}/lib-terminal.sh"
 
 commit_and_pack () {
 	test_commit "$@" 1>&2 &&
@@ -378,4 +379,10 @@ test_expect_success '--write-midx -b packs non-kept objects' '
 	test_subcommand_inexact git pack-objects --honor-pack-keep <trace.txt
 '
 
+test_expect_success TTY '--quiet disables progress' '
+	test_terminal env GIT_PROGRESS_DELAY=0 \
+		git -C midx repack -ad --quiet --write-midx 2>stderr &&
+	test_must_be_empty stderr
+'
+
 test_done
-- 
gitgitgadget
