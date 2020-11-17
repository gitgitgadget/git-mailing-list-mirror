Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA655C6379D
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F46221F9
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3Bcn5vR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgKQVgF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKQVgE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:36:04 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41638C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:36:04 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id e18so24081517edy.6
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ss7GyOaT78nJ5Jk3PH2IClj2LsH5TJucGg9eP+H5lDQ=;
        b=f3Bcn5vR+XrNNPUWcDukU9EslMzkbcSfkvWRp1kuEaajBjvq4Wy01AjPOJC2aYp68G
         bxTJPDEAkW3+SS7D6HfVQJhn6Aywnh8+ctoKLTd5d53h57X0tjVPkeUMfjYgQIoAq3DM
         dDpKgW+DB1JieAoS2IE/gKAjsSbIxxNLP1WP8VXi8BgdgLQwRovi5D6PE9Tme9SMCXko
         KsaDNRf1U3HnCAw1YM3AGGqybNgNjE+XyKnB+7ugi3Zac8Uv6EDcPxGi/2CREUJVXhN/
         oAY3jD4n3nILCdxy7a9Agn6kq9g+NPLVD0/peMH632qeBdp/X5JJcApLpS+y5xiazg/G
         87Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ss7GyOaT78nJ5Jk3PH2IClj2LsH5TJucGg9eP+H5lDQ=;
        b=pStd6Ej9V7k6/G8lr8ru1cqH4KmDSrwhtP7fdqZaVez62Wxi/1ySiqIN/j1Y5FR4yn
         1INvWVqM6/vsca/NiJHBd0Zs3VcnMFlSii2pLNPaz5VPDge64mSmYaL0GelvVK024hTu
         /aiQ3RYUNdZ7yWr7zeb3nibOgrg6BZ+/w7Skq/WNaL6yuv6Xy6Y4Dp+D9YGS9b2EROup
         8OUx2BEzQ2qz5Yr+CNFp5W3vNE9cCwyXEooGiS4jRcfxRYMcL/6ZdoIyVOTeS2pHF4+7
         q9A3yDBNMQDcUBcm88eZFuInToPpk4+UrJ+veCNiurZVRyfqvjdHPmMuos53YC62HOVx
         N0Tg==
X-Gm-Message-State: AOAM531a5FnIIQDL6vcxs3j4OG9RhP4wWf75nsUYKZrpHy7vZrvE0bla
        xZUfZUmKk2JKGUkDqCRunCg=
X-Google-Smtp-Source: ABdhPJxi9pKgTnGYiaLCSNmc4bpgtNr8CWzxcTJLJ9ep/nwUbj4424uuj5qCXZQlebrsZUoSVi7xAg==
X-Received: by 2002:a50:9e8a:: with SMTP id a10mr23599501edf.150.1605648962967;
        Tue, 17 Nov 2020 13:36:02 -0800 (PST)
Received: from localhost.localdomain (178.115.129.143.wireless.dyn.drei.com. [178.115.129.143])
        by smtp.gmail.com with ESMTPSA id by8sm12623417edb.49.2020.11.17.13.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:36:02 -0800 (PST)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        Johannes Altmanninger <aclopte@gmail.com>
Subject: [PATCH 1/3] range-diff: move " ## filename ##" headers to the first column
Date:   Tue, 17 Nov 2020 22:35:49 +0100
Message-Id: <20201117213551.2539438-2-aclopte@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201117213551.2539438-1-aclopte@gmail.com>
References: <xmqqmtzvikwi.fsf@gitster.c.googlers.com>
 <20201117213551.2539438-1-aclopte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Output of range-diff may include comparisons of metadata like commit messages
and filenames. Metadata lines look like " ## <content> ##".

When range-diff compares two matching commits, it computes a diff of two
special commit diffs. In these commit diffs, each changed file is introduced
with a " ## filename ##" line which is followed by the diff hunks with changes
to the file's contents.

The leading space makes it hard to distinguish between file metadata lines
and context lines from a diff hunk, especially when looking only at the
output of range-diff.  Drop the space prefix to facilitate that.
---
 range-diff.c          |  4 ++--
 t/t3206-range-diff.sh | 42 +++++++++++++++++++++---------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 24dc435e48..72660453bd 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -136,7 +136,7 @@ static int read_patches(const char *range, struct string_list *list,
 			if (len < 0)
 				die(_("could not parse git header '%.*s'"),
 				    orig_len, line);
-			strbuf_addstr(&buf, " ## ");
+			strbuf_addstr(&buf, "## ");
 			if (patch.is_new > 0)
 				strbuf_addf(&buf, "%s (new)", patch.new_name);
 			else if (patch.is_delete > 0)
@@ -432,7 +432,7 @@ static void output_pair_header(struct diff_options *diffopt,
 }
 
 static struct userdiff_driver section_headers = {
-	.funcname = { "^ ## (.*) ##$\n"
+	.funcname = { "^ ?## (.*) ##$\n"
 		      "^.?@@ (.*)$", REG_EXTENDED }
 };
 
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 6eb344be03..f875843b5e 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -304,8 +304,8 @@ test_expect_success 'renamed file' '
 	    -    s/4/A/
 	    +    s/4/A/ + rename file
 	    Z
-	    - ## file ##
-	    + ## file => renamed-file ##
+	    -## file ##
+	    +## file => renamed-file ##
 	    Z@@
 	    Z 1
 	    Z 2
@@ -314,9 +314,9 @@ test_expect_success 'renamed file' '
 	    Z ## Commit message ##
 	    Z    s/11/B/
 	    Z
-	    - ## file ##
+	    -## file ##
 	    -@@ file: A
-	    + ## renamed-file ##
+	    +## renamed-file ##
 	    +@@ renamed-file: A
 	    Z 8
 	    Z 9
@@ -326,9 +326,9 @@ test_expect_success 'renamed file' '
 	    Z ## Commit message ##
 	    Z    s/12/B/
 	    Z
-	    - ## file ##
+	    -## file ##
 	    -@@ file: A
-	    + ## renamed-file ##
+	    +## renamed-file ##
 	    +@@ renamed-file: A
 	    Z 9
 	    Z 10
@@ -348,14 +348,14 @@ test_expect_success 'file with mode only change' '
 	    -    s/4/A/
 	    +    s/4/A/ + add other-file
 	    Z
-	    Z ## file ##
+	    Z## file ##
 	    Z@@
 	    @@ file
 	    Z A
 	    Z 6
 	    Z 7
 	    +
-	    + ## other-file (new) ##
+	    +## other-file (new) ##
 	2:  $(test_oid t3) ! 2:  $(test_oid o2) s/11/B/
 	    @@ Metadata
 	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
@@ -364,14 +364,14 @@ test_expect_success 'file with mode only change' '
 	    -    s/11/B/
 	    +    s/11/B/ + mode change other-file
 	    Z
-	    Z ## file ##
+	    Z## file ##
 	    Z@@ file: A
 	    @@ file: A
 	    Z 12
 	    Z 13
 	    Z 14
 	    +
-	    + ## other-file (mode change 100644 => 100755) ##
+	    +## other-file (mode change 100644 => 100755) ##
 	3:  $(test_oid t4) = 3:  $(test_oid o3) s/12/B/
 	EOF
 	test_cmp expect actual
@@ -389,14 +389,14 @@ test_expect_success 'file added and later removed' '
 	    -    s/4/A/
 	    +    s/4/A/ + new-file
 	    Z
-	    Z ## file ##
+	    Z## file ##
 	    Z@@
 	    @@ file
 	    Z A
 	    Z 6
 	    Z 7
 	    +
-	    + ## new-file (new) ##
+	    +## new-file (new) ##
 	3:  $(test_oid t3) ! 3:  $(test_oid s3) s/11/B/
 	    @@ Metadata
 	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
@@ -405,14 +405,14 @@ test_expect_success 'file added and later removed' '
 	    -    s/11/B/
 	    +    s/11/B/ + remove file
 	    Z
-	    Z ## file ##
+	    Z## file ##
 	    Z@@ file: A
 	    @@ file: A
 	    Z 12
 	    Z 13
 	    Z 14
 	    +
-	    + ## new-file (deleted) ##
+	    +## new-file (deleted) ##
 	4:  $(test_oid t4) = 4:  $(test_oid s4) s/12/B/
 	EOF
 	test_cmp expect actual
@@ -434,7 +434,7 @@ test_expect_success 'changed message' '
 	    Z
 	    +    Also a silly comment here!
 	    +
-	    Z ## file ##
+	    Z## file ##
 	    Z@@
 	    Z 1
 	3:  $(test_oid t3) = 3:  $(test_oid m3) s/11/B/
@@ -453,7 +453,7 @@ test_expect_success 'dual-coloring' '
 	:     <RESET>
 	:    <REVERSE><GREEN>+<RESET><BOLD>    Also a silly comment here!<RESET>
 	:    <REVERSE><GREEN>+<RESET>
-	:      ## file ##<RESET>
+	:     ## file ##<RESET>
 	:    <CYAN> @@<RESET>
 	:      1<RESET>
 	:<RED>3:  $(test_oid c3) <RESET><YELLOW>!<RESET><GREEN> 3:  $(test_oid m3)<RESET><YELLOW> s/11/B/<RESET>
@@ -537,7 +537,7 @@ test_expect_success 'range-diff compares notes by default' '
 	    -    topic note
 	    +    unmodified note
 	    Z
-	    Z ## file ##
+	    Z## file ##
 	    Z@@ file: A
 	EOF
 	test_cmp expect actual
@@ -584,7 +584,7 @@ test_expect_success 'range-diff with multiple --notes' '
 	    -    topic note2
 	    +    unmodified note2
 	    Z
-	    Z ## file ##
+	    Z## file ##
 	    Z@@ file: A
 	EOF
 	test_cmp expect actual
@@ -645,7 +645,7 @@ test_expect_success 'format-patch --range-diff with --notes' '
 	    -    topic note
 	    +    unmodified note
 	    Z
-	    Z ## file ##
+	    Z## file ##
 	    Z@@ file: A
 	EOF
 	sed "/@@ Commit message/,/@@ file: A/!d" 0000-* >actual &&
@@ -674,7 +674,7 @@ test_expect_success 'format-patch --range-diff with format.notes config' '
 	    -    topic note
 	    +    unmodified note
 	    Z
-	    Z ## file ##
+	    Z## file ##
 	    Z@@ file: A
 	EOF
 	sed "/@@ Commit message/,/@@ file: A/!d" 0000-* >actual &&
@@ -710,7 +710,7 @@ test_expect_success 'format-patch --range-diff with multiple notes' '
 	    -    topic note2
 	    +    unmodified note2
 	    Z
-	    Z ## file ##
+	    Z## file ##
 	    Z@@ file: A
 	EOF
 	sed "/@@ Commit message/,/@@ file: A/!d" 0000-* >actual &&
-- 
2.29.2

