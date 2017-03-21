Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44DAB2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 00:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755580AbdCUA4b (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 20:56:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64207 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755253AbdCUA4a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 20:56:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF7437FDDE;
        Mon, 20 Mar 2017 20:56:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=+xRn
        mhooF1V7ch2qG1LDn+PuZzc=; b=GbsJPsrQnIIYOWgpIS+8Fxe6TE3CTDlKcU9m
        ne1tm9+ssm8jVObLIAfSKvrDNVlTIiDrL0iGOq8U1mRqsxL3l8hwywk56LAmbEZ3
        5gs5sTn/o8KovqE2lLPHp0zEJhHHJEes7gcAqqPLr0Y10/MegTgSAYhNooOx9ukJ
        AgA1WFE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7FE57FDDC;
        Mon, 20 Mar 2017 20:56:28 -0400 (EDT)
Received: from kmlap.hsd1.ct.comcast.net (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1DC7D7FDD8;
        Mon, 20 Mar 2017 20:56:27 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: [PATCH 3/5] t1400: use test_path_is_* helpers
Date:   Mon, 20 Mar 2017 20:56:14 -0400
Message-Id: <20170321005616.31324-4-kyle@kyleam.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170321005616.31324-1-kyle@kyleam.com>
References: <20170321005616.31324-1-kyle@kyleam.com>
X-Pobox-Relay-ID: 3723C75C-0DD1-11E7-AFBD-FC50AE2156B6-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=mesmtp;
 bh=+xRnmhooF1V7ch2qG1LDn+PuZzc=;
 b=ORJ3YT1jkcWNHuywbDieU8Bmh2h9xOkKwJlOH0Pz2tKExBAhK7cnvFAU1JqA2tUGm6X6L0g4m7DOU4wFyOa86uOzR13/l6Vet5l9meC/hsFM2SHtAZZhSEObkvlPz8Fr9hXAD17jPrDPh7drjACOGJgKy2OQhrugq0IXYNIwDHY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 t/t1400-update-ref.sh | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index be8b113b1..c5c8e95fc 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -49,7 +49,7 @@ test_expect_success "fail to delete $m with stale ref" '
 '
 test_expect_success "delete $m" '
 	git update-ref -d $m $B &&
-	! test -f .git/$m
+	test_path_is_missing .git/$m
 '
 rm -f .git/$m
 
@@ -57,7 +57,7 @@ test_expect_success "delete $m without oldvalue verification" "
 	git update-ref $m $A &&
 	test $A = \$(cat .git/$m) &&
 	git update-ref -d $m &&
-	! test -f .git/$m
+	test_path_is_missing .git/$m
 "
 rm -f .git/$m
 
@@ -81,7 +81,7 @@ test_expect_success "fail to delete $m (by HEAD) with stale ref" '
 '
 test_expect_success "delete $m (by HEAD)" '
 	git update-ref -d HEAD $B &&
-	! test -f .git/$m
+	test_path_is_missing .git/$m
 '
 rm -f .git/$m
 
@@ -89,7 +89,7 @@ test_expect_success "deleting current branch adds message to HEAD's log" '
 	git update-ref $m $A &&
 	git symbolic-ref HEAD $m &&
 	git update-ref -m delete-$m -d $m &&
-	! test -f .git/$m &&
+	test_path_is_missing .git/$m &&
 	grep "delete-$m$" .git/logs/HEAD
 '
 rm -f .git/$m
@@ -98,7 +98,7 @@ test_expect_success "deleting by HEAD adds message to HEAD's log" '
 	git update-ref $m $A &&
 	git symbolic-ref HEAD $m &&
 	git update-ref -m delete-by-head -d HEAD &&
-	! test -f .git/$m &&
+	test_path_is_missing .git/$m &&
 	grep "delete-by-head$" .git/logs/HEAD
 '
 rm -f .git/$m
@@ -190,14 +190,14 @@ test_expect_success \
 test_expect_success "delete $m (by HEAD) should remove both packed and loose $m" '
 	git update-ref -d HEAD $B &&
 	! grep "$m" .git/packed-refs &&
-	! test -f .git/$m
+	test_path_is_missing .git/$m
 '
 rm -f .git/$m
 
 cp -f .git/HEAD .git/HEAD.orig
 test_expect_success "delete symref without dereference" '
 	git update-ref --no-deref -d HEAD &&
-	! test -f .git/HEAD
+	test_path_is_missing .git/HEAD
 '
 cp -f .git/HEAD.orig .git/HEAD
 
@@ -207,7 +207,7 @@ test_expect_success "delete symref without dereference when the referred ref is
 	git commit -m foo &&
 	git pack-refs --all &&
 	git update-ref --no-deref -d HEAD &&
-	! test -f .git/HEAD
+	test_path_is_missing .git/HEAD
 '
 cp -f .git/HEAD.orig .git/HEAD
 git update-ref -d $m
@@ -242,7 +242,7 @@ test_expect_success '(not) create HEAD with old sha1' "
 	test_must_fail git update-ref HEAD $A $B
 "
 test_expect_success "(not) prior created .git/$m" "
-	! test -f .git/$m
+	test_path_is_missing .git/$m
 "
 rm -f .git/$m
 
@@ -280,13 +280,13 @@ test_expect_success \
 test_expect_success "empty directory removal" '
 	git branch d1/d2/r1 HEAD &&
 	git branch d1/r2 HEAD &&
-	test -f .git/refs/heads/d1/d2/r1 &&
-	test -f .git/logs/refs/heads/d1/d2/r1 &&
+	test_path_is_file .git/refs/heads/d1/d2/r1 &&
+	test_path_is_file .git/logs/refs/heads/d1/d2/r1 &&
 	git branch -d d1/d2/r1 &&
-	! test -e .git/refs/heads/d1/d2 &&
-	! test -e .git/logs/refs/heads/d1/d2 &&
-	test -f .git/refs/heads/d1/r2 &&
-	test -f .git/logs/refs/heads/d1/r2
+	test_path_is_missing .git/refs/heads/d1/d2 &&
+	test_path_is_missing .git/logs/refs/heads/d1/d2 &&
+	test_path_is_file .git/refs/heads/d1/r2 &&
+	test_path_is_file .git/logs/refs/heads/d1/r2
 '
 
 test_expect_success "symref empty directory removal" '
@@ -294,14 +294,14 @@ test_expect_success "symref empty directory removal" '
 	git branch e1/r2 HEAD &&
 	git checkout e1/e2/r1 &&
 	test_when_finished "git checkout master" &&
-	test -f .git/refs/heads/e1/e2/r1 &&
-	test -f .git/logs/refs/heads/e1/e2/r1 &&
+	test_path_is_file .git/refs/heads/e1/e2/r1 &&
+	test_path_is_file .git/logs/refs/heads/e1/e2/r1 &&
 	git update-ref -d HEAD &&
-	! test -e .git/refs/heads/e1/e2 &&
-	! test -e .git/logs/refs/heads/e1/e2 &&
-	test -f .git/refs/heads/e1/r2 &&
-	test -f .git/logs/refs/heads/e1/r2 &&
-	test -f .git/logs/HEAD
+	test_path_is_missing .git/refs/heads/e1/e2 &&
+	test_path_is_missing .git/logs/refs/heads/e1/e2 &&
+	test_path_is_file .git/refs/heads/e1/r2 &&
+	test_path_is_file .git/logs/refs/heads/e1/r2 &&
+	test_path_is_file .git/logs/HEAD
 '
 
 cat >expect <<EOF
-- 
2.12.0

