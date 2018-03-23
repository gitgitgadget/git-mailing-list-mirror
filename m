Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02F021F404
	for <e@80x24.org>; Fri, 23 Mar 2018 02:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbeCWCJr (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 22:09:47 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45165 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751776AbeCWCJq (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Mar 2018 22:09:46 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E1F020D3F;
        Thu, 22 Mar 2018 22:09:46 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 22 Mar 2018 22:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        aaronjgreenberg.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=cHspy5Olkxm/S0BSCoMNfKwpn9Keqr/bfK9DdiVFyhY=; b=JDLDNUdD
        O4XquPxDAR4hHEeD5GnV7+NB5oo9JieCdbzJk1TJFklnSjJqlsb4cZbMaOrz3eis
        2+L/fUuNfHDqWZXC3xAJQowWIZ+4icg66ulbURHg1zL9isWmvhu558yallaUha6K
        A1COTxUfLe3OF4wa8U4tyNCHdjdlNDcrlhVuXfw1SA4QZIi5aJDrBKLlTN5oOGkd
        333biKtI/pC+4GTPEDV3w/rvFUydN8ieNXpr7P1irua1UTlc24Yv1h2HXrW9pzn3
        1oLzzgkPDlbp8kXP9aECbPLki6X5GOd1XAWMJPxgX1ivTvl4Z5QykKjzqmCqkERx
        zWrK1fE5RFC2nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=cHspy5Olkxm/S0BSCoMNfKwpn9Keqr/bfK9DdiVFyhY=; b=LRZ1/XE7
        4GuE7A7qxx2B+Tt4lF6xeyUcjzI/PaUaPbHBcQW7kTkmkbRm0AghV3Fo1GoajQhJ
        E4lAzcOjVBBJIxQpt5TFPw31ObzqE+okQE4zdBT69INCD7s38CMeh92lafPuKwiT
        wMAI7oM7tWLsBspMH584k1f/4778RGHN/ziYFw8TFhDSzuxC4XyfVWrWsxjp+bjU
        tjLtmor0sd0j2Iw/Lo5E/io9lEDgPUp/G5kVZfGBhyFtVffPgPcxNtyy8wl6SVLc
        WavXIagr3Sh9FsK0kNp+hCrTtyh+oDEpEPvM2NRua3krZeNOHRBK45jMPnLV05MD
        lDb0+pG5Ass67w==
X-ME-Sender: <xms:6mG0WtuNm6rCqz3PErVHYZUdBiPFfQSElVrprguby3vhQXOIeDo98Q>
Received: from localhost.localdomain (unknown [159.203.64.218])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0D735241E1;
        Thu, 22 Mar 2018 22:09:46 -0400 (EDT)
From:   Aaron Greenberg <p@aaronjgreenberg.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, p@aaronjgreenberg.com
Subject: [PATCH] branch: implement shortcut to delete last branch
Date:   Fri, 23 Mar 2018 02:09:26 +0000
Message-Id: <1521770966-18383-2-git-send-email-p@aaronjgreenberg.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521770966-18383-1-git-send-email-p@aaronjgreenberg.com>
References: <1521770966-18383-1-git-send-email-p@aaronjgreenberg.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for using the "-" shortcut to delete the last checked-out
branch. This functionality already exists for git-merge, git-checkout,
and git-revert.

Signed-off-by: Aaron Greenberg <p@aaronjgreenberg.com>
---
 builtin/branch.c  | 3 +++
 t/t3200-branch.sh | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6d0cea9..9e37078 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -221,6 +221,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		char *target = NULL;
 		int flags = 0;
 
+		if (!strcmp(argv[i], "-"))
+			argv[i] = "@{-1}";
+
 		strbuf_branchname(&bname, argv[i], allowed_interpret);
 		free(name);
 		name = mkpathdup(fmt, bname.buf);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 6c0b7ea..a3ffd54 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -776,6 +776,15 @@ test_expect_success 'deleting currently checked out branch fails' '
 	test_must_fail git branch -d my7
 '
 
+test_expect_success 'test deleting last branch' '
+	git checkout -b my7.2 &&
+	git checkout  - &&
+	sha1=$(git rev-parse my7 | cut -c 1-7) &&
+	echo "Deleted branch my7.2 (was $sha1)." >expect &&
+	git branch -d - >actual 2>&1 &&
+	test_i18ncmp expect actual
+'
+
 test_expect_success 'test --track without .fetch entries' '
 	git branch --track my8 &&
 	test "$(git config branch.my8.remote)" &&
-- 
2.7.4

