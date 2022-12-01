Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2069DC43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 15:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiLAPzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 10:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiLAPza (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 10:55:30 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E33B0DF3
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 07:55:29 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id q15so1200853pja.0
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 07:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9qfpmm1y1m1ufCC0Zf8ZOsk6O1YTRee3MkyeynW2rs=;
        b=VUVSqDi6l2XmXt8EW4HohxAs2VYZOep8E7Pcg479KTkQEDvjOWJMOvqcb5clKiyo1P
         UPOkRFmebAgRNFvYhC/zm6CR5wNJ76u5L7vLjjvVO5KW/5G3nOVeJB1jbCbJIZlb6nJT
         blV72AsoOnz/uY/0jFjFRw2u1G/DS2Zxc4Ysco08XpgNhe23jAqbW8/ymJql6W2IvcnX
         AEAKDPF4bg2AJZlBSGTvoxrp5pDiQWFecYLdxWSLzlAaNr61XaDqujqQ/DUnfGyiOEqk
         uTVOY3ECy00vuaDDeN6wkPlaHwd7xuAbhRCV8dvGaFk27EulrZjjQZ5jKk3Q47kVXZ2u
         PFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9qfpmm1y1m1ufCC0Zf8ZOsk6O1YTRee3MkyeynW2rs=;
        b=nbi3Ei477XiYRFNTcu6elNLFT6HATMkWJbPuMe/iSWPMTtvPmD7rkVTbZAzDQpFfoO
         sLhOwKUtLabW/N9ozMKIEr0ZC4BVgmLMmpqVhPcJSoMiwYLrbTrhzSiIFuPA6pcO0kh2
         hyt3r7sHDRvoGKUAdv600oaj1RndkycXYP4EWw76yJFj/BpxgvN9t2bvihY+Gqh28s2b
         qDEslQh4pieSBPvRts4GcEwKBoihthYmLntoWxAjlR5lDuP5rf51ViexogGnG73rzj5H
         yWYgp9U2ZEVP15qBvsNxDIy8Oj26F2WLjMJUBT2p32E2ou9OgaEC1j1LR0IwYLCKPKoc
         9kUA==
X-Gm-Message-State: ANoB5pnPldMEaicJZx3fxiqsU7FbrjEGmxP4OhMm7b5Kn9Nzx8hFuvM8
        eMIG4zTaajGMs2V4QBfEI8DuFZGBnH5cQQ==
X-Google-Smtp-Source: AA0mqf7nutv/Bfb6b6mjXpcQKAvPf+Nn6Mpmo765x3s0zMbVN+Nk/YcaZFjcnJ12btA+x4Pe+vD7cQ==
X-Received: by 2002:a17:90a:a08:b0:219:7ec6:8f4a with SMTP id o8-20020a17090a0a0800b002197ec68f4amr2342263pjo.184.1669910128673;
        Thu, 01 Dec 2022 07:55:28 -0800 (PST)
Received: from HB2.. ([2401:4900:36ac:5594:1695:30e6:556:ccb7])
        by smtp.gmail.com with ESMTPSA id x28-20020aa78f1c000000b0056c349f5c70sm3405290pfr.79.2022.12.01.07.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 07:55:28 -0800 (PST)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, me@ttaylorr.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v6 2/2] cat-file: add mailmap support to --batch-check option
Date:   Thu,  1 Dec 2022 21:25:04 +0530
Message-Id: <20221201155504.320461-3-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.6.g86692db720
In-Reply-To: <20221201155504.320461-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221201155504.320461-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though the cat-file command with `--batch-check` option does not
complain when `--use-mailmap` option is given, the latter option is
ignored. Compute the size of the object after replacing the idents and
report it instead.

In order to make `--batch-check` option honour the mailmap mechanism we
have to read the contents of the commit/tag object.

There were two ways to do it:

1. Make two calls to `oid_object_info_extended()`. If `--use-mailmap`
   option is given, the first call will get us the type of the object
   and second call will only be made if the object type is either a
   commit or tag to get the contents of the object.

2. Make one call to `oid_object_info_extended()` to get the type of the
   object. Then, if the object type is either of commit or tag, make a
   call to `read_object_file()` to read the contents of the object.

I benchmarked the following command with both the above approaches and
compared against the current implementation where `--use-mailmap`
option is ignored:

`git cat-file --use-mailmap --batch-all-objects --batch-check --buffer
--unordered`

The results can be summarized as follows:
                       Time (mean ± σ)
default               827.7 ms ± 104.8 ms
first approach        6.197 s ± 0.093 s
second approach       1.975 s ± 0.217 s

Since, the second approach is faster than the first one, I implemented
it in this patch.

The command git cat-file can now use the mailmap mechanism to replace
idents with canonical versions for commit and tag objects. There are
several options like `--batch`, `--batch-check` and `--batch-command`
that can be combined with `--use-mailmap`. But the documentation for
`--batch`, `--batch-check` and `--batch-command` doesn't say so. This
patch fixes that documentation.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-cat-file.txt | 49 +++++++++++++++++++++++++---------
 builtin/cat-file.c             | 14 ++++++++++
 t/t4203-mailmap.sh             | 36 +++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index f82d702d6b..81235c60a3 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -91,26 +91,49 @@ OPTIONS
 --batch::
 --batch=<format>::
 	Print object information and contents for each object provided
-	on stdin.  May not be combined with any other options or arguments
-	except `--textconv` or `--filters`, in which case the input lines
-	also need to specify the path, separated by whitespace.  See the
-	section `BATCH OUTPUT` below for details.
+	on stdin. May not be combined with any other options or arguments
+	except --textconv, --filters, or --use-mailmap.
+	+
+	* When used with `--textconv` or `--filters`, the input lines
+	  must specify the path, separated by whitespace. See the section
+	  `BATCH OUTPUT` below for details.
+	+
+	* When used with `--use-mailmap`, for commit and tag objects, the
+	  contents part of the output shows the identities replaced using the
+	  mailmap mechanism, while the information part of the output shows
+	  the size of the object as if it actually recorded the replacement
+	  identities.
 
 --batch-check::
 --batch-check=<format>::
-	Print object information for each object provided on stdin.  May
-	not be combined with any other options or arguments except
-	`--textconv` or `--filters`, in which case the input lines also
-	need to specify the path, separated by whitespace.  See the
-	section `BATCH OUTPUT` below for details.
+	Print object information for each object provided on stdin. May not be
+	combined with any other options or arguments except --textconv, --filters
+	or --use-mailmap.
+	+
+	* When used with `--textconv` or `--filters`, the input lines must
+	 specify the path, separated by whitespace. See the section
+	 `BATCH OUTPUT` below for details.
+	+
+	* When used with `--use-mailmap`, for commit and tag objects, the
+	  printed object information shows the size of the object as if the
+	  identities recorded in it were replaced by the mailmap mechanism.
 
 --batch-command::
 --batch-command=<format>::
 	Enter a command mode that reads commands and arguments from stdin. May
-	only be combined with `--buffer`, `--textconv` or `--filters`. In the
-	case of `--textconv` or `--filters`, the input lines also need to specify
-	the path, separated by whitespace. See the section `BATCH OUTPUT` below
-	for details.
+	only be combined with `--buffer`, `--textconv`, `--use-mailmap` or
+	`--filters`.
+	+
+	* When used with `--textconv` or `--filters`, the input lines must
+	  specify the path, separated by whitespace. See the section
+	  `BATCH OUTPUT` below for details.
+	+
+	* When used with `--use-mailmap`, for commit and tag objects, the
+	  `contents` command shows the identities replaced using the
+	  mailmap mechanism, while the `info` command shows the size
+	  of the object as if it actually recorded the replacement
+	  identities.
+
 +
 `--batch-command` recognizes the following commands:
 +
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index dde8dbeacd..7811016ae8 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -444,6 +444,9 @@ static void batch_object_write(const char *obj_name,
 	if (!data->skip_object_info) {
 		int ret;
 
+		if (use_mailmap)
+			data->info.typep = &data->type;
+
 		if (pack)
 			ret = packed_object_info(the_repository, pack, offset,
 						 &data->info);
@@ -457,6 +460,17 @@ static void batch_object_write(const char *obj_name,
 			fflush(stdout);
 			return;
 		}
+
+		if (use_mailmap && (data->type == OBJ_COMMIT || data->type == OBJ_TAG)) {
+			size_t s = data->size;
+			char *buf = NULL;
+
+			buf = read_object_file(&data->oid, &data->type, &data->size);
+			buf = replace_idents_using_mailmap(buf, &s);
+			data->size = cast_size_t_to_ulong(s);
+
+			free(buf);
+		}
 	}
 
 	strbuf_reset(scratch);
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index b8ec5e0959..fa7f987284 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -1051,4 +1051,40 @@ test_expect_success 'git cat-file -s returns correct size with --use-mailmap for
 	test_cmp expect actual
 '
 
+test_expect_success 'git cat-file --batch-check returns correct size with --use-mailmap' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	git cat-file commit HEAD >commit.out &&
+	commit_size=$(wc -c <commit.out) &&
+	commit_sha=$(git rev-parse HEAD) &&
+	echo $commit_sha commit $commit_size >expect &&
+	git cat-file --use-mailmap commit HEAD >commit.out &&
+	commit_size=$(wc -c <commit.out) &&
+	echo $commit_sha commit $commit_size >>expect &&
+	echo "HEAD" >in &&
+	git cat-file --batch-check <in >actual &&
+	git cat-file --use-mailmap --batch-check <in >>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-command returns correct size with --use-mailmap' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	git cat-file commit HEAD >commit.out &&
+	commit_size=$(wc -c <commit.out) &&
+	commit_sha=$(git rev-parse HEAD) &&
+	echo $commit_sha commit $commit_size >expect &&
+	git cat-file --use-mailmap commit HEAD >commit.out &&
+	commit_size=$(wc -c <commit.out) &&
+	echo $commit_sha commit $commit_size >>expect &&
+	echo "info HEAD" >in &&
+	git cat-file --batch-command <in >actual &&
+	git cat-file --use-mailmap --batch-command <in >>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.39.0.rc1.6.g86692db720

