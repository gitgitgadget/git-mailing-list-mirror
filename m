Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D61C4CECC
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5CF206E2
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfVsd9m6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgD0UUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726825AbgD0UUc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 16:20:32 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341D3C09B052
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:13:46 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id e26so290563wmk.5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=IfVsd9m6+0hdqFRnQAmeZwNh3I5uWA52xx0B6x5ovktYoclw+3K9mhZKL9OSpoPP6I
         Hzg5NPKyPHjgvPebwt6LXvUj/gcs+iaqoPXnTjMD3WH5piL6TjFwZWyJS3xkbkfdopAX
         NoaP5nTICAZ3vPFRYxhb73tImf2pExnGirCB4kfckKk2LxyHI53SWT/boPa9SRJAwSMv
         T8eU13AIQ4tPJTWxrZhXI/tdkHZlZ8VAxhTUgAf2b+jiISL3H7z9UUKZATFFdD/8Okgm
         URkFspSt6wR0UZiwsp829FHr+9oBxV5raZIREo8QP4+OwJs7qkn87x6EMDmByk26wSLZ
         YjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=aD+DdgKLhYggpoBAbTLdB6nZZk3w5h+IPseUU6ySS4aQ6Op4Xl2L3tex2Q43kegDI4
         aw8B3+WeOoSsStOLvwBLRLO8MN543M/ZGm2RA2HYegGD5lZhyt8goCZWsWRl5Jh2O3Q2
         KOhHSsNeZ7+ogCAtjTI6KwMWeeo1FB+SQGtoQbagkQeDVIpI7fhKa8E98NvZ9Ex4WtfN
         +3EVX4CcbdWK4frHhmfgQedWfXu6PAy/YbWg7Q+Dfk9MRJ6V+XcwYt6rb/EdkNWWq3X5
         dwcHZMnAGMaHSr8hq2ewGCNY/465pPfio0xHWSAArIJJdnDRGazjQCc6moK5F0gZrbfg
         pnLA==
X-Gm-Message-State: AGi0Pub2mI0bxGgODenuy10Se3JUod5NK81vloqdqbiQzZKjfh7Spj0h
        BfQyvPqBt+33QHPSDa/K+Y6INN0l
X-Google-Smtp-Source: APiQypLcw0eYgRPOamMKNYOV7xagOjcetw29dnT2box5k9xvAAz+Dsa3O+ZormyQjHTQ+8znEa3lzA==
X-Received: by 2002:a7b:cdfa:: with SMTP id p26mr420895wmj.186.1588018424869;
        Mon, 27 Apr 2020 13:13:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h188sm391418wme.8.2020.04.27.13.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:13:44 -0700 (PDT)
Message-Id: <5373828f8546d48341d17b10904c8c0049e47d49.1588018418.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
References: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
        <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Apr 2020 20:13:31 +0000
Subject: [PATCH v10 05/12] Add .gitattributes for the reftable/ directory
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
 reftable/.gitattributes | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 reftable/.gitattributes

diff --git a/reftable/.gitattributes b/reftable/.gitattributes
new file mode 100644
index 00000000000..f44451a3795
--- /dev/null
+++ b/reftable/.gitattributes
@@ -0,0 +1 @@
+/zlib-compat.c	whitespace=-indent-with-non-tab,-trailing-space
-- 
gitgitgadget

