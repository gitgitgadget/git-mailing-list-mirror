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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE742C4332E
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 779A7207A5
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbhAACRJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbhAACRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:09 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB3FC061757
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:28 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id d8so19294095otq.6
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OHEgwj2FM/LQ3+Dbsj85rHbcY/m3Jx/uS9l1fHep4uQ=;
        b=cwyHougPLbKZt6Dp5O0XEBEVV2PXB4jzKC36JAGiaQ1lDlbEbHL4+Po7r9QsX7ftK7
         28JGC3u37Y7k9PpDUVFXOxa2rfSq7lbHQZAbdFE1zXv1/nIuXiEe5229EJecZZwOPdLc
         LV4yv8JYKiTO+lnBqgtBAIBYJNikV1JCe6pFLyPnNFXdT1n3yrZiioXMLV6w7xXLWSVx
         XEwT2GGS7CpGzs8yjtafYPUq0UvjTneaWeBFqJsD9CdrhM0c4fB52wkrxkBR9EOrg2ed
         +PPxibkPXscgiCy+ez0ePyd7inxsxG0ftt5kSAY2EVIkkuslvLysCxJrZhZyzNhF3Cz9
         4SAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OHEgwj2FM/LQ3+Dbsj85rHbcY/m3Jx/uS9l1fHep4uQ=;
        b=G4s7rQFbdFZYpuyjZFzSymRbwSNuCgrfFa/KP+Ir9szD8QFnK3LljgpequVP3M0quD
         jjFr0wPngAyphFY2tA4xelO5A6DoIhYg+qDq3rfICQOXHSwcmysaC/zS35le9/PMSekZ
         y6H6EFfnR8FLstj81bazNA8PiUK22nhqDs9dDr3x0zitVyxKVCJJ8G2XhLoqrC6acvJf
         5XCGggoaWQm/BVWb0pgIa7L6sRvZ9zfULrKpyLenaPLVXZ0tCYSXVNKfYry3ZNodkycj
         W0PBDjsICAV8C3YUrym1ZaYlwyDT8UCqhMH5I8G7FZAhFqTSY3ofit4JXciyGxO7bNep
         4QlA==
X-Gm-Message-State: AOAM532km/yNmZMcqp8iu5mEw8aBywbPD26KEndECnwVLQ29kvXsDP4q
        giF49Yz6GOfvuOXqahGpHQX8tdV4h8orcA==
X-Google-Smtp-Source: ABdhPJxl9+rHSrJWK5DkXrTdFDHH8Xa5JY9URmIMKv31SMY9I5Fs6hC8bQJE7Fq4EF/84HIwO/JBlQ==
X-Received: by 2002:a9d:6d08:: with SMTP id o8mr43664112otp.334.1609467387997;
        Thu, 31 Dec 2020 18:16:27 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id d10sm7661654ooh.32.2020.12.31.18.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:27 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/47] completion: fix for suboptions with value
Date:   Thu, 31 Dec 2020 20:15:37 -0600
Message-Id: <20210101021622.798041-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
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
 contrib/completion/git-completion.bash |  2 +-
 contrib/completion/git-completion.zsh  |  2 +-
 t/t9902-completion.sh                  | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 10d225cc9c..10e69af9ed 100644
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
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 6c56296997..69f90913db 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -55,7 +55,7 @@ __gitcomp ()
 	local cur_="${3-$cur}"
 
 	case "$cur_" in
-	--*=)
+	*=)
 		;;
 	--no-*)
 		local c IFS=$' \t\n'
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index a1c4f1f6d4..39760293f6 100755
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
@@ -2355,6 +2364,12 @@ test_expect_success 'git clone --config= - value' '
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
2.30.0

