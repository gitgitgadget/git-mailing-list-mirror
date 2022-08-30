Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55984ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiH3JcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiH3JcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:09 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1E2A063C
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:57 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-11eab59db71so11496089fac.11
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=r3olx8FBJ3YfPirvaIW7ssFqvxySlbdnXxpNKjeEsKE=;
        b=k6XPWaOSnMeLdOZGnIjTsalsyB3W+A3cb4KKt4uSpWxjiOZMoxWB7ymE3AeTRTwMlK
         ue8svIBOf7uH2RksLO88RC9xI5DOc/Y4NmdEiyn8wD4F/4bl+WGJsN9TJuqGqAemvme7
         VPhIwnAtg8usDTzGMaerJXY7xQCyBUu6LBoLfpAwcLaYIkZfWmKkOFAYbuuKMutWbzUx
         83klwh+evHLhJdw4Q/5EJIQ+uqA4ntdx5gOEl8VZEaBTW9jh/XoMeBMnKRt863T77Aaw
         fzJXFutngfExliDmyd8UGPm+Qp+frX+Pvh5v9OEYkSiVa17XAmfzeKNg5zgSfjWnBZ5x
         aYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=r3olx8FBJ3YfPirvaIW7ssFqvxySlbdnXxpNKjeEsKE=;
        b=2NKOBH9HOEtMu5JH8q1f6BNBcpwgUvuTqKLVFYqKeF7o4BesGOyF3DhcezxMJDv3cC
         CEfmYa4lxBG4440cTAAgCVhBmQlAUSLIAqrt0yTmkdNhwyE8O6qkPq1S6SQdeiEuEJ1P
         CbupQTKTtFomn5KPVpCW8ChtYRYzSVJWXnJHm3oPujccJRa/DxhkNZRXnkhwPRf1LsIm
         T4OwiWybxS010do4B4e0W4PJAYxBmBvEQkjLfb4nsfp86dLzarDtu7AOIL5z8S0npmvQ
         5Gtx5y3oxgRk8+z5F0Wr8lsruamq+33WtTnQQWij69UITlg1Yp7OemvbS+TvQW9asPRq
         +iCA==
X-Gm-Message-State: ACgBeo3bxaeMe1sx8gGEvIAbXKfycYPwWTSX+yoUNsVJUDoXGPk1pnmh
        sdXaGGaMNpqGhG/bc8TKByG7BxVGc4I=
X-Google-Smtp-Source: AA6agR5Ek6qWetd/t9JW5RuhQqKeZ0fY10vs5jOYStMClj2CaUXfGupPsy9jQBRe0azRky8lZSCoDg==
X-Received: by 2002:a05:6870:a78d:b0:11c:437b:ec70 with SMTP id x13-20020a056870a78d00b0011c437bec70mr10029487oao.136.1661851916996;
        Tue, 30 Aug 2022 02:31:56 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id v30-20020a056830091e00b006371af665c5sm7122486ott.56.2022.08.30.02.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:31:56 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/51] completion: fix for suboptions with value
Date:   Tue, 30 Aug 2022 04:30:57 -0500
Message-Id: <20220830093138.1581538-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We need to ignore options that don't start with -- as well.

Depending on the value of COMP_WORDBREAKS, the last word could be
duplicated otherwise.

Can be tested with:

  git merge -X diff-algorithm=<tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 t/t9904-zsh-completion.sh             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 18ad897568..1905ff98b7 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -56,7 +56,7 @@ __gitcomp ()
 	local cur_="${3-$cur}"
 
 	case "$cur_" in
-	--*=)
+	*=)
 		;;
 	--no-*)
 		local c IFS=$' \t\n'
diff --git a/t/t9904-zsh-completion.sh b/t/t9904-zsh-completion.sh
index 656eaf77ab..d3fe42a9b3 100755
--- a/t/t9904-zsh-completion.sh
+++ b/t/t9904-zsh-completion.sh
@@ -157,7 +157,7 @@ test_expect_success '__gitcomp - expand/narrow all negative options' '
 	EOF
 '
 
-test_expect_failure '__gitcomp - equal skip' '
+test_expect_success '__gitcomp - equal skip' '
 	test_gitcomp "--option=" "--option=" <<-\EOF &&
 
 	EOF
@@ -1115,7 +1115,7 @@ test_expect_success 'git clone --config= - value' '
 	EOF
 '
 
-test_expect_failure 'options with value' '
+test_expect_success 'options with value' '
 	test_completion "git merge -X diff-algorithm=" <<-\EOF
 
 	EOF
-- 
2.37.2.351.g9bf691b78c.dirty

