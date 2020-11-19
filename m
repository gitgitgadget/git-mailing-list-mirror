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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B43CC64E75
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 01:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E79246CA
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 01:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQLagNGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbgKSBwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 20:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbgKSBwS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 20:52:18 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F45FC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 17:52:18 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id k26so4619861oiw.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 17:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iUt7GQutxz3mgHglSFcvh2I2ipKDO2u3MjWJhgdu43M=;
        b=JQLagNGak8GZnwo0YuJN8W/4dMU6DmOAvHvBjtVR4xD8fhXQyHAB+uS6m10pLShFS7
         P3Jb90WVaROXf8PPk/J5+5TJlwYueMSKchzXaNQvac9TOBIrita2Aei1tzVFW6mPiwLy
         7lQDqgAGJJSkOjzYicZoFuhcUEh6zKZKKY2bZEQJVz0WxlF3uDcxQRF/Q8oa5JeK0QGY
         MavtGxTPbfbw7pNUqYP7+KGBOEYGCaKzb/bBc/564MkH5xD43TAvUE4+xJdYgoRewUXP
         Ef/iejPXGJsBnhpPxtzDC+rR0/7r8k8c8ZOHK+8Miff1hgbUe39W2UNTl+CeAjc83BHx
         nlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iUt7GQutxz3mgHglSFcvh2I2ipKDO2u3MjWJhgdu43M=;
        b=kJ1wqmbDgObUXnyugFvTgVp6CQXt9k612i2Iqn7Owx15E0quijzKgWMcYQ+cLAk/aM
         tH7HMUAPUCsP0qqus0K65mn6Z6ANaMuRA3w/x4Jm2ru0mN/12/Yn4umfLW4O+H6AjA4L
         Oj3+6C+5wvci/17lkDJOEuq42wjrVTm9DiTk+yyypc82kEYmbYlLdhdvJu9ZZMPXGKC1
         YLHec9pcuettF90soR+JxW+g2/HXTZHe08ipxSLaabGwGBO1iN1ZYrFl5j5/qcIuai7X
         HbZdL1OTWX6qfLiwvvF93s1cbK5oxrUiXV1zIj8tOXNKLzg0/twhOT1Q+8HIl4wdOQ88
         hdRQ==
X-Gm-Message-State: AOAM532xG8nM6BkluwxkibGI/X6LfZCZtlLoBfK3ymeyzstcfmPYBVlk
        xv8VIthiOehJZLeO3DuhACqd57QHBtFdYw==
X-Google-Smtp-Source: ABdhPJx6qkJOA88PWWzrvQ90H6+Fl7SZudt0g3KTIhxqwqhqIWxXypa5JNeSIebMvyujm7OAjpbrwQ==
X-Received: by 2002:aca:c188:: with SMTP id r130mr1451829oif.99.1605750737414;
        Wed, 18 Nov 2020 17:52:17 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id p128sm8869200ooa.14.2020.11.18.17.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 17:52:16 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/4] completion: bash: fix for suboptions with value
Date:   Wed, 18 Nov 2020 19:52:08 -0600
Message-Id: <20201119015209.1155170-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119015209.1155170-1-felipe.contreras@gmail.com>
References: <20201119015209.1155170-1-felipe.contreras@gmail.com>
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

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |  2 +-
 t/t9902-completion.sh                  | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bbdb46d87e..5b2dff150d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -347,7 +347,7 @@ __gitcomp ()
 	local cur_="${3-$cur}"
 
 	case "$cur_" in
-	--*=)
+	*=)
 		;;
 	--no-*)
 		local c i=0 IFS=$' \t\n'
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 4a3d3d1597..4deda01153 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -537,6 +537,15 @@ test_expect_success '__gitcomp - expand/narrow all negative options' '
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
@@ -2342,6 +2351,12 @@ test_expect_success 'git clone --config= - value' '
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
2.29.2

