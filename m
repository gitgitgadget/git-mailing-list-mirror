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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB04C64E75
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F812083E
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZLb2DlB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbgKYXev (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 18:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgKYXev (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 18:34:51 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C7AC0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 15:34:51 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id o25so242713oie.5
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 15:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZpHCstE09YwJv82yvtJn1ceRRPvyWL50rX8fZzfn1xE=;
        b=BZLb2DlBj8QBwFw4VoTC8I06lURq3QI3julNiMkK0i3mzkdHCBuQfdjdOfXFk3qS2i
         IIP5yXeGAEStn41EgMppXhjgqv1/YW1TjSK8UqHsSq5rVT3Lx0oJFbbNVbNvEQxEAR1L
         9ffYeuoXTz8WiNqYP+1gm3u69jHe/QpVPzn/ZvAtUABq6pU51pyE0rNt/u3T2iqLwCM+
         F9VMNav54VAK+bV/4kwYh4rXoM+peklp+DC06UoBRo8mmsF8+lz6LTqv5MPacRgqsZ4B
         H7ukgVRAuhjVb+hql2pXdfuwfIcH6HFj3B7JrZbVc9QyoKsAlsOpfMw50Bym/YdIjf9S
         pQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZpHCstE09YwJv82yvtJn1ceRRPvyWL50rX8fZzfn1xE=;
        b=psMNXXLGfpdXZavjqfwP7bkAZuR/iryr/AkbfX2tEDPDe72oWgzPmIiBnajt7cRQ4D
         u6E/ZAR9/vXA78RMxIUObRqT/WDszayFT17Eq3TLG04VwqpJ086F6iWNAclDSGLiwyus
         D91W/Q0kGnEOX9AzawvWf1q9xnTQtRh+1gmYnPc0MCgqgw0Q43f9x9tuaF46NEOtQnce
         JJI5Bz8U87yVFwWRjeZ7m+5oVSxLZQzuuLF+08shkbJxYAHqTtq82vYGLCc6mfPxSE2t
         2YxciO81+VoSQ0U526tdGy/yjcktlr62y9XFHXiuwWptShaC4H17UV1AmHcJsYRGQW4L
         b4Lw==
X-Gm-Message-State: AOAM530Sqet+RgO8VBAN+kl8I+w7YerQxWsm4D3mDuiKazPO49JUHwwm
        0c1VAWFhtmK3e/tgX1Tr+iKmaCL5Y7HsMg==
X-Google-Smtp-Source: ABdhPJx5aq3X3vxUvu/jaoCmfgHuLbgG5WdTrGbzGoGTxOPrnqKbXMOD59GvMdvrjUJBNak32UWt9A==
X-Received: by 2002:a05:6808:b38:: with SMTP id t24mr324780oij.153.1606347290517;
        Wed, 25 Nov 2020 15:34:50 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id m29sm1937345otj.42.2020.11.25.15.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 15:34:50 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Tomo Krajina <tkrajina@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 3/3] refspec: make @ a synonym of HEAD
Date:   Wed, 25 Nov 2020 17:34:43 -0600
Message-Id: <20201125233443.63130-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125233443.63130-1-felipe.contreras@gmail.com>
References: <20201125233443.63130-1-felipe.contreras@gmail.com>
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
 t/t5516-fetch-push.sh | 106 ++++++++++++++++++++++--------------------
 3 files changed, 61 insertions(+), 52 deletions(-)

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
index 245eafb170..0cc5688135 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -436,71 +436,75 @@ test_expect_success 'push ref expression with non-existent, incomplete dest' '
 
 '
 
-test_expect_success 'push with HEAD' '
+for head in HEAD @; do
 
-	mk_test testrepo heads/master &&
-	git checkout master &&
-	git push testrepo HEAD &&
-	check_push_result testrepo $the_commit heads/master
+	test_expect_success "push with $head" "
 
-'
+		mk_test testrepo heads/master &&
+		git checkout master &&
+		git push testrepo $head &&
+		check_push_result testrepo \$the_commit heads/master
 
-test_expect_success 'push with HEAD nonexisting at remote' '
+	"
 
-	mk_test testrepo heads/master &&
-	git checkout -b local master &&
-	test_when_finished "git checkout master; git branch -D local" &&
-	git push testrepo HEAD &&
-	check_push_result testrepo $the_commit heads/local
-'
+	test_expect_success "push with $head nonexisting at remote" "
 
-test_expect_success 'push with +HEAD' '
+		mk_test testrepo heads/master &&
+		git checkout -b local master &&
+		test_when_finished 'git checkout master; git branch -D local' &&
+		git push testrepo $head &&
+		check_push_result testrepo \$the_commit heads/local
+	"
 
-	mk_test testrepo heads/master &&
-	git checkout -b local master &&
-	test_when_finished "git checkout master; git branch -D local" &&
-	git push testrepo master local &&
-	check_push_result testrepo $the_commit heads/master &&
-	check_push_result testrepo $the_commit heads/local &&
+	test_expect_success "push with +$head" "
 
-	# Without force rewinding should fail
-	git reset --hard HEAD^ &&
-	test_must_fail git push testrepo HEAD &&
-	check_push_result testrepo $the_commit heads/local &&
+		mk_test testrepo heads/master &&
+		git checkout -b local master &&
+		test_when_finished 'git checkout master; git branch -D local' &&
+		git push testrepo master local &&
+		check_push_result testrepo \$the_commit heads/master &&
+		check_push_result testrepo \$the_commit heads/local &&
 
-	# With force rewinding should succeed
-	git push testrepo +HEAD &&
-	check_push_result testrepo $the_first_commit heads/local
+		# Without force rewinding should fail
+		git reset --hard $head^ &&
+		test_must_fail git push testrepo $head &&
+		check_push_result testrepo \$the_commit heads/local &&
 
-'
+		# With force rewinding should succeed
+		git push testrepo +$head &&
+		check_push_result testrepo \$the_first_commit heads/local
 
-test_expect_success 'push HEAD with non-existent, incomplete dest' '
+	"
 
-	mk_test testrepo &&
-	git checkout master &&
-	git push testrepo HEAD:branch &&
-	check_push_result testrepo $the_commit heads/branch
+	test_expect_success "push $head with non-existent, incomplete dest" "
 
-'
+		mk_test testrepo &&
+		git checkout master &&
+		git push testrepo $head:branch &&
+		check_push_result testrepo \$the_commit heads/branch
 
-test_expect_success 'push with config remote.*.push = HEAD' '
+	"
 
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
+	test_expect_success "push with config remote.*.push = $head" "
+
+		mk_test testrepo heads/local &&
+		git checkout master &&
+		git branch -f local \$the_commit &&
+		test_when_finished 'git branch -D local' &&
+		(
+			cd testrepo &&
+			git checkout local &&
+			git reset --hard \$the_first_commit
+		) &&
+		test_config remote.there.url testrepo &&
+		test_config remote.there.push $head &&
+		test_config branch.master.remote there &&
+		git push &&
+		check_push_result testrepo \$the_commit heads/master &&
+		check_push_result testrepo \$the_first_commit heads/local
+	"
+
+done
 
 test_expect_success 'push with remote.pushdefault' '
 	mk_test up_repo heads/master &&
-- 
2.29.2

