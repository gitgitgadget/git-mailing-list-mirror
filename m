Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 009F61FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 13:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbdDRNcK (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 09:32:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33627 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750893AbdDRNcI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 09:32:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id o81so14733877wmb.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 06:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=78RzLvqAwV8+NX58B75whLY3iKAU9TZfGd/PpUXNyBM=;
        b=T+cnDl2icdEuovi2joNnc3iO85g+lsSV7cdF96ppu3A45oUx9zP3XlZy41hclnrlmD
         Q9yJHJtXkvoDEFFS63zkzc+JdGTKLzCYb2mQTnjioOakE6mcIqV45yXnPZgIkBhZfzeF
         VOLcFaDK/0ZvnYG3OKqpoB4L7qu/cvZHVQ46tV8S5ZClBtlg8TC9cPTPxCRfyfwvGZ2T
         L1u36amaIboCumfh6z7TDSFE9Zde39fjxbHkiPqPnSzn2pSBzRvhq6P7PSbUB0AnBL/s
         pNNcTByHNxi40m4DPsoe6pKB0+t6OxiJtiimeF5OZcRj5nLEZHM4Q/IU5aXnVUO4ECip
         HxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=78RzLvqAwV8+NX58B75whLY3iKAU9TZfGd/PpUXNyBM=;
        b=mVO8O6f0vfaR3l6pGG+D1+rptKIcwMCuDQ4no/MpirDsXdKn83SzuNZFrxaH623lTT
         kjNkz08mbOhkOTBJviKXyLUrdTo5zP8+aFCqPD3/khXaAdvJAcbZK6oIvdN7PrHdlLBB
         VynOuj/cdpv+P6PPg0LyqwA6FJHU5tdizERJ7+eV6SzdahPx1ct54E4bKmW3vXMN3Y7a
         h9OwD91u6yWfyLBKzGE5PtWiqbMsWPEYemSIb3Cou0Ljof9LtRVDbuCpuxAXWQH9/YYL
         xaCaEt21Vx+r0Xs27/UGOcYYB4+6svoOdMBnZLLGO3+HLgyBLnwdpyr4G46IqfK/1qY4
         1ylw==
X-Gm-Message-State: AN3rC/6U8YgOxqx7FxTdKduDYDHEkvuWl1eh9cTa4ZcUWyMfLTwbSbYx
        cBUZeEfh9Gmkbw==
X-Received: by 10.28.95.67 with SMTP id t64mr13881293wmb.140.1492522321958;
        Tue, 18 Apr 2017 06:32:01 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k26sm18729790wre.9.2017.04.18.06.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Apr 2017 06:32:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jay Soffian <jaysoffian@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] completion: expand "push --delete <remote> <ref>" for refs on that <remote>
Date:   Tue, 18 Apr 2017 13:31:52 +0000
Message-Id: <20170418133152.3262-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the completion of "push --delete <remote> <ref>" to complete
refs on that <remote>, not all refs. Before this e.g. cloning git.git
and doing "git push --delete origin p<TAB>" will complete nothing,
whereas origin/p<TAB> will uselessly complete origin/pu.

Now p<TAB> will complete as "pu". The completion of giving --delete
later, e.g. "git push origin --delete p<TAB>" remains unchanged, this
is a bug, but is a general existing limitation of the bash completion,
and not how git-push is documented, so I'm not fixing that case.

I looked over t9902-completion.sh but couldn't quickly find out how to
add a test for this, but all the existing tests pass, and all my
manual testing of "git push --delete <remote> ..." does the right
thing now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/completion/git-completion.bash | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1150164d5c..2e5b3ed776 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -701,7 +701,7 @@ __git_complete_revlist ()
 __git_complete_remote_or_refspec ()
 {
 	local cur_="$cur" cmd="${words[1]}"
-	local i c=2 remote="" pfx="" lhs=1 no_complete_refspec=0
+	local i c=2 remote="" pfx="" lhs=1 no_complete_refspec=0 delete=0
 	if [ "$cmd" = "remote" ]; then
 		((c++))
 	fi
@@ -709,6 +709,7 @@ __git_complete_remote_or_refspec ()
 		i="${words[c]}"
 		case "$i" in
 		--mirror) [ "$cmd" = "push" ] && no_complete_refspec=1 ;;
+		--delete) delete=1 ;;
 		--all)
 			case "$cmd" in
 			push) no_complete_refspec=1 ;;
@@ -761,7 +762,9 @@ __git_complete_remote_or_refspec ()
 		fi
 		;;
 	push)
-		if [ $lhs = 1 ]; then
+		if [ $delete = 1 ]; then
+			__git_complete_refs --remote="$remote" --pfx="$pfx" --cur="$cur_"
+		elif [ $lhs = 1 ]; then
 			__git_complete_refs --pfx="$pfx" --cur="$cur_"
 		else
 			__git_complete_refs --remote="$remote" --pfx="$pfx" --cur="$cur_"
-- 
2.11.0

