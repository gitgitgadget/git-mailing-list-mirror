Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E4FC25B06
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 20:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbiHDUqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 16:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiHDUqO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 16:46:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463F56D55B
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 13:46:13 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l4so1037698wrm.13
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 13:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=oyrQE6FVXaEt+jquEbYsdAUH9nWe19rHeEkyJVthEdI=;
        b=MrnbeECR48V2FN1h9YlWCFURYpeggLKzS33aivtgw1rBoIg3J5xJB2wb2K9mBKndoK
         NOD+A5K+eZTdC995jbFwAKsC1d4fV17wzXqq9mm3ZfQ4H36eV67pZ+FCmqE7Zn5KgQWN
         uXs3so96AZiwW2ZJfmZI0qrSvUQQNzZrKa+RIH9cz0T+JdQah27EgNsLYKZxuj0MIYYr
         fMrcvwDfn675SUg3rqDiVI2WlYdtJaTmoxRS5hXIYcn2aCH/N64WmQdUHpiBf87XfwCg
         36s42SV8rNHvi7Nxxcf89rTVLnJ2DbAp8AAzkaCSz+6czHcJIw+b1uyCktHl9koT5zg3
         Oz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=oyrQE6FVXaEt+jquEbYsdAUH9nWe19rHeEkyJVthEdI=;
        b=n876VA2dzhl+U+TUROxThyNbiELJVt9pxb+3D2gFNBxobFMmcm66HCHUKunZjugPAp
         kDPtwPaOXBUAloW3clnzTtOqfQRLb3bMuVvs33cWFe6aSRnQInEMR5Xb9TL7Ie+CVGQc
         GXLysAMgUr8BF1SosnJrVsLDyHsiiwv9+zqh1W9KQhYLkPtG/0flzenUvTUZ24xObie5
         BGS/2AoxK2V1m2MHtaibAVHHiFBQBFL2+nejNUeYHxmm4/gKmpt11qDRM4u5Us7bMzZc
         gnwD6xyRzjrJtSh0QkSa7jNTgkhSBnc1pZokZr0n5GIN/owNSjJ13ioAD2nFYHcUox2w
         gCCw==
X-Gm-Message-State: ACgBeo1u5L6WgSrMKpdKTMI8wQvG9e8K9VM4vBU4DqOLDgWJRrefpbd1
        Tf/AtG6cEmkzkQtDURvO6paU2fkHM8Q=
X-Google-Smtp-Source: AA6agR7ye2a72sawIJSTX58U6WaiI4hy5vjXdRLr1OkoM8s4yTdN+arPTFojr7EdotSXrWWbif6cfw==
X-Received: by 2002:a5d:4804:0:b0:21f:bf7:83be with SMTP id l4-20020a5d4804000000b0021f0bf783bemr2482933wrq.94.1659645971307;
        Thu, 04 Aug 2022 13:46:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c4f4600b003a4eea0aa48sm2689516wmq.0.2022.08.04.13.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 13:46:10 -0700 (PDT)
Message-Id: <55c77ba4b291fffe3031fbef67dcee9aa91a105c.1659645967.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
References: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 20:46:05 +0000
Subject: [PATCH 2/4] oneway_diff: handle removed sparse directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, shaoxuan.yuan02@gmail.com,
        newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update 'do_oneway_diff()' to perform a 'diff_tree_oid()' on removed sparse
directories, as it does for added or modified sparse directories (see
9eb00af562 (diff-lib: handle index diffs with sparse dirs, 2021-07-14)).

At the moment, this update is unreachable code because 'unpack_trees()'
(currently the only way 'oneway_diff()' can be called, via 'diff_cache()')
will always traverse trees down to the individual removed files of a deleted
sparse directory. A subsequent patch will change this to better preserve a
sparse index in other uses of 'unpack_tree()', e.g. 'git reset --hard'.
However, making that change without this patch would result in (among other
issues) 'git status' printing only the name of a deleted sparse directory,
not its contents. To avoid introducing that bug, 'do_oneway_diff()' is
updated before modifying 'unpack_trees()'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 diff-lib.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index 7eb66a417aa..2edea41a234 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -466,6 +466,11 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	 * Something removed from the tree?
 	 */
 	if (!idx) {
+		if (S_ISSPARSEDIR(tree->ce_mode)) {
+			diff_tree_oid(&tree->oid, NULL, tree->name, &revs->diffopt);
+			return;
+		}
+
 		diff_index_show_file(revs, "-", tree, &tree->oid, 1,
 				     tree->ce_mode, 0);
 		return;
-- 
gitgitgadget

