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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAB9C07E9B
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 02:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3285B61CA2
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 02:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhGGCef (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 22:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhGGCed (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 22:34:33 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885BFC061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 19:31:52 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id b2so1701247oiy.6
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 19:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QrnsAeUe83T3jTXKML1epgqqWssAt8hSEjd5QDbWyJw=;
        b=iK8x+8Cj3oWR8/e3DTgAFsTko2ntZIXj11X9VnjCnQSxmR6EgafTandhz5UwT2inHI
         +k7UeSqyqaSn6bsA4zuFktOEZ321ka6gn0PFgYsO7Jw4LpmItQ8qCbhhw3QgkFQ9J+uh
         /RJUY1u2lMYHrzihvFtxyb913bHTx6CX+FUj/ci4QlflULLfkUn8lvRa1ySm0HNg6+27
         djjsFKvZWjHL/VnPKG5HXOVgqe68ToH/SnjTS5f8dVtrcYLlPVgk1YkCSf84CfY+U25k
         x1PP5vF07g3JJ9CbKQzX3sB8R7g2/SB4qXuAEbCO+iaMG1cb2WxhBcNSvpLKo+TWXdN0
         sCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QrnsAeUe83T3jTXKML1epgqqWssAt8hSEjd5QDbWyJw=;
        b=p8cGierSKlCCXlGSQyjsazUopjqJiZFGvLY/UmRjGmCG4AlNRSYmk5W/G+ofrhsf1W
         Wb9dfsgpvUyVDTHaZHML5+u3AZkzZkF+R40RUN5eQld9UgelngWEp7Q+g2yzrZ7Wr8I2
         316sqgcrYzCq8uOC64xi7KWoyZZn4zLmlbii39gpj5S+f1h5gINN43P323e3dPo72qBv
         LqHU2+4a8qwVSz2yhwWrUXIVunwGEG0VO8uomG90htinD+JCwPNMeI+uCZ8+rh5p8ALn
         ErWU9Rqag5E6klLyhzrLO0u52jU0PVPbXOVljlfY1iL9OoshgDqASg+0W9sE0aFXCsYx
         FHdg==
X-Gm-Message-State: AOAM531lCxZi1rZDsTU3vIQM+UJ40R7gy+CZJNNtMfgzYZA1fQlT2TL2
        xoIbdurQt0+Bm4VKNpc+Ko1ZnO25wj8=
X-Google-Smtp-Source: ABdhPJzgqHqf10hBsKlg8M42EqoBCTC7qglkX/xo+RjDuATU4HYZHVEaKceswMTR9e2hwNvi6QT63g==
X-Received: by 2002:a05:6808:2105:: with SMTP id r5mr2989925oiw.57.1625625111775;
        Tue, 06 Jul 2021 19:31:51 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id a16sm2588102oiy.17.2021.07.06.19.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 19:31:51 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 2/4] completion: bash: fix for suboptions with value
Date:   Tue,  6 Jul 2021 21:31:44 -0500
Message-Id: <20210707023146.3132162-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210707023146.3132162-1-felipe.contreras@gmail.com>
References: <20210707023146.3132162-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We need to ignore options that don't start with -- as well.

Depending on the value of COMP_WORDBREAKS the last word could be
duplicated otherwise.

Can be tested with:

  git merge -X diff-algorithm=<tab>

Tested-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |  2 +-
 t/t9902-completion.sh                  | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 47b48fbab6..05606609f9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -356,7 +356,7 @@ __gitcomp ()
 	local cur_="${3-$cur}"
 
 	case "$cur_" in
-	--*=)
+	*=)
 		;;
 	--no-*)
 		local c i=0 IFS=$' \t\n'
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cb057ef161..6b56e54fc3 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -540,6 +540,15 @@ test_expect_success '__gitcomp - expand/narrow all negative options' '
 	EOF
 '
 
+test_expect_success '__gitcomp - equal skip' '
+	test_gitcomp "--option=" "--option=" <<-\EOF &&
+
+	EOF
+	test_gitcomp "option=" "option=" <<-\EOF
+
+	EOF
+'
+
 test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
 	__gitcomp "$invalid_variable_name"
 '
@@ -2380,6 +2389,12 @@ test_expect_success 'git clone --config= - value' '
 	EOF
 '
 
+test_expect_success 'options with value' '
+	test_completion "git merge -X diff-algorithm=" <<-\EOF
+
+	EOF
+'
+
 test_expect_success 'sourcing the completion script clears cached commands' '
 	__git_compute_all_commands &&
 	verbose test -n "$__git_all_commands" &&
-- 
2.32.0.36.g70aac2b1aa

