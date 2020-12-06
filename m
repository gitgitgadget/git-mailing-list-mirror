Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14BDC1B0E3
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 04:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE1E022DFB
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 04:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgLFEIb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 23:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgLFEIY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 23:08:24 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D830C061A4F
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 20:07:43 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id bo9so14470223ejb.13
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 20:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b3jJPHDfjc5VlGaFTuqLoZhOsVzYqT1r8ek7ZF/iTCQ=;
        b=m2OMJOlsmt6Yq75T+3FHIGwoeIvks8bZS3MVwCjxLqll5ZETWBm/38NEyjOMBlFH5r
         g8CUlIXLwvThHPn3dqlpUXlVrOYpYdnq3sZscqN0USVTWOMSJtnMCcdx/dOyUvnVVJN6
         irIv40xoUWWp1WBoMxDM85v5WP9RR4LnukaFBFKSJrLeLLgkFOe5lsWegi2wdk97KmFQ
         mPJR7JpjuU7UWWZAf30/RhwkLxecblkBoD+u9J5wT/VVP20x1LSCm8PatJ8QQKqRQ+sz
         ruiQxGmaOBHbqDRo7929A5uiHtCr0J9dUNsaQ7oRyfCZTJ3gmVq9hDoNEgmyQP2Hzke5
         OQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b3jJPHDfjc5VlGaFTuqLoZhOsVzYqT1r8ek7ZF/iTCQ=;
        b=I4c2kS+H25Jo0ohv9PFHD+DMZH3JORJl0xdnmgLuBYzKhuNA9Ibd+4VORQiWQP8WRP
         o7NgBypuSIbQjI3Xz++MKMjy8Lb+DYDq7DR8poWLnzutZXCxoFcVUB3Ggn5TPSg4yQIn
         Ni2ewUbRoQc6ajR4LRBdSG924pCbiTjWsKbgXVGzP9nxtdxmOOJCKRCn/JirLIYBoGv1
         hkXEcpo7U1AW6EDYhac7cY79lgDT/7NyMKBD5Sany4u+oG/4vu7HJ0x2HBb1d44w7i8W
         EnkHC4mqAR9CAHVrQ8KEjmMRq3heEwdPGyB3osgAr88pzP0RWgqaDeAAv7UjVHAoEDt/
         EFeA==
X-Gm-Message-State: AOAM530t3b/Oz98Bz/Xm2rR23G8BE2v4lyYDsvCsqf72jSojULiUd2CX
        5ArzTRhuwkE03qJo0mlctaC8PI4zcE8=
X-Google-Smtp-Source: ABdhPJxz3PiYg1CDrq8Sp450x3HABqiROZhheMzm5OJEjIdIWHIlCfDMZwl6+2SLEdgfRetWJO/nOg==
X-Received: by 2002:adf:efc4:: with SMTP id i4mr12336343wrp.323.1607223284185;
        Sat, 05 Dec 2020 18:54:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d15sm10095524wrx.93.2020.12.05.18.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 18:54:43 -0800 (PST)
Message-Id: <306a48820dd3c338d2b9e2288e5a3e1c7c89f36e.1607223276.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Dec 2020 02:54:35 +0000
Subject: [PATCH 6/7] diffcore-rename: simplify and accelerate
 register_rename_src()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

reigster_rename_src() took pains to create an array in rename_src which
was sorted by pathname of the contained diff_filepair.  However, the
fact that this array was sorted was not needed anywhere, and thus
represented wasted time.  Simply append to the end of the array, which
in a usecase of note saved 45% of diffcore_rename() setup time for me.

Technically, there is one difference in the end result for the code.  IF
the caller of diffcore-rename provides a set of pairs with a duplicate
filename in the sources (an erroneous input condition), the old code
would simply ignore the duplicate (without warning or error).  The new
code will simply swallow it and thus allow multiple pairings for the
"same" source file.  Checking for this error condition is expensive
(basically undoing the optimization) and the only existing callers
already avoid passing such an invalid input.  If someone really wants to
add some error checking here on this input condition, I believe they
should add a separate function which can be called before
diffcore_rename(), and then other callers that don't need additional
checks because of their design (such as merge-ort) can avoid the extra
overhead.

Also, note that I dropped the return type on the function since it was
unconditionally discarded anyway.

This patch is being submitted in a different order than its original
development, but in a large rebase of many commits with lots of renames
and with several optimizations to inexact rename detection,
diffcore_rename() setup time was a sizeable chunk of overall runtime.
This patch dropped execution time of rebasing 35 commits with lots of
renames by 2% overall.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 3d637ba4645..816d2fbac44 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -76,36 +76,12 @@ static struct diff_rename_src {
 } *rename_src;
 static int rename_src_nr, rename_src_alloc;
 
-static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
+static void register_rename_src(struct diff_filepair *p)
 {
-	int first, last;
-	struct diff_filespec *one = p->one;
-	unsigned short score = p->score;
-
-	first = 0;
-	last = rename_src_nr;
-	while (last > first) {
-		int next = first + ((last - first) >> 1);
-		struct diff_rename_src *src = &(rename_src[next]);
-		int cmp = strcmp(one->path, src->p->one->path);
-		if (!cmp)
-			return src;
-		if (cmp < 0) {
-			last = next;
-			continue;
-		}
-		first = next+1;
-	}
-
-	/* insert to make it at "first" */
 	ALLOC_GROW(rename_src, rename_src_nr + 1, rename_src_alloc);
+	rename_src[rename_src_nr].p = p;
+	rename_src[rename_src_nr].score = p->score;
 	rename_src_nr++;
-	if (first < rename_src_nr)
-		MOVE_ARRAY(rename_src + first + 1, rename_src + first,
-			   rename_src_nr - first - 1);
-	rename_src[first].p = p;
-	rename_src[first].score = score;
-	return &(rename_src[first]);
 }
 
 static int basename_same(struct diff_filespec *src, struct diff_filespec *dst)
-- 
gitgitgadget

