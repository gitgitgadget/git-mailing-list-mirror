Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABE3C433B4
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA8B06101A
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346096AbhIBQCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 12:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346101AbhIBQCd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 12:02:33 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3249FC0613A3
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 09:01:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i6so3763947wrv.2
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JafKzOC3zrlYrSW/uLPW3JVRbuHlrT5H1URgR28LLiA=;
        b=NKIrZKimDq8rdhYD67I0wujhBVwZ1G9X/x8pP2JShUtH5IaKS8BttNtyU9bUHzwa/3
         aHBoXUX1AF8Zr6DkkWQrgZhwatPRUmUK1JoUhuTqZyPAHApAtBhUPkRdC//4b3JGMwst
         nshL72UWLpI0NUxpb45INHKV7RvoF/tINwoXn1YKI1phUrTP80RahZeViMrTcaHEkbm0
         0BQKGz7obFn7/99hGJluJsfTdDlFVWd1ENhMNeanbBPSMhOBbAhyURpGyhDNoS87mD3Z
         qBtwa71hFHpWEQqhTMI5YzgujXY2ydZ996vjlL1JfaL55ho6ssXPmx2eadKrCJbqJxNr
         1e1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JafKzOC3zrlYrSW/uLPW3JVRbuHlrT5H1URgR28LLiA=;
        b=omY79Up0F2mrmVFam4oasOjeN7ze3+o8UVQfZnA7vOCHPekrNoLKyZVMbchVPDfAK6
         ORLcnkyGV2hgWKZL+me4jgbbEGiavrwRcFDu80bt6gppJ0jrPYOr1dy6F6JP75fr5w67
         4DNijACdeekr4v26JFwAzX1Oc+iL6ocvxZlr8Fcd+uCxt19OOW0CEG9CFXTVhGZbGQSm
         JjTnRtnuBnZUEIbY4kEgFSBQjH27gj7U0y1pqtrf+7cm4+B9rLPKn5WJ4Yl02zjxPJnM
         X7E4Whkh1o5S0CcYmqSBFeJ/qdhUG+QFzpHt/LuNQf/5uvwZCtdfUNKbJDjLsdKznDEx
         XSjA==
X-Gm-Message-State: AOAM531Yx9JORnbD1nhzZKtYJE/rxQH3zrbqb6X6ZgACbjkPr2h5YrKX
        WwVAShs1u8PBojTBRn9edNAPqResROZN2Q==
X-Google-Smtp-Source: ABdhPJzYW9T8hWztuZfpedA482avnPiZDhln8EhQTdSFboEvGxoMaD4RuptjpoH5b4XGmBDNix9+1g==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr4855913wrn.66.1630598489518;
        Thu, 02 Sep 2021 09:01:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u26sm2403215wrd.32.2021.09.02.09.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:01:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/9] git-sh-setup: move create_virtual_base() to mergetools/p4merge
Date:   Thu,  2 Sep 2021 18:01:13 +0200
Message-Id: <patch-6.9-d2d65f3d77f-20210902T155758Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.814.gb82868f05f3
In-Reply-To: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the create_virtual_base() function out of "git-sh-setup" to its
only user, "mergetools/p4merge". Since 1a92e53ba36 (merge-one-file:
use empty blob for add/add base, 2016-02-23) when
git-merge-one-file.sh stopped using it, it has only been used in
"mergetools/p4merge".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-sh-setup.txt |  6 ------
 git-sh-setup.sh                | 12 ------------
 mergetools/p4merge             | 12 ++++++++++++
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 1d8c87e9b2f..2febe754206 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -66,12 +66,6 @@ get_author_ident_from_commit::
 	outputs code for use with eval to set the GIT_AUTHOR_NAME,
 	GIT_AUTHOR_EMAIL and GIT_AUTHOR_DATE variables for a given commit.
 
-create_virtual_base::
-	modifies the first file so only lines in common with the
-	second file remain. If there is insufficient common material,
-	then the first file is left empty. The result is suitable
-	as a virtual base input for a 3-way merge.
-
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 363c0096842..6a21238dc0e 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -238,18 +238,6 @@ clear_local_git_env() {
 	unset $(git rev-parse --local-env-vars)
 }
 
-# Generate a virtual base file for a two-file merge. Uses git apply to
-# remove lines from $1 that are not in $2, leaving only common lines.
-create_virtual_base() {
-	sz0=$(wc -c <"$1")
-	@@DIFF@@ -u -La/"$1" -Lb/"$1" "$1" "$2" | git apply --no-add
-	sz1=$(wc -c <"$1")
-
-	# If we do not have enough common material, it is not
-	# worth trying two-file merge using common subsections.
-	expr $sz0 \< $sz1 \* 2 >/dev/null || : >"$1"
-}
-
 
 # Platform specific tweaks to work around some commands
 case $(uname -s) in
diff --git a/mergetools/p4merge b/mergetools/p4merge
index 7a5b291dd28..23f8735efa2 100644
--- a/mergetools/p4merge
+++ b/mergetools/p4merge
@@ -19,6 +19,18 @@ diff_cmd () {
 	fi
 }
 
+# Generate a virtual base file for a two-file merge. Uses git apply to
+# remove lines from $1 that are not in $2, leaving only common lines.
+create_virtual_base() {
+	sz0=$(wc -c <"$1")
+	@@DIFF@@ -u -La/"$1" -Lb/"$1" "$1" "$2" | git apply --no-add
+	sz1=$(wc -c <"$1")
+
+	# If we do not have enough common material, it is not
+	# worth trying two-file merge using common subsections.
+	expr $sz0 \< $sz1 \* 2 >/dev/null || : >"$1"
+}
+
 merge_cmd () {
 	if ! $base_present
 	then
-- 
2.33.0.814.gb82868f05f3

