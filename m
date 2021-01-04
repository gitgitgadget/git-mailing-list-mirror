Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E48C433E9
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4538220DD4
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbhADDKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 22:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbhADDKF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 22:10:05 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A388C061796
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 19:09:25 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k10so17228951wmi.3
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 19:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F5mr/fFvRdXYRRCHVaEtFFWbeGwbu/OPMWpaJOKG0T0=;
        b=osDl8CwNuTo3u2SVbVa+6BDdhz8Mgz+ATIaqyahALjt8UTcuOEinKN4KbDZMqi/Kc8
         T42okljt8b6w6nF//BpsxIheQU6RajXHGQvhKPlPo8PbbI1eZ07xVAL0456thgUJZfnX
         ChfM5ln4YmGz2P7MpypUdxBH/NbdSBjEOgyp0SRvUEE4nOSMhUM2U8wJfFDShbLApFB/
         IW5fDkVqidZPSAABgpPoSRyuspnpS2JP8L4V9ZT0s1UMMFNTFctQQvuK3tkDt0juP5fz
         I0kbwji0YwERCO+AjidUwo5sOxDo7FWo4VG3tPaVjqhhbUsrvbgjnhbdi/gOz4QRPl9v
         rEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F5mr/fFvRdXYRRCHVaEtFFWbeGwbu/OPMWpaJOKG0T0=;
        b=D6ahSR8u+ORw/2FvQXK3VXAoxlqycfythbYA24t3x2g+jTYe5hIoOQJLXTiY1RGqMT
         kE+qorXBYR7MR9oAJl/3pXudYuXvUVi6+HEQVySjt+1TrlRKdFQJ3phhh3AFqicS0VBy
         3xIV++npmgBbjUuwTCQmMy9pgYt2Vk3YK10Hgr3dDlwJ1fI5NEItH19l6Vs7BJU50Vq8
         ryYV3X6+VIDBVO0UTUySRQLUP2iS9gnGm+JOAWkhMooCsfUftmfbPsOSJUrVRHcqBaOq
         4030eUgFYzI+OrMetE+ClGAJdwhIgeq0AlYtTSWs2W8IrTI0kL2fA6I+AQyuku3phWR/
         Ll4Q==
X-Gm-Message-State: AOAM5325j6IHswAN4x1tLWF4paNIj9wOiuSzCwBP9/9MxkFKdqHdqeeG
        zBn/EWFQIaq+OyTWryd6ltS3tJwzVLk=
X-Google-Smtp-Source: ABdhPJymsQRs6PFxGTwS3LjkH8NjstVV6PUEV979mHnuOODyFnAjzku0Bk2AEyjdH8Cm11WqKw1z6Q==
X-Received: by 2002:a1c:2394:: with SMTP id j142mr25224843wmj.42.1609729763653;
        Sun, 03 Jan 2021 19:09:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z21sm30511451wmk.20.2021.01.03.19.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 19:09:23 -0800 (PST)
Message-Id: <1d8a797ee2650e8c815281b0c672301c7f24a724.1609729758.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
        <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Jan 2021 03:09:13 +0000
Subject: [PATCH v2 4/9] cache-tree: trace regions for I/O
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As we write or read the cached tree index extension, it can be good to
isolate how much of the file I/O time is spent constructing this
in-memory tree from the existing index or writing it out again to the
new index file. Use trace2 regions to indicate that we are spending time
on this operation.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 9efb6748662..45fb57b17f3 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -494,7 +494,9 @@ static void write_one(struct strbuf *buffer, struct cache_tree *it,
 
 void cache_tree_write(struct strbuf *sb, struct cache_tree *root)
 {
+	trace2_region_enter("cache_tree", "write", the_repository);
 	write_one(sb, root, "", 0);
+	trace2_region_leave("cache_tree", "write", the_repository);
 }
 
 static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
@@ -583,9 +585,16 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size)
 {
+	struct cache_tree *result;
+
 	if (buffer[0])
 		return NULL; /* not the whole tree */
-	return read_one(&buffer, &size);
+
+	trace2_region_enter("cache_tree", "read", the_repository);
+	result = read_one(&buffer, &size);
+	trace2_region_leave("cache_tree", "read", the_repository);
+
+	return result;
 }
 
 static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *path)
-- 
gitgitgadget

