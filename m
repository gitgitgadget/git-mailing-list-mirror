Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC037C54E4A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 09:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4EC821841
	for <git@archiver.kernel.org>; Thu,  7 May 2020 09:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbtoozfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgEGJ7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 05:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbgEGJ7v (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 05:59:51 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EBBC061A10
        for <git@vger.kernel.org>; Thu,  7 May 2020 02:59:51 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so6068358wmc.5
        for <git@vger.kernel.org>; Thu, 07 May 2020 02:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XTW+S1tjt/UjHTmSLUWWzSNcFWS/aoQftFrdnmqTgX8=;
        b=mbtoozfL454sO31w/F3AZA8UZ6FpXT4+sWo//8XcILkaZlb4KeFCaTp3Mo7I3ZV32a
         wrJgQBWzk7smKsJT1hBoI+ZMf/TJCQ1gEJmA75M6ySfRbcdR0bk3sTI4xpYIWuCN15Dx
         7y2/m4xV55z/TQlfRKe5RuZMqqyGb8nOCb++uXH0D+bEDR/iH+97mQLdU8S2V9ocynZt
         ymdofpI4x9v5ifKGmLwWz9JFkFdE0q9h6d8rfzSx/ao2L6MVOXerNH429tMkiD9qsObB
         Ae3ji4c8bjIuhXgtwMZcmNkv7Mmo3Zg1oY6OjcLnVkXJAseLlT7H+f+Zu8BfwIAPi5Jw
         oO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XTW+S1tjt/UjHTmSLUWWzSNcFWS/aoQftFrdnmqTgX8=;
        b=mnLZ5LVf/FExXCjX4Azf7ETKZ1IApxI5C/5lKlFHW2eFnqhlW5cJewZrEw5wlZ5ABn
         gh3RH/FlarkZeAZnOVR+wGYFua2jWD577v/WcDtT7Bvdz0do4jfDD8lCjZkI+QWVVsP2
         noZoMl0dNohCXL/cmcANlFW3Zh8/IRGuT+v1EOmwVBq1RnXf6LX4hk1Id+ksWniw24u7
         MfJwafc8DToNl1tv3bBSz+e6RJZGweXzr95EZlXSDG9/u1cx+tXBhEG0GvkAX8gIJHuX
         JkAVpOj96pr/g3H46xa2KPinKTdNW1qAJ7rdbVipOo3BPKLDRxM1Z95xhAZeSpg70MuT
         znLA==
X-Gm-Message-State: AGi0PubFWdpceUgFDOyGPSr9XkJX81U3Dx0iuSbR+SGh8j24LKd7BM2X
        jaeTVOYYUImDVmqXnhxuNAnVe14S
X-Google-Smtp-Source: APiQypLK1BRrN1d07KgLL492DQ3cEzclldXUZUBtMyb3ndrxo1TysQFEKxEc+XjbYFDsWzbgJPzSDw==
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr10044851wml.55.1588845589830;
        Thu, 07 May 2020 02:59:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6sm7227471wrw.97.2020.05.07.02.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 02:59:49 -0700 (PDT)
Message-Id: <340c5c415e17a957b8a38932215b1179fbe68dbd.1588845586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
References: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
        <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 09:59:35 +0000
Subject: [PATCH v12 02/12] Iterate over the "refs/" namespace in
 for_each_[raw]ref
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

This happens implicitly in the files/packed ref backend; making it
explicit simplifies adding alternate ref storage backends, such as
reftable.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 224ff66c7bb..4db27379661 100644
--- a/refs.c
+++ b/refs.c
@@ -1525,7 +1525,7 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 
 int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
+	return do_for_each_ref(refs, "refs/", fn, 0, 0, cb_data);
 }
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
@@ -1585,8 +1585,8 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0,
-			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+	return do_for_each_ref(refs, "refs/", fn, 0, DO_FOR_EACH_INCLUDE_BROKEN,
+			       cb_data);
 }
 
 int for_each_rawref(each_ref_fn fn, void *cb_data)
-- 
gitgitgadget

