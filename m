Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAE0E1FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 14:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934987AbcLTOKi (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 09:10:38 -0500
Received: from [192.252.130.194] ([192.252.130.194]:64234 "EHLO
        cubert.xiplink.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S934980AbcLTOKg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 09:10:36 -0500
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
        by cubert.xiplink.com (Postfix) with ESMTP id 65EFC60078;
        Tue, 20 Dec 2016 09:02:26 -0500 (EST)
From:   Marc Branchaud <marcnarc@xiplink.com>
To:     git@vger.kernel.org
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Chris Packham <judge.packham@gmail.com>,
        Alex Riesen <raa.lkml@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCHv2] Tweak help auto-correct phrasing.
Date:   Tue, 20 Dec 2016 09:02:26 -0500
Message-Id: <20161220140226.18456-1-marcnarc@xiplink.com>
X-Mailer: git-send-email 2.11.0.1.g75fa99b
In-Reply-To: <xmqqpoknmv7d.fsf@gitster.mtv.corp.google.com>
References: <xmqqpoknmv7d.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When auto-correct is enabled, an invalid git command prints a warning and
a continuation message, which differs depending on whether or not
help.autoCorrect is positive or negative.

With help.autoCorrect = 15:

   WARNING: You called a Git command named 'lgo', which does not exist.
   Continuing under the assumption that you meant 'log'
   in 1.5 seconds automatically...

With help.autoCorrect < 0:

   WARNING: You called a Git command named 'lgo', which does not exist.
   Continuing under the assumption that you meant 'log'

The continuation message's phrasing is awkward.  This commit cleans it up.
As a bonus, we now use full-sentence strings which make translation easier.

With help.autoCorrect = 15:

   WARNING: You called a Git command named 'lgo', which does not exist.
   Continuing in 1.5 seconds, assuming that you meant 'log'.

With help.autoCorrect < 0:

   WARNING: You called a Git command named 'lgo', which does not exist.
   Continuing under the assumption that you meant 'log'.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

Writing the commit message was more work than the commit!  :)

		M.

 help.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/help.c b/help.c
index 53e2a67e00..fc56aa2d76 100644
--- a/help.c
+++ b/help.c
@@ -381,12 +381,18 @@ const char *help_unknown_cmd(const char *cmd)
 		clean_cmdnames(&main_cmds);
 		fprintf_ln(stderr,
 			   _("WARNING: You called a Git command named '%s', "
-			     "which does not exist.\n"
-			     "Continuing under the assumption that you meant '%s'"),
-			cmd, assumed);
-		if (autocorrect > 0) {
-			fprintf_ln(stderr, _("in %0.1f seconds automatically..."),
-				(float)autocorrect/10.0);
+			     "which does not exist."),
+			   cmd);
+		if (autocorrect < 0)
+			fprintf_ln(stderr,
+				   _("Continuing under the assumption that "
+				     "you meant '%s'."),
+				   assumed);
+		else {
+			fprintf_ln(stderr,
+				   _("Continuing in %0.1f seconds, "
+				     "assuming that you meant '%s'."),
+				   (float)autocorrect/10.0, assumed);
 			sleep_millisec(autocorrect * 100);
 		}
 		return assumed;
-- 
2.11.0.1.g75fa99b

