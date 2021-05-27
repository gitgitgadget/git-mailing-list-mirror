Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491C9C4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 14:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BBD6613D8
	for <git@archiver.kernel.org>; Thu, 27 May 2021 14:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236521AbhE0OpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 10:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbhE0OpB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 10:45:01 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B6AC061761
        for <git@vger.kernel.org>; Thu, 27 May 2021 07:43:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id z130so367123wmg.2
        for <git@vger.kernel.org>; Thu, 27 May 2021 07:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rO99rP4TaMSEtwGvuSZU8jXly6RwP2acwvUOj/yLpys=;
        b=lCZfDM8ofeohPVTU3B3zvWrI3xieQxvm2kZS7JJEd/eSVylC0xpsofkMxgdo4xuURv
         tOD8lc9Qkm0wG6p6oGhJ5Z2ZzpOJA2b++iVZKERb5TdcpLXq9f/ccno3QpGMKBwZsqMD
         kLXzGu8xGGqeQV68b4wsgnv12j5MxJJWVLNlLD30yHHafHqIWRKz0jQELUDY5eQugguQ
         7ndX/bg7/l+xULQh0MS9qVvQ4D7+R0K4HuEkhmhS+yyjuaXSufBFp+x11xbm5rMfW1oQ
         YK+Kw+9OvpsVJByv4b36mWmeSg7yf0Mcai8rfrRkaVKsDc2OmgnjhauXGgn7HOri6YJP
         aofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rO99rP4TaMSEtwGvuSZU8jXly6RwP2acwvUOj/yLpys=;
        b=F6Sk9VkdaAJ1slPhCpJ0qDSI3D5PcxVLd+V53fDbVzqlxkNdKDiqJvuJHPlhgAs7tO
         2s+msQkI1auI+cYlkOCd11/VhA9uA+qEpbF4NtEy0X0FUiGPn6mVeSD2oWFrpmr6tbwT
         WfLMZQVS7Mawt1u7D0lnvLlSni9tc0pCNt6J6RREeQgR0fEWFwb6Ro9Klcq1SIQe1G2l
         9UYFjFwmixxHgWGSC/IAg+9bb1oxPbitunrN3HpVOvgt4txr5IvIwjZfpwungwEinZ8C
         A+2SZ39OFu6kzxhcZxQIxiR21Ba/b4s4dgPOQdXaKaQtp+A63AUn8J1DmDj5FXRbaFrz
         8OEQ==
X-Gm-Message-State: AOAM533gP2mmITPtQXIzWEr0qlsIUxZ5gCEWWU/lU8dqDNb4X+N5CXI6
        wSWiCeRkIqIG9z9aVTrRNvRmlaRXDv8=
X-Google-Smtp-Source: ABdhPJwCroyxXfyWjhq3KlKQfjmSuazjsKUVAEkpeAZQ/H8ewS4om5Yy9XRpUUqJzE6H61NBtJJRuA==
X-Received: by 2002:a7b:cc84:: with SMTP id p4mr3775421wma.171.1622126605714;
        Thu, 27 May 2021 07:43:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y189sm2184460wmy.25.2021.05.27.07.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 07:43:25 -0700 (PDT)
Message-Id: <aa6d73f3e526f416ee1e4e332e9ca3119efba0e8.1622126603.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.963.git.1622126603.gitgitgadget@gmail.com>
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 May 2021 14:43:22 +0000
Subject: [PATCH 2/2] [GSOC] ref-filter: add %(header) atom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Add new formatting option `%(header)`, which will print the
the structured header part of the raw object data.

In the storage layout of an object: blob and tree only
contains raw data; commit and tag raw data contains two part:
header and contents. The header of tag contains "object OOO",
"type TTT", "tag AAA", "tagger GGG"; The header of commit
contains "tree RRR", "parent PPP", "author UUU", "committer CCC".

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-for-each-ref.txt |  7 +++++
 ref-filter.c                       | 26 +++++++++++++++++
 t/t6300-for-each-ref.sh            | 45 ++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index f6ae751fd256..7827e48cde75 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -249,6 +249,13 @@ Note that `--format=%(raw)` should not combine with `--python`, `--shell`, `--tc
 `--perl` because if our binary raw data is passed to a variable in the host language,
 the host languages may cause escape errors.
 
+The structured header part of the raw data in a commit or a tag object is `header`,
+it composed of "tree XXX", "parent YYY", etc lines in commits, or composed of
+"object OOO", "type TTT", etc lines in tags.
+
+header:size::
+	The header size of the object.
+
 The message in a commit or a tag object is `contents`, from which
 `contents:<part>` can be used to extract various parts out of:
 
diff --git a/ref-filter.c b/ref-filter.c
index c2abf5da7006..2f426830f562 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -141,6 +141,9 @@ static struct used_atom {
 		struct {
 			enum { RAW_BARE, RAW_LENGTH } option;
 		} raw_data;
+		struct {
+			enum { H_BARE, H_LENGTH } option;
+		} header;
 		struct {
 			cmp_status cmp_status;
 			const char *str;
@@ -385,6 +388,18 @@ static int raw_atom_parser(const struct ref_format *format, struct used_atom *at
 	return 0;
 }
 
+static int header_atom_parser(const struct ref_format *format, struct used_atom *atom,
+			      const char *arg, struct strbuf *err)
+{
+	if (!arg)
+		atom->u.header.option = H_BARE;
+	else if (!strcmp(arg, "size"))
+		atom->u.header.option = H_LENGTH;
+	else
+		return strbuf_addf_ret(err, -1, _("unrecognized %%(header) argument: %s"), arg);
+	return 0;
+}
+
 static int oid_atom_parser(const struct ref_format *format, struct used_atom *atom,
 			   const char *arg, struct strbuf *err)
 {
@@ -546,6 +561,7 @@ static struct {
 	{ "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
 	{ "contents", SOURCE_OBJ, FIELD_STR, contents_atom_parser },
 	{ "raw", SOURCE_OBJ, FIELD_STR, raw_atom_parser },
+	{ "header", SOURCE_OBJ, FIELD_STR, header_atom_parser },
 	{ "upstream", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
 	{ "push", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
 	{ "symref", SOURCE_NONE, FIELD_STR, refname_atom_parser },
@@ -1362,6 +1378,7 @@ static void grab_raw_data(struct atom_value *val, int deref, void *buf, unsigned
 		if ((obj->type != OBJ_TAG &&
 		     obj->type != OBJ_COMMIT) ||
 		    (strcmp(name, "body") &&
+		     !starts_with(name, "header") &&
 		     !starts_with(name, "subject") &&
 		     !starts_with(name, "trailers") &&
 		     !starts_with(name, "contents")))
@@ -1372,6 +1389,15 @@ static void grab_raw_data(struct atom_value *val, int deref, void *buf, unsigned
 				    &bodypos, &bodylen, &nonsiglen,
 				    &sigpos, &siglen);
 
+		if (starts_with(name, "header")) {
+			size_t header_len = subpos - (const char *)buf - 1;
+			if (atom->u.header.option == H_BARE) {
+				v->s = xmemdupz(buf, header_len);
+			} else if (atom->u.header.option == H_LENGTH)
+				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)header_len);
+			continue;
+		}
+
 		if (atom->u.contents.option == C_SUB)
 			v->s = copy_subject(subpos, sublen);
 		else if (atom->u.contents.option == C_SUB_SANITIZE) {
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 07de4a84d70b..11fc8fc53649 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -232,6 +232,35 @@ test_expect_success 'basic atom: refs/tags/testtag *raw' '
 	test_cmp expected.clean actual.clean
 '
 
+test_expect_success 'basic atom: refs/tags/testtag header' '
+	cat >expected <<-EOF &&
+	object ea122842f48be4afb2d1fc6a4b96c05885ab7463
+	type commit
+	tag testtag
+	tagger C O Mitter <committer@example.com> 1151968725 +0200
+
+	EOF
+	git for-each-ref --format="%(header)" refs/tags/testtag >actual &&
+	test_cmp expected actual &&
+	echo "131" >expected &&
+	git for-each-ref --format="%(header:size)" refs/tags/testtag >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'basic atom: refs/heads/main header' '
+	cat >expected <<-EOF &&
+	tree 8039ce043250c402d62ca312e9596e42ce1c7bb0
+	author A U Thor <author@example.com> 1151968724 +0200
+	committer C O Mitter <committer@example.com> 1151968723 +0200
+
+	EOF
+	git for-each-ref --format="%(header)" refs/heads/main >actual &&
+	test_cmp expected actual &&
+	echo "162" >expected &&
+	git for-each-ref --format="%(header:size)" refs/heads/main >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
 '
@@ -768,6 +797,14 @@ test_expect_success 'basic atom: refs/mytrees/first raw' '
 	test_cmp expected actual
 '
 
+test_expect_success 'basic atom: refs/mytrees/first header' '
+	echo "" >expected &&
+	git for-each-ref --format="%(header)" refs/mytrees/first >actual &&
+	test_cmp expected actual &&
+	git for-each-ref --format="%(header:size)" refs/mytrees/first >actual &&
+	test_cmp expected actual
+'
+
 test_atom refs/myblobs/first subject ""
 test_atom refs/myblobs/first contents:subject ""
 test_atom refs/myblobs/first body ""
@@ -785,6 +822,14 @@ test_expect_success 'basic atom: refs/myblobs/first raw' '
 	test_cmp expected actual
 '
 
+test_expect_success 'basic atom: refs/myblobs/first header' '
+	echo "" >expected &&
+	git for-each-ref --format="%(header)" refs/myblobs/first >actual &&
+	test_cmp expected actual &&
+	git for-each-ref --format="%(header:size)" refs/myblobs/first >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'set up refs pointing to binary blob' '
 	printf "%b" "a\0b\0c" >blob1 &&
 	printf "%b" "a\0c\0b" >blob2 &&
-- 
gitgitgadget
