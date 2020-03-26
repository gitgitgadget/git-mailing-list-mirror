Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93134C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDFB2078E
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0oQvCgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgCZI2T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:28:19 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:33503 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgCZI2S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 04:28:18 -0400
Received: by mail-qt1-f169.google.com with SMTP id c14so4598608qtp.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Xmt/ZdvBmrODrpbs2I8e0SBEBAFkBWWfWCeg2U1NQcg=;
        b=B0oQvCgXQR0Sr3/pE8lDQ9T7NUz7GudGNt4JOdG2eh6xqubKL47Nx0+EhLsv8NISYu
         19MQzQQOJoDB7cMTjPCJwgtlsCp23PoxFQhjgeqiTifC8cVlgvwHPCfESxKjEM/Njl6q
         TvoOWfhTfZKbikWufxrWloqLNdMrW3z6rgc4HWXVrIfOLKY+zMXKQARwbOruq9/EFVG4
         foFaRiHKMpMFhyAJMwuorCL5Py1CKk/UNCqk0RIiXRCisqvOo7kfUKPU5wiFvOOmE+AB
         NND+K6rq4aeaFMHu/pudkmWe6C0D7HGSQBRnFxk9J8RGie9iC8qC3VbhsUljH6KPSX5+
         K3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xmt/ZdvBmrODrpbs2I8e0SBEBAFkBWWfWCeg2U1NQcg=;
        b=TrA9fYiNvukiCdWfm38fwa6o4G/CSFVMSpjG1kDhTPH0TqR+/56vXNwrBggkGMPWaK
         F8olat/H0sRbkJQcsP3fRmwIwTynhdIcyqPvBnoI5FuV7Hr8WScoZHQWb7ZcE6MYpiXm
         dMOXvJOhbEj+ujB/5hevAmPrEayJgLF/+nfnjnHzHjxjftcWx39hurqq+MUYdEXhepBl
         gxyI8gW9lgwNl19PgOnnBWMTMZhOtdYl/ycJzzN9QNWgK0iX8eXewRyvg5iqdmEFDPlM
         BiaaBYvXfY/OQLyq+unVLdJGuqf2HqB5Hdv9yMBYaD7/jCxO2moarPvo8SIUZhrokcGg
         8ajw==
X-Gm-Message-State: ANhLgQ2ones6vLQiLbi/heKCpCVleyjXvoSYK9AUrXIeqH1k9GFMxpBL
        2S8l7pKVcypMz+pirbzPPSKLRWjo
X-Google-Smtp-Source: ADFU+vtil+37qwJBk24+fMODGDI4y+cPT1WTCECCRCp56RvZUmOyqrVYTrXkn4DB68QK7rqFxRzS4Q==
X-Received: by 2002:ac8:41cd:: with SMTP id o13mr6976759qtm.266.1585211297017;
        Thu, 26 Mar 2020 01:28:17 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id g187sm935789qkf.115.2020.03.26.01.28.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 01:28:16 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2 2/8] t5512: stop losing git exit code in here-docs
Date:   Thu, 26 Mar 2020 04:27:49 -0400
Message-Id: <97bc46e4a9105f13b5284f86907eb1459a9987b6.1585209554.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585209554.git.liu.denton@gmail.com>
References: <cover.1585115341.git.liu.denton@gmail.com> <cover.1585209554.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The expected references are generated using a here-doc with some inline
command substitutions. If one of the `git rev-parse` invocations within
the command substitutions fails, its return code is swallowed and we
won't know about it. Replace these command substitutions with
generate_references(), which actually reports when `git rev-parse`
fails.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5512-ls-remote.sh | 64 ++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 08b98f12b8..dcb7349b0b 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -4,6 +4,14 @@ test_description='git ls-remote'
 
 . ./test-lib.sh
 
+generate_references () {
+	for ref
+	do
+		oid=$(git rev-parse "$ref") &&
+		printf '%s\t%s\n' "$oid" "$ref" || return 1
+	done
+}
+
 test_expect_success setup '
 	>file &&
 	git add file &&
@@ -43,34 +51,31 @@ test_expect_success 'ls-remote self' '
 '
 
 test_expect_success 'ls-remote --sort="version:refname" --tags self' '
-	cat >expect <<-EOF &&
-	$(git rev-parse mark)	refs/tags/mark
-	$(git rev-parse mark1.1)	refs/tags/mark1.1
-	$(git rev-parse mark1.2)	refs/tags/mark1.2
-	$(git rev-parse mark1.10)	refs/tags/mark1.10
-	EOF
+	generate_references \
+		refs/tags/mark \
+		refs/tags/mark1.1 \
+		refs/tags/mark1.2 \
+		refs/tags/mark1.10 >expect &&
 	git ls-remote --sort="version:refname" --tags self >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'ls-remote --sort="-version:refname" --tags self' '
-	cat >expect <<-EOF &&
-	$(git rev-parse mark1.10)	refs/tags/mark1.10
-	$(git rev-parse mark1.2)	refs/tags/mark1.2
-	$(git rev-parse mark1.1)	refs/tags/mark1.1
-	$(git rev-parse mark)	refs/tags/mark
-	EOF
+	generate_references \
+		refs/tags/mark1.10 \
+		refs/tags/mark1.2 \
+		refs/tags/mark1.1 \
+		refs/tags/mark >expect &&
 	git ls-remote --sort="-version:refname" --tags self >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'ls-remote --sort="-refname" --tags self' '
-	cat >expect <<-EOF &&
-	$(git rev-parse mark1.2)	refs/tags/mark1.2
-	$(git rev-parse mark1.10)	refs/tags/mark1.10
-	$(git rev-parse mark1.1)	refs/tags/mark1.1
-	$(git rev-parse mark)	refs/tags/mark
-	EOF
+	generate_references \
+		refs/tags/mark1.2 \
+		refs/tags/mark1.10 \
+		refs/tags/mark1.1 \
+		refs/tags/mark >expect &&
 	git ls-remote --sort="-refname" --tags self >actual &&
 	test_cmp expect actual
 '
@@ -212,17 +217,18 @@ test_expect_success 'protocol v2 supports hiderefs' '
 
 test_expect_success 'ls-remote --symref' '
 	git fetch origin &&
-	cat >expect <<-EOF &&
-	ref: refs/heads/master	HEAD
-	$(git rev-parse HEAD)	HEAD
-	$(git rev-parse refs/heads/master)	refs/heads/master
-	$(git rev-parse HEAD)	refs/remotes/origin/HEAD
-	$(git rev-parse refs/remotes/origin/master)	refs/remotes/origin/master
-	$(git rev-parse refs/tags/mark)	refs/tags/mark
-	$(git rev-parse refs/tags/mark1.1)	refs/tags/mark1.1
-	$(git rev-parse refs/tags/mark1.10)	refs/tags/mark1.10
-	$(git rev-parse refs/tags/mark1.2)	refs/tags/mark1.2
-	EOF
+	echo "ref: refs/heads/master	HEAD" >expect &&
+	generate_references \
+		HEAD \
+		refs/heads/master >>expect &&
+	oid=$(git rev-parse HEAD) &&
+	echo "$oid	refs/remotes/origin/HEAD" >>expect &&
+	generate_references \
+	refs/remotes/origin/master \
+		refs/tags/mark \
+		refs/tags/mark1.1 \
+		refs/tags/mark1.10 \
+		refs/tags/mark1.2 >>expect &&
 	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
 	# protocol v0 here.
 	GIT_TEST_PROTOCOL_VERSION=0 git ls-remote --symref >actual &&
-- 
2.26.0.159.g23e2136ad0

