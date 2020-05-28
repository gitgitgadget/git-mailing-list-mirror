Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4680AC433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B66207BC
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7uTqmkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406728AbgE1Try (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 15:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbgE1Tqz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 15:46:55 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A00C08C5C7
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:46:55 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x6so424006wrm.13
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sD08nvPKEureMPWUl3ZPXZUlGgVzCFnRDJ8XWySzO9I=;
        b=q7uTqmkvnLmrzalMwyi9x8N1JIY1VPy6z6ZFuRcjuFA4S1gPU3cC83sPAjge5EGGur
         rCdyVRrJ1o26cJ9fE7CVk5YpgBZePK87UyUfFpurSJWTjBoq8nUxIln3fcto9E6rJ/Dv
         LwY1uUxicDzegJPDAR6WpqRMvMF6oxic/ITSJ5cnUqS38DfEI/ybigzR+OBcSjrNxLut
         aoW/+nO2duis3SBNgh2LIrrtwJ/WPd6ne0ThdRs8yRYTuERHoA/s4FOfxmwn4Z+H6sc/
         CZvLgDHaC5yH8vm9vanUXbmw5OpOtyLaKBFWnj59C5O83WaQfYgLUr7JkAIdOgoBX/Vf
         l0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sD08nvPKEureMPWUl3ZPXZUlGgVzCFnRDJ8XWySzO9I=;
        b=lMPp5Oy22DI6uvtMv8kEOKyIj8HdfF/C7FQm0DIRNKCfPCopqWqGpeiRttkLZ1a0mD
         8UG78JWYh/Gey7ipzwkmruWL/Q0oXtn6YGn8w8pERz+uKu1F88xKV30IYELxUhOYSW/5
         lwqw5AQzkPAHXUFHC79wNRJu5F4UwxgpPHOOtHdvapI+zqf0HLFORSAaaTqssRPU2WPr
         xpoT4zR5B/Dz9pugeZTR/dorYOrJxw5ad73T1oAWCDj7ejWu1/U5oa66IS18EUQ8vWx8
         ZKAwjGK3dy9zW9EL86Z4hCC5hWh4h9lwUu5Ruy/KyZtuHsarT20C4ZJoMAF0hVs3IgVY
         raOQ==
X-Gm-Message-State: AOAM531nzIzIE8RAcLtmm4k0A/XnObixLpLsC93WYV0Y1ZCyn3cjG6eA
        lBiK+0kDAATP+D8OQW9ciJaeSI2I
X-Google-Smtp-Source: ABdhPJyaRl7mQAb3iWFSezNDbY+X0Nb3AtBRptKH1BMCyJv5oJ5JdEEa1cJDgNsFq47jJJ3yo+pPTg==
X-Received: by 2002:a5d:4987:: with SMTP id r7mr4868875wrq.316.1590695214040;
        Thu, 28 May 2020 12:46:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x24sm7339804wrd.51.2020.05.28.12.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:46:53 -0700 (PDT)
Message-Id: <d489806907bf55e88ea66d3ca996687c4ee3b207.1590695210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
References: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
        <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 May 2020 19:46:38 +0000
Subject: [PATCH v15 02/13] Make refs_ref_exists public
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
index 12908066b13..812fee47108 100644
--- a/refs.c
+++ b/refs.c
@@ -311,7 +311,7 @@ int read_ref(const char *refname, struct object_id *oid)
 	return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
 }
 
-static int refs_ref_exists(struct ref_store *refs, const char *refname)
+int refs_ref_exists(struct ref_store *refs, const char *refname)
 {
 	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL);
 }
diff --git a/refs.h b/refs.h
index 4dad8f24914..7aaa1226551 100644
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

