Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4C4C4332F
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 07:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKTHtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 02:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKTHtT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 02:49:19 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED379A3421
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 23:49:18 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id h14so7968332pjv.4
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 23:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03PoZ9UMSq+AOPU3jGotV+uG893UvXGYZ1OAgpw1xck=;
        b=aw4AKbo0hSjKSp0dakylq2I+jBQSwkiPrfcqwLVqTZnv2T/+q9yDGdt61Z6ZttvlYa
         PNJa2fmEHD9TJ7Mr2jb5+0xcAbLsicXxPTnKFGsD7gsTvJGAUhuLkDtL5Vt3jCmSszbX
         yCXZEVOZ/AjZNu2chwOCwDYqaiREGQOV/mZLbukzkxTmf1bk4shQl8kFRwHnc/IjpF6j
         BglK1CpYf7w7j6N+854R3/w2SwsJzQ9LUjkqqj3X+RnnEsPgbdJ+wDRsId0khheQ6tuU
         uR13J8PPA62PMDD3gLysmwf3oVaf8R8iB3Js13BO4elHI2eNlBE4aNK8QSMUiIVxiXt5
         RR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03PoZ9UMSq+AOPU3jGotV+uG893UvXGYZ1OAgpw1xck=;
        b=RmOtY5n2pz8QpM6LBelN3bL1MgGkc+eAzaowh6Flj0khkUOA86r6SOvIFvbfQTb5k6
         eD/SmC3STpvPLYks/s24koatYaIerFpSZX9xS2f2tn7wQC5NTVy3lvh09uAQ/PYRQvrk
         j4O12IhbhvnhscvbZT/TCwRt5agfO1Ks/XYjPwHrdRqb6GAUXW2WDgsF02+Rc4YCDVjR
         NWtxkP9l6Wof+8UxMl4dIZ9YaqsTMN/PSipMPEx7hc63eUqfVlaAFoCSKIrnfXsio1ag
         PS6E/jI2tVEljrOtDvV9yQQ+mPmJMUlFDjctSp0Pi43OfCCsehiOFS6E9epRZ7xxKrx/
         q0MQ==
X-Gm-Message-State: ANoB5pnc1HEJs3zVyUJ3vUMsI6NfTRxCt/4NA1Zal0+hmmqfz16DaW+p
        LY8A4Yf2aHGN4+cRaLuyMXkxVw/BKaDf7WmT
X-Google-Smtp-Source: AA0mqf6cKHjLal1WoaT1LWu/uLDwcv5ynPfRsX5pHKk+2VWryyv9hDPnfpze/C7evg1cFkxZZjv4lQ==
X-Received: by 2002:a17:903:2642:b0:186:8558:ded2 with SMTP id je2-20020a170903264200b001868558ded2mr6779155plb.95.1668930558034;
        Sat, 19 Nov 2022 23:49:18 -0800 (PST)
Received: from HB2.. ([2409:4081:9e01:f9e1:b435:9ad:e08d:a7fb])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e80600b001871461688esm6988645plg.175.2022.11.19.23.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 23:49:17 -0800 (PST)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, me@ttaylorr.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v5 2/2] cat-file: add mailmap support to --batch-check option
Date:   Sun, 20 Nov 2022 13:18:52 +0530
Message-Id: <20221120074852.121346-3-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.1.438.gd2340c8913
In-Reply-To: <20221120074852.121346-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221120074852.121346-1-siddharthasthana31@gmail.com>
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
patch also fixes that documentation.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-cat-file.txt | 49 +++++++++++++++++++++++++---------
 builtin/cat-file.c             | 14 ++++++++++
 t/t4203-mailmap.sh             | 32 ++++++++++++++++++++++
 3 files changed, 82 insertions(+), 13 deletions(-)

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
index 8a6e2343ec..39f2a2483f 100644
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
index 87b77fc5c9..21ba6bc278 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -1047,4 +1047,36 @@ test_expect_success 'git cat-file -s returns correct size with --use-mailmap for
 	test_cmp expect actual
 '
 
+test_expect_success 'git cat-file --batch-check returns correct size with --use-mailmap' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	commit_size=`git cat-file commit HEAD | wc -c` &&
+	commit_sha=`git log --pretty=format:'%H' -n 1` &&
+	echo "$commit_sha commit $commit_size" >expect &&
+	commit_size=`git cat-file --use-mailmap commit HEAD | wc -c` &&
+	echo "$commit_sha commit $commit_size" >>expect &&
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
+	commit_size=`git cat-file commit HEAD | wc -c` &&
+	commit_sha=`git log --pretty=format:'%H' -n 1` &&
+	echo "$commit_sha commit $commit_size" >expect &&
+	commit_size=`git cat-file --use-mailmap commit HEAD | wc -c` &&
+	echo "$commit_sha commit $commit_size" >>expect &&
+	echo "info HEAD" >in &&
+	git cat-file --batch-command <in >actual &&
+	git cat-file --use-mailmap --batch-command <in >>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.38.1.438.gd2340c8913

