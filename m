Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21C6C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B93502087E
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY7H5ugy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgD0UUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD0UUd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 16:20:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B68BC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:13:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x17so21322516wrt.5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NfPWVYm5oJnAy6N3ND7qYx88WtkIig5hT6uesdXdV6c=;
        b=ZY7H5ugylzlN7iV0UPATHw1LGWoGkDn+hDzmP37ZHivDT2VChLX3k5hWPDV3eRtpTp
         suFec1/kQOBgpEi0C5W/F/F4kmOCaXGE13gRlYZg73Etpn3aHGZsjoWwHBlnWZ2cMd6T
         tzLdNd9Iti1Xr6LRiB50NpWCqnc982MzH+LbjIwWyekow+GBEUhkflCJKLG+9mUMCUDY
         za29TJLAgJbC5MnmocWxQt/59HQlaBgHLGanlbtdVRHy1dhRG1G/aVJCz3jfo7x22SUE
         khknAL6SerlK+3lFO+m8ySNDVogerGFTlTItJ9aEQN1w5+QmTOBBAR9RcIihlmvOysW9
         612w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NfPWVYm5oJnAy6N3ND7qYx88WtkIig5hT6uesdXdV6c=;
        b=YzFgz7N6Jsiuyjwvfo1o2dSPzM8MvTvQutuqKnHZAJ6Ug7G6PElovLaVq7XHQ562Eh
         uq6Uu6ZHpFA3u3hKFOJndLy91u90EAcPvRcV1BX7ZfrI+eZpNW3aE2LAAuB0p3gMNZOs
         H7KA2L9rJgvXaaW50eJSLxf5OYT1lGeqJmA3zDtD48ErmSLoeJrNxgoyJwqxyHYjssvX
         NgoXV0fe+bz8EXY2mQzKWmsa/Q0tMWJkdLOC6iNi69QHtwPQ2ZZYNNMjsPs3q5/Ui1Tl
         U1bAMARRkjwoe93gVLCWPXgnVMDvtsYjN+Iy/mdMQ9LBZ7H5Ws4otnDuX0vaAzUEVfpJ
         I7zg==
X-Gm-Message-State: AGi0PuYtAL9LWQ9IczybSwG4w/W3xV8QgP3KTabQVRGvgB+ukeDdWiVt
        QnwWaUslU6d5FFwJ1XErQXL0DYDf
X-Google-Smtp-Source: APiQypKS/XsArUH2TN1JIymu6FnNyv3hZ9WGvulWogMib3WZtA97xWxhGoWVugI62J+yCkIslXaefA==
X-Received: by 2002:adf:afc6:: with SMTP id y6mr28110708wrd.74.1588018420717;
        Mon, 27 Apr 2020 13:13:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7sm304900wmb.43.2020.04.27.13.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:13:40 -0700 (PDT)
Message-Id: <d3d8ed2032c1c720a200b64e40399b461c440f36.1588018418.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
References: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
        <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Apr 2020 20:13:27 +0000
Subject: [PATCH v10 01/12] refs.h: clarify reflog iteration order
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.h b/refs.h
index 545029c6d80..87c9ec921b9 100644
--- a/refs.h
+++ b/refs.h
@@ -444,18 +444,21 @@ int delete_refs(const char *msg, struct string_list *refnames,
 int refs_delete_reflog(struct ref_store *refs, const char *refname);
 int delete_reflog(const char *refname);
 
-/* iterate over reflog entries */
+/* Iterate over reflog entries. */
 typedef int each_reflog_ent_fn(
 		struct object_id *old_oid, struct object_id *new_oid,
 		const char *committer, timestamp_t timestamp,
 		int tz, const char *msg, void *cb_data);
 
+/* Iterate in over reflog entries, oldest entry first. */
 int refs_for_each_reflog_ent(struct ref_store *refs, const char *refname,
 			     each_reflog_ent_fn fn, void *cb_data);
 int refs_for_each_reflog_ent_reverse(struct ref_store *refs,
 				     const char *refname,
 				     each_reflog_ent_fn fn,
 				     void *cb_data);
+
+/* Call a function for each reflog entry, oldest entry first. */
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 
-- 
gitgitgadget

