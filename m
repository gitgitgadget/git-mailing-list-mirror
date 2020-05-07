Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C751FC54E49
	for <git@archiver.kernel.org>; Thu,  7 May 2020 09:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ED212083B
	for <git@archiver.kernel.org>; Thu,  7 May 2020 09:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5I8SLW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgEGJ7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 05:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725953AbgEGJ7u (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 05:59:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C46C061A41
        for <git@vger.kernel.org>; Thu,  7 May 2020 02:59:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so5627662wrt.1
        for <git@vger.kernel.org>; Thu, 07 May 2020 02:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q9NuaAvYc4TMXl8Vc00eXBn/gp7cRyZftwBh5NUsgbc=;
        b=R5I8SLW3+I0/zsZxaIXnd7yLLGz9cxgXTM1VZKjKQc/MFUoAFSoMw+UFYhNfG81jz8
         dKq19QZstQ8weuW4nc13WDI00MUIyJloTKpXf3fsdd45oWhDPVbf3AUEnzKRvc+OJpB/
         fKD3EDu3OlLNqbZtKswJ0imAWHru0mO/I7Xn/P00+1STLfTA5Ul9UFEpyMzsicx0qScV
         AjYlAfx0YrqXCCDrt9Z5TRzPtCTkzqu5PLcsf63HtHQHoypIBDTKf71qtakjCkTET27j
         o6/k5X5srJJ4n9rTUxQFPYxB3oPZOqPkPjJL8/oGomp1WmieMmLT/KLovTohwLQHFYeS
         Ztaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q9NuaAvYc4TMXl8Vc00eXBn/gp7cRyZftwBh5NUsgbc=;
        b=fvrgNguF/y2rUs0XD3u1CY5W1s6HV7aOojLLo11zYCk807xkB2YxxqvCurYusKl04O
         PXA5KNSrFBg8GPH4SWIr4xEsOkbuC9YI3XMj6Q3SwhC+cHYKVb+db7H4IInRPy6HsRgR
         GfxhVkFoQZ88OgS8m/aL2YO+/GGXMe6KmP0hTDbrjO3JJsSBbwLbH98PbK/TOehc05oa
         0qBogJCIU4P1DOvgP2WOYRjhdvgEpxo0+wUnBkVxCaV2n4Z6O20UhBu6WHb8cYqvp0Ar
         ZFFLTCWB9sEZ3YjWzQeOLjwUGcpGSyz+intciptX9xn6fTFQF2BXPhQMANH5MAHDP9yV
         7f9A==
X-Gm-Message-State: AGi0Puac/MrLITc0yehpvYaRK4pZ5mo6GCtSrk71OP8m7dx4Yja4wUip
        Rp3JdgigPT45HwDYok5OloAhQQew
X-Google-Smtp-Source: APiQypL0ZhXp/aCtMTBToTiqUE/otR6fIumf4Dp+yDCBAVnoJPRgU8oZPvAcQYrJLx3c9mJL6yKZhw==
X-Received: by 2002:a5d:610e:: with SMTP id v14mr14196917wrt.159.1588845588876;
        Thu, 07 May 2020 02:59:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v124sm5323321wme.45.2020.05.07.02.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 02:59:48 -0700 (PDT)
Message-Id: <dfa5fd74f859b2186d0222f98417128c52903fe7.1588845586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
References: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
        <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 09:59:34 +0000
Subject: [PATCH v12 01/12] refs.h: clarify reflog iteration order
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
index a92d2c74c83..9421c5b8465 100644
--- a/refs.h
+++ b/refs.h
@@ -432,18 +432,21 @@ int delete_refs(const char *msg, struct string_list *refnames,
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

