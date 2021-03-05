Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81347C433E9
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 15:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B45465015
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 15:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhCEPWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 10:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhCEPWG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 10:22:06 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B1DC061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 07:22:05 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id r5so1128762qvv.9
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 07:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=88MkexIJZ7VpGMDZp9DCeqY4uEnqyzGiUxC7bKMLQHY=;
        b=zwYjybWiVqMyBtqy3JcY0pSmIOawaLQQYa27wdbMCl4BG5rWorSa6+653U3pvqi3H+
         sId3Dyf0mWhcD8RD1FZS4arfeQphO6Ynb8FGaInYUu4/gSn171ReqXbQx+cbmSwab2SK
         MjVyzgsnCX3W2ScrhtJfo29VFu/g2bYkZB6bHbXXXqMUglglTuC3TtitI+XQzdMAs4aX
         PqwsDHQMhh9Wgim6pExcxdBsqt5wsVbnqwRntqKPL8i4dzOyPjCon3EY+OdUCd8FRZLS
         +2nBV/Nmh/iBis8wwtJ3YkZG0+jAVTPSV9rHg6okUMkI1fBC9eGTvuEHU/ZJu1i7tsLr
         Msfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=88MkexIJZ7VpGMDZp9DCeqY4uEnqyzGiUxC7bKMLQHY=;
        b=lfwmg22XmR2UCp1tJQnnHghBu2JdiHc+qkbk2uNFm86YUv8Nsm0Qcj8epFFPw57KeG
         pJE9aO65Y97z4APUphBr2aVlcKPAkNOVHNDVNJKu1snDtuspddbw1wNWzRcDBCiNPoGo
         HEvjtUpwK6Xv94Ik3005fk1ZEjHpHNzwQQAy2nWEr/6oPdA94YVxt0+VlBPbsakenmjk
         1WnQxv9ym0En7ljlZzcuTisXuWKA8Lr3S9GDFij5XHKB8RvAeSkmYSuTlf/k32w0z9R0
         d15/eB8mn8rYvi82ugfPZePVqEhENB+4oOjctoiT/7o3Gw3ZbRUtXLj6gKNiXR98kKmD
         nF8g==
X-Gm-Message-State: AOAM531eIWrgu8fdfty7jWHH7uv401ZYeFgULb5hkJk2ivvsWcdkoq+G
        qHkevYlMX3gl8+nNJGQoWcjMHpOF4FjOwbx4
X-Google-Smtp-Source: ABdhPJyGQSGnco0fX3iHlWJG4Ae3xM0BCIAO62rqCEvvqc5W9G/V9/gC7Z6QREWRw125I1zFmoNF8A==
X-Received: by 2002:a05:6214:b27:: with SMTP id w7mr9457981qvj.34.1614957724696;
        Fri, 05 Mar 2021 07:22:04 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:4ce8:219:f731:dbf5])
        by smtp.gmail.com with ESMTPSA id e15sm2104410qtp.58.2021.03.05.07.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 07:22:04 -0800 (PST)
Date:   Fri, 5 Mar 2021 10:22:02 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: [PATCH 5/5] builtin/repack.c: reword comment around pack-objects
 flags
Message-ID: <de4715c7c75e36c446782107f3194a3eedaffdde.1614957681.git.me@ttaylorr.com>
References: <cover.1614957681.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614957681.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

The comment in this block is meant to indicate that passing '--all',
'--reflog', and so on aren't necessary when repacking with the
'--geometric' option.

But, it has two problems: first, it is factually incorrect ('--all' is
*not* incompatible with '--stdin-packs' as the comment suggests);
second, it is quite focused on the geometric case for a block that is
guarding against it.

Reword this comment to address both issues.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 677c6b75c1..6ce2556c9e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -545,12 +545,14 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	strvec_push(&cmd.args, "--non-empty");
 	if (!geometry) {
 		/*
-		 * 'git pack-objects' will up all objects loose or packed
-		 * (either rolling them up or leaving them alone), so don't pass
-		 * these options.
+		 * We need to grab all reachable objects, including those that
+		 * are reachable from reflogs and the index.
 		 *
-		 * The implementation of 'git pack-objects --stdin-packs'
-		 * makes them redundant (and the two are incompatible).
+		 * When repacking into a geometric progression of packs,
+		 * however, we ask 'git pack-objects --stdin-packs', and it is
+		 * not about packing objects based on reachability but about
+		 * repacking all the objects in specified packs and loose ones
+		 * (indeed, --stdin-packs is incompatible with these options).
 		 */
 		strvec_push(&cmd.args, "--all");
 		strvec_push(&cmd.args, "--reflog");
-- 
2.30.0.667.g81c0cbc6fd
