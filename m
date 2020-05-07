Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4783BC4724C
	for <git@archiver.kernel.org>; Thu,  7 May 2020 09:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20FCE21473
	for <git@archiver.kernel.org>; Thu,  7 May 2020 09:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJhbDeBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgEGJ7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 05:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725953AbgEGJ7w (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 05:59:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DF2C061A10
        for <git@vger.kernel.org>; Thu,  7 May 2020 02:59:52 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k12so5750546wmj.3
        for <git@vger.kernel.org>; Thu, 07 May 2020 02:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4D690/NLx/9daAF2hWG5tCfDYzmNZsPcuZnuRxKSdQk=;
        b=cJhbDeBUrqc6CbUIh7lVL49p6M+VnEOJrJWPuepufJyPpprPiP301gttyYPnW73kXC
         DngxfZXvWf408mT5Fe7SlPR/r2XRAO0CNgPhtXs4QwSdp6mb3PVDZLmF40eVj/ZfALKv
         zo/k0xO4VmrF4AAyPtSpmWrA1fgVngntn7L6LxX/17VkebUg7zu0AFz+FdkzbhjPKJZs
         DyOr+D2KnzTkYFmgJwsJgnhcuDC9ajUGhaHMSUvNnY12HeQCtOI6D25PqIsQr3pVtzyY
         GQ67j1cRYgRHqcU2STkAvEwel8mzYC2W4ZVycQW6I2wCKxPi7pnNHsQlgRN5/f2E1BVw
         NojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4D690/NLx/9daAF2hWG5tCfDYzmNZsPcuZnuRxKSdQk=;
        b=Npo439zjWcZaSmQzNKj+tl6xCeNzFEzvfy7dubM5AlbBnapUCvekiZowZv+zEDcoeJ
         nxtfo0ctTEjJUZLUgpRhKJYqX0UmJ3ZEoI7LyQsqB+8EGn6ywfuX7UlcfNG0f9LBpk2S
         4AxGnDLJ3BwZLke0orJNIQhHTAreeAmELYzHTY50JDv+tgAsS2nSSHglVjg/drN0f4OB
         3JO4U2WMzDp0dc0+Vunrb6h2R5uzB8cp73YbCjjcptz+A2jowuoO+rXIBjFTNBw6bCsn
         GdfexXztLq+Ah67GZiZiLHllhN9sx9avVZcbGTr0KmfRUBequYOVkWncIqidfk/1V+V3
         DHow==
X-Gm-Message-State: AGi0PubnF2U68gcd5FTsZFpI6i9HyyKvcaLUOS+VsZd4Wg7WMrTrd67Z
        ccraxdeMsVB0Kjx3HSpXTL/1Yckt
X-Google-Smtp-Source: APiQypIDwA8kAhwFWShHYGHENMA0+WwKX3kQikBBZ/jDMmD21md6X+h7Wv2IriZvGJ3T3GzsmbcwUQ==
X-Received: by 2002:a7b:c766:: with SMTP id x6mr9823975wmk.142.1588845590623;
        Thu, 07 May 2020 02:59:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a24sm7198386wmb.24.2020.05.07.02.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 02:59:50 -0700 (PDT)
Message-Id: <6553285043b2f004cca646aefd59c509324d4da3.1588845586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
References: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
        <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 09:59:36 +0000
Subject: [PATCH v12 03/12] refs: document how ref_iterator_advance_fn should
 handle symrefs
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
 refs/refs-internal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index ff2436c0fb7..3490aac3a40 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -438,6 +438,11 @@ void base_ref_iterator_free(struct ref_iterator *iter);
 
 /* Virtual function declarations for ref_iterators: */
 
+/*
+ * backend-specific implementation of ref_iterator_advance.
+ * For symrefs, the function should set REF_ISSYMREF, and it should also
+ * dereference the symref to provide the OID referent.
+ */
 typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
 
 typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
-- 
gitgitgadget

