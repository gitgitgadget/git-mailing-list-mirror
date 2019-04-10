Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C48B20248
	for <e@80x24.org>; Wed, 10 Apr 2019 02:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfDJCNT (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 22:13:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34089 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfDJCNT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 22:13:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so548581pgq.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 19:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iYU1FBmhk3gn/IXklEp8UKZLWeSuZxcJ3xVZ0/pfIYg=;
        b=RSe7fGh5/pctSraZcxmrRfUU+6ZBv73dFBZ2G1DwWzAGediTKv8hUlEZiY2Y+Zv4gC
         vSzhyRoQwlZid7ddCH8WpXfvJXeSSZl8fAI5saRFTEWQfB8ODpqRB9hpp2a5ZKgMezT/
         LwiEZV2jDGrfKLcUaoG1emqePBvn7C5fDxCsStC2U2A0u8lEEYjm2CL5dFdSUR0/pW0k
         3zVDDXcVN3Kr4OTY+U0Cz5MhmPNImBYoMjPwOVbbo6WeanONgsa4hMMxIhTX9lK1tq6e
         X5gQMtuNDogxbBXfmDnWXkm6CFQYOfF2kStmZLd3OYFfM876Ua8/MLVHb8hyKdnvgmQe
         11DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iYU1FBmhk3gn/IXklEp8UKZLWeSuZxcJ3xVZ0/pfIYg=;
        b=qO+sQQo/CY8OZY7r98wLeToYNlVu0S8OXFzXZI4Pv/0qvlmeTTNr14TWz7uh/lvDhn
         NVdDUyCk+41IkEn2UwOEIWjCkt0P4yr9MjoigsrR4ZY0WJcoeta5udq4pccsMYcoce/H
         2KpOynWaDRlD9mxhe0DunE+7ANjArpmfzi5UuxCOyYXs3GhU3upIIy6X3tKCPRePmfmR
         7zlwCs1rMHsRg3BIM4/A852M4hQ201v+VoJEvn3Ps/qk2wkJFE/kbMXhIam5EXn5BGxN
         +cKR/x025fHAqnIf0C2FZLcLpZv7QDBX4Mw0G63NM8TGqSOxUFnVMgRC9Ayn+I0R0nqo
         BXIQ==
X-Gm-Message-State: APjAAAVxk/jtmMB0Dsr45EQkazt8pyLszK5UntnphoyvfPABqatk7J5z
        mVy9qco8GU1uCg+opNCjX4cGD36fGQyKiqLm
X-Google-Smtp-Source: APXvYqz1wZdp/kK6fgg5cPPiEvzMz7ABVH1WSDymU6xVHnDV3d22Tmmky8IzIOvvzkhtOsMAax2ZPA==
X-Received: by 2002:aa7:928b:: with SMTP id j11mr21196898pfa.200.1554862398277;
        Tue, 09 Apr 2019 19:13:18 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:c47d:9491:9418:887])
        by smtp.gmail.com with ESMTPSA id u17sm47176298pfn.19.2019.04.09.19.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 19:13:17 -0700 (PDT)
Date:   Tue, 9 Apr 2019 19:13:17 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, peff@peff.net,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v2 3/7] list-objects.c: handle unexpected non-blob entries
Message-ID: <1d1ac9b7a74fefccb6003f4ab8eb1a6d3660dff7.1554861974.git.me@ttaylorr.com>
References: <cover.1554435033.git.me@ttaylorr.com>
 <cover.1554861974.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554861974.git.me@ttaylorr.com>
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
index 15072ecce3..1377c60378 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -20,8 +20,9 @@ test_expect_failure 'traverse unexpected non-blob entry (lone)' '
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

