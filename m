Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B153C64E75
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 00:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562FB216C4
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 00:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5rIop3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgKZAQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 19:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgKZAQY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 19:16:24 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EA2C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 16:16:23 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id j15so352120oih.4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 16:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OAJMuKgCy6nbY0KmtKo+zoasNRSlQO+lk5gK1k6xRd8=;
        b=g5rIop3j85wuUkeYWxrdxZMangcfwqUU+3uETby8cpMfKKHtdT85QBkGih8dnYXi4d
         /+TrOeTOG1HodZdDUj1VuF9aq9GZQ03agNyUMeit2DZF3x0mURl0v4ZeS/Q70h70icZy
         SUB5fhqUnpY4jRuLU0CpAm3ETitXE0u2VyxCy+Dfeph9/tZSKl9ueFszWLn7uvxIfz+l
         +yGzPiaQjANJSPUaEYt6Odm3xTvSFAg5E4btWALZlQYJ2mbxuU5gCxwwMS116+a6hdZ1
         X5m70lkQuOlCJ+lHPS5BCjVGM87Fk9tR+FfvPmoniDubqpIdMJ1jPibhq6FIZqwZefBe
         G36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OAJMuKgCy6nbY0KmtKo+zoasNRSlQO+lk5gK1k6xRd8=;
        b=V4QP10TCjOnxizof+Cuo0BHP+N/K5EqYAh0X9e9XcEnAndqFP8e84OWyxWjgtnWU4X
         5n3J5DUgst9Z4SpO2H9qkDPesDmbflnVmk8Y8IhhtMEtMLpHDxU/1E9YBhNuKproCufy
         sku3sLnDQ18u9VdOo339ORCDLJRu9CI5dlWxVFrrsIDeKexSwjyoWqCHWsunLRNy5don
         hjkC32MuiO1pFNoiieJZzLtspjkJmhVloodQU33VR20/1HMP7f0UH1HQYJ9SlWYVekQL
         DxCSQu7Gl5S6VNG/jFR7AQ61SWk+KtSW7hZP6iHAuvze7+4MAqaIk2fNCLm7l1KRiLAw
         n6Ug==
X-Gm-Message-State: AOAM532TqEVy61WjQrW9bbiWC6yGnuYVGCCzByBQG04lAfvN66UF+Rwp
        oxqd+gHfPEDc1KU7hGJuN/UMw+VpeogvNQ==
X-Google-Smtp-Source: ABdhPJwkACeFvPYDw2E6arpX0hV1Ft0Z50zmqS0bU2sgfCohVj2E65JInEzRIxqh7uSA+NgqlHDPmw==
X-Received: by 2002:aca:af57:: with SMTP id y84mr459323oie.122.1606349783054;
        Wed, 25 Nov 2020 16:16:23 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id y18sm2343619ooj.20.2020.11.25.16.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 16:16:22 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Tomo Krajina <tkrajina@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 3/3] refspec: make @ a synonym of HEAD
Date:   Wed, 25 Nov 2020 18:16:16 -0600
Message-Id: <20201126001616.663910-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126001616.663910-1-felipe.contreras@gmail.com>
References: <20201126001616.663910-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit 9ba89f484e git learned how to push to a remote branch using
the source @, for example:

  git push origin @:master

However, if the right-hand side is missing, the push fails:

  git push origin @

It is obvious what is the desired behavior, and allowing the push makes
things more consistent.

Additionally, @:master now has the same semantics as HEAD:master.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 refspec.c             |   5 +-
 t/t5511-refspec.sh    |   2 +
 t/t5516-fetch-push.sh | 107 ++++++++++++++++++++++--------------------
 3 files changed, 62 insertions(+), 52 deletions(-)

diff --git a/refspec.c b/refspec.c
index c49347c2d7..adbfb3283a 100644
--- a/refspec.c
+++ b/refspec.c
@@ -71,7 +71,10 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 	}
 
 	item->pattern = is_glob;
-	item->src = xstrndup(lhs, llen);
+	if (llen == 1 && *lhs == '@')
+		item->src = xstrdup("HEAD");
+	else
+		item->src = xstrndup(lhs, llen);
 	flags = REFNAME_ALLOW_ONELEVEL | (is_glob ? REFNAME_REFSPEC_PATTERN : 0);
 
 	if (item->negative) {
diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
index f541f30bc2..f808649de4 100755
--- a/t/t5511-refspec.sh
+++ b/t/t5511-refspec.sh
@@ -58,6 +58,8 @@ test_refspec fetch 'HEAD~4:refs/remotes/frotz/new'		invalid
 
 test_refspec push 'HEAD'
 test_refspec fetch 'HEAD'
+test_refspec push '@'
+test_refspec fetch '@'
 test_refspec push 'refs/heads/ nitfol'				invalid
 test_refspec fetch 'refs/heads/ nitfol'				invalid
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 245eafb170..01004ff680 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -436,71 +436,76 @@ test_expect_success 'push ref expression with non-existent, incomplete dest' '
 
 '
 
-test_expect_success 'push with HEAD' '
+for head in HEAD @
+do
 
-	mk_test testrepo heads/master &&
-	git checkout master &&
-	git push testrepo HEAD &&
-	check_push_result testrepo $the_commit heads/master
+	test_expect_success "push with $head" '
 
-'
+		mk_test testrepo heads/master &&
+		git checkout master &&
+		git push testrepo $head &&
+		check_push_result testrepo $the_commit heads/master
 
-test_expect_success 'push with HEAD nonexisting at remote' '
+	'
 
-	mk_test testrepo heads/master &&
-	git checkout -b local master &&
-	test_when_finished "git checkout master; git branch -D local" &&
-	git push testrepo HEAD &&
-	check_push_result testrepo $the_commit heads/local
-'
+	test_expect_success "push with $head nonexisting at remote" '
 
-test_expect_success 'push with +HEAD' '
+		mk_test testrepo heads/master &&
+		git checkout -b local master &&
+		test_when_finished "git checkout master; git branch -D local" &&
+		git push testrepo $head &&
+		check_push_result testrepo $the_commit heads/local
+	'
 
-	mk_test testrepo heads/master &&
-	git checkout -b local master &&
-	test_when_finished "git checkout master; git branch -D local" &&
-	git push testrepo master local &&
-	check_push_result testrepo $the_commit heads/master &&
-	check_push_result testrepo $the_commit heads/local &&
+	test_expect_success "push with +$head" '
 
-	# Without force rewinding should fail
-	git reset --hard HEAD^ &&
-	test_must_fail git push testrepo HEAD &&
-	check_push_result testrepo $the_commit heads/local &&
+		mk_test testrepo heads/master &&
+		git checkout -b local master &&
+		test_when_finished "git checkout master; git branch -D local" &&
+		git push testrepo master local &&
+		check_push_result testrepo $the_commit heads/master &&
+		check_push_result testrepo $the_commit heads/local &&
 
-	# With force rewinding should succeed
-	git push testrepo +HEAD &&
-	check_push_result testrepo $the_first_commit heads/local
+		# Without force rewinding should fail
+		git reset --hard $head^ &&
+		test_must_fail git push testrepo $head &&
+		check_push_result testrepo $the_commit heads/local &&
 
-'
+		# With force rewinding should succeed
+		git push testrepo +$head &&
+		check_push_result testrepo $the_first_commit heads/local
 
-test_expect_success 'push HEAD with non-existent, incomplete dest' '
+	'
 
-	mk_test testrepo &&
-	git checkout master &&
-	git push testrepo HEAD:branch &&
-	check_push_result testrepo $the_commit heads/branch
+	test_expect_success "push $head with non-existent, incomplete dest" '
 
-'
+		mk_test testrepo &&
+		git checkout master &&
+		git push testrepo $head:branch &&
+		check_push_result testrepo $the_commit heads/branch
 
-test_expect_success 'push with config remote.*.push = HEAD' '
+	'
 
-	mk_test testrepo heads/local &&
-	git checkout master &&
-	git branch -f local $the_commit &&
-	test_when_finished "git branch -D local" &&
-	(
-		cd testrepo &&
-		git checkout local &&
-		git reset --hard $the_first_commit
-	) &&
-	test_config remote.there.url testrepo &&
-	test_config remote.there.push HEAD &&
-	test_config branch.master.remote there &&
-	git push &&
-	check_push_result testrepo $the_commit heads/master &&
-	check_push_result testrepo $the_first_commit heads/local
-'
+	test_expect_success "push with config remote.*.push = $head" '
+
+		mk_test testrepo heads/local &&
+		git checkout master &&
+		git branch -f local $the_commit &&
+		test_when_finished "git branch -D local" &&
+		(
+			cd testrepo &&
+			git checkout local &&
+			git reset --hard $the_first_commit
+		) &&
+		test_config remote.there.url testrepo &&
+		test_config remote.there.push $head &&
+		test_config branch.master.remote there &&
+		git push &&
+		check_push_result testrepo $the_commit heads/master &&
+		check_push_result testrepo $the_first_commit heads/local
+	'
+
+done
 
 test_expect_success 'push with remote.pushdefault' '
 	mk_test up_repo heads/master &&
-- 
2.29.2

