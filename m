Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05AEC48BE8
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 03:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7924A613E2
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 03:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFQDTy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 23:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhFQDTs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 23:19:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DC2C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 20:17:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ei4so2949132pjb.3
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 20:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gw3mfJrR95P+h8qXdZ1/ozeAbnpCw/KfFGAcxe614+M=;
        b=UXRRFJThSLeobLl8Mdq0o0T0kE5xYxP8wHnIe6DV7eclJkHC1AXsM2cEHsnZuhoiYn
         P8wjrdEVJ3TJ5UPwNGDKjaKUJJIksSMhV56Yh1KO3x6H3X2nPH3JI9V0QQMEPwDDf7aj
         KGrkCtavW6357zYJQ910AvF1zAMyf7SeRi7VK32RT+xvYzB+yxzeAS8cgB82PPLCEK8P
         RxMbUIGAeQPnCg/cPaaOsplUlZyZN8dyz3Q67n1kVxbU1C3BSGokxQtja4YR71m1hIMA
         RFT+Zep8P4HIm6k5GcGky44Us+YP3gcwAwzkOnXaO9+RPfqGMaZW2T/TY5NSpQ42kJ3q
         lDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gw3mfJrR95P+h8qXdZ1/ozeAbnpCw/KfFGAcxe614+M=;
        b=gLLdlrRiGBlO0cs+ehi6ARYY6Num7QrbHks5LVm/rZKgy0w4+Ojlm+mPObIB6CdxW+
         QWdkMsfUBMG/3KSHFZfiKuYFYGdWVDOxXVfllA8kdkEWNV66X0Q4QydQ7YoeqUAs4ccd
         kLz4hEQllf8xBEmm17Ulur7dq6mMcyFgoLV349OYaiyqSnUGSTSCERqGWbCvWXYlSlBN
         CVVjvhLD8MPlVcoJ2LmnBS7wG7Ckvzgps86uT6WwH98+W4s3lOMu8pp8xqrnKCstViD5
         8luPCYbmT++fxS4AHsN51ZokMjJq4YgLH2QfW9EI2d6K1NDa/JbfhPrNF1CV40mt13B+
         aS2g==
X-Gm-Message-State: AOAM53053YtbgtJfTmuhXy1q/0WOyh/CKtxYiO4VQFWXsq+dccKwr6xe
        dYgqa5Ul2utLnzZg97ntkcg=
X-Google-Smtp-Source: ABdhPJxGjAyNwQSYmoq5lbTh9751+4v7XBkxaSFNZa80rM8t4RsMa9uPWZrt9N2ssc6W//TemcdqCw==
X-Received: by 2002:a17:902:6904:b029:fb:42b6:e952 with SMTP id j4-20020a1709026904b02900fb42b6e952mr2621480plk.16.1623899859681;
        Wed, 16 Jun 2021 20:17:39 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.151])
        by smtp.gmail.com with ESMTPSA id ei10sm3301726pjb.8.2021.06.16.20.17.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jun 2021 20:17:39 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 4/4] test: refactor to use "get_abbrev_oid" to get abbrev oid
Date:   Thu, 17 Jun 2021 11:17:27 +0800
Message-Id: <20210617031727.81105-4-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc0.27.g7b1e85181b
In-Reply-To: <20210617031727.81105-1-zhiyou.jx@alibaba-inc.com>
References: <20210617031727.81105-1-zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add new function "get_abbrev_oid" to get abbrev object ID.  This
function has a default value which helps to prepare a nonempty replace
pattern for sed command.  An empty replace pattern may cause sed fail
to allocate memory.

Refactor function "make_user_friendly_and_stable_output" to use
"get_abbrev_oid" to get abbrev object ID.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5411/common-functions.sh                   | 20 ++++++++++++----
 t/t5411/test-0000-standard-git-push.sh        |  6 ++---
 .../test-0001-standard-git-push--porcelain.sh |  6 ++---
 t/t5411/test-0022-report-unexpect-ref.sh      |  2 +-
 ...est-0023-report-unexpect-ref--porcelain.sh |  2 +-
 t/t5411/test-0032-report-with-options.sh      |  8 +++----
 ...est-0033-report-with-options--porcelain.sh |  8 +++----
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 10 ++++----
 ...rt-multi-rewrite-for-one-ref--porcelain.sh | 10 ++++----
 t/t5411/test-0038-report-mixed-refs.sh        |  4 ++--
 .../test-0039-report-mixed-refs--porcelain.sh |  4 ++--
 t/t5411/test-0040-process-all-refs.sh         |  8 +++----
 .../test-0041-process-all-refs--porcelain.sh  |  8 +++----
 ...t-0050-proc-receive-refs-with-modifiers.sh |  4 ++--
 t/t5548-push-porcelain.sh                     | 24 +++++++++++++------
 15 files changed, 72 insertions(+), 52 deletions(-)

diff --git a/t/t5411/common-functions.sh b/t/t5411/common-functions.sh
index b9c6adecf5..3c747782c1 100644
--- a/t/t5411/common-functions.sh
+++ b/t/t5411/common-functions.sh
@@ -18,6 +18,18 @@ create_commits_in () {
 	done
 }
 
+get_abbrev_oid () {
+	oid=$1 &&
+	suffix=${oid#???????} &&
+	oid=${oid%$suffix} &&
+	if test -n "$oid"
+	then
+		echo "$oid"
+	else
+		echo "undefined-oid"
+	fi
+}
+
 # Format the output of git-push, git-show-ref and other commands to make a
 # user-friendly and stable text.  We can easily prepare the expect text
 # without having to worry about changes of the commit ID (full or abbrev.)
@@ -28,12 +40,10 @@ create_commits_in () {
 make_user_friendly_and_stable_output () {
 	sed \
 		-e "s/'/\"/g" \
-		-e "s/$A/<COMMIT-A>/g" \
-		-e "s/$B/<COMMIT-B>/g" \
-		-e "s/$TAG/<TAG-v123>/g" \
+		-e "s/$(get_abbrev_oid $A)[0-9a-f]*/<COMMIT-A>/g" \
+		-e "s/$(get_abbrev_oid $B)[0-9a-f]*/<COMMIT-B>/g" \
+		-e "s/$(get_abbrev_oid $TAG)[0-9a-f]*/<TAG-v123>/g" \
 		-e "s/$ZERO_OID/<ZERO-OID>/g" \
-		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
-		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
 		-e "s#To $URL_PREFIX/upstream.git#To <URL/of/upstream.git>#" \
 		-e "/^error: / d"
 }
diff --git a/t/t5411/test-0000-standard-git-push.sh b/t/t5411/test-0000-standard-git-push.sh
index d8aafc235c..ce64bb660b 100644
--- a/t/t5411/test-0000-standard-git-push.sh
+++ b/t/t5411/test-0000-standard-git-push.sh
@@ -15,7 +15,7 @@ test_expect_success "git-push ($PROTOCOL)" '
 	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
 	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
 	> To <URL/of/upstream.git>
-	>    <OID-A>..<OID-B>  <COMMIT-B> -> main
+	>    <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
 	>  * [new branch]      HEAD -> next
 	EOF
 	test_cmp expect actual &&
@@ -69,7 +69,7 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL)" '
 	> remote: # post-receive hook        Z
 	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/next        Z
 	> To <URL/of/upstream.git>
-	>    <OID-A>..<OID-B>  <COMMIT-B> -> next
+	>    <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> next
 	>  ! [rejected]        main -> main (non-fast-forward)
 	EOF
 	test_cmp expect actual &&
@@ -106,7 +106,7 @@ test_expect_success "git-push -f ($PROTOCOL)" '
 	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/main/topic        Z
 	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c        Z
 	> To <URL/of/upstream.git>
-	>  + <OID-B>...<OID-A> main -> main (forced update)
+	>  + <COMMIT-B>...<COMMIT-A> main -> main (forced update)
 	>  - [deleted]         next
 	>  * [new tag]         v123 -> v123
 	>  * [new reference]   main -> refs/review/main/topic
diff --git a/t/t5411/test-0001-standard-git-push--porcelain.sh b/t/t5411/test-0001-standard-git-push--porcelain.sh
index 2078d0a027..373ec3d865 100644
--- a/t/t5411/test-0001-standard-git-push--porcelain.sh
+++ b/t/t5411/test-0001-standard-git-push--porcelain.sh
@@ -15,7 +15,7 @@ test_expect_success "git-push ($PROTOCOL/porcelain)" '
 	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
 	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        Z
 	> To <URL/of/upstream.git>
-	>  	<COMMIT-B>:refs/heads/main	<OID-A>..<OID-B>
+	>  	<COMMIT-B>:refs/heads/main	<COMMIT-A>..<COMMIT-B>
 	> *	HEAD:refs/heads/next	[new branch]
 	> Done
 	EOF
@@ -71,7 +71,7 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL/porcelain)" '
 	> remote: # post-receive hook        Z
 	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/next        Z
 	> To <URL/of/upstream.git>
-	>  	<COMMIT-B>:refs/heads/next	<OID-A>..<OID-B>
+	>  	<COMMIT-B>:refs/heads/next	<COMMIT-A>..<COMMIT-B>
 	> !	refs/heads/main:refs/heads/main	[rejected] (non-fast-forward)
 	> Done
 	EOF
@@ -109,7 +109,7 @@ test_expect_success "git-push -f ($PROTOCOL/porcelain)" '
 	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/main/topic        Z
 	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c        Z
 	> To <URL/of/upstream.git>
-	> +	refs/heads/main:refs/heads/main	<OID-B>...<OID-A> (forced update)
+	> +	refs/heads/main:refs/heads/main	<COMMIT-B>...<COMMIT-A> (forced update)
 	> -	:refs/heads/next	[deleted]
 	> *	refs/tags/v123:refs/tags/v123	[new tag]
 	> *	refs/heads/main:refs/review/main/topic	[new reference]
diff --git a/t/t5411/test-0022-report-unexpect-ref.sh b/t/t5411/test-0022-report-unexpect-ref.sh
index a2ce7ebdf6..f7a494bdb9 100644
--- a/t/t5411/test-0022-report-unexpect-ref.sh
+++ b/t/t5411/test-0022-report-unexpect-ref.sh
@@ -26,7 +26,7 @@ test_expect_success "proc-receive: report unexpected ref ($PROTOCOL)" '
 	> remote: # post-receive hook        Z
 	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
 	> To <URL/of/upstream.git>
-	>    <OID-A>..<OID-B>  <COMMIT-B> -> main
+	>    <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
 	>  ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual &&
diff --git a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
index 4e56b163f8..63c479e975 100644
--- a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
+++ b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
@@ -26,7 +26,7 @@ test_expect_success "proc-receive: report unexpected ref ($PROTOCOL/porcelain)"
 	> remote: # post-receive hook        Z
 	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main        Z
 	> To <URL/of/upstream.git>
-	>  	<COMMIT-B>:refs/heads/main	<OID-A>..<OID-B>
+	>  	<COMMIT-B>:refs/heads/main	<COMMIT-A>..<COMMIT-B>
 	> !	HEAD:refs/for/main/topic	[remote rejected] (proc-receive failed to report status)
 	> Done
 	EOF
diff --git a/t/t5411/test-0032-report-with-options.sh b/t/t5411/test-0032-report-with-options.sh
index cd4f213a7d..988a4302a6 100644
--- a/t/t5411/test-0032-report-with-options.sh
+++ b/t/t5411/test-0032-report-with-options.sh
@@ -123,7 +123,7 @@ test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL)
 	> remote: # post-receive hook        Z
 	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/123/head        Z
 	> To <URL/of/upstream.git>
-	>    <OID-B>..<OID-A>  HEAD -> refs/pull/123/head
+	>    <COMMIT-B>..<COMMIT-A>  HEAD -> refs/pull/123/head
 	EOF
 	test_cmp expect actual
 '
@@ -155,7 +155,7 @@ test_expect_success "proc-receive: report option old-oid ($PROTOCOL)" '
 	> remote: # post-receive hook        Z
 	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/main/topic        Z
 	> To <URL/of/upstream.git>
-	>    <OID-B>..<OID-A>  HEAD -> refs/for/main/topic
+	>    <COMMIT-B>..<COMMIT-A>  HEAD -> refs/for/main/topic
 	EOF
 	test_cmp expect actual
 '
@@ -189,7 +189,7 @@ test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL)
 	> remote: # post-receive hook        Z
 	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic        Z
 	> To <URL/of/upstream.git>
-	>    <OID-A>..<OID-B>  HEAD -> refs/for/main/topic
+	>    <COMMIT-A>..<COMMIT-B>  HEAD -> refs/for/main/topic
 	EOF
 	test_cmp expect actual
 '
@@ -243,7 +243,7 @@ test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL)" '
 	> To <URL/of/upstream.git>
 	>  * [new reference]   HEAD -> refs/pull/123/head
 	>  * [new reference]   HEAD -> refs/for/a/b/c/topic
-	>  + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
+	>  + <COMMIT-B>...<COMMIT-A> HEAD -> refs/pull/124/head (forced update)
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0033-report-with-options--porcelain.sh b/t/t5411/test-0033-report-with-options--porcelain.sh
index 7433870e40..daacb3d69d 100644
--- a/t/t5411/test-0033-report-with-options--porcelain.sh
+++ b/t/t5411/test-0033-report-with-options--porcelain.sh
@@ -127,7 +127,7 @@ test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL/
 	> remote: # post-receive hook        Z
 	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/123/head        Z
 	> To <URL/of/upstream.git>
-	>  	HEAD:refs/pull/123/head	<OID-B>..<OID-A>
+	>  	HEAD:refs/pull/123/head	<COMMIT-B>..<COMMIT-A>
 	> Done
 	EOF
 	test_cmp expect actual
@@ -160,7 +160,7 @@ test_expect_success "proc-receive: report option old-oid ($PROTOCOL/porcelain)"
 	> remote: # post-receive hook        Z
 	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/main/topic        Z
 	> To <URL/of/upstream.git>
-	>  	HEAD:refs/for/main/topic	<OID-B>..<OID-A>
+	>  	HEAD:refs/for/main/topic	<COMMIT-B>..<COMMIT-A>
 	> Done
 	EOF
 	test_cmp expect actual
@@ -195,7 +195,7 @@ test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL/
 	> remote: # post-receive hook        Z
 	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic        Z
 	> To <URL/of/upstream.git>
-	>  	HEAD:refs/for/main/topic	<OID-A>..<OID-B>
+	>  	HEAD:refs/for/main/topic	<COMMIT-A>..<COMMIT-B>
 	> Done
 	EOF
 	test_cmp expect actual
@@ -251,7 +251,7 @@ test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL/porc
 	> To <URL/of/upstream.git>
 	> *	HEAD:refs/pull/123/head	[new reference]
 	> *	HEAD:refs/for/a/b/c/topic	[new reference]
-	> +	HEAD:refs/pull/124/head	<OID-B>...<OID-A> (forced update)
+	> +	HEAD:refs/pull/124/head	<COMMIT-B>...<COMMIT-A> (forced update)
 	> Done
 	EOF
 	test_cmp expect actual &&
diff --git a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
index e3f456ca5a..8c8a6c16e1 100644
--- a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
+++ b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
@@ -60,9 +60,9 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1        Z
 	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/25/125/1        Z
 	> To <URL/of/upstream.git>
-	>    <OID-A>..<OID-B>  HEAD -> refs/for/main/topic
+	>    <COMMIT-A>..<COMMIT-B>  HEAD -> refs/for/main/topic
 	>  * [new reference]   HEAD -> refs/changes/24/124/1
-	>    <OID-A>..<OID-B>  HEAD -> refs/changes/25/125/1
+	>    <COMMIT-A>..<COMMIT-B>  HEAD -> refs/changes/25/125/1
 	EOF
 	test_cmp expect actual &&
 
@@ -136,8 +136,8 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/changes/25/125/1        Z
 	> To <URL/of/upstream.git>
 	>  * [new reference]   HEAD -> refs/changes/24/124/1
-	>    <OID-A>..<OID-B>  HEAD -> refs/for/main/topic
-	>  + <OID-B>...<OID-A> HEAD -> refs/changes/25/125/1 (forced update)
+	>    <COMMIT-A>..<COMMIT-B>  HEAD -> refs/for/main/topic
+	>  + <COMMIT-B>...<COMMIT-A> HEAD -> refs/changes/25/125/1 (forced update)
 	EOF
 	test_cmp expect actual &&
 
@@ -198,7 +198,7 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL)" '
 	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/24/124/2        Z
 	> To <URL/of/upstream.git>
 	>  * [new reference]   HEAD -> refs/changes/23/123/1
-	>    <OID-A>..<OID-B>  HEAD -> refs/changes/24/124/2
+	>    <COMMIT-A>..<COMMIT-B>  HEAD -> refs/changes/24/124/2
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
index 7786079ba5..bc44810f33 100644
--- a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
+++ b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
@@ -45,9 +45,9 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1        Z
 	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/25/125/1        Z
 	> To <URL/of/upstream.git>
-	>  	HEAD:refs/for/main/topic	<OID-A>..<OID-B>
+	>  	HEAD:refs/for/main/topic	<COMMIT-A>..<COMMIT-B>
 	> *	HEAD:refs/changes/24/124/1	[new reference]
-	>  	HEAD:refs/changes/25/125/1	<OID-A>..<OID-B>
+	>  	HEAD:refs/changes/25/125/1	<COMMIT-A>..<COMMIT-B>
 	> Done
 	EOF
 	test_cmp expect actual &&
@@ -107,8 +107,8 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/changes/25/125/1        Z
 	> To <URL/of/upstream.git>
 	> *	HEAD:refs/changes/24/124/1	[new reference]
-	>  	HEAD:refs/for/main/topic	<OID-A>..<OID-B>
-	> +	HEAD:refs/changes/25/125/1	<OID-B>...<OID-A> (forced update)
+	>  	HEAD:refs/for/main/topic	<COMMIT-A>..<COMMIT-B>
+	> +	HEAD:refs/changes/25/125/1	<COMMIT-B>...<COMMIT-A> (forced update)
 	> Done
 	EOF
 	test_cmp expect actual &&
@@ -155,7 +155,7 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL/porc
 	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/24/124/2        Z
 	> To <URL/of/upstream.git>
 	> *	HEAD:refs/changes/23/123/1	[new reference]
-	>  	HEAD:refs/changes/24/124/2	<OID-A>..<OID-B>
+	>  	HEAD:refs/changes/24/124/2	<COMMIT-A>..<COMMIT-B>
 	> Done
 	EOF
 	test_cmp expect actual &&
diff --git a/t/t5411/test-0038-report-mixed-refs.sh b/t/t5411/test-0038-report-mixed-refs.sh
index 0990a3f76a..e63fe7ba11 100644
--- a/t/t5411/test-0038-report-mixed-refs.sh
+++ b/t/t5411/test-0038-report-mixed-refs.sh
@@ -55,12 +55,12 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
 	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo        Z
 	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic        Z
 	> To <URL/of/upstream.git>
-	>    <OID-A>..<OID-B>  <COMMIT-B> -> main
+	>    <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
 	>  * [new branch]      HEAD -> bar
 	>  * [new branch]      HEAD -> baz
 	>  * [new reference]   HEAD -> refs/for/next/topic2
 	>  * [new branch]      HEAD -> foo
-	>    <OID-A>..<OID-B>  HEAD -> refs/for/main/topic
+	>    <COMMIT-A>..<COMMIT-B>  HEAD -> refs/for/main/topic
 	>  ! [remote rejected] HEAD -> refs/for/next/topic1 (fail to call Web API)
 	>  ! [remote rejected] HEAD -> refs/for/next/topic3 (proc-receive failed to report status)
 	EOF
diff --git a/t/t5411/test-0039-report-mixed-refs--porcelain.sh b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
index 7e4d08a939..99d17b73af 100644
--- a/t/t5411/test-0039-report-mixed-refs--porcelain.sh
+++ b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
@@ -55,12 +55,12 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcel
 	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo        Z
 	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic        Z
 	> To <URL/of/upstream.git>
-	>  	<COMMIT-B>:refs/heads/main	<OID-A>..<OID-B>
+	>  	<COMMIT-B>:refs/heads/main	<COMMIT-A>..<COMMIT-B>
 	> *	HEAD:refs/heads/bar	[new branch]
 	> *	HEAD:refs/heads/baz	[new branch]
 	> *	HEAD:refs/for/next/topic2	[new reference]
 	> *	HEAD:refs/heads/foo	[new branch]
-	>  	HEAD:refs/for/main/topic	<OID-A>..<OID-B>
+	>  	HEAD:refs/for/main/topic	<COMMIT-A>..<COMMIT-B>
 	> !	HEAD:refs/for/next/topic1	[remote rejected] (fail to call Web API)
 	> !	HEAD:refs/for/next/topic3	[remote rejected] (proc-receive failed to report status)
 	> Done
diff --git a/t/t5411/test-0040-process-all-refs.sh b/t/t5411/test-0040-process-all-refs.sh
index f67cb2a7b3..2f405adefa 100644
--- a/t/t5411/test-0040-process-all-refs.sh
+++ b/t/t5411/test-0040-process-all-refs.sh
@@ -85,11 +85,11 @@ test_expect_success "proc-receive: process all refs ($PROTOCOL)" '
 	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/pull/123/head        Z
 	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head        Z
 	> To <URL/of/upstream.git>
-	>    <OID-A>..<OID-B>  <COMMIT-B> -> bar
+	>    <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> bar
 	>  - [deleted]         foo
-	>  + <OID-B>...<OID-A> HEAD -> main (forced update)
-	>    <OID-A>..<OID-B>  HEAD -> refs/pull/123/head
-	>  + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
+	>  + <COMMIT-B>...<COMMIT-A> HEAD -> main (forced update)
+	>    <COMMIT-A>..<COMMIT-B>  HEAD -> refs/pull/123/head
+	>  + <COMMIT-B>...<COMMIT-A> HEAD -> refs/pull/124/head (forced update)
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0041-process-all-refs--porcelain.sh b/t/t5411/test-0041-process-all-refs--porcelain.sh
index 7d1a99d3a2..c88405792e 100644
--- a/t/t5411/test-0041-process-all-refs--porcelain.sh
+++ b/t/t5411/test-0041-process-all-refs--porcelain.sh
@@ -85,11 +85,11 @@ test_expect_success "proc-receive: process all refs ($PROTOCOL/porcelain)" '
 	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/pull/123/head        Z
 	> remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head        Z
 	> To <URL/of/upstream.git>
-	>  	<COMMIT-B>:refs/heads/bar	<OID-A>..<OID-B>
+	>  	<COMMIT-B>:refs/heads/bar	<COMMIT-A>..<COMMIT-B>
 	> -	:refs/heads/foo	[deleted]
-	> +	HEAD:refs/heads/main	<OID-B>...<OID-A> (forced update)
-	>  	HEAD:refs/pull/123/head	<OID-A>..<OID-B>
-	> +	HEAD:refs/pull/124/head	<OID-B>...<OID-A> (forced update)
+	> +	HEAD:refs/heads/main	<COMMIT-B>...<COMMIT-A> (forced update)
+	>  	HEAD:refs/pull/123/head	<COMMIT-A>..<COMMIT-B>
+	> +	HEAD:refs/pull/124/head	<COMMIT-B>...<COMMIT-A> (forced update)
 	> Done
 	EOF
 	test_cmp expect actual &&
diff --git a/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh b/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
index dba544162c..31989f0185 100644
--- a/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
+++ b/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
@@ -46,7 +46,7 @@ test_expect_success "proc-receive: update branch and new tag ($PROTOCOL)" '
 	> remote: post-receive< <COMMIT-A> <COMMIT-B> refs/pull/123/head        Z
 	> remote: post-receive< <ZERO-OID> <TAG-v123> refs/pull/124/head        Z
 	> To <URL/of/upstream.git>
-	>    <OID-A>..<OID-B>  <COMMIT-B> -> refs/pull/123/head
+	>    <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> refs/pull/123/head
 	>  * [new reference]   v123 -> refs/pull/124/head
 	EOF
 	test_cmp expect actual &&
@@ -116,7 +116,7 @@ test_expect_success "proc-receive: create/delete branch, and delete tag ($PROTOC
 	> remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/124/head        Z
 	> To <URL/of/upstream.git>
 	>  - [deleted]         refs/pull/123/head
-	>    <OID-A>..<OID-B>  <COMMIT-B> -> topic
+	>    <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> topic
 	>  - [deleted]         v123
 	>  * [new reference]   <COMMIT-A> -> refs/pull/124/head
 	EOF
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index c8f18a7a12..f11ff57e54 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -26,17 +26,27 @@ create_commits_in () {
 	done
 }
 
+get_abbrev_oid () {
+	oid=$1 &&
+	suffix=${oid#???????} &&
+	oid=${oid%$suffix} &&
+	if test -n "$oid"
+	then
+		echo "$oid"
+	else
+		echo "undefined-oid"
+	fi
+}
+
 # Format the output of git-push, git-show-ref and other commands to make a
 # user-friendly and stable text.  We can easily prepare the expect text
 # without having to worry about future changes of the commit ID and spaces
 # of the output.
 make_user_friendly_and_stable_output () {
 	sed \
-		-e "s/$A/<COMMIT-A>/g" \
-		-e "s/$B/<COMMIT-B>/g" \
+		-e "s/$(get_abbrev_oid $A)[0-9a-f]*/<COMMIT-A>/g" \
+		-e "s/$(get_abbrev_oid $B)[0-9a-f]*/<COMMIT-B>/g" \
 		-e "s/$ZERO_OID/<ZERO-OID>/g" \
-		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
-		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
 		-e "s#To $URL_PREFIX/upstream.git#To <URL/of/upstream.git>#"
 }
 
@@ -102,9 +112,9 @@ run_git_push_porcelain_output_test() {
 		format_and_save_expect <<-EOF &&
 		> To <URL/of/upstream.git>
 		> =	refs/heads/baz:refs/heads/baz	[up to date]
-		>  	<COMMIT-B>:refs/heads/bar	<OID-A>..<OID-B>
+		>  	<COMMIT-B>:refs/heads/bar	<COMMIT-A>..<COMMIT-B>
 		> -	:refs/heads/foo	[deleted]
-		> +	refs/heads/main:refs/heads/main	<OID-B>...<OID-A> (forced update)
+		> +	refs/heads/main:refs/heads/main	<COMMIT-B>...<COMMIT-A> (forced update)
 		> *	refs/heads/next:refs/heads/next	[new branch]
 		> Done
 		EOF
@@ -220,7 +230,7 @@ run_git_push_porcelain_output_test() {
 		To <URL/of/upstream.git>
 		> =	refs/heads/next:refs/heads/next	[up to date]
 		> -	:refs/heads/baz	[deleted]
-		>  	refs/heads/main:refs/heads/main	<OID-A>..<OID-B>
+		>  	refs/heads/main:refs/heads/main	<COMMIT-A>..<COMMIT-B>
 		> !	refs/heads/bar:refs/heads/bar	[rejected] (non-fast-forward)
 		Done
 		EOF
-- 
2.32.0.rc0.27.g7b1e85181b

