Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB8C520958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965067AbdCWP3o (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:29:44 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36475 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964964AbdCWP3m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:29:42 -0400
Received: by mail-wr0-f196.google.com with SMTP id l37so31602578wrc.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BYQOiLupNdgAI2RYhWybgugQwhACKQgVyAp+PXIw3ks=;
        b=rvQAMuDoWdfI9GdSzc0K62S5HN09H+4fruVeBsEv+wAYAR6h6r8xjY9oXlEpl3IQ8R
         i3w+d2r9MX4x37spASjVikf01Tq9Tssa18FLCaMiofb619VYQAU0/Kwc8a2++0zfAumH
         7tUiqRnKdb9gREXRTu3ypYzPnYL1gwGNfZL3Nq/M5GIcm699zbt87AI/o6MbCUI9DFYP
         Zjk5xnluBN6BXgBLDktykgNsCKiJEVyDpENzk1ZqKtD7QWh872HAxJMgiHOiE4HYHLoN
         VzMpTp/eJzAZKyX1EJY6JY9L94fc2l7+S3WX/VrStfTDKLW3Tlp+9LvWvPst5lGJY3me
         32Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BYQOiLupNdgAI2RYhWybgugQwhACKQgVyAp+PXIw3ks=;
        b=mOKz2pV3llM0NApZzPbHxY5PHvJt7SI48gQ3D3VmF30g9B4N5kHODFkEa+kGRC/m4e
         N02Fu2CBlofwdZTWW/ErEZ31t3HMNR5FRaQIW688JwmT63AY7HBH/4img3c0H9VciXUG
         S05QxlGLh4h8wa8S9u5pnVxDhOB2krj+b+zayorz1+t9UqdRqSH3E2Unlc+k1qG63PDz
         x5o5qxoaRWQ1fWu14mxZ/WyH+j4MOkpwpmZG5GgYohiSB/TYLcA7mFIbWDZ6lQ3V6uJB
         muWgUwSrts0tyvJYAv/Ainfb2OlSWpJUvoaOHRoSaejSsba7V59SxZG9sRv/yoXKKDh8
         ueCw==
X-Gm-Message-State: AFeK/H1wmjkK6lqSNZllBHN2S1Rk7JbNBHmFN+WRLq2xKhtSizx5N65PDIMG+XBwWFn+Aw==
X-Received: by 10.223.135.163 with SMTP id b32mr3206016wrb.170.1490282980421;
        Thu, 23 Mar 2017 08:29:40 -0700 (PDT)
Received: from localhost.localdomain (x4db02660.dyn.telefonica.de. [77.176.38.96])
        by smtp.gmail.com with ESMTPSA id q135sm455057wmd.8.2017.03.23.08.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 08:29:40 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 05/14] completion: support excluding full refs
Date:   Thu, 23 Mar 2017 16:29:15 +0100
Message-Id: <20170323152924.23944-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.1.485.g1616aa492
In-Reply-To: <20170323152924.23944-1-szeder.dev@gmail.com>
References: <20170323152924.23944-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 49416ad22 (completion: support excluding refs, 2016-08-24) made
possible to complete short refs with a '^' prefix.

Extend the support to full refs to make completing '^refs/...' work.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash |  8 ++++----
 t/t9902-completion.sh                  | 31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 067dff823..882635f97 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -387,6 +387,10 @@ __git_refs ()
 	fi
 
 	if [ "$list_refs_from" = path ]; then
+		if [[ "$cur_" == ^* ]]; then
+			pfx="^"
+			cur_=${cur_#^}
+		fi
 		case "$cur_" in
 		refs|refs/*)
 			format="refname"
@@ -394,10 +398,6 @@ __git_refs ()
 			track=""
 			;;
 		*)
-			if [[ "$cur_" == ^* ]]; then
-				pfx="^"
-				cur_=${cur_#^}
-			fi
 			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD; do
 				if [ -e "$dir/$i" ]; then echo $pfx$i; fi
 			done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f641d99ec..e2b45f625 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -806,6 +806,37 @@ test_expect_success '__git_refs - after --opt= - full refs' '
 	test_cmp expected "$actual"
 '
 
+test_expect_success '__git refs - exluding refs' '
+	cat >expected <<-EOF &&
+	^HEAD
+	^master
+	^matching-branch
+	^other/branch-in-other
+	^other/master-in-other
+	^matching-tag
+	EOF
+	(
+		cur=^ &&
+		__git_refs >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git refs - exluding full refs' '
+	cat >expected <<-EOF &&
+	^refs/heads/master
+	^refs/heads/matching-branch
+	^refs/remotes/other/branch-in-other
+	^refs/remotes/other/master-in-other
+	^refs/tags/matching-tag
+	EOF
+	(
+		cur=^refs/ &&
+		__git_refs >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_expect_success '__git_complete_refs - simple' '
 	sed -e "s/Z$//" >expected <<-EOF &&
 	HEAD Z
-- 
2.12.1.485.g1616aa492

