Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76C5C2D0D3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 11:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DCA21D7D
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 11:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLULjV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 06:39:21 -0500
Received: from mail-gateway-shared12.cyon.net ([194.126.200.65]:51666 "EHLO
        mail-gateway-shared12.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbfLULjV (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 06:39:21 -0500
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared12.cyon.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <bb@drbeat.li>)
        id 1iid6L-00046Y-Vt
        for git@vger.kernel.org; Sat, 21 Dec 2019 12:39:19 +0100
Received: from [10.20.10.230] (port=64542 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.92)
        (envelope-from <bb@drbeat.li>)
        id 1iid6K-006Ksy-PQ; Sat, 21 Dec 2019 12:39:16 +0100
Received: by drbeat.li (Postfix, from userid 1000)
        id 93992180093; Sat, 21 Dec 2019 12:39:16 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 2/2] contrib/git-jump: add mode commit
Date:   Sat, 21 Dec 2019 12:38:46 +0100
Message-Id: <20191221113846.169538-2-dev+git@drbeat.li>
X-Mailer: git-send-email 2.24.1.592.g326176f9f0
In-Reply-To: <20191221113846.169538-1-dev+git@drbeat.li>
References: <20191221113846.169538-1-dev+git@drbeat.li>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-OutGoing-Spam-Status: No, score=-1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After committing, I often want to return to the place of the latest
change to continue my work. Add the new mode "commit" which does exactly
this.

Optional arguments are given to the "git show" call. So it's possible to
jump to changes of other commits than HEAD.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 contrib/git-jump/git-jump | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 776fa90f7f..e7192073c6 100644
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -9,6 +9,9 @@ The <mode> parameter is one of:
 
 diff: elements are diff hunks. Arguments are given to diff.
 
+commit: element are the hunks of a commit (default HEAD). Arguments are
+        given to git show.
+
 merge: elements are merge conflicts. Arguments are ignored.
 
 grep: elements are grep hits. Arguments are given to git grep or, if
@@ -27,6 +30,10 @@ mode_diff() {
 	git diff --no-prefix --relative "$@" | diff_to_quickfix
 }
 
+mode_commit() {
+	git show --no-prefix --relative "$@" | diff_to_quickfix
+}
+
 diff_to_quickfix() {
 	perl -ne '
 	if (m{^\+\+\+ (.*)}) { $file = $1; next }
-- 
2.21.0.1020.gf2820cf01a

