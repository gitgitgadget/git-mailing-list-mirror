Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8331FC43215
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5066D20855
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkaH5DKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfKUAqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:46:30 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46805 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfKUAqa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:46:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id l4so660386plt.13
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 16:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tPW7/8SMl6017Q/IMECZIjQvVVKketRz/lQXBlisQiw=;
        b=EkaH5DKujJU5RIXdC/+1uE4p0R6TBWqV4gaZGQLDWJntrNGo5kG6iHaCZP4ZWgPoQT
         1FmsQhXPTW9tAhut2QNjUk6cGRexhHBcCzOHJmjfdkHaPIg96H/3/PVVFWqRIKCn14BA
         0YIvR2wLIZgl3ERKdYp6Hq7qkCCSpCwtcm2/SFWSFfmzcbbCYUDkjDSJlMVoI8rkH6hT
         OiezP5Wk8KnU8PYtbbL2ndK0OvS4ZbJz60FztOSXt1ZY1HOHsh3/Nf4le92wAwcRZeRT
         ZK/Zw9sU5jZt9lcS8y7up5Uss8CLuefj4m69upQSQbn0fOoQLMwnC7nsor+O+R6OzUt9
         c+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tPW7/8SMl6017Q/IMECZIjQvVVKketRz/lQXBlisQiw=;
        b=G5fWgKUvYHsiUdFpsJW5Bn/WTarvl8w8d36jwylqX1bULgjB6NVEiv6mOijCid7Bru
         F/Rf/qhuVWDz1rRbeKRngMkIvvTUFcfHh2aBgNyu8WpvlX1jbAtWpP5AmP5OGmXrAQNu
         Pvu0sVX8OkwBSUyj4mSmB0gLk627vc9LmEp+l1OAsIuJgn08EvefvDun8sFtn54wQWYB
         EamjnSn+QZdC/prrGjrPOu0uhTYXWeDXKmq26sqTSSi948rWhVZx9Uv5GGipiyOVavb7
         NIslLdCRNksFjl25zXiswZyaSZDK6DSg1UI9vAhW9Ad5B63NdMLxGlrIZ0Wq39K4EIyb
         D3Sg==
X-Gm-Message-State: APjAAAWoakQCKHDNO9teZJQko+8F9Hid6Frw0THUYeYgwqvEbDDdDJbi
        eB+dE/OOGdxfsuG65BISzOOEs89w
X-Google-Smtp-Source: APXvYqzYXnPMl7ykQdQ9gKW6h0noAWfgiUpf9gb8b+++oode4xfCfbhrk3vQbz+O3MNPdzcHFY1TXw==
X-Received: by 2002:a17:90a:4fe6:: with SMTP id q93mr7606446pjh.88.1574297188949;
        Wed, 20 Nov 2019 16:46:28 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id y6sm614546pfm.12.2019.11.20.16.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:46:28 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:46:26 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 17/21] t7700: drop redirections to /dev/null
Message-ID: <3cc6e4455cd55ff5d03595f6c348ae80268497a6.1574296987.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
 <cover.1574296987.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574296987.git.liu.denton@gmail.com>
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
2.24.0.450.g7a9a4598a9

