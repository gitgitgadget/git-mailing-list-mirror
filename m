Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F19C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D253207FD
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HijSmkLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKZBR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:17:58 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34689 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKZBR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:17:58 -0500
Received: by mail-pl1-f195.google.com with SMTP id h13so7354429plr.1
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BJOtIL+cfbhl9dwPpTN/bZ6NZM7pqVzyL6qjSsZmjfU=;
        b=HijSmkLRUrd3CmtfmJF5hsKRfAQPXz6RgBkXs1ABzDEq/A5vq5gWxnbG2NynAjlFIh
         uWGwJ7uk8Ap40MWjYksYQH66yG4gdmDlt2ht0FUIJiadGctwGiuJ2BxLx/faZM0r6jS0
         GhdADU9oq9kcEbcOUbxCLQngr+iO+vBg4B0tTJw+QhqE5ngI6/7gBe6PJV8CqDtkeYar
         gy7yhOAtC0XYFTnG7J8HkLFhZ5epd+9X+1zzN+fU2FYWeXhATT3U9kDCR7PWAE6+nAGP
         utGBUDie8lbzinZeR299lfiIbfwIGZV4blfxLQV9AXuDI6Qc+Pe54fofe+x3vNOFsfXB
         ymeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BJOtIL+cfbhl9dwPpTN/bZ6NZM7pqVzyL6qjSsZmjfU=;
        b=kc84uQQlhazSHtvMmmTr/XCDdQq07KTOZKSfN81FJbod8/woAuuv7TTM2b/228Cyem
         hjr4GR1HDJycPeiH4nD28Y2RXsk5c4DPstdzXTym34soD3JAzCpSLW1WChW5nUjmD/x8
         gILahwKQ4EEZRjzCzJajtevHrEOLC4Jhd77OTukNyCY9h6002UgHajuQNSjt0Z/0PtBS
         Oa33u21Zdn6GDjqXUV5pwJ0dmoq6xLk7gXxi7HPgqOjJtKAHF43J+mNDL64DXqKAXfni
         LSJrPFuwOJ6Fv8aOHG/rDiDsDXrGee7ro84R4qmR9KBDCws13ziFvXl46NftMevfnWHj
         81Gw==
X-Gm-Message-State: APjAAAWsmN/4qu/JBkkCCfNhTUPgn9QjeqUWeS+RBPEqd8qdg165UxUG
        8Fa2oj+p+40cgtn26djQPQ1zS0Uh
X-Google-Smtp-Source: APXvYqx1LTPvP0A3rsexfSQ9gcTRQbzMjfcsckvLHhe6dhw192OAI/t150r7KImUVNix+6x3j+1/BQ==
X-Received: by 2002:a17:90a:6d64:: with SMTP id z91mr2861642pjj.44.1574731075720;
        Mon, 25 Nov 2019 17:17:55 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id x2sm9691396pfn.167.2019.11.25.17.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:17:55 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:17:53 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 04/27] t0090: stop losing return codes of git commands
Message-ID: <7d33586b214f8dfd8e027b3bc618ca908799b560.1574731022.git.liu.denton@gmail.com>
References: <cover.1574449072.git.liu.denton@gmail.com>
 <cover.1574731022.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574731022.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In generate_expected_cache_tree_rec(), there are currently two instances
of `git ls-files` in the upstream of a pipe. In the case where the
upstream git command fails, its return code will be lost. Extract the
`git ls-files` into its own call so that if it ever fails, its return
code is not lost.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0090-cache-tree.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index ce9a4a5f32..5a633690bf 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -21,9 +21,10 @@ generate_expected_cache_tree_rec () {
 	parent="$2" &&
 	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
 	# We want to count only foo because it's the only direct child
-	subtrees=$(git ls-files|grep /|cut -d / -f 1|uniq) &&
+	git ls-files >files &&
+	subtrees=$(grep / files|cut -d / -f 1|uniq) &&
 	subtree_count=$(echo "$subtrees"|awk -v c=0 '$1 != "" {++c} END {print c}') &&
-	entries=$(git ls-files|wc -l) &&
+	entries=$(wc -l <files) &&
 	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_count" &&
 	for subtree in $subtrees
 	do
-- 
2.24.0.504.g3cd56eb17d

