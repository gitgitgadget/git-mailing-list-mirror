Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03BAC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 06:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiLTGBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 01:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiLTGBo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 01:01:44 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D83BF4
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 22:01:36 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id l10so11241894plb.8
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 22:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9alnJ0sEWlB20pcxaWo/zQhfaQMu4C+d6sOJCrIIeFM=;
        b=P/6Yyk1s+J0d68vluqOv/RuH4Q08PfGlBh2lfneCzH53sqRINJItKaRYti8oZhSCJF
         vGdq36GwU9LKLOTQEgmSRYjIkNnA6siw68RWjlQT77VcDluo2UmGUJSyXkYgKB1a0T51
         2l/4VU5bUFwX8yQbyiZCEUU63AQslujnk+X+dW+/1vW420+FntvB01TFu9I2JcAPv21I
         nWP4QYruLUJC8W5MFcsaKxAkzUVHIzrGNSRtz3X8IhAo7l+eZ8rcDsu+B32ut7F1MfqH
         5ybIR9M71HiEScoAdM2u6DK5Th4M7q06m+g57wtaw8Uv9rUUYkNdDlS4s9vodiZ3SirC
         F0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9alnJ0sEWlB20pcxaWo/zQhfaQMu4C+d6sOJCrIIeFM=;
        b=z1YKKgnoHHxTD18hMOjUfk8yAFj7Bn75hFqRp4945X+HYlAwTgjd5dZlRgXF4Hqm0u
         lPCYrYtVcdQV4IIyDVEmZo6E45LXtklzftNbhshJKRHgJKIaAxKBUkp7k+2WzoALSoS8
         j5tt/Ypk8eMC3CVfWmk2XiQW/Q/unZF8SizHUgYrTxq9aD3tCSExJ1F6V0fhOWNB08kO
         Kg0KX9bb9kuzeY9lWEKM+73zlKSGfd2OB8VrQiUwMsth9Le/LlEgajz/9hkNbbc+4SZE
         kKJ2hDOhkR78hS5t9EqUobx4EE9JZlX2wXMYfUWq2qoAwHbyhxrNImYf66/Pen0h9AZ5
         epBg==
X-Gm-Message-State: ANoB5pnzIh7yTldga2rVFoXguX5J0qY6Ptapb0MADV++iYi90la/25bv
        KGKku4DbECSJGaMOBVdvMP00Dsvug6vj6g==
X-Google-Smtp-Source: AA0mqf7SusQurdjggwsSBkEn+VH9GzeaqW4RWOQ8dURWgiRI1OQ8d01+hsbQFTDJPFUuxHslBJtNXA==
X-Received: by 2002:a17:90b:3744:b0:21a:fd7:210d with SMTP id ne4-20020a17090b374400b0021a0fd7210dmr45840252pjb.2.1671516095580;
        Mon, 19 Dec 2022 22:01:35 -0800 (PST)
Received: from HB2.. ([223.177.27.192])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090a0d0f00b0021358bd24b9sm10211041pja.21.2022.12.19.22.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 22:01:35 -0800 (PST)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, me@ttaylorr.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v7 2/2] cat-file: add mailmap support to --batch-check option
Date:   Tue, 20 Dec 2022 11:31:13 +0530
Message-Id: <20221220060113.51010-3-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.39.0.97.g8305148718
In-Reply-To: <20221220060113.51010-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221220060113.51010-1-siddharthasthana31@gmail.com>
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
   call to `repo_read_object_file()` to read the contents of the object.

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
 builtin/cat-file.c             | 15 +++++++++++
 t/t4203-mailmap.sh             | 36 +++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index f82d702d6b..830f0a2eff 100644
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
+	except `--textconv`, `--filters`, or `--use-mailmap`.
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
+	combined with any other options or arguments except `--textconv`, `--filters`
+	or `--use-mailmap`.
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
index dde8dbeacd..cc17635e76 100644
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
@@ -457,6 +460,18 @@ static void batch_object_write(const char *obj_name,
 			fflush(stdout);
 			return;
 		}
+
+		if (use_mailmap && (data->type == OBJ_COMMIT || data->type == OBJ_TAG)) {
+			size_t s = data->size;
+			char *buf = NULL;
+
+			buf = repo_read_object_file(the_repository, &data->oid, &data->type,
+						    &data->size);
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
2.39.0.97.g8305148718

