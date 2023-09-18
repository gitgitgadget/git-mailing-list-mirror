Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4C5CD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 20:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjIRUF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 16:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIRUF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 16:05:26 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DA48F
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 13:05:19 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40473f1fe9fso50249005e9.2
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 13:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695067518; x=1695672318; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yYIRz4t+CxsmhAelKTXyhe0XN3Lm5zbzeQsi2xmhc0w=;
        b=MvehxHWu052/ATTYBIha1RgRFn66Kk+3HgkQoIa5JkT5TPO3YQYWN4+3nQ0EDOCT8E
         FGqUbyqYx5iUxKc3jdXxgYbk/dkj1LLfZu4S0kJWmW4G+xu8Xp20ChpjWzYJGpYbdrUv
         6Ho5lwgC7xVKxGLHKB1Nmyw4CFrWfITSlVEx2utA1n3PUFFT7nRXOx0j45+C2E3drBOy
         XRSqlw2TLoKHq7TSszF2pPT4tf5heWfnT+1CeD4WWsS54VDHVGjimf8sY0p5QCpQxx61
         3BetXltUIHN9dwhaoy7bXvgu88sDNG/vSrvtsaw0zJiiMQIwT5ciKhHuji0AjTJGZ82y
         MvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695067518; x=1695672318;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYIRz4t+CxsmhAelKTXyhe0XN3Lm5zbzeQsi2xmhc0w=;
        b=QxBeiCyLh7+QRt4EeS9hFpK07+gCXpbWr+89r+r7DtPj2AQHtfASZaTLeBDXIVqsgF
         eALVKSm0HQ/GBDUda4/rTjpZKL0kSM5shStIaGRGjXyXyOlLt4TlBKPzEgmyFagKrJ3j
         +5CPrB0lUKo7StBA/1vnLswZ1ZP4wzWpvsylWWptdYdTSUUeockebNm4BkXOz/dsha0M
         DnzdxTckYYDFysIRVBJR3D+jeUH+oPPHliCVyURbj7kMIQKeUZQ+plLHYO1JJw2FflOC
         jOcZPy/5Xqd12mTZYMReeuZCIukXXGtOn3EGwhW07qkYccKoMLgJDTl8n26wL6RXUsuw
         u8RA==
X-Gm-Message-State: AOJu0Yzi75Lj8JHtls2GRRB3ZoNrpxVi21+LR95r/pfFi8znWxGONcrN
        WCa3I9NrbCJbTRnkJ1pWhkF645kIJxw=
X-Google-Smtp-Source: AGHT+IEuuubCjOXBtUK5fDYEuXeN9fnmZiIT3Z8OM85znsU0OSQ6ciUeCEewvTZYa+nLENRX2mpYUA==
X-Received: by 2002:a7b:c7cb:0:b0:403:b6bc:dc83 with SMTP id z11-20020a7bc7cb000000b00403b6bcdc83mr8882492wmk.38.1695067517534;
        Mon, 18 Sep 2023 13:05:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d20-20020a1c7314000000b003feef82bbefsm13203772wmb.29.2023.09.18.13.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 13:05:16 -0700 (PDT)
Message-ID: <pull.1587.git.1695067516192.gitgitgadget@gmail.com>
From:   "Zach FettersMoore via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Sep 2023 20:05:16 +0000
Subject: [PATCH] subtree: fix split processing with multiple subtrees present
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Zach FettersMoore <zach.fetters@apollographql.com>,
        Zach FettersMoore <zach.fetters@apollographql.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Zach FettersMoore <zach.fetters@apollographql.com>

When there are multiple subtrees present in a repository and they are
all using 'git subtree split', the 'split' command can take a
significant (and constantly growing) amount of time to run even when
using the '--rejoin' flag. This is due to the fact that when processing
commits to determine the last known split to start from when looking
for changes, if there has been a split/merge done from another subtree
there will be 2 split commits, one mainline and one subtree, for the
second subtree that are part of the processing. The non-mainline
subtree split commit will cause the processing to always need to search
the entire history of the given subtree as part of its processing even
though those commits are totally irrelevant to the current subtree
split being run.

In the diagram below, 'M' represents the mainline repo branch, 'A'
represents one subtree, and 'B' represents another. M3 and B1 represent
a split commit for subtree B that was created from commit M4. M2 and A1
represent a split commit made from subtree A that was also created
based on changes back to and including M4. M1 represents new changes to
the repo, in this scenario if you try to run a 'git subtree split
--rejoin' for subtree B, commits M1, M2, and A1, will be included in
the processing of changes for the new split commit since the last
split/rejoin for subtree B was at M3. The issue is that by having A1
included in this processing the command ends up needing to processing
every commit down tree A even though none of that is needed or relevant
to the current command and result.

M1
 |	  \	  \
M2	   |	   |
 |     	  A1	   |
M3	   |	   |
 |	   |	  B1
M4	   |	   |

So this commit makes a change to the processing of commits for the split
command in order to ignore non-mainline commits from other subtrees such
as A1 in the diagram by adding a new function
'should_ignore_subtree_commit' which is called during
'process_split_commit'. This allows the split/rejoin processing to still
function as expected but removes all of the unnecessary processing that
takes place currently which greatly inflates the processing time.

Signed-off-by: Zach FettersMoore <zach.fetters@apollographql.com>
---
    subtree: fix split processing with multiple subtrees present
    
    When there are multiple subtrees in a repo and git subtree split
    --rejoin is being used for the subtrees, the processing of commits for a
    new split can take a significant (and constantly growing) amount of time
    because the split commits from other subtrees cause the processing to
    have to scan the entire history of the other subtree(s). This patch
    filters out the other subtree split commits that are unnecessary for the
    split commit processing.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1587%2FBobaFetters%2Fzf%2Fmulti-subtree-processing-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1587/BobaFetters/zf/multi-subtree-processing-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1587

 contrib/subtree/git-subtree.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index e0c5d3b0de6..e9250dfb019 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -778,12 +778,29 @@ ensure_valid_ref_format () {
 		die "fatal: '$1' does not look like a ref"
 }
 
+# Usage: check if a commit from another subtree should be ignored from processing for splits
+should_ignore_subtree_commit () {
+  if [ "$(git log -1 --grep="git-subtree-dir:" $1)" ]
+  then
+    if [[ -z "$(git log -1 --grep="git-subtree-mainline:" $1)" && -z "$(git log -1 --grep="git-subtree-dir: $dir$" $1)" ]]
+    then
+      return 0
+    fi
+  fi
+  return 1
+}
+
 # Usage: process_split_commit REV PARENTS
 process_split_commit () {
 	assert test $# = 2
 	local rev="$1"
 	local parents="$2"
 
+    if should_ignore_subtree_commit $rev
+    then
+	    return
+    fi
+
 	if test $indent -eq 0
 	then
 		revcount=$(($revcount + 1))

base-commit: bda494f4043963b9ec9a1ecd4b19b7d1cd9a0518
-- 
gitgitgadget
