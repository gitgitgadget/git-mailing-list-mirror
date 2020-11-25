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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9065C56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 00:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB6120708
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 00:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wb0vdhQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgKYALG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 19:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgKYALG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 19:11:06 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4667C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 16:11:05 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 11so603729oty.9
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 16:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XchkaicPQHmfruHNC3kaJQEcM3vkzLRNqkpSaC0kJKQ=;
        b=Wb0vdhQvXhJnHURXrLnebCmGI38pxFWwb1IYX3HWJQaE4FTmExlUZkJjbRllVl8cLu
         /xjtoc8yra8I8p5xi3sA9E8uY8A3EGdwqKr2Em7i3CtpKkBIGj2yCLkd+EuWiHR4N4ET
         HoX/Jy4uxZlvO2xXE5LJEVFu+TwvTE0QVAjslNmA4ZO1OrHuzA9ivvMDVQ/d/5rNComj
         Ss5z8aKj+OvDbB0/YRhYa1y9iZPezBzwZ3iTMJohSozI81iYoHbK6sSudfZhx7klcVqF
         ydOU3XBwypLjjQkmKVnd5lYziqJ/gDJdS/i+LjcbhUIaCO/bkMKzvwzTfQRF6qzIagBP
         W/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XchkaicPQHmfruHNC3kaJQEcM3vkzLRNqkpSaC0kJKQ=;
        b=FMP0rDLhbCNfeXB00SISGJI1MQ/eUYKCfcKZ5Vu3YKnhqFNw+f8ZljZVqNfRNREKnn
         cx/o68LSKtEsjni72PvLna1hypfxGOPV2vE+v9DkXlnzX88a6MZlM0Rsh6lV9tdHuYcU
         8jWbSIWbGz8Ir0qAJHeKCyt+7DJjSdn0nAdjjpopj0ohwlgrnxi180EZJqpLj0pVkVHX
         jCMqCu0Q4V36AChmn8Jz5LJ1/agNTonVotQZTOJttzs4be4VECxY00TSEj62rQ1aTika
         FvHQa35yT4VrApuc2OgKtZPd0TDEjorzmhmAhvFoLN9ML57P8GscdY7mWVrfsXTiQnvQ
         l+EQ==
X-Gm-Message-State: AOAM5324U7TPBtO6VWzQY/cr0/o/SfyDT103hfmpSfjm6lXoR2XkuhWp
        jxvwLXqHQHSPIIFgx/X0+3FUKSY0/RKfqg==
X-Google-Smtp-Source: ABdhPJymKt2i5k69pYD/wVYciUS9wHTDkcLPPnw/1yu6XveuhPqghc/ObM2+QZln/iSgIHIt/71b8w==
X-Received: by 2002:a9d:bf4:: with SMTP id 107mr936091oth.320.1606263064930;
        Tue, 24 Nov 2020 16:11:04 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id e47sm320726ote.50.2020.11.24.16.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 16:11:04 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Tomo Krajina <tkrajina@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] refspec: make @ a synonym of HEAD
Date:   Tue, 24 Nov 2020 18:11:02 -0600
Message-Id: <20201125001102.111025-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit 9ba89f484e git learned how to push to a remote branch using
the source @, for example:

  git push origin @:$dst

However, if the right-hand side is missing, the push fails:

  git push origin @

It is obvious what is the desired behavior, and allowing the push makes
things more consistent.

Additionally, @:master now has the same semantics as HEAD:master.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 refspec.c             |  5 ++++-
 t/t5511-refspec.sh    |  2 ++
 t/t5516-fetch-push.sh | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

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
index d11382f769..1ca6b9641d 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -483,6 +483,15 @@ test_expect_success 'push HEAD with non-existent, incomplete dest' '
 
 '
 
+test_expect_success 'push @ with non-existent, incomplete dest' '
+
+	mk_test testrepo &&
+	git checkout master &&
+	git push testrepo @:branch &&
+	check_push_result testrepo $the_commit heads/branch
+
+'
+
 test_expect_success 'push with config remote.*.push = HEAD' '
 
 	mk_test testrepo heads/local &&
@@ -501,6 +510,15 @@ test_expect_success 'push with config remote.*.push = HEAD' '
 	check_push_result testrepo $the_first_commit heads/local
 '
 
+test_expect_success 'push with @' '
+
+	mk_test testrepo heads/master &&
+	git checkout master &&
+	git push testrepo @ &&
+	check_push_result testrepo $the_commit heads/master
+
+'
+
 test_expect_success 'push with remote.pushdefault' '
 	mk_test up_repo heads/master &&
 	mk_test down_repo heads/master &&
-- 
2.29.2

