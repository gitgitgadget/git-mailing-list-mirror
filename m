Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE8FC6FA86
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 12:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239167AbiIZMGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 08:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239877AbiIZMFm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 08:05:42 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E585659EF
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 03:55:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t3so5899978ply.2
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 03:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tNfDA9AF4xKePriBiUXL02iS3j7PsVCuCKynMdIMbHo=;
        b=NG0uzVDAkTKegt1Z/Zej3I8kvaLZS0Ise3MDjCZ5akQ0rUY1iW4wfTOn803sprhNkU
         jnrmeJU14qqDKEWzUIfOq5tEl5mo5P7KnX4UOg0ObniA6WE8qn5HeDz/e6k2EcD+CwBd
         Pm8jHaFUY86yC0pQQVfvZuLgi9VYWFhgm7TbQ1V0P/02jzsHSJCeQ2HXWkk2Mf52bEF0
         dDD/aGyd8mZabs2SEgoYdJorbckhKIYhxUF6w1/mx9aqMKGaNwUe6QM3K+AqeZwmNn8e
         lfqk86ccGRQwIcHAC/rtLPQHILrXRerKczO9c8yGyGbI9jcly8l7YS0zO6aVD8lbQG0O
         ZjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tNfDA9AF4xKePriBiUXL02iS3j7PsVCuCKynMdIMbHo=;
        b=d+vpj319oaVu8tH0hqk8WxWmbe0nyncHMr6DS0/KRpqLXx3VCc86Re8+mrt9H/+tap
         7V9cMTJIanjwhYx/wfXH253GNFyHwVfj+h9qH++7JATDzh6n7RQ2NkVd9r2P2htO403z
         Q8YAU1f9Jkd4ZAnvYv/CkzWoR6Gp6ny/OwHySnpTwMVZN/ANotZG4I9xpcbEPOtVOkmx
         dZC0FujKZJB/tkuGJs120LTZvWRZ4PXw5HJojRxiBJWvMxxvVFEedGY2n3ifw2b66v6P
         QFvkrcP07cYNRBcVkyplxQYH7EyQECI7SgUHR+1/UypcBPAWKUdBBdsJnN1rR6dOLH2U
         v54w==
X-Gm-Message-State: ACrzQf0/v7bpsPHQD3QmbhlFofsUf28XwIWCFE4X6aGUHDjq5lklI6eg
        ey41OWAPOuEh+6JgAhqbLA/V43LRLJcQ9Q==
X-Google-Smtp-Source: AMsMyM5VsCkGox+ez20AYr5CaxDKv9lwKWUqT6alU9Ry2VPRsQeEnZAHgB3IujEO02SKUv7FBMICnQ==
X-Received: by 2002:a17:902:8c81:b0:178:1701:cd with SMTP id t1-20020a1709028c8100b00178170100cdmr21761524plo.138.1664189663567;
        Mon, 26 Sep 2022 03:54:23 -0700 (PDT)
Received: from HB2.. ([2409:4081:9e0a:3b3c:baa6:3f:18b6:80cf])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902c40a00b001782aee4881sm11031794plk.153.2022.09.26.03.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 03:54:22 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v2 2/2] cat-file: add mailmap support to --batch-check option
Date:   Mon, 26 Sep 2022 16:23:43 +0530
Message-Id: <20220926105343.233296-3-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.8.g9592ff2ba4
In-Reply-To: <20220926105343.233296-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20220926105343.233296-1-siddharthasthana31@gmail.com>
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

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-cat-file.txt |  2 ++
 builtin/cat-file.c             | 14 ++++++++++++++
 t/t4203-mailmap.sh             | 22 ++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 594b6f2dfd..a8e7906b3d 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -103,6 +103,8 @@ OPTIONS
 	`--textconv` or `--filters`, in which case the input lines also
 	need to specify the path, separated by whitespace.  See the
 	section `BATCH OUTPUT` below for details.
+	If used with `--use-mailmap` option, will show the size of
+	updated object after replacing idents using the mailmap mechanism.
 
 --batch-command::
 --batch-command=<format>::
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 9942b93867..7ee8cb453f 100644
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
index 59513e7c57..4b236c68aa 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -1032,4 +1032,26 @@ test_expect_success 'git cat-file -s returns correct size with --use-mailmap' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git cat-file --batch-check returns correct size with --use-mailmap' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	echo "92d99959b011b1cd69fe7be5315d6732fe302575 commit 220" >expect &&
+	echo "HEAD" >in &&
+	git cat-file --use-mailmap --batch-check <in >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-command returns correct size with --use-mailmap' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	echo "92d99959b011b1cd69fe7be5315d6732fe302575 commit 220" >expect &&
+	echo "info HEAD" >in &&
+	git cat-file --use-mailmap --batch-command <in >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.38.0.rc1.8.g9592ff2ba4

