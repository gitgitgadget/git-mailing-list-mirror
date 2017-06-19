Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70C4F1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 17:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751088AbdFSR5a (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 13:57:30 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:53322 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbdFSR53 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 13:57:29 -0400
Received: from lindisfarne.localdomain ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id N0uGdKeNKHGLwN0vYdVsJm; Mon, 19 Jun 2017 18:57:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1497895049; bh=IlbyRK8aKG4KPsHLvD20drKFC5gJDBSVlClV23XQ1Yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=KN2IJBkImVBcE/ov8HU1dHcCS03B5KnPa/VR5IRWmohPYKrmnQs5nSNx3GPZc4Mo2
         XkpkbqQpEoVrZpnpbc5NOun5QM9dQnuIbZtk+Rsz/vhsLtrEPmNu5sHSGjJcGXT+5K
         NyucMf4o7Um7AjJ5hLQ0kldnOzKGfS23KV1GHtnU=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=evINK-nbAAAA:8 a=7gz-IJMLiO6ZI-wDAvAA:9
 a=9A_41kZySjNGcpa8:21 a=mGc0pmItOCr-rUzD:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 2/4] rebase -i: Add test for reflog message
Date:   Mon, 19 Jun 2017 18:56:03 +0100
Message-Id: <20170619175605.27864-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170619175605.27864-1-phillip.wood@talktalk.net>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170619175605.27864-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfIZ7bP3ulpa0SAUwbiyMLJptZbKXJkWPO2mdkmlwOEAC+f/lytTzcfwBOCuYGtqYhB1kw+y63HmOpCX4urO8vzRCul2uMPLTIDvTjKeVU6npufKZyUjy
 dDQeANFKcKSZcvKUQ8yE02z2NFoL1AsfQzANxg0Q6u3cDjdpp+KLDDBFUNt/OyLrywPrc5IwdKtG0WyIN29jyK9kR2cgzUJmxRJG7w/VlU5IeQQv7e/6TAGe
 41/uIHXqt9zUtE2p02GOLQ84EUObkIlQ8Do13xAvN04Xvh1HzvdPY6TUL1kF+fkNITSkJ6CKpK60u0sqSKKOPA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Check that the reflog message written to the branch reflog when the
rebase is completed is correct

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3404-rebase-interactive.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 5bd0275930b715c25507fc9744c8946e7f73900b..37821d245433f757fa13f0a3e27da0312bebb7db 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -169,6 +169,13 @@ test_expect_success 'reflog for the branch shows state before rebase' '
 	test $(git rev-parse branch1@{1}) = $(git rev-parse original-branch1)
 '
 
+test_expect_success 'reflog for the branch shows correct finish message' '
+	printf "rebase -i (finish): refs/heads/branch1 onto %s\n" \
+		"$(git rev-parse branch2)" >expected &&
+	git log -g --pretty=%gs -1 refs/heads/branch1 >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'exchange two commits' '
 	set_fake_editor &&
 	FAKE_LINES="2 1" git rebase -i HEAD~2 &&
-- 
2.13.0

