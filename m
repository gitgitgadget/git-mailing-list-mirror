Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26942C432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AD820835
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6rZhfjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfK0Txt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:53:49 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:44319 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfK0Txs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:53:48 -0500
Received: by mail-pj1-f67.google.com with SMTP id w8so10533342pjh.11
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oSYv3IDSDLX8QBH2hFjskq7DU0N5bdk2cfFPPNtUL5s=;
        b=L6rZhfjVHjHgFJQCBqGhyiKZtu3jprO9RWGgOlp2FaqGcOuNQMOoTmlRPxEBi+kEHR
         65/LxFx9Ess6IWCv60jCRyGXuWmlwux+8k4MOP5wOwIh6LbAa3gTODFyi3Cy2Q1xKSb7
         WbEegOcBwSinjvleZV8E1dPmL/4OoYaRKIRnkMpj61OeEe9GOMpK7sBEDVpIt1y8JRtT
         qiGD/OWzBJqs4KruBkva5j9332yPhCe4fbOAT1YNBn7JPXmVsXwRIidwnSDRdC+GaeQb
         NTcYtyaYLppK6pLYPGtVtHlIfTHtPL7RA/ehglD+pRNqUN1DP/QDKs5b30woC2jJ4U8F
         iqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oSYv3IDSDLX8QBH2hFjskq7DU0N5bdk2cfFPPNtUL5s=;
        b=arp+n0skpiDoGx6HP2BsaChIhmdR3pBjy8WgA1cydew4rANjqbIqNifTpdFqeSMzd+
         2mTwQPdwxE3t7XjKFsiVieerJLWGECtHfHMoJQsgnTi16GIy/XEmogbUPJTZH4J/KOAO
         BAFV7KLmrBxvITfgu130TFsLhRloH0VNXaaCr6IZBiEmrWSxbNv2hTWNALf5kaKYEcQt
         p7uTxM7dLTXu9bXa1HcoJuxf4UxHfODzFDq3nSNmxFV1rKrtL6sjY7f5I19Ka2dXeD2j
         WkHTx7IgxNmRkNE8GBOsA7b46JPkbdmX7e2UOeoUz0NB5eXEfFwz7+AEQJWpGmkgQK0j
         n3nA==
X-Gm-Message-State: APjAAAU32/REE2mElTthrsSpD/eN3D3AewsER7LIcROyDp5Lk8JGBGL7
        qcmwcD3+i5k0qaFGr5/5/b3O2Lpb
X-Google-Smtp-Source: APXvYqzM5OOp5+oAqN1uvAmhM+6Bsxz5WLoYfx4/lGvNf62yzou/PZcBejTwOCRfrTshee96zTq/6g==
X-Received: by 2002:a17:90a:fb53:: with SMTP id iq19mr8027518pjb.138.1574884427422;
        Wed, 27 Nov 2019 11:53:47 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id 9sm7326601pfx.177.2019.11.27.11.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:53:46 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:53:45 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 18/26] t7700: drop redirections to /dev/null
Message-ID: <c50c192429c73146b64a8c7637e89554fee4e24d.1574884302.git.liu.denton@gmail.com>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574884302.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since output is silenced when running without `-v` and debugging output
is useful with `-v`, remove redirections to /dev/null as it is not
useful.

In one case where the output of stdout is consumed, redirect the output
of test_commit to stderr.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 4e855bc21b..e1a689d6a9 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -5,7 +5,7 @@ test_description='git repack works correctly'
 . ./test-lib.sh
 
 commit_and_pack() {
-	test_commit "$@" >/dev/null &&
+	test_commit "$@" 1>&2 &&
 	SHA1=$(git pack-objects --all --unpacked --incremental .git/objects/pack/pack </dev/null) &&
 	echo pack-${SHA1}.pack
 }
@@ -19,7 +19,7 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	# Create two packs
 	# The first pack will contain all of the objects except one
 	git rev-list --objects --all | grep -v file2 |
-		git pack-objects pack > /dev/null &&
+		git pack-objects pack &&
 	# The second pack will contain the excluded object
 	packsha1=$(git rev-list --objects --all | grep file2 |
 		git pack-objects pack) &&
@@ -235,7 +235,7 @@ test_expect_success 'incremental repack does not complain' '
 
 test_expect_success 'bitmaps can be disabled on bare repos' '
 	git -c repack.writeBitmaps=false -C bare.git repack -ad &&
-	bitmap=$(ls bare.git/objects/pack/*.bitmap 2>/dev/null || :) &&
+	bitmap=$(ls bare.git/objects/pack/*.bitmap || :) &&
 	test -z "$bitmap"
 '
 
-- 
2.24.0.504.g3cd56eb17d

