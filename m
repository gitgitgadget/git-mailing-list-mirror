Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9F97203E2
	for <e@80x24.org>; Tue, 26 Jul 2016 04:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbcGZEOX (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 00:14:23 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33730 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823AbcGZEOW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 00:14:22 -0400
Received: by mail-pf0-f193.google.com with SMTP id i6so13085283pfe.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 21:14:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JANRYsOgPlsF2hNahI6lNsfyGLvB6aWKtXKzi4mI3Nw=;
        b=KqsfjPeNXJlGFUjygc3SSqV3oKsPk/mgldjWoemx6AzfJVmi+QUGN3v9kKIiPX3r2M
         0kCqU9WPmZmSjjoNpJl5Iw1TgvBnofbN8bKCpGSXJjqWB8MAAeMOYkSaMJ9bIGdVbEzJ
         7m9ezU39Hx3O1Pfl83JPGwMUciD4UymNIrDosydB2huIKnGQ2ISZcwCevdgdUUefro78
         +BCbGZ4leQOobU5Izo3seo3EBcmta1Fo862zYQYLIkM12C3ynNZCbP2fqn8qTiA+9R89
         z8zrs2SshO9iLnv5VWYp0/hJ1r/fgPmQosUaagwgtfsd1v+n+6p/d8eoLZb7bnX7B0XU
         pzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JANRYsOgPlsF2hNahI6lNsfyGLvB6aWKtXKzi4mI3Nw=;
        b=aRfjQLml3bMwMnk+zIRHLzIC5Ch4TmfWJ6/JCZB5Ziil1wOahhEWxB94j81G4p+WiF
         tFrRDz07a8Zp2upByvOfz7riPDyGoCTkyuUH2qZwpBo5TgDRae7kGZI05XWPjozaYZyz
         dZ2nhszVoTBBtmHwGZEvbMR08klfZNDq8cxQkEFH3hqEGo3ZyHBSmdDbWvOoZFc5Ptax
         ly62p42qxaqgnaji9eEMdvQJqbGlNdyzRabfLA2GMwqjhaaRqUpgOA20HSMkiO5DM3g5
         Ls3FzRajQAq/VagbKxqQ31bsdB0gol/z3h1rTkYfFIEpD/xhH/2wqVkFog16tQwpaxeR
         WrRA==
X-Gm-Message-State: AEkoouvoYpoAKW//IzB+avV0KDhToFUYFO6+sAXo0/jHMRvt+QaXvkqCmD6j+YFyYP/JMA==
X-Received: by 10.98.64.93 with SMTP id n90mr35984392pfa.29.1469506461210;
        Mon, 25 Jul 2016 21:14:21 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id a21sm8759877pfe.81.2016.07.25.21.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Jul 2016 21:14:20 -0700 (PDT)
From:	David Aguilar <davvid@gmail.com>
To:	Git Mailing List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brett Cundal <brett.cundal@iugome.com>,
	"David A . Greene" <greened@obbligato.org>,
	Charles Bailey <cbailey32@bloomberg.net>,
	Techlive Zheng <techlivezheng@gmail.com>
Subject: [PATCH 2/3] subtree: fix "git subtree split --rejoin"
Date:	Mon, 25 Jul 2016 21:14:15 -0700
Message-Id: <20160726041416.9438-2-davvid@gmail.com>
X-Mailer: git-send-email 2.9.2.466.g8c6d1f9.dirty
In-Reply-To: <20160726041416.9438-1-davvid@gmail.com>
References: <20160726041416.9438-1-davvid@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"git merge" in v2.9 prevents merging unrelated histories.

"git subtree split --rejoin" creates unrelated histories when
creating a split repo from a raw sub-directory that did not
originate from an invocation of "git subtree add".

Restore the original behavior by passing --allow-unrelated-histories
when merging subtrees.  This ensures that the synthetic history
created by "git subtree split" can be merged.

Add a test to ensure that this feature works as advertised.

Reported-by: Brett Cundal <brett.cundal@iugome.com>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
This is a "re-implementation" of Brett's original RFC patch.
I preferred adding a new line (rather than modifying the existing line)
so I have no problem signing off on this being a distinct patch
authored by me.

 contrib/subtree/git-subtree.sh     |  1 +
 contrib/subtree/t/t7900-subtree.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7a39b30..b567eae 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -662,6 +662,7 @@ cmd_split()
 		debug "Merging split branch into HEAD..."
 		latest_old=$(cache_get latest_old)
 		git merge -s ours \
+			--allow-unrelated-histories \
 			-m "$(rejoin_msg "$dir" $latest_old $latest_new)" \
 			$latest_new >&2 || exit $?
 	fi
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 431a2fe..e179b29 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -347,6 +347,22 @@ test_expect_success 'split sub dir/ with --rejoin' '
  '
 
 next_test
+test_expect_success 'split sub dir/ with --rejoin from scratch' '
+	subtree_test_create_repo "$subtree_test_count" &&
+	test_create_commit "$subtree_test_count" main1 &&
+	(
+		cd "$subtree_test_count" &&
+		mkdir "sub dir" &&
+		echo file >"sub dir"/file &&
+		git add "sub dir/file" &&
+		git commit -m"sub dir file" &&
+		split_hash=$(git subtree split --prefix="sub dir" --rejoin) &&
+		git subtree split --prefix="sub dir" --rejoin &&
+		check_equal "$(last_commit_message)" "Split '\''sub dir/'\'' into commit '\''$split_hash'\''"
+	)
+ '
+
+next_test
 test_expect_success 'split sub dir/ with --rejoin and --message' '
 	subtree_test_create_repo "$subtree_test_count" &&
 	subtree_test_create_repo "$subtree_test_count/sub proj" &&
-- 
2.9.2.466.g8c6d1f9.dirty

