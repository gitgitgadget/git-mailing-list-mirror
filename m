Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 538F520248
	for <e@80x24.org>; Fri,  5 Apr 2019 03:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfDEDht (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 23:37:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36534 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbfDEDhs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 23:37:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85so2306478pgc.3
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 20:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AxVTQ4DnUgP3W/0YNxbBl/tAE1nkMLyDaJJJllUySFY=;
        b=XkuNJCvg7NmQuJ9PvBX/QTjQQWpKwro/mGAuqwf1HT9ozsw4psQgL2C4qwM94KWQPL
         NNfWwHEirqTv+e3K8QiUFoXWJOAFDhkWGCUSVf7TpzLvZCjQi7lHdFJvMNidW4EH5iL/
         EGq77OxPf6/EeOENEVnBcs5lzPRMwv32TyILeqS2Bc/8155JMoHx+8riRxTUqQiSt2LB
         3Rnq71i9JI2uYz2LWZQq2wozrvPUv/n8XY5v+96aTfCHXddIEH0VHJ1QGjINZjem+qFP
         RDYw8sptmWWZTYHgCpSFQdYCbdm0sONMejL5leWw+ErG3zGAIPNcXT9zHU/yqaTjkRsU
         hzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AxVTQ4DnUgP3W/0YNxbBl/tAE1nkMLyDaJJJllUySFY=;
        b=imCQOqBusUyEjLVEfsm/ILOHjRTfBXCpe2j3+8mOnAqOYnYXIExjfkSCPO4ueGzJTA
         0ML4dTLfSxS0BS+OJ1G+bjIJAbVxuS5+tJ3as0rYihWN2CuZmegvFQEywRCUVobfk6WK
         Agb2v15zjRngUHdW7kIhaLgsxMyG3qdlEqDO8/wvENybMoPDfLgt7L2yMJPMNVHVip9K
         mGvATuwkAawMBfP7JlI/7PZBN2xk6hilRN+Eq5GPNnRBDAEhnFfRL8AM2CpOZwG08Vlr
         474X4h35F6RH/oOaaDNOSCCrSd81QhtHpFpY50LpbLCgxpJeZ3pLi7GvjiA4MEIcASsW
         JGYg==
X-Gm-Message-State: APjAAAV6D0yze5IZQfOctxMuGe8Ex3r9ai1pyiiTjBud6l/cBQ6nqx4+
        AmjGvAFflBFmyxoM0VzgCVBB7wZV/WairQ==
X-Google-Smtp-Source: APXvYqzG8rVlfX9oP0DuN7UPL6c602gKWG8HBGIczwliOq01bxeIhsmSQz7lD6TJ9qq5aCOiQA7Cbg==
X-Received: by 2002:a63:1912:: with SMTP id z18mr9686967pgl.115.1554435467628;
        Thu, 04 Apr 2019 20:37:47 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:9900:4016:ceb4:1574])
        by smtp.gmail.com with ESMTPSA id l63sm30487829pfc.89.2019.04.04.20.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 20:37:47 -0700 (PDT)
Date:   Thu, 4 Apr 2019 20:37:46 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH 3/7] list-objects.c: handle unexpected non-blob entries
Message-ID: <75f20ee26def257aa45dd31cd016ee76f81dcb83.1554435033.git.me@ttaylorr.com>
References: <cover.1554435033.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554435033.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix one of the cases described in the previous commit where a tree-entry
that is promised to a blob is in fact a non-blob.

When 'lookup_blob()' returns NULL, it is because Git has cached the
requested object as a non-blob. In this case, prevent a SIGSEGV by
'die()'-ing immediately before attempting to dereference the result.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 list-objects.c                         | 5 +++++
 t/t6102-rev-list-unexpected-objects.sh | 5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index dc77361e11..ea04bbdee6 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -133,6 +133,11 @@ static void process_tree_contents(struct traversal_context *ctx,
 					base, entry.path);
 		else {
 			struct blob *b = lookup_blob(ctx->revs->repo, &entry.oid);
+			if (!b) {
+				die(_("entry '%s' in tree %s has blob mode, "
+				      "but is not a blob"),
+				    entry.path, oid_to_hex(&tree->object.oid));
+			}
 			b->object.flags |= NOT_USER_GIVEN;
 			process_blob(ctx, b, base, entry.path);
 		}
diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 472b08528a..76fe9be30f 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -19,8 +19,9 @@ test_expect_failure 'traverse unexpected non-blob entry (lone)' '
 	test_must_fail git rev-list --objects $broken_tree
 '
 
-test_expect_failure 'traverse unexpected non-blob entry (seen)' '
-	test_must_fail git rev-list --objects $tree $broken_tree
+test_expect_success 'traverse unexpected non-blob entry (seen)' '
+	test_must_fail git rev-list --objects $tree $broken_tree >output 2>&1 &&
+	test_i18ngrep "is not a blob" output
 '
 
 test_expect_success 'setup unexpected non-tree entry' '
-- 
2.21.0.203.g358da99528

