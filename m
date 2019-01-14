Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B3A7211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 17:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfANReV (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 12:34:21 -0500
Received: from [192.252.130.194] ([192.252.130.194]:46088 "EHLO
        cubert.xiplink.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726646AbfANReV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 12:34:21 -0500
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jan 2019 12:34:20 EST
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
        by cubert.xiplink.com (Postfix) with ESMTP id C8135A1E8D;
        Mon, 14 Jan 2019 12:27:02 -0500 (EST)
From:   Marc Branchaud <marcnarc@xiplink.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: [PATCH] new-workdir: Never try to recurse into submodules on the initial checkout.
Date:   Mon, 14 Jan 2019 12:27:02 -0500
Message-Id: <20190114172702.19959-1-marcnarc@xiplink.com>
X-Mailer: git-send-email 2.20.1.1.gfb6d716d28
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new workdir is empty before the checkout, so attempts to recurse into
a non-existent submodule directory fail.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

Until the worktree command supports submodules I've gone back to using the
git-new-workdir script, but it fails if my config has
submdodule.recurse=true.

With this patch, the checkout succeeds and the workdir has empty submodules,
which is the script's normal behaviour.

		M.

 contrib/workdir/git-new-workdir | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 888c34a521..5de1dc3c58 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -102,4 +102,4 @@ trap - $siglist
 
 # checkout the branch (either the same as HEAD from the original repository,
 # or the one that was asked for)
-git checkout -f $branch
+git -c submodule.recurse=false checkout -f $branch
-- 
2.20.1.1.gfb6d716d28

