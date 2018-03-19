Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB0F81F404
	for <e@80x24.org>; Mon, 19 Mar 2018 23:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755944AbeCSXSu (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 19:18:50 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45851 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755871AbeCSXSt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 19:18:49 -0400
Received: by mail-wr0-f193.google.com with SMTP id h2so20268854wre.12
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 16:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ODoIcKSnLRojMsrYgfp52tAUqSOVoymvPFV4XcJV5eo=;
        b=bdYo83IsdAt+SWoSfhyDb11wewTj28bH4/JLWnsX0McnhwBtdcJauRb5P0xab0z6/K
         8xt1twV0kJ9tA4witasEI2Yeo/M78K0PGNCQsiDObExHGxgq54I384mi6v0N4857fuiA
         3AYkuly8b1XA461pp3nn0F4Ob8b0v0bAM+t+jiGw1Xfqj7vz55bRZvqnRL+nzbmzKMDf
         +0EL+kHT4fa7odpLxlhSuU/dQj9P4STpUm1cucvgWqq77umFTFxYpHW5o4m/BJDzj8m4
         LFmLhjQOVpkGcbIzobcgwkKfuwn1lFdXmyBgJZWhq1Ihyal14R+7PPjZiNlMlYbt4Q9w
         ulkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ODoIcKSnLRojMsrYgfp52tAUqSOVoymvPFV4XcJV5eo=;
        b=Lt62CqfPXZpXKKzgdigYIhbH5UqHphJ61gf/EenPnzeXFSHAe5j0ZkoIoOJw8Qzv1Q
         n3mXC+Qub9xwpiNf/mcM+zODhgqgele8b2wmP16kLmab/lSI8noVr1dy2PEMggCjx83o
         kGAZnBVMMZjrF+jH88/Q7hRzppCfIowoLInx/KtxUdxptHOpbDlm3PhfEEGaeREJD+e8
         YzwTAYJyauHKuFJLjIixdQqtaySCrLJ4Rpx+F02KJdHcL+XqDOqarxXX5o2t4SKXGOAU
         e+Dwd/7+vNtbwefMYgwRsP3SVidgRguWdu37wyNsAOoojb77rOtC79+Unp/Lb2vY+B2n
         Wg0A==
X-Gm-Message-State: AElRT7Hq7CkVidU9A78Cp56l3whsx0snXJvD8RflFQJrgFa5j3iVLKbj
        f1GPkSz1AwawT0P1oiHh13R7Ze1l
X-Google-Smtp-Source: AG47ELteB+tZlfAut7GD7OBM4U7wJS2E1LBFCDXEMu71MdbPfwNkoHs8XnBB2+TTmycd5QiA0/GR9w==
X-Received: by 10.223.150.175 with SMTP id u44mr10560296wrb.104.1521501527995;
        Mon, 19 Mar 2018 16:18:47 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id e67sm458188wmf.20.2018.03.19.16.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 16:18:47 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 1/3] stash: fix nonsense pipeline
Date:   Mon, 19 Mar 2018 23:21:54 +0000
Message-Id: <20180319232156.30916-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.1.33.g3165b24a68
In-Reply-To: <20180319232156.30916-1-t.gummerer@gmail.com>
References: <20180316223715.108044-1-gitster@pobox.com>
 <20180319232156.30916-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

An earlier change bba067d2 ("stash: don't delete untracked files
that match pathspec", 2018-01-06) was made by taking a suggestion in
a list discussion [1] but did not copy the suggested snippet
correctly.  And the bug was unnoticed during the review and slipped
through.

This fixes it.

[1] https://public-inbox.org/git/xmqqpo7byjwb.fsf@gitster.mtv.corp.google.com/

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-stash.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index b48b164748..4c92ec931f 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -315,9 +315,9 @@ push_stash () {
 
 		if test $# != 0
 		then
-			git add -u -- "$@" |
-			git checkout-index -z --force --stdin
-			git diff-index -p --cached --binary HEAD -- "$@" | git apply --index -R
+			git add -u -- "$@"
+			git diff-index -p --cached --binary HEAD -- "$@" |
+			git apply --index -R
 		else
 			git reset --hard -q
 		fi
-- 
2.15.1.33.g3165b24a68

