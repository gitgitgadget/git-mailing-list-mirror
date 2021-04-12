Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F219DC433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA9A361358
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbhDLTc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 15:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbhDLTc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 15:32:56 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A54C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 12:32:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g18-20020a7bc4d20000b0290116042cfdd8so9362429wmk.4
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 12:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=nDo9WqCd+V83tWwaUusi1upKAL13k1SdsCBud2tl3EY=;
        b=dkd+QdERRU1glUY4YsbZR//TqGJIUK1LvVmy9KILUg96uIQ+OFTd0B3uVgXZNlql2K
         b5JvHMUpAHDn7lNP3R6bKZGjBhhhOa+x6GnkX28wjxltFLbNSLCtJntiHa1wIVWWxt5p
         AqL8jovY+M4OGakiQ9to/cxhezoqKC4Re1gi95IGoaAPJEYf9P2no8LOUgvAA1FbeQ/X
         foBYsVlWznyxhrPaMbyhLONstoSDnugpojRxyoQPZFxdOfLvS2UEs/hihasIHueY1G4H
         llAu0bKHCCtp3K1Wkj8E5GIuBmwmdecnrwGT6oaxJLhtm49U/ZD9GJrCKVPVT44Bmome
         O8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nDo9WqCd+V83tWwaUusi1upKAL13k1SdsCBud2tl3EY=;
        b=V3ZYwaz3zgFzW6poWd457wieUEsuALdqRtuGpILeqjIdf4V6am9tgr+gKn6mLmuVMz
         joBm+13BhD7QeennFPDJS/TaHcnC0EjSAv5JxaAlNzf181f/BKNUHavDpifUAbee+x4M
         F+aeXQvlPmUfTMEmZQM5yg72lHibMQ6t0fmp5sOlLHFr8LUSmi4zx65j0Vs4Oqf0D3eI
         CsdptXzAVhmB1G1JFuSz9esJz4jUzPi0hZC2pP7zVvoFqx9VzrRwdYRn9objhXihB2Y7
         Zmrs3CSc73Nh0YXkzXR/2LNrc7pR+xckcmGMXrEgrjKLF06wSyjU9/n8H1LnDFTY4KC/
         Uccg==
X-Gm-Message-State: AOAM5319+YgvH5f8uNC3KMbiiacsu7ewsT7TDcnFOLOHsim1/9ia2Rg1
        MEHcJWVS7HYApYYc3FPjxR7mowjyKW4=
X-Google-Smtp-Source: ABdhPJydJnonrVP7ecAvcy1xt2qCgAcJ8IK+LGv1+9cp8TnpdQ+HTYt7jT9X8Jwqp2oorvZmcHs6tQ==
X-Received: by 2002:a05:600c:4f8e:: with SMTP id n14mr629208wmq.166.1618255955513;
        Mon, 12 Apr 2021 12:32:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e9sm10288238wrs.84.2021.04.12.12.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 12:32:35 -0700 (PDT)
Message-Id: <pull.1002.git.git.1618255954484.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 19:32:34 +0000
Subject: [PATCH] refs: print errno for read_raw_ref if GIT_TRACE_REFS is set
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The ref backend API uses errno as a sideband error channel.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    refs: print errno for read_raw_ref if GIT_TRACE_REFS is set
    
    The ref backend API uses errno as a sideband error channel.
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1002%2Fhanwen%2Ferrno-debug-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1002/hanwen/errno-debug-v1
Pull-Request: https://github.com/git/git/pull/1002

 refs/debug.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs/debug.c b/refs/debug.c
index 922e64fa6ad9..576bf98e74ae 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -244,6 +244,7 @@ static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	int res = 0;
 
 	oidcpy(oid, &null_oid);
+	errno = 0;
 	res = drefs->refs->be->read_raw_ref(drefs->refs, refname, oid, referent,
 					    type);
 
@@ -251,7 +252,9 @@ static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		trace_printf_key(&trace_refs, "read_raw_ref: %s: %s (=> %s) type %x: %d\n",
 			refname, oid_to_hex(oid), referent->buf, *type, res);
 	} else {
-		trace_printf_key(&trace_refs, "read_raw_ref: %s: %d\n", refname, res);
+		trace_printf_key(&trace_refs,
+				 "read_raw_ref: %s: %d (errno %d)\n", refname,
+				 res, errno);
 	}
 	return res;
 }

base-commit: 89b43f80a514aee58b662ad606e6352e03eaeee4
-- 
gitgitgadget
