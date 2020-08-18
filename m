Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA3FC433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 12:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77CEE206DA
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 12:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/a25xmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgHRMSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgHRMSA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 08:18:00 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01677C061389
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 05:17:59 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id t14so16768983wmi.3
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 05:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Sx6CMLrWHoHQdFj8ZnUXjNm80mJffZ/ZFDEc2Snpvws=;
        b=d/a25xmKkzway2fPZJYbCF8HIEw5Q0HnHLA6iRITRvMBPW51LfNdvoycKf3UpMFON2
         svb5vYzOn01ZMH4a5SBpGHXjlqgu20LqfE9zsLPNlzqkLdQ7S6s5H9F8wKFqTTzFq/B5
         Wmz0kiyj94YJ9ZnjKkdSOlKA8nu9RF0LFt8sEmxj83Yptm0NZoGrWztSmnsBk5OMxi5g
         kwJOWcM1lQ/mnmnc3KKqYXeL9GUW3Tr+HfDKCeQd1VlmJp8FVrFYeQNsPB8Lq9Xlfdpo
         aZRYZA8GY1oIfn7f9KVIRUkzfN13jgV30P95AK+4HG0OsVRNRwxfdIEc6QmIoZthME5x
         Ro9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Sx6CMLrWHoHQdFj8ZnUXjNm80mJffZ/ZFDEc2Snpvws=;
        b=UAre/+ESoRhKdf9KLGuQzw0rnoP+k3GmnJ3srSx9NjC5TjxISj+vg8WuKvN5gCu02Q
         JgAuzf3RPaMrUVXnxjFlZSILfxLVJ7TEFvvRVsRDpsCNYPB5F5UPwgR3cnUK8Pof5ox1
         dA5FwIv8qzdaNw9x1Wf3vrBhWvRcBd0TV54s6xHlxc7Abc0tHYg5tRKekK2GP1rsD1RR
         LgHJuBsq0VTXCzCUlcqubQZ3NRAMYJi3Tnqtx51vbCTTJNsrI6Bc4MSTK4Tsrtatvz7S
         JEt/wkcRSQmyQWmQAFBl3cgY61ciVpR1fhu6rJbCvIAMnx6qmbnoEDkn6t6VMv7s8+fn
         e0EA==
X-Gm-Message-State: AOAM530QTS88zL5UWTEIKUOctR8XjeTYb7giNn2/ypY0puknP0AXF1Of
        ja+eqFw/AkryWeuv5xTlEmJh4p7v/Vo=
X-Google-Smtp-Source: ABdhPJzm/52eYmFlNMoXB7luMaVVADqEgrb6UvdKQf7YU8I+PHgBnuPk/I/kN9Zns83Qh57jxnw4ug==
X-Received: by 2002:a1c:1f85:: with SMTP id f127mr20373777wmf.154.1597753078074;
        Tue, 18 Aug 2020 05:17:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17sm35891048wrc.42.2020.08.18.05.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 05:17:57 -0700 (PDT)
Message-Id: <5e29fa74dc70b5e36ace27ed6d83060cf0925681.1597753075.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.706.git.1597753075.gitgitgadget@gmail.com>
References: <pull.706.git.1597753075.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 12:17:53 +0000
Subject: [PATCH 1/3] Make refs_ref_exists public
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
 refs.c | 2 +-
 refs.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index cf91711968..d46080f4b6 100644
--- a/refs.c
+++ b/refs.c
@@ -313,7 +313,7 @@ int read_ref(const char *refname, struct object_id *oid)
 	return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
 }
 
-static int refs_ref_exists(struct ref_store *refs, const char *refname)
+int refs_ref_exists(struct ref_store *refs, const char *refname)
 {
 	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL);
 }
diff --git a/refs.h b/refs.h
index 29e28124cd..04bd25019f 100644
--- a/refs.h
+++ b/refs.h
@@ -105,6 +105,8 @@ int refs_verify_refname_available(struct ref_store *refs,
 				  const struct string_list *skip,
 				  struct strbuf *err);
 
+int refs_ref_exists(struct ref_store *refs, const char *refname);
+
 int ref_exists(const char *refname);
 
 int should_autocreate_reflog(const char *refname);
-- 
gitgitgadget

