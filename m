Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 580621FF6D
	for <e@80x24.org>; Thu, 22 Dec 2016 18:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938770AbcLVS4P (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 13:56:15 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34495 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934398AbcLVS4O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 13:56:14 -0500
Received: by mail-pg0-f48.google.com with SMTP id y62so48479312pgy.1
        for <git@vger.kernel.org>; Thu, 22 Dec 2016 10:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5za96rDUglSBwFrsQOphILqW8CUG8my+rh+OJrQQaq0=;
        b=ugDZeGxx3bxdESLqnQc3y1Maqy6LxEEj6wL4q1NV8yBGBAnpQfULJR77jLxleA4cwV
         HXYaBXxKCwuWp0gBuBxm73t6lRCznIdcgupFDo0xNksv2DlglM2A7Dqv/z+svpFc0kQq
         zAYi4dx7MvFF2H73sA9Dg7p15LEjy6Eyk/g46jLNWYQ10NOG64Rj0oFQvnRWjWTrok5s
         fIn2N+TX6kw29RRMubDd3DeLUwr6ecpauLvF8wtlzmDHw0LMTCSDMxmGx58Hj8Wb1TY/
         OYIbvI6Cl51/kONZdtjq2PIYeLuGqSCUCD+t74ZDGhJv2iysBWuaxEmq+6Fc2+a16JD7
         NiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5za96rDUglSBwFrsQOphILqW8CUG8my+rh+OJrQQaq0=;
        b=KisALEShz4PpQFjHReqYvZhVlT5YBqsYYHghAS3lT6i0YZe+hhr4mTVkU3TD0s8iMh
         ABKGecWFxiZsiAwL+StmcKVGy3RY08zGGKfQtk1LOScjSiEGmgyqFZkZY5dRaIVLeP8w
         WZV49ZxxGFZMMpbP4GgL3G9oQl8eOb2uNgKrSwvtGp7zxnRv6Y1MzLEvzpAjGAJhaNvV
         7YNaOLczeb9uu/2a0BBMB1bDHvNwludQcZZgcnynCOTYL4R0gEXl91RS15GKr9nCpxCi
         DbwZhv6Y/2+8xTet2ePGZdiBv1FHRVx1eAXAxuVPMZGQkHKmdJvcAwdsLee8lNX0KNFl
         8o1g==
X-Gm-Message-State: AIkVDXKrBVqRhv+DQx9ToN1ruLWcTDJVVFWVGhZ9F95a6DmLqLm3OLZpZ3oOqj7BMoI1brse
X-Received: by 10.99.213.21 with SMTP id c21mr19004065pgg.137.1482432973673;
        Thu, 22 Dec 2016 10:56:13 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:257c:d256:967a:f8])
        by smtp.gmail.com with ESMTPSA id 16sm56515616pfk.54.2016.12.22.10.56.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Dec 2016 10:56:13 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH] add diffstat information to rebase
Date:   Thu, 22 Dec 2016 10:56:09 -0800
Message-Id: <20161222185609.21139-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.193.g3170a3a57b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

When working on a large feature consisting of lots of commits,
my development workflow is to create a lot of very small commits and
then reshuffle these via interactive rebase.

Sometimes the commit message titles for these very small commits are
not as good as I thought they would, such that the interactive rebase
session needs to be accompanied by extensive use of gitk in my case.

This is a small hack that adds the diffstat to the interactive rebase
helping me a bit during the rebase, such that:

    $ git rebase -i HEAD^^

    pick 2eaa3f532c Third batch for 2.12
    # Documentation/RelNotes/2.12.0.txt | 40 +++++++++++++++++++++++++++++++++++++++
    # 1 file changed, 40 insertions(+)
    pick 3170a3a57b add information to rebase
    # git-rebase--interactive.sh | 2 ++
    # 1 file changed, 2 insertions(+)
    
    # Rebase 2eaa3f532c..3170a3a57b onto 2eaa3f532c (1 command)
    #
    # Commands:
    # p, pick = use commit
    # r, reword = use commit, but edit the commit message
    # e, edit = use commit, but stop for amending

I am not completely satisfied with the result, as I initially wished these
information would just appear in line after the commit subject, but this
comes close. Maybe the last line also needs to be dropped.

This is not a patch meant for inclusion, as for that we'd want to hide this
feature behind an option I'd guess.

Stefan

 git-rebase--interactive.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 41fd374c72..db73c69674 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1220,6 +1220,7 @@ do
 	if test t != "$preserve_merges"
 	then
 		printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
+		git diff --stat $sha1^..$sha1 |sed s/^/"$comment_char"/ >>"$todo"
 	else
 		if test -z "$rebase_root"
 		then
@@ -1238,6 +1239,7 @@ do
 		then
 			touch "$rewritten"/$sha1
 			printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
+			git diff --stat $sha1^..$sha1 |sed s/^/"$comment_char"/ >>"$todo"
 		fi
 	fi
 done
-- 
2.11.0.193.g3170a3a57b

