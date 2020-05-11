Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50E7C54E4B
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 894C8206F5
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOhkAbsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731502AbgEKTqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 15:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731477AbgEKTqe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 15:46:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77512C05BD09
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:46:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l18so12486679wrn.6
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4D690/NLx/9daAF2hWG5tCfDYzmNZsPcuZnuRxKSdQk=;
        b=jOhkAbsSgAW8xyh8lhDbD7tlVW63wfKZzuYCwGWrlHSe4MFS60Php7wqYA6lpjfcL3
         qyJATnVTWldXsFjTOHboOMJL35ffrNAZ3bw79GOh7aSsqYOycR/CRYv9RNsfbmGSeNty
         bipmuQh/vhV/ZUZ6bWAIQZ9H1xrVca08us6no5XoZONWlmQb1fKbwyNepLF8etobzaOV
         H1FGSgM3P/IXQreMQJo1atxZIb0PtVbg57/JtOZPAizFEFrWx7xXKzXaDwx3uKMDVji2
         uUouK1lxYLPU429yUqSJxjTMY+s5CkdiSvwVN4TE3S+qd5uh6tfMF2AMNixOIDUnb7H5
         Zg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4D690/NLx/9daAF2hWG5tCfDYzmNZsPcuZnuRxKSdQk=;
        b=Q+rmch27r6qnP8olJZAdtZBrszbodGiUC64lHqPAtL15mfwQDkhDa3D9H82iDE1wGN
         vz/ic9oT7ATivlebiGafDux5zuiUWtWwNGEbyzECCDISy1+d6I67drFtTwS5JIwfnsay
         uMjBGbZ/s/Zn9e+5UU8xHYsRWW8/ycAm88+gbrurSe4PT6q0qUj5r3Hb79j5jtoB8jHx
         1V0sCqDIpmmw8Ikmtw7J3PqyoS1BdFJ0/EJX1iyMsvMsZ4bRMiXBHf70MzQ9/2mgQDdA
         HJXA8wYUNaM5EhpRWHl6RanjQVtJ3PNw4PZQOM1HJSk47YCrok5xhmnGaZ7z5qUZJZPO
         SY8w==
X-Gm-Message-State: AGi0Pubj7hbTyHzWnk9MuGqOe0bQcQdyRqKDiMJVCHUv2mP0KUgHjORk
        YQkaAjU2S3jwvWQhbZHc0aVS3Cg4
X-Google-Smtp-Source: APiQypKhNBbpbf5xLUFOJiqWMMW1jSUX8peJvuVjV8SGkI4e/I0RbD0EFzsLp8ar50xd6aWO+Yc3FA==
X-Received: by 2002:adf:cd83:: with SMTP id q3mr8611661wrj.187.1589226393118;
        Mon, 11 May 2020 12:46:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n128sm1360603wmb.47.2020.05.11.12.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:46:32 -0700 (PDT)
Message-Id: <be083a85fb54d6399641ca634c432952aa95e1ba.1589226388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 19:46:18 +0000
Subject: [PATCH v13 03/13] refs: document how ref_iterator_advance_fn should
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

