Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46706C63777
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 20:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBE4D22470
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 20:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSbZvu9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbgKTUgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 15:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730623AbgKTUgd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 15:36:33 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0742C0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 12:36:32 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w24so11033213wmi.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 12:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=z0LD6EMPImiuoJEnyOfKACl6CMb/R3sH3IiKCH7dxvs=;
        b=LSbZvu9fM98ryly3ROED41FlN+r85Kjqigywfi1qpv7tcET30S2gaAfpoLCFsc11c4
         6Wwud5Hxo8b5t1q6EOrxAlgx5d8aIkBCYaANyRMEi05jPWzGR814EpV4N/A4bB9r8oy7
         hHIjISWe/VYd29/V2iK/juqF+SncDYMJIaRy0d1BobnjmxC7RjDdLQ42KcDDmjIt530+
         eMivVUWj9/sOS9K5V1XvObBsfKWFzUfeMV96ARFfaIGxowGNLunTtM7BftHuD//jjDG+
         NInpk1mTRgZhhfQmcrM4u3Fkduwg/pa4c6AaFh2WoINhf+DM9WocVjJmTvimlRtdWrMb
         TLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z0LD6EMPImiuoJEnyOfKACl6CMb/R3sH3IiKCH7dxvs=;
        b=J3pfmiJ5tP6LjziYUe07ZXd+G37zxQ9/mn4X+zH/R1+UrgNa9t4+0M68F2tzavbQi/
         JD+lGWrsErnQC87LGeI559C5wK1L7MaeYVt127qt2xm1+NPiz9dMGbdTQNkaPoQ+NWdw
         RuaDwBEmqk2JQ80/7cqy5mejy3qpOkHIcF/7X86SbYRQg9v5LTXFtMvA6WVF0yskLG+/
         LvyBVkn+PeDMttAx3VJ+gqRxHGRiia5vVCjILTDUzR4Ke64Imt7QCIGyJlypQ3a30zae
         dBz70m69Ktfkb1KiRCJxrOOIVTHmKvItnYJyzwfppl99FOHYIbQOVo+vIvybTbzMTyF2
         QTXA==
X-Gm-Message-State: AOAM53200bEIvVicVlhblc88S81vLDRV77zwhxEcfGePrysNk57ydC7T
        WVLXJU7QlRj9BOSKY4A7L/6v0JII0lg=
X-Google-Smtp-Source: ABdhPJzdORNidwf11MkNMacfkbA+I985SPzuBCKhFu36KhJtB4E9I3jyQh+DB1fuqWD3Sb5krzJeSw==
X-Received: by 2002:a1c:3b07:: with SMTP id i7mr12175582wma.118.1605904588448;
        Fri, 20 Nov 2020 12:36:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w21sm5336730wmi.29.2020.11.20.12.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 12:36:27 -0800 (PST)
Message-Id: <pull.797.git.1605904586929.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Nov 2020 20:36:26 +0000
Subject: [PATCH] clone: --filter=tree:0 implies fetch.recurseSubmodules=no
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The partial clone feature has several modes, but only a few are quick
for a server to process using reachability bitmaps:

* Blobless: --filter=blob:none downloads all commits and trees and
  fetches necessary blobs on-demand.

* Treeless: --filter=tree:0 downloads all commits and fetches necessary
  trees and blobs on demand.

This treeles mode is most similar to a shallow clone in the total size
(it only adds the commit objects for the full history). This makes
treeless clones an interesting replacement for shallow clones. A user
can run more commands in a treeless clone than in a shallow clone,
especially 'git log' (no pathspec).

In particular, servers can still serve 'git fetch' requests quickly by
calculating the difference between commit wants and haves using bitmaps.

I was testing this feature with this in mind, and I knew that some trees
would be downloaded multiple times when checking out a new branch, but I
did not expect to discover a significant issue with 'git fetch', at
least in repostiories with submodules.

I was testing these commands:

	$ git clone --filter=tree:0 --single-branch --branch=master \
	  https://github.com/git/git
	$ git -C git fetch origin "+refs/heads/*:refs/remotes/origin/*"

This fetch command started downloading several pack-files of trees
before completing the command. I never let it finish since I got so
impatient with the repeated downloads. During debugging, I found that
the stack triggering promisor_remote_get_direct() was going through
fetch_populated_submodules(). Notice that I did not recurse my
submodules in the original clone, so the sha1collisiondetection
submodule is not initialized. Even so, my 'git fetch' was scanning
commits for updates to submodules.

I decided that even if I did populate the submodules, the nature of
treeless clones makes me not want to care about the contents of commits
other than those that I am explicitly navigating to.

This loop of tree fetches can be avoided by adding
--no-recurse-submodules to the 'git fetch' command or setting
fetch.recurseSubmodules=no.

To make this as painless as possible for future users of treeless
clones, automatically set fetch.recurseSubmodules=no at clone time.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    clone: --filter=tree:0 implies fetch.recurseSubmodules=no
    
    While testing different partial clone options, I stumbled across this
    one. My initial thought was that we were parsing commits and loading
    their root trees unnecessarily, but I see that doesn't happen after this
    change.
    
    Here are some recent discussions about using --filter=tree:0:
    
    [1] 
    https://lore.kernel.org/git/aa7b89ee-08aa-7943-6a00-28dcf344426e@syntevo.com/
    [2] https://lore.kernel.org/git/cover.1588633810.git.me@ttaylorr.com/[3] 
    https://lore.kernel.org/git/58274817-7ac6-b6ae-0d10-22485dfe5e0e@syntevo.com/
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-797%2Fderrickstolee%2Ftree-0-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-797/derrickstolee/tree-0-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/797

 list-objects-filter-options.c | 4 ++++
 t/t5616-partial-clone.sh      | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index defd3dfd10..249939dfa5 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -376,6 +376,10 @@ void partial_clone_register(
 		       expand_list_objects_filter_spec(filter_options));
 	free(filter_name);
 
+	if (filter_options->choice == LOFC_TREE_DEPTH &&
+	    !filter_options->tree_exclude_depth)
+		git_config_set("fetch.recursesubmodules", "no");
+
 	/* Make sure the config info are reset */
 	promisor_remote_reinit();
 }
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index f4d49d8335..b2eaf78069 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -341,6 +341,12 @@ test_expect_success 'partial clone with sparse filter succeeds' '
 	)
 '
 
+test_expect_success '--filter=tree:0 sets fetch.recurseSubmodules=no' '
+	rm -rf dst &&
+	git clone --filter=tree:0 "file://$(pwd)/src" dst &&
+	test_config -C dst fetch.recursesubmodules no
+'
+
 test_expect_success 'partial clone with unresolvable sparse filter fails cleanly' '
 	rm -rf dst.git &&
 	test_must_fail git clone --no-local --bare \

base-commit: faefdd61ec7c7f6f3c8c9907891465ac9a2a1475
-- 
gitgitgadget
