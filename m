Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DBD51F859
	for <e@80x24.org>; Wed, 24 Aug 2016 08:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754959AbcHXInS (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 04:43:18 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33652 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753880AbcHXImg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 04:42:36 -0400
Received: by mail-pa0-f66.google.com with SMTP id vy10so779457pac.0
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 01:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=r4UqqIJjH7wr00XBgbETvfpN0TbAtmA9sYZJQVvJFzo=;
        b=TK8+rHIDwO/ow++RTVYdS225SHPznvbBi7RBrEfT2BN8bwjiXCpBk84cQq2Z1n4x5X
         1V6F5M+JeEheokT00RKcC/l1cZckCAbIWMnQ89m2vmXmCL58elElOeeC+pcT+UVo0TN/
         r12fh938Mi4jvndos+sf+ef+WuzTNqSgZ988lMjJ5VFY4FGYa+6KQzsPEF7ktQYpYLMK
         tyFQEc7+JNndDu2SYPy7Pj7zMLnGZH+frETZq3J+JgxzxL+o4rh25Yo1zTVTzH33vJrV
         I12Fe5kfjM0282w8ZEnwZ4QRqKKO31gBvdLjEPMedKKG/zcDjkkJHAxma5xTJMAHJa1l
         mf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r4UqqIJjH7wr00XBgbETvfpN0TbAtmA9sYZJQVvJFzo=;
        b=bq2/YI5kEf/sx0o86EZxOWe/PsZkjLzCqzVkRPDZjiK+QOevoY2Ev2t86Y4coOmomy
         Ad7nKWjGJ1Gch6GOhTYno7XkRHJ8EGRKy1jsEueeI3nE09B7nCZNSAPZgL+8UbFxyDD8
         DYbnz/ZAi6entoN5SVx07UfZe2Cb/dRXBkt5bg2Uv7Ynk9Vo5g+bNTzbXXAw/zIKHWDg
         hSo6QF8/dc96ubH/IJKF4st1CM1Cq91lzPd74HhJ9dE1IzquXycB4gXnVEBxPa4P3Xts
         tY63sc6KFHTdMosS8fEAxBCDEDz+IlIyr+vQUD5F5rC/V5AcUdxfJEwQB/53Zg6UVNiB
         1jCw==
X-Gm-Message-State: AE9vXwN+amYXoNhhrUr1g7D/6QXoZ8RWCIjnv1s60mB/zjF06q8UvW1fAkqgoo6pAKP6Mw==
X-Received: by 10.66.49.137 with SMTP id u9mr3528222pan.72.1472028134700;
        Wed, 24 Aug 2016 01:42:14 -0700 (PDT)
Received: from chrisp-dl.ws.atlnz.lc (2-163-36-202-static.alliedtelesis.co.nz. [202.36.163.2])
        by smtp.gmail.com with ESMTPSA id x126sm11446249pfx.61.2016.08.24.01.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Aug 2016 01:42:14 -0700 (PDT)
From:   Chris Packham <judge.packham@gmail.com>
To:     git@vger.kernel.org
Cc:     Chris Packham <judge.packham@gmail.com>
Subject: [RFC PATCH] completion: support excluding refs
Date:   Wed, 24 Aug 2016 20:41:52 +1200
Message-Id: <20160824084152.2857-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.9.2.518.ged577c6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow completion of refs with a ^ prefix. This allows completion of
commands like 'git log HEAD ^origin/master'.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
I often find myself using variations of 'git log HEAD ^origin/master' to
see commits that I have locally that have not been pushed. It is also
useful when reviewing changes before integrating them e.g. 'git fetch
...; git log FETCH_HEAD ^origin/master'.

 contrib/completion/git-completion.bash | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9c8f738..21016bf 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -338,7 +338,7 @@ __git_tags ()
 __git_refs ()
 {
 	local i hash dir="$(__gitdir "${1-}")" track="${2-}"
-	local format refs
+	local format refs pfx
 	if [ -d "$dir" ]; then
 		case "$cur" in
 		refs|refs/*)
@@ -347,14 +347,15 @@ __git_refs ()
 			track=""
 			;;
 		*)
+			[[ "$cur" == ^* ]] && pfx="^"
 			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD; do
-				if [ -e "$dir/$i" ]; then echo $i; fi
+				if [ -e "$dir/$i" ]; then echo $pfx$i; fi
 			done
 			format="refname:short"
 			refs="refs/tags refs/heads refs/remotes"
 			;;
 		esac
-		git --git-dir="$dir" for-each-ref --format="%($format)" \
+		git --git-dir="$dir" for-each-ref --format="$pfx%($format)" \
 			$refs
 		if [ -n "$track" ]; then
 			# employ the heuristic used by git checkout
-- 
2.9.2.518.ged577c6.dirty

