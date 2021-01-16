Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309C4C43333
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3A92251E
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbhAPRGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 12:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbhAPQbM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 11:31:12 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CB1C061349
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:04 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id c5so12227823wrp.6
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EYVYCkd0dKoJ5n1v94tHUH8tTkOt6HzhnBOH7Gbrpvg=;
        b=V6BiU4VlqHPzLHF+HciIMXDMxB8WA0t5P8rdV29GeiwQohdcZK7kmf8uN/3O4TOsnn
         wuNvMVLgLrJMiSVNsx1z+Y7JWupBdvloT0iOgXyCFPHHOsxTyt6lSOW5iazX0fSC7j1q
         leAI0hDvTGDHQFCvEJtPakHZvIVhumD++rfr77C/HLaDwT72Tt8AaBPMD7nEDG21AYg6
         odXQ0uFjow6OozDJNiy2tVvRyTzFiFLu67tk7+dtUHGbKCDHcV8UTC7dosZ0Co5M6zMc
         78Ndd+iFMD9diXfsQwi9JBEg6yTKUSSZEB+U9qVWMQSeENvHEIimmsk0+PBPzR7J179U
         YMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EYVYCkd0dKoJ5n1v94tHUH8tTkOt6HzhnBOH7Gbrpvg=;
        b=fA5bspDPMZ3BQN87GF3EffXXoEhokeHA+0v6fMT+iY20uj3RvVL9NvJ1yAImmWqXAs
         lopoJ5PBfk5Qg/ew01uRNTSDic1M57QD32Ny67gqFjsR5CAnWjVbkwrgxecd7rhcnRzi
         0B+soib+h3NcLb/MdJgnpsgdWFaX3nuLIU1CKfSAUGQKYuo0u5+QmQXnl1lEVrFVUvsE
         SZPAXULKAXvk8LFiBUya/HGwl/gaMG/25Rq0Qy1QP1IODoQ0dclDhSdmeQYshVoKuPqc
         uwCErG6qLupC8WLxAxQSzq7pEZHO+IbgWAjJWC7LQpk6zGJZ6KW+QH/KNW07gPJMWSSO
         YeYg==
X-Gm-Message-State: AOAM5325zxBgEJ6jBV2BFkKjRxbRrjRV+jXNyOmXtQNYnEO4J8yjdPNN
        VNUwU1IVUmS+3AOKdLkbEeuI8CB1xPp1hA==
X-Google-Smtp-Source: ABdhPJzuKiM96iDU9xXwWUiswVP+n3b8gZftFpb2tknQg4ETp3EcT+eReGAX5+ry62nv1d3FSeiZ/A==
X-Received: by 2002:adf:c642:: with SMTP id u2mr18568514wrg.243.1610811362722;
        Sat, 16 Jan 2021 07:36:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm20008855wra.53.2021.01.16.07.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 07:36:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/11] cache-tree tests: refactor overly complex function
Date:   Sat, 16 Jan 2021 16:35:46 +0100
Message-Id: <20210116153554.12604-4-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210114233515.31298-1-avarab@gmail.com>
References: <20210114233515.31298-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor overly complex code added in 9c4d6c0297 (cache-tree: Write
updated cache-tree after commit, 2014-07-13).

Interestingly, in the numerous commits[1][2][3] who fixed commits bugs
in this code since its introduction it seems not to have been noticed
that we didn't need to be doing some dance with grep/cut/uniq/awk to
extract this information. It can be done in a much simpler way with
just "ls-tree" and "wc -l".

I'm also removing the comment, because I think now that this code is
trivial to understand it's not needed anymore.

1. c8db708d5d (t0090: avoid passing empty string to printf %d,
   2014-09-30)
2. d69360c6b1 (t0090: tweak awk statement for Solaris
   /usr/xpg4/bin/awk, 2014-12-22)
3. 9b5a9fa60a (t0090: stop losing return codes of git commands,
   2019-11-27)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0090-cache-tree.sh | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 2e3efeb80e..f1b0a6a679 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -18,20 +18,16 @@ cmp_cache_tree () {
 # correct.
 generate_expected_cache_tree_rec () {
 	dir="$1${1:+/}" &&
-	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
-	# We want to count only foo because it's the only direct child
-	git ls-files >files &&
-	subtrees=$(grep / files|cut -d / -f 1|uniq) &&
-	subtree_count=$(echo "$subtrees"|awk -v c=0 '$1 != "" {++c} END {print c}') &&
-	entries=$(wc -l <files) &&
-	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_count" &&
-	for subtree in $subtrees
+	git ls-tree --name-only HEAD >files &&
+	git ls-tree --name-only -d HEAD >subtrees &&
+	printf "SHA %s (%d entries, %d subtrees)\n" "$dir" $(wc -l <files) $(wc -l <subtrees) &&
+	while read subtree
 	do
 		(
 			cd "$subtree"
-			generate_expected_cache_tree_rec "$dir$subtree" || return 1
+			generate_expected_cache_tree_rec "$subtree" || return 1
 		)
-	done
+	done <subtrees
 }
 
 test_cache_tree () {
-- 
2.29.2.222.g5d2a92d10f8

