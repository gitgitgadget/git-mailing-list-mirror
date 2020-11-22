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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEF6C5519F
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 16:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD3C420781
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 16:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThdaL3bz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgKVQqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 11:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgKVQqo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 11:46:44 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6317EC0613CF
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 08:46:44 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id l36so13733677ota.4
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 08:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Yo3DM1R/1aJPm1lMHZGVMuw2fMdXRzHvcn6WYR06+Y=;
        b=ThdaL3bzjEDtmW0Sn4pNX+RIUiBWEjyUvXAzJo74TH8neoTmMy+o1G3YMd+6Ub1n8F
         yja4IJrHg29MYCBjRucVpkoZWQAZ2MaPGjEvz7Yrz/MJrAmYh60XJEg2iiw71/LXlEhJ
         Ivpw6Ke69D6stB3Q3heVAUEXnYjBVLzOrbmXub/kdjBh/3jPeg8SglEKjK60DZRTj3Ge
         BX76/sIA17E0z0lQw9Np5PyFAx7H0dktvn6SVA6zpQU2LS1BEhzPQhCOuyM7MJj7n/qV
         g62e25ppHZfLgGGkJPTQCypZ/NqqjA/f/oJlTVKGpLvCr6NT0nUP/l08OOoi3pI+2Jzb
         TUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Yo3DM1R/1aJPm1lMHZGVMuw2fMdXRzHvcn6WYR06+Y=;
        b=hjh7BifTRwm3LpYn4BdNtqHGNQyR/Yyxt/DLR4aKlNGuEG2CcqGVv1ZEjovhPMs5Nk
         0chnaCrFcvgdFoHpIiZgWDoX/DwaRcCYRJ5n08o3jzo1mqjdJAt3u7/fSksQrLDLkMjE
         QS6/VmIyAJEWXqfGf1Ud1oBpYvtvKAj4nWZjSaZAHp9o52P69YwlfwM/rA9D6Nhuy9jX
         P6Mjf+G38jrqi8ayUgRxczAaapCe+hGBMZchAMJQpPYQuQhDqojOLsc0TqTJc/tcivQi
         KH7MJkmBXyDJNsFPLinnoukSh3q1SkobcWOP6LibaaEgJH1aBInEvq1FiIyBgXIGkKi7
         q0pA==
X-Gm-Message-State: AOAM533efz18/JCcCT94zBjFAB2N7joAcASi8LvCmGzBn8CBB/HPSN1K
        3/huxDu7A0/OQP+PStzlhN/JHPxr20MyWw==
X-Google-Smtp-Source: ABdhPJyS9K8FZ+31Fr7RcWdNR5NwNzZMkXiqLE0y2eVwuGMSUdlHVZwZD4QLutFB8zStu0ZBEirTtw==
X-Received: by 2002:a9d:6d05:: with SMTP id o5mr6286239otp.158.1606063603324;
        Sun, 22 Nov 2020 08:46:43 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id u4sm3773736ote.71.2020.11.22.08.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 08:46:42 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] refspec: make @ a valid refspec
Date:   Sun, 22 Nov 2020 10:46:41 -0600
Message-Id: <20201122164641.2091160-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
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

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 refspec.c             | 5 ++++-
 t/t5511-refspec.sh    | 2 ++
 t/t5516-fetch-push.sh | 9 +++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

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
index d11382f769..12c0c7c06b 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -501,6 +501,15 @@ test_expect_success 'push with config remote.*.push = HEAD' '
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

