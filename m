Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A3FC54FCF
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780522074D
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udvYPGXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgCYFzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:55:17 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:34660 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgCYFzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 01:55:16 -0400
Received: by mail-qt1-f179.google.com with SMTP id 10so1305869qtp.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 22:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hzBtOCeXirYDUcUW+TlH01ogvvKrN//YJk3QfvJsTBU=;
        b=udvYPGXm/U/fqhhK5o9dpjPoK3ktCQfqhi5/TpTCeCZU1mCuLFLnrAmkj8gAfqS/xB
         bPunVZ/2iqEluhhUgu45cDWWSQFsbpjnoi3uKV4fFM6fIHgsIH7CkXoV+z0IGgeUxgsr
         /zPlmzn9HuQnzirMCDOxvz35oNL4FYnjZLqBtojTO/7dbMImMiEVRC3tkRW04j/nx++X
         oI2ErNuJ7HqWKuUjKCCqj4FXK7xdu2+SCf0Ug7OE/DiyVe/cbM3O2KYLf9lAXd8Ig4eI
         doLeyammmuaMJ0C8LACW6jZaSmDr+cvRjO5xTMw//MuW2pJEOBk2Ua1AlIcGvFJLyKdY
         5mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hzBtOCeXirYDUcUW+TlH01ogvvKrN//YJk3QfvJsTBU=;
        b=UfeFDYRgfcGXxqmFbiimKHrgQSXTISDBapvM1iunZoexWmTwygA9mHjiJdx56TOYed
         vXXQY6GaNXDZL5Rlg8MQAypSjN3FNlXAmwTRHGdGYgLLFvKzGpIuElUFg3gMT6RszQEU
         2O296lNRcvx9FTPhO6k+PtK+u4jMFKhIcXzo9MlqsMmgogVkBIVeqIvqIpuIJxxcKnXQ
         zuU04u/4rZyZozzrbdDY3bRg83MU1hw/lSRiOpTyWWqOzm5yKJIPTFmAdoPkC1oNLvX9
         Gc94ct5oG91HZEQ7Z56nG/WrltTlXZ1/hvl0alWypewNO3bGSi7F3eOZCxTl97V1B65t
         nUHw==
X-Gm-Message-State: ANhLgQ3mG1qO6NqoRSW6JL9Fgzgs/bhS6EJRCo64SeTgG6xn0iuvFfZA
        gi91Vgk/EuFxDoE93cGdyK8Q0VGa
X-Google-Smtp-Source: ADFU+vt6Hg+MDEapw05yeihxcFe6t2MpI+vl+pn1JHvqrWcQr5dN8uG+HhIlXoTjxdIWpA/67rfO2w==
X-Received: by 2002:aed:2c06:: with SMTP id f6mr1362961qtd.337.1585115714907;
        Tue, 24 Mar 2020 22:55:14 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id k15sm17168712qta.74.2020.03.24.22.55.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 22:55:14 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/8] t5512: generate references with generate_references()
Date:   Wed, 25 Mar 2020 01:54:49 -0400
Message-Id: <674de50db28a50554d7af6e5c869c427d06f78aa.1585115341.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1585115341.git.liu.denton@gmail.com>
References: <cover.1585115341.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The expected references are generated using a here-doc with some inline
subshells. If one of the `git rev-parse` invocations within the
subshells failed, its return code is swallowed and we won't know about
it. Replace these here-docs with generate_references(), which actually
reports when `git rev-parse` fails.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5512-ls-remote.sh | 50 +++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 08b98f12b8..62d02152c7 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -4,6 +4,14 @@ test_description='git ls-remote'
 
 . ./test-lib.sh
 
+generate_references () {
+	for i
+	do
+		oid=$(git rev-parse "$i") || return 1
+		printf '%s\t%s\n' "$oid" "$i"
+	done
+}
+
 test_expect_success setup '
 	>file &&
 	git add file &&
@@ -43,34 +51,19 @@ test_expect_success 'ls-remote self' '
 '
 
 test_expect_success 'ls-remote --sort="version:refname" --tags self' '
-	cat >expect <<-EOF &&
-	$(git rev-parse mark)	refs/tags/mark
-	$(git rev-parse mark1.1)	refs/tags/mark1.1
-	$(git rev-parse mark1.2)	refs/tags/mark1.2
-	$(git rev-parse mark1.10)	refs/tags/mark1.10
-	EOF
+	generate_references refs/tags/mark refs/tags/mark1.1 refs/tags/mark1.2 refs/tags/mark1.10 >expect &&
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
+	generate_references refs/tags/mark1.10 refs/tags/mark1.2 refs/tags/mark1.1 refs/tags/mark >expect &&
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
+	generate_references refs/tags/mark1.2 refs/tags/mark1.10 refs/tags/mark1.1 refs/tags/mark >expect &&
 	git ls-remote --sort="-refname" --tags self >actual &&
 	test_cmp expect actual
 '
@@ -212,17 +205,16 @@ test_expect_success 'protocol v2 supports hiderefs' '
 
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
+	generate_references HEAD \
+		refs/heads/master >>expect &&
+	oid=$(git rev-parse HEAD) &&
+	echo "$oid	refs/remotes/origin/HEAD" >>expect &&
+	generate_references refs/remotes/origin/master \
+		refs/tags/mark \
+		refs/tags/mark1.1 \
+		refs/tags/mark1.10 \
+		refs/tags/mark1.2 >>expect &&
 	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
 	# protocol v0 here.
 	GIT_TEST_PROTOCOL_VERSION=0 git ls-remote --symref >actual &&
-- 
2.25.0.114.g5b0ca878e0

