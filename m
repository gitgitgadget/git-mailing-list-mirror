Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8ECC433E4
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 16:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C168120725
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 16:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSrrc4NA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgGJQsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgGJQsC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 12:48:02 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B873AC08C5DD
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 09:48:01 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so6641967wrm.4
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yOfNiCEUiGkMJyP2oxfjOwrbkswTAeLy23Ep/QVQJEU=;
        b=BSrrc4NAI/3aCJ/AYqbZopnplquunwIcjvY3jer8PrbM6Rd79jpuKjJk1iVLA8mArn
         D+69mj5lpKPtChcUHrt265zntSP+O/9jEw0GK4hFFsulJbHQdfQ+1LyFLW1gNfWlgVOQ
         nN/SGdGKFDLroMcqgvlxaSEbblxB8hMhW0Yt/1HP9ZeGegp9zwfp2C2qW8Da5AOuwkHW
         uOYl9/Y3dTXcd6w5BzHxQHjGH3p9HHrXflbT8ARP2/LZfXMiWNCNM+lUmtrl8bhsNUML
         hc/jPyTWo3jYom7R14zRJQd8SMKnpCSuE/k/j3GHGHPCJTLHnuD5AAofThQNhNj6ZYc0
         GSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOfNiCEUiGkMJyP2oxfjOwrbkswTAeLy23Ep/QVQJEU=;
        b=CEsjdZCM1MwMPurcr+w+C/3eVRHMLNysLi2mWDjQQCButL42/TfDcEi2KIHk3inFPU
         SjRSLaBPre4+n+IiGzxI7EM0k9VNLtZzrJd8BsngllzYN5ddzac+NTxy0u7NvK3o9ESA
         clCsACRs1MyTcFPFxKhLOXYuSYLb9X/p6ZzPngTFvNJGA+vtSN72ADcScNbZDGl7EGyL
         PmJhpWJ8vg1h815YX2mGM1umF6PL+P8bb8M4lyxYwOQggmRzXtvQEAwNLxmfdD/4cBI7
         qTnKTnz6WTsp9vy7utMbgNPuvbsSeI+S4jVTF6ZUVMkQc/v5bx9exQ+Z7bCBBbxpYLTI
         YUsA==
X-Gm-Message-State: AOAM531zbpsgAXheM3EFbw1qDuEyu0NpPHi6Jdf0a0Yt9l6QCFvwG4M3
        Krs8seWLmY5bkVhzVMeh4DRuitT3NUM=
X-Google-Smtp-Source: ABdhPJxCbSXhs/CBpUiiPZzprhYuW1BrMSCpsCFFU2/HUWlLe1aeVR7mhrBCRQknzOE1c6Am6jJhOw==
X-Received: by 2002:a05:6000:1283:: with SMTP id f3mr69628842wrx.106.1594399680189;
        Fri, 10 Jul 2020 09:48:00 -0700 (PDT)
Received: from localhost.localdomain ([185.228.229.54])
        by smtp.gmail.com with ESMTPSA id m4sm9883385wmi.48.2020.07.10.09.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:47:59 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 3/3] ref-filter: add support for %(contents:size)
Date:   Fri, 10 Jul 2020 18:47:39 +0200
Message-Id: <20200710164739.6616-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.347.gb620d8b0da
In-Reply-To: <20200710164739.6616-1-chriscool@tuxfamily.org>
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
 <20200710164739.6616-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's useful and efficient to be able to get the size of the
contents directly without having to pipe through `wc -c`.

Also the result of the following:

`git for-each-ref --format='%(contents)' refs/heads/my-branch | wc -c`

is off by one as `git for-each-ref` appends a newline character
after the contents, which can be seen by comparing its output
with the output from `git cat-file`.

As with %(contents), %(contents:size) is silently ignored, if a
ref points to something other than a commit or a tag:

```
$ git update-ref refs/mytrees/first HEAD^{tree}
$ git for-each-ref --format='%(contents)' refs/mytrees/first

$ git for-each-ref --format='%(contents:size)' refs/mytrees/first

```

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-for-each-ref.txt |  3 +++
 ref-filter.c                       |  7 ++++++-
 t/t6300-for-each-ref.sh            | 19 +++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index b739412c30..2ea71c5f6c 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -235,6 +235,9 @@ and `date` to extract the named component.
 The message in a commit or a tag object is `contents`, from which
 `contents:<part>` can be used to extract various parts out of:
 
+contents:size::
+	The size in bytes of the commit or tag message.
+
 contents:subject::
 	The first paragraph of the message, which typically is a
 	single line, is taken as the "subject" of the commit or the
diff --git a/ref-filter.c b/ref-filter.c
index 8447cb09be..73d8bfa86d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -127,7 +127,8 @@ static struct used_atom {
 			unsigned int nobracket : 1, push : 1, push_remote : 1;
 		} remote_ref;
 		struct {
-			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
+			enum { C_BARE, C_BODY, C_BODY_DEP, C_LENGTH,
+			       C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
 			struct process_trailer_options trailer_opts;
 			unsigned int nlines;
 		} contents;
@@ -338,6 +339,8 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
 		atom->u.contents.option = C_BARE;
 	else if (!strcmp(arg, "body"))
 		atom->u.contents.option = C_BODY;
+	else if (!strcmp(arg, "size"))
+		atom->u.contents.option = C_LENGTH;
 	else if (!strcmp(arg, "signature"))
 		atom->u.contents.option = C_SIG;
 	else if (!strcmp(arg, "subject"))
@@ -1253,6 +1256,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 			v->s = copy_subject(subpos, sublen);
 		else if (atom->u.contents.option == C_BODY_DEP)
 			v->s = xmemdupz(bodypos, bodylen);
+		else if (atom->u.contents.option == C_LENGTH)
+			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)strlen(subpos));
 		else if (atom->u.contents.option == C_BODY)
 			v->s = xmemdupz(bodypos, nonsiglen);
 		else if (atom->u.contents.option == C_SIG)
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index e9f468d360..467871ac10 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -52,6 +52,25 @@ test_atom() {
 		sanitize_pgp <actual >actual.clean &&
 		test_cmp expected actual.clean
 	"
+	# Automatically test "contents:size" atom after testing "contents"
+	if test "$2" = "contents"
+	then
+		case "$1" in
+		refs/tags/signed-*)
+			# We cannot use $3 as it expects sanitize_pgp to run
+			expect=$(git cat-file tag $ref | tail -n +6 | wc -c) ;;
+		refs/mytrees/* | refs/myblobs/*)
+			expect='' ;;
+		*)
+			expect=$(printf '%s' "$3" | wc -c) ;;
+		esac
+		# Leave $expect unquoted to lose possible leading whitespaces
+		echo $expect >expected
+		test_expect_${4:-success} $PREREQ "basic atom: $1 $2:size" "
+			git for-each-ref --format='%($2:size)' $ref >actual &&
+			test_cmp expected actual
+		"
+	fi
 }
 
 hexlen=$(test_oid hexsz)
-- 
2.27.0.347.gb620d8b0da

