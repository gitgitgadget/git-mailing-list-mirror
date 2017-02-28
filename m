Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 391402022D
	for <e@80x24.org>; Tue, 28 Feb 2017 08:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbdB1I7N (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 03:59:13 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:40083 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751741AbdB1I7L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 03:59:11 -0500
Received: from localhost (x55b3852d.dyn.telefonica.de [85.179.133.45])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id 7B0AD178898;
        Tue, 28 Feb 2017 09:59:09 +0100 (CET)
From:   Patrick Steinhardt <patrick.steinhardt@elego.de>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <patrick.steinhardt@elego.de>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/2] docs/diffcore: unquote "Complete Rewrites" in headers
Date:   Tue, 28 Feb 2017 09:59:05 +0100
Message-Id: <576fa5be072ebd503aa553ef24290c77ed34eeb1.1488272203.git.patrick.steinhardt@elego.de>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <2882e77a58e4219d60a39827c3ea8d4537d5178a.1488272203.git.patrick.steinhardt@elego.de>
References: <2882e77a58e4219d60a39827c3ea8d4537d5178a.1488272203.git.patrick.steinhardt@elego.de>
In-Reply-To: <2882e77a58e4219d60a39827c3ea8d4537d5178a.1488272203.git.patrick.steinhardt@elego.de>
References: <2882e77a58e4219d60a39827c3ea8d4537d5178a.1488272203.git.patrick.steinhardt@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The gitdiffcore documentation quotes the term "Complete Rewrites" in
headers for no real gain. This would make sense if the term could be
easily confused if not properly grouped together. But actually, the term
is quite obvious and thus does not really need any quoting, especially
regarding that it is not used anywhere else.

But more importanly, this brings up a bug when rendering man pages: when
trying to render quotes inside of a section header, we end up with
quotes which have been misaligned to the end of line. E.g.

    diffcore-break: For Splitting Up Complete Rewrites
    --------------------------------------------------

renders as

    DIFFCORE-BREAK: FOR SPLITTING UP  COMPLETE REWRITES""

, which is obviously wrong. While this is fixable for the man pages by
using double-quotes (e.g. ""COMPLETE REWRITES""), this again breaks it
for our generated HTML pages.

So fix the issue by simply dropping quotes inside of section headers,
which is currently only done for the term "Complete Rewrites".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

The obvious other route here would be to fix how the stylesheets
handle quoting inside of these headers. But after taking a short
look, I didn't really get how our stylesheets actually stitch
together and as such bailed from doing so.

 Documentation/gitdiffcore.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index cf009a187..c0a60f315 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -84,8 +84,8 @@ format sections of the manual for 'git diff-{asterisk}' commands) or
 diff-patch format.
 
 
-diffcore-break: For Splitting Up "Complete Rewrites"
-----------------------------------------------------
+diffcore-break: For Splitting Up Complete Rewrites
+--------------------------------------------------
 
 The second transformation in the chain is diffcore-break, and is
 controlled by the -B option to the 'git diff-{asterisk}' commands.  This is
@@ -177,8 +177,8 @@ the expense of making it slower.  Without `--find-copies-harder`,
 copied happened to have been modified in the same changeset.
 
 
-diffcore-merge-broken: For Putting "Complete Rewrites" Back Together
---------------------------------------------------------------------
+diffcore-merge-broken: For Putting Complete Rewrites Back Together
+------------------------------------------------------------------
 
 This transformation is used to merge filepairs broken by
 diffcore-break, and not transformed into rename/copy by
-- 
2.12.0

