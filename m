Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5BBC433E3
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C9D0204EC
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQuJWExg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgF2S5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgF2S5G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:06 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2604FC031C40
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so17595868wrw.12
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zHBnFxcXmIhbuXWDyq7C4Apz59yuLdmvC+zAsiN2Q/M=;
        b=pQuJWExgD295/VJjPz0gVEg+YYX7V3Kn51W7GB/Jqhw0lBXgHtyZJMX5VOFMJlObt1
         NuZ9akRuPniLDCIeRDW4draFOhr2AUqzZwAQwPpCBdX8Bq7X8yGx6IKMY7CkBQCJcJK+
         V7I6fUl6FHDSHZsth5jw5qVfr4zo/uqJuWFv06rp+ybBJ5drpRq3eZ09xy6+z9s70Th4
         NL/ISD4zeb8YM+zaVx0ACKCuoPEMOJNbkH0G9K3Do3oJf4YYBGChz6YGUBO2eesFcJNl
         BENGG+ijVYBrpMK4Pua246HYnneK+tfKkvWAqA9I1Zp8fWjqnvh/z+81ZL8VhypelgEZ
         bH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zHBnFxcXmIhbuXWDyq7C4Apz59yuLdmvC+zAsiN2Q/M=;
        b=NXvFnJXocy5YwEKiVAL0HQieJvZamWzyhxGBoC5UjCgCtn9oXj5SXlsn6Y3BtKkDPv
         uUlVXkheAbyzFFHl7mEoQUy8YvZjQz5JVfJmIskuS2pZ8QXxzGWu+uVgM9+bIhUtnFzv
         wugOCNAiZoAcyIRgUys5BLSg+NGMXTgz6dCoescGUbKCMOZHJBoez4JI2lCZfb8tcnRB
         +l5wXcoOwH8zFhrCIH9jqBBVKd8VhDEPQFJ66LIS67pARRllJG7hWgwUyrmv0ObXM7c1
         iWVmx+GVfi6yvjuifbpWK3r80YcQiAxCmMNvwhs5m9ANO2kK2qxu9n608m15rif5jVLj
         C6EQ==
X-Gm-Message-State: AOAM530hIXR8Z33Wwi6ytMZyqdjI8J3DH3AdzfZzMsVnmB/aBn5vQf6e
        c6rnDIusmEJUk2eJOaBKtX0ah+4/WJg=
X-Google-Smtp-Source: ABdhPJwpJfg7iCx5nLDl0Xdxlq1+2Pd8K58vd5LEpYsA19t28yW3+Axa1IgBOwu3APb22LMh8D05tA==
X-Received: by 2002:adf:8444:: with SMTP id 62mr17494933wrf.278.1593457024805;
        Mon, 29 Jun 2020 11:57:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d201sm749952wmd.34.2020.06.29.11.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:57:03 -0700 (PDT)
Message-Id: <c8cf2d2ce11855aeca9e33bdd372722b5436d71e.1593457018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
        <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Jun 2020 18:56:43 +0000
Subject: [PATCH v19 05/20] Make refs_ref_exists public
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
index 1e9d893191..0363ddbeeb 100644
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
index 9ad1400aab..e9916ca6f0 100644
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

