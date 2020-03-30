Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5BAC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 12:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB9820675
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 12:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSpG9PBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgC3Mnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:43:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37217 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbgC3Mnq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 08:43:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id j19so2924572wmi.2
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 05:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GxEBw2WvVWRUdkrlXW6ClwwoJwK79xs2b8FVCn2oLzk=;
        b=pSpG9PBykdglJWGmx1JNDlvz2rMxKhNmjBCPDc9Tv0Ynvxk1WhP+4uPQccjv0AJyvV
         eBjYpKKpC6J/05nukilXQusuXz/Wqun4OSXVWplfiuTU9SZm9AdkKnhS2Hfzi4tdn2Kx
         aDa1L4Lz7dFe8PYJF/YHcrHkt7V+aMyMfLvXXyI1ntpjia3piQEGNRDJStxE02mXOQ3v
         GFAKJk3Cts8Jj6jfTZd18YXVAGvCm6klPcf4YGYNYoDl44bCLRCFasr9sfuwN8v3zScI
         hzoF3mXUkxzgq39nps4827955G6IgsuHzBn6yWJf9dNmbEOosJLbCJEVgPhQnLdIEm7j
         ixWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GxEBw2WvVWRUdkrlXW6ClwwoJwK79xs2b8FVCn2oLzk=;
        b=eU5iHTqNeM/GVSu6diY53MsCXOQvhRrMM4ja2WhMDi788+wljUeLAz+/ndImxCgpAI
         mDZ+M/ZPhU0yxkI73GKOuxhJzN6X//VDqeTWaNkj75yX7u88mpboX3O8ckFOhDvKP7N4
         Nl9k9culHGRBqZ+kQFLGwddEkxi4lXxHERv2T7rkmFRrbTIiBb8tAS1dLZmqVV6annmW
         B7bOSmCYme+tkoISHqVHu7j+WYiyQ5JYYY6h1gfeW4YTHanPQvyT6OvPJ09jRvM8OVTF
         BZNCCAPjUXMY5lRLUhhrVgJqa/738dgN1L5ySYXdW+r55XsPLKZX3BOsAPAiJZ9Dvhfk
         +ZnQ==
X-Gm-Message-State: ANhLgQ1R14wIbxQYWx7m6XY3FWOTkeKV6uXQJ36H72ZhTsY3i/6t400T
        YS10fpChDx6Vd8zlrEOpgLbsT9ru
X-Google-Smtp-Source: ADFU+vsd/v/z1GZlxpj/6LnJOqOhyjcc0g7filAA2pszW2jsAUU5Dla3XyHp38qvmbtovmPnX33cYg==
X-Received: by 2002:a05:600c:4410:: with SMTP id u16mr12842793wmn.161.1585572222373;
        Mon, 30 Mar 2020 05:43:42 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-654-1-428-45.w2-6.abo.wanadoo.fr. [2.6.211.45])
        by smtp.googlemail.com with ESMTPSA id 9sm20228480wmm.6.2020.03.30.05.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2020 05:43:41 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>, jan.steffens@gmail.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v1 2/2] t3432: test `--merge' with `rebase.abbreviateCommands = true', too
Date:   Mon, 30 Mar 2020 14:42:36 +0200
Message-Id: <20200330124236.6716-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200330124236.6716-1-alban.gruin@gmail.com>
References: <9b4bc756764d87c9f34c11e6ec2fc6482f531805.camel@gmail.com>
 <20200330124236.6716-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fast forwarding, `git --merge' should act the same whether
`rebase.abbreviateCommands' is set or not, but so far it was not the
case.  This duplicates the tests ensuring that `--merge' works when fast
forwarding to check if it also works with abbreviated commands.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 t/t3432-rebase-fast-forward.sh | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 6c9d4a1375..6f0452c0ea 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -28,10 +28,12 @@ test_rebase_same_head () {
 	shift &&
 	cmp_f="$1" &&
 	shift &&
-	test_rebase_same_head_ $status_n $what_n $cmp_n " --apply" "$*" &&
-	test_rebase_same_head_ $status_f $what_f $cmp_f " --apply --no-ff" "$*"
-	test_rebase_same_head_ $status_n $what_n $cmp_n " --merge" "$*" &&
-	test_rebase_same_head_ $status_f $what_f $cmp_f " --merge --no-ff" "$*"
+	test_rebase_same_head_ $status_n $what_n $cmp_n 0 " --apply" "$*" &&
+	test_rebase_same_head_ $status_f $what_f $cmp_f 0 " --apply --no-ff" "$*"
+	test_rebase_same_head_ $status_n $what_n $cmp_n 0 " --merge" "$*" &&
+	test_rebase_same_head_ $status_f $what_f $cmp_f 0 " --merge --no-ff" "$*"
+	test_rebase_same_head_ $status_n $what_n $cmp_n 1 " --merge" "$*" &&
+	test_rebase_same_head_ $status_f $what_f $cmp_f 1 " --merge --no-ff" "$*"
 }
 
 test_rebase_same_head_ () {
@@ -41,9 +43,21 @@ test_rebase_same_head_ () {
 	shift &&
 	cmp="$1" &&
 	shift &&
+	abbreviate="$1" &&
+	shift &&
 	flag="$1"
 	shift &&
-	test_expect_$status "git rebase$flag $* with $changes is $what with $cmp HEAD" "
+	if test $abbreviate -eq 1
+	then
+		msg="git rebase$flag $* (rebase.abbreviateCommands = true) with $changes is $what with $cmp HEAD"
+	else
+		msg="git rebase$flag $* with $changes is $what with $cmp HEAD"
+	fi &&
+	test_expect_$status "$msg" "
+		if test $abbreviate -eq 1
+		then
+			test_config rebase.abbreviateCommands true
+		fi &&
 		oldhead=\$(git rev-parse HEAD) &&
 		test_when_finished 'git reset --hard \$oldhead' &&
 		cp .git/logs/HEAD expect &&
-- 
2.25.0

