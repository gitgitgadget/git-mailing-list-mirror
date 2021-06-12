Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3BCC48BE5
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 05:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B42A611C9
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 05:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFLFKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 01:10:19 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:43910 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhFLFKR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 01:10:17 -0400
Received: by mail-pl1-f182.google.com with SMTP id v12so3833667plo.10
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 22:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aRZYq+uuArKqU+h5Ld3jiyU5IQHGr/WZ6Mv0sPtl2HM=;
        b=m/8WNTLliHEXkDLR2sAIx8IXiOREwRTzer7ZQgWYMJIIUC6hgYRAXrHwCaUj/ownI0
         eH8LGibQCRNMDLsaShfQuz2Y3Da50VKOvSltbLaSHkQCEl43CDMw3C+h1J5qYFHjwjsP
         z7QwnFNbVVxg8zadyQzZN+GmfXPFp4OAjCwIEdpU6rx5oRYWV9Qs9ElVAOV0IXQFaZZl
         EEsHHwqY/6z3Xhv093LcMKIqfhJG5Mb5CTxTxXjFVBYYh9+qCNH6RzjZeJjGJ7UdACNI
         nO05em3jJBgtVwUT6i39JysbR6srp5eMPsgJ2IXK5JdDTEp4IaTYGHAN2fBwj+m/3vTR
         F/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRZYq+uuArKqU+h5Ld3jiyU5IQHGr/WZ6Mv0sPtl2HM=;
        b=A7K99D+vOcjBQrLT2uwZ6B6Xd28iwfajfhLtehyVJ3fEtCYne4G3qDW8wwqcNB+1GL
         3YowH6ec6WL0p/ydix2uiyUq4WX4T8BAzW0TUqrDKa1jtXRr1fDQAIhdezqoKSrgtQkA
         KZ/HjHAjykN/MVfEtm6ElS4UCoVoWQjRlojfAy7vnWAzpKSbnWDVUCHYq6l2Teb/x1Xg
         rkBUzajFGtttVhVDwTEb4WQOTE+VLKbqEtKkRZmkGmKOPwP4BMeyGoNDowOrvCOns4Af
         BhiBEj/EXMjdUdWx5jupjcbuseU0wmTgBKmEb5HiixjMxfy55SdS2BPOZInvwpBX4/zL
         A56g==
X-Gm-Message-State: AOAM532SPR1EIqilpcBnBl8r/K3zckHkXlYmq6TrHSqRwCMHaNOA9ibO
        ewz2vbaVL9qPOujTgOohr9w=
X-Google-Smtp-Source: ABdhPJxSSrxv6V66sK4q7u7SyvtLIsuBlkU6+mFZtHj8s3oqtUBKRX6Rsb68RYrxO4Ct4ucjdag9pQ==
X-Received: by 2002:a17:90a:1150:: with SMTP id d16mr7939875pje.180.1623474437952;
        Fri, 11 Jun 2021 22:07:17 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id n23sm6651745pff.93.2021.06.11.22.07.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jun 2021 22:07:17 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 2/4] test: refactor create_commits_in() for t5411 and t5548
Date:   Sat, 12 Jun 2021 13:07:09 +0800
Message-Id: <20210612050711.4057-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <87im2s5jjm.fsf@evledraar.gmail.com>
References: <87im2s5jjm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Use "test_commit" in "create_commits_in" to create commit and get abbrev
object ID by using function "get_abbrev_oid".

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5411/common-functions.sh                   | 45 ++++++++---------
 t/t5411/test-0000-standard-git-push.sh        |  6 +--
 .../test-0001-standard-git-push--porcelain.sh |  6 +--
 t/t5411/test-0022-report-unexpect-ref.sh      |  2 +-
 ...est-0023-report-unexpect-ref--porcelain.sh |  2 +-
 t/t5411/test-0032-report-with-options.sh      |  8 +--
 ...est-0033-report-with-options--porcelain.sh |  8 +--
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 10 ++--
 ...rt-multi-rewrite-for-one-ref--porcelain.sh | 10 ++--
 t/t5411/test-0038-report-mixed-refs.sh        |  4 +-
 .../test-0039-report-mixed-refs--porcelain.sh |  4 +-
 t/t5411/test-0040-process-all-refs.sh         |  8 +--
 .../test-0041-process-all-refs--porcelain.sh  |  8 +--
 ...t-0050-proc-receive-refs-with-modifiers.sh |  4 +-
 t/t5548-push-porcelain.sh                     | 49 +++++++++----------
 15 files changed, 84 insertions(+), 90 deletions(-)

diff --git a/t/t5411/common-functions.sh b/t/t5411/common-functions.sh
index 6694858e18..6398f5f2a3 100644
--- a/t/t5411/common-functions.sh
+++ b/t/t5411/common-functions.sh
@@ -6,29 +6,28 @@
 # NOTE: Never calling this function from a subshell since variable
 # assignments will disappear when subshell exits.
 create_commits_in () {
-	repo="$1" &&
-	if ! parent=$(git -C "$repo" rev-parse HEAD^{} --)
-	then
-		parent=
-	fi &&
-	T=$(git -C "$repo" write-tree) &&
+	repo="$1" && test -d "$repo" ||
+	error "Repository $repo does not exist."
 	shift &&
 	while test $# -gt 0
 	do
 		name=$1 &&
-		test_tick &&
-		if test -z "$parent"
-		then
-			oid=$(echo $name | git -C "$repo" commit-tree $T)
-		else
-			oid=$(echo $name | git -C "$repo" commit-tree -p $parent $T)
-		fi &&
-		eval $name=$oid &&
-		parent=$oid &&
-		shift ||
-		return 1
-	done &&
-	git -C "$repo" update-ref refs/heads/main $oid
+		shift &&
+		test_commit -C "$repo" --no-tag "$name" &&
+		eval $name=$(git -C "$repo" rev-parse HEAD)
+	done
+}
+
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
 }
 
 # Format the output of git-push, git-show-ref and other commands to make a
@@ -44,12 +43,10 @@ make_user_friendly_and_stable_output () {
 		-e "s/  */ /g" \
 		-e "s/'/\"/g" \
 		-e "s/	/    /g" \
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
index e1e0175c12..2c69cf60d4 100644
--- a/t/t5411/test-0000-standard-git-push.sh
+++ b/t/t5411/test-0000-standard-git-push.sh
@@ -15,7 +15,7 @@ test_expect_success "git-push ($PROTOCOL)" '
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
 	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> <COMMIT-B> -> main
+	 <COMMIT-A>..<COMMIT-B> <COMMIT-B> -> main
 	 * [new branch] HEAD -> next
 	EOF
 	test_cmp expect actual &&
@@ -69,7 +69,7 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL)" '
 	remote: # post-receive hook
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/next
 	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> <COMMIT-B> -> next
+	 <COMMIT-A>..<COMMIT-B> <COMMIT-B> -> next
 	 ! [rejected] main -> main (non-fast-forward)
 	EOF
 	test_cmp expect actual &&
@@ -106,7 +106,7 @@ test_expect_success "git-push -f ($PROTOCOL)" '
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/main/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
 	To <URL/of/upstream.git>
-	 + <OID-B>...<OID-A> main -> main (forced update)
+	 + <COMMIT-B>...<COMMIT-A> main -> main (forced update)
 	 - [deleted] next
 	 * [new tag] v123 -> v123
 	 * [new reference] main -> refs/review/main/topic
diff --git a/t/t5411/test-0001-standard-git-push--porcelain.sh b/t/t5411/test-0001-standard-git-push--porcelain.sh
index bcbda72341..7b982c8395 100644
--- a/t/t5411/test-0001-standard-git-push--porcelain.sh
+++ b/t/t5411/test-0001-standard-git-push--porcelain.sh
@@ -15,7 +15,7 @@ test_expect_success "git-push ($PROTOCOL/porcelain)" '
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
 	To <URL/of/upstream.git>
-	     <COMMIT-B>:refs/heads/main    <OID-A>..<OID-B>
+	     <COMMIT-B>:refs/heads/main    <COMMIT-A>..<COMMIT-B>
 	*    HEAD:refs/heads/next    [new branch]
 	Done
 	EOF
@@ -71,7 +71,7 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL/porcelain)" '
 	remote: # post-receive hook
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/next
 	To <URL/of/upstream.git>
-	     <COMMIT-B>:refs/heads/next    <OID-A>..<OID-B>
+	     <COMMIT-B>:refs/heads/next    <COMMIT-A>..<COMMIT-B>
 	!    refs/heads/main:refs/heads/main    [rejected] (non-fast-forward)
 	Done
 	EOF
@@ -109,7 +109,7 @@ test_expect_success "git-push -f ($PROTOCOL/porcelain)" '
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/main/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
 	To <URL/of/upstream.git>
-	+    refs/heads/main:refs/heads/main    <OID-B>...<OID-A> (forced update)
+	+    refs/heads/main:refs/heads/main    <COMMIT-B>...<COMMIT-A> (forced update)
 	-    :refs/heads/next    [deleted]
 	*    refs/tags/v123:refs/tags/v123    [new tag]
 	*    refs/heads/main:refs/review/main/topic    [new reference]
diff --git a/t/t5411/test-0022-report-unexpect-ref.sh b/t/t5411/test-0022-report-unexpect-ref.sh
index dbed467186..a482ff931a 100644
--- a/t/t5411/test-0022-report-unexpect-ref.sh
+++ b/t/t5411/test-0022-report-unexpect-ref.sh
@@ -26,7 +26,7 @@ test_expect_success "proc-receive: report unexpected ref ($PROTOCOL)" '
 	remote: # post-receive hook
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
 	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> <COMMIT-B> -> main
+	 <COMMIT-A>..<COMMIT-B> <COMMIT-B> -> main
 	 ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual &&
diff --git a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
index e89096fa13..c586cd70a0 100644
--- a/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
+++ b/t/t5411/test-0023-report-unexpect-ref--porcelain.sh
@@ -26,7 +26,7 @@ test_expect_success "proc-receive: report unexpected ref ($PROTOCOL/porcelain)"
 	remote: # post-receive hook
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
 	To <URL/of/upstream.git>
-	     <COMMIT-B>:refs/heads/main    <OID-A>..<OID-B>
+	     <COMMIT-B>:refs/heads/main    <COMMIT-A>..<COMMIT-B>
 	!    HEAD:refs/for/main/topic    [remote rejected] (proc-receive failed to report status)
 	Done
 	EOF
diff --git a/t/t5411/test-0032-report-with-options.sh b/t/t5411/test-0032-report-with-options.sh
index 437ade012d..bbd09ecdfb 100644
--- a/t/t5411/test-0032-report-with-options.sh
+++ b/t/t5411/test-0032-report-with-options.sh
@@ -123,7 +123,7 @@ test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL)
 	remote: # post-receive hook
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
-	 <OID-B>..<OID-A> HEAD -> refs/pull/123/head
+	 <COMMIT-B>..<COMMIT-A> HEAD -> refs/pull/123/head
 	EOF
 	test_cmp expect actual
 '
@@ -155,7 +155,7 @@ test_expect_success "proc-receive: report option old-oid ($PROTOCOL)" '
 	remote: # post-receive hook
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/main/topic
 	To <URL/of/upstream.git>
-	 <OID-B>..<OID-A> HEAD -> refs/for/main/topic
+	 <COMMIT-B>..<COMMIT-A> HEAD -> refs/for/main/topic
 	EOF
 	test_cmp expect actual
 '
@@ -189,7 +189,7 @@ test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL)
 	remote: # post-receive hook
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic
 	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> HEAD -> refs/for/main/topic
+	 <COMMIT-A>..<COMMIT-B> HEAD -> refs/for/main/topic
 	EOF
 	test_cmp expect actual
 '
@@ -243,7 +243,7 @@ test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL)" '
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/pull/123/head
 	 * [new reference] HEAD -> refs/for/a/b/c/topic
-	 + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
+	 + <COMMIT-B>...<COMMIT-A> HEAD -> refs/pull/124/head (forced update)
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0033-report-with-options--porcelain.sh b/t/t5411/test-0033-report-with-options--porcelain.sh
index 11486720ee..d6a24d60ff 100644
--- a/t/t5411/test-0033-report-with-options--porcelain.sh
+++ b/t/t5411/test-0033-report-with-options--porcelain.sh
@@ -127,7 +127,7 @@ test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL/
 	remote: # post-receive hook
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
-	     HEAD:refs/pull/123/head    <OID-B>..<OID-A>
+	     HEAD:refs/pull/123/head    <COMMIT-B>..<COMMIT-A>
 	Done
 	EOF
 	test_cmp expect actual
@@ -160,7 +160,7 @@ test_expect_success "proc-receive: report option old-oid ($PROTOCOL/porcelain)"
 	remote: # post-receive hook
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/main/topic
 	To <URL/of/upstream.git>
-	     HEAD:refs/for/main/topic    <OID-B>..<OID-A>
+	     HEAD:refs/for/main/topic    <COMMIT-B>..<COMMIT-A>
 	Done
 	EOF
 	test_cmp expect actual
@@ -195,7 +195,7 @@ test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL/
 	remote: # post-receive hook
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic
 	To <URL/of/upstream.git>
-	     HEAD:refs/for/main/topic    <OID-A>..<OID-B>
+	     HEAD:refs/for/main/topic    <COMMIT-A>..<COMMIT-B>
 	Done
 	EOF
 	test_cmp expect actual
@@ -251,7 +251,7 @@ test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL/porc
 	To <URL/of/upstream.git>
 	*    HEAD:refs/pull/123/head    [new reference]
 	*    HEAD:refs/for/a/b/c/topic    [new reference]
-	+    HEAD:refs/pull/124/head    <OID-B>...<OID-A> (forced update)
+	+    HEAD:refs/pull/124/head    <COMMIT-B>...<COMMIT-A> (forced update)
 	Done
 	EOF
 	test_cmp expect actual &&
diff --git a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
index be9b18b2b6..604656824b 100644
--- a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
+++ b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
@@ -60,9 +60,9 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/25/125/1
 	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> HEAD -> refs/for/main/topic
+	 <COMMIT-A>..<COMMIT-B> HEAD -> refs/for/main/topic
 	 * [new reference] HEAD -> refs/changes/24/124/1
-	 <OID-A>..<OID-B> HEAD -> refs/changes/25/125/1
+	 <COMMIT-A>..<COMMIT-B> HEAD -> refs/changes/25/125/1
 	EOF
 	test_cmp expect actual &&
 
@@ -136,8 +136,8 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/changes/25/125/1
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/changes/24/124/1
-	 <OID-A>..<OID-B> HEAD -> refs/for/main/topic
-	 + <OID-B>...<OID-A> HEAD -> refs/changes/25/125/1 (forced update)
+	 <COMMIT-A>..<COMMIT-B> HEAD -> refs/for/main/topic
+	 + <COMMIT-B>...<COMMIT-A> HEAD -> refs/changes/25/125/1 (forced update)
 	EOF
 	test_cmp expect actual &&
 
@@ -198,7 +198,7 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL)" '
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/24/124/2
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/changes/23/123/1
-	 <OID-A>..<OID-B> HEAD -> refs/changes/24/124/2
+	 <COMMIT-A>..<COMMIT-B> HEAD -> refs/changes/24/124/2
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
index 95fb89c031..6cc0c78a2a 100644
--- a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
+++ b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
@@ -45,9 +45,9 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/25/125/1
 	To <URL/of/upstream.git>
-	     HEAD:refs/for/main/topic    <OID-A>..<OID-B>
+	     HEAD:refs/for/main/topic    <COMMIT-A>..<COMMIT-B>
 	*    HEAD:refs/changes/24/124/1    [new reference]
-	     HEAD:refs/changes/25/125/1    <OID-A>..<OID-B>
+	     HEAD:refs/changes/25/125/1    <COMMIT-A>..<COMMIT-B>
 	Done
 	EOF
 	test_cmp expect actual &&
@@ -107,8 +107,8 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/changes/25/125/1
 	To <URL/of/upstream.git>
 	*    HEAD:refs/changes/24/124/1    [new reference]
-	     HEAD:refs/for/main/topic    <OID-A>..<OID-B>
-	+    HEAD:refs/changes/25/125/1    <OID-B>...<OID-A> (forced update)
+	     HEAD:refs/for/main/topic    <COMMIT-A>..<COMMIT-B>
+	+    HEAD:refs/changes/25/125/1    <COMMIT-B>...<COMMIT-A> (forced update)
 	Done
 	EOF
 	test_cmp expect actual &&
@@ -155,7 +155,7 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL/porc
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/24/124/2
 	To <URL/of/upstream.git>
 	*    HEAD:refs/changes/23/123/1    [new reference]
-	     HEAD:refs/changes/24/124/2    <OID-A>..<OID-B>
+	     HEAD:refs/changes/24/124/2    <COMMIT-A>..<COMMIT-B>
 	Done
 	EOF
 	test_cmp expect actual &&
diff --git a/t/t5411/test-0038-report-mixed-refs.sh b/t/t5411/test-0038-report-mixed-refs.sh
index 5e005299cc..9260644814 100644
--- a/t/t5411/test-0038-report-mixed-refs.sh
+++ b/t/t5411/test-0038-report-mixed-refs.sh
@@ -55,12 +55,12 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic
 	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> <COMMIT-B> -> main
+	 <COMMIT-A>..<COMMIT-B> <COMMIT-B> -> main
 	 * [new branch] HEAD -> bar
 	 * [new branch] HEAD -> baz
 	 * [new reference] HEAD -> refs/for/next/topic2
 	 * [new branch] HEAD -> foo
-	 <OID-A>..<OID-B> HEAD -> refs/for/main/topic
+	 <COMMIT-A>..<COMMIT-B> HEAD -> refs/for/main/topic
 	 ! [remote rejected] HEAD -> refs/for/next/topic1 (fail to call Web API)
 	 ! [remote rejected] HEAD -> refs/for/next/topic3 (proc-receive failed to report status)
 	EOF
diff --git a/t/t5411/test-0039-report-mixed-refs--porcelain.sh b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
index 8f891c5385..4fe37683f8 100644
--- a/t/t5411/test-0039-report-mixed-refs--porcelain.sh
+++ b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
@@ -55,12 +55,12 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcel
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/main/topic
 	To <URL/of/upstream.git>
-	     <COMMIT-B>:refs/heads/main    <OID-A>..<OID-B>
+	     <COMMIT-B>:refs/heads/main    <COMMIT-A>..<COMMIT-B>
 	*    HEAD:refs/heads/bar    [new branch]
 	*    HEAD:refs/heads/baz    [new branch]
 	*    HEAD:refs/for/next/topic2    [new reference]
 	*    HEAD:refs/heads/foo    [new branch]
-	     HEAD:refs/for/main/topic    <OID-A>..<OID-B>
+	     HEAD:refs/for/main/topic    <COMMIT-A>..<COMMIT-B>
 	!    HEAD:refs/for/next/topic1    [remote rejected] (fail to call Web API)
 	!    HEAD:refs/for/next/topic3    [remote rejected] (proc-receive failed to report status)
 	Done
diff --git a/t/t5411/test-0040-process-all-refs.sh b/t/t5411/test-0040-process-all-refs.sh
index fdcdcc7c2e..33a7f49a50 100644
--- a/t/t5411/test-0040-process-all-refs.sh
+++ b/t/t5411/test-0040-process-all-refs.sh
@@ -85,11 +85,11 @@ test_expect_success "proc-receive: process all refs ($PROTOCOL)" '
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/pull/123/head
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head
 	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> <COMMIT-B> -> bar
+	 <COMMIT-A>..<COMMIT-B> <COMMIT-B> -> bar
 	 - [deleted] foo
-	 + <OID-B>...<OID-A> HEAD -> main (forced update)
-	 <OID-A>..<OID-B> HEAD -> refs/pull/123/head
-	 + <OID-B>...<OID-A> HEAD -> refs/pull/124/head (forced update)
+	 + <COMMIT-B>...<COMMIT-A> HEAD -> main (forced update)
+	 <COMMIT-A>..<COMMIT-B> HEAD -> refs/pull/123/head
+	 + <COMMIT-B>...<COMMIT-A> HEAD -> refs/pull/124/head (forced update)
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0041-process-all-refs--porcelain.sh b/t/t5411/test-0041-process-all-refs--porcelain.sh
index 73b35fe0aa..07dce47a7d 100644
--- a/t/t5411/test-0041-process-all-refs--porcelain.sh
+++ b/t/t5411/test-0041-process-all-refs--porcelain.sh
@@ -85,11 +85,11 @@ test_expect_success "proc-receive: process all refs ($PROTOCOL/porcelain)" '
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/pull/123/head
 	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head
 	To <URL/of/upstream.git>
-	     <COMMIT-B>:refs/heads/bar    <OID-A>..<OID-B>
+	     <COMMIT-B>:refs/heads/bar    <COMMIT-A>..<COMMIT-B>
 	-    :refs/heads/foo    [deleted]
-	+    HEAD:refs/heads/main    <OID-B>...<OID-A> (forced update)
-	     HEAD:refs/pull/123/head    <OID-A>..<OID-B>
-	+    HEAD:refs/pull/124/head    <OID-B>...<OID-A> (forced update)
+	+    HEAD:refs/heads/main    <COMMIT-B>...<COMMIT-A> (forced update)
+	     HEAD:refs/pull/123/head    <COMMIT-A>..<COMMIT-B>
+	+    HEAD:refs/pull/124/head    <COMMIT-B>...<COMMIT-A> (forced update)
 	Done
 	EOF
 	test_cmp expect actual &&
diff --git a/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh b/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
index 7214647ada..906d75e62d 100644
--- a/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
+++ b/t/t5411/test-0050-proc-receive-refs-with-modifiers.sh
@@ -46,7 +46,7 @@ test_expect_success "proc-receive: update branch and new tag ($PROTOCOL)" '
 	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/pull/123/head
 	remote: post-receive< <ZERO-OID> <TAG-v123> refs/pull/124/head
 	To <URL/of/upstream.git>
-	 <OID-A>..<OID-B> <COMMIT-B> -> refs/pull/123/head
+	 <COMMIT-A>..<COMMIT-B> <COMMIT-B> -> refs/pull/123/head
 	 * [new reference] v123 -> refs/pull/124/head
 	EOF
 	test_cmp expect actual &&
@@ -116,7 +116,7 @@ test_expect_success "proc-receive: create/delete branch, and delete tag ($PROTOC
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/124/head
 	To <URL/of/upstream.git>
 	 - [deleted] refs/pull/123/head
-	 <OID-A>..<OID-B> <COMMIT-B> -> topic
+	 <COMMIT-A>..<COMMIT-B> <COMMIT-B> -> topic
 	 - [deleted] v123
 	 * [new reference] <COMMIT-A> -> refs/pull/124/head
 	EOF
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index 5a761f3642..335abe85a7 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -14,29 +14,28 @@ test_description='Test git push porcelain output'
 # NOTE: Never calling this function from a subshell since variable
 # assignments will disappear when subshell exits.
 create_commits_in () {
-	repo="$1" &&
-	if ! parent=$(git -C "$repo" rev-parse HEAD^{} --)
-	then
-		parent=
-	fi &&
-	T=$(git -C "$repo" write-tree) &&
+	repo="$1" && test -d "$repo" ||
+	error "Repository $repo does not exist."
 	shift &&
 	while test $# -gt 0
 	do
 		name=$1 &&
-		test_tick &&
-		if test -z "$parent"
-		then
-			oid=$(echo $name | git -C "$repo" commit-tree $T)
-		else
-			oid=$(echo $name | git -C "$repo" commit-tree -p $parent $T)
-		fi &&
-		eval $name=$oid &&
-		parent=$oid &&
-		shift ||
-		return 1
-	done &&
-	git -C "$repo" update-ref refs/heads/main $oid
+		shift &&
+		test_commit -C "$repo" --no-tag "$name" &&
+		eval $name=$(git -C "$repo" rev-parse HEAD)
+	done
+}
+
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
 }
 
 # Format the output of git-push, git-show-ref and other commands to make a
@@ -48,11 +47,9 @@ make_user_friendly_and_stable_output () {
 		-e "s/  *\$//" \
 		-e "s/   */ /g" \
 		-e "s/	/    /g" \
-		-e "s/$A/<COMMIT-A>/g" \
-		-e "s/$B/<COMMIT-B>/g" \
+		-e "s/$(get_abbrev_oid $A)[0-9a-f]*/<COMMIT-A>/g" \
+		-e "s/$(get_abbrev_oid $B)[0-9a-f]*/<COMMIT-B>/g" \
 		-e "s/$ZERO_OID/<ZERO-OID>/g" \
-		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
-		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
 		-e "s#To $URL_PREFIX/upstream.git#To <URL/of/upstream.git>#"
 }
 
@@ -114,9 +111,9 @@ run_git_push_porcelain_output_test() {
 		cat >expect <<-EOF &&
 		To <URL/of/upstream.git>
 		=    refs/heads/baz:refs/heads/baz    [up to date]
-		     <COMMIT-B>:refs/heads/bar    <OID-A>..<OID-B>
+		     <COMMIT-B>:refs/heads/bar    <COMMIT-A>..<COMMIT-B>
 		-    :refs/heads/foo    [deleted]
-		+    refs/heads/main:refs/heads/main    <OID-B>...<OID-A> (forced update)
+		+    refs/heads/main:refs/heads/main    <COMMIT-B>...<COMMIT-A> (forced update)
 		*    refs/heads/next:refs/heads/next    [new branch]
 		Done
 		EOF
@@ -231,7 +228,7 @@ run_git_push_porcelain_output_test() {
 		To <URL/of/upstream.git>
 		=    refs/heads/next:refs/heads/next    [up to date]
 		-    :refs/heads/baz    [deleted]
-		     refs/heads/main:refs/heads/main    <OID-A>..<OID-B>
+		     refs/heads/main:refs/heads/main    <COMMIT-A>..<COMMIT-B>
 		!    refs/heads/bar:refs/heads/bar    [rejected] (non-fast-forward)
 		Done
 		EOF
-- 
2.32.0.rc0.27.g7b1e85181b

