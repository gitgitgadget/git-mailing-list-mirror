Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEEEC433E0
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB54420767
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTI1WmEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbgFVVzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730820AbgFVVzk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 17:55:40 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0EAC061573
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v3so10847054wrc.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=HTI1WmEluhBxuLmOANWhhXP4aLdrmi1zmv8hqiSOKWqtdIlS10pdB2Cz4wlaSEfwqH
         A0hRdAW8oF7Eu0cumgivakCzdO377RBcRNof/gwkJNJZRUMiRP6UhgDDGNwcAW+3iuhp
         Zz4Aik86L6cjwLCHQ/JCI0FBqMCjaUtk3EomrfFdilIzNLnwxvikLdXlY2zY/Vp5XdI7
         bpPg5zDhClZzPJ20Ws60M35Q2W8RpsSnzopYCezVSLHYng4Mmzw9Ti6mtg+a/TuOOcvU
         dSpTVLvNXYP7AzDSm9aGOjPYP1w9Cqgdv4crP9Sw1vL9Hi1rKv2LjZQay0+3XrdUxRWb
         dzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=YlfKyXbjTywvFnZjjeG65nsA62ge0UD1GS86+v9a+pgmhh9oYcaukKY2LpHcetiv5G
         h5HTVdmmNR/BRVt3o8DcyA+hVeEV4vi524RALO/O190ZQI/vp7xRrw4u8mIUYl30WtkS
         vQKUCp2XA73WVRZ2YiCNo25Cjm7CBawaOJnpVY3Y+lhCqJ2giGt/HZdFXyOjC7bExn0J
         PUQNEj5mNxhnkbnB3hSVEwS84n4L4GRhjQlTazJNdXjLZ6PTr9AvYwTH6mJjwvZgZqxr
         7w4S2cyNpxr3nKRDLFOqZQuyYUOONF6ZI85owFJcWJe2jocmNcLOI/kbBTV9Icc+ZGVe
         va0A==
X-Gm-Message-State: AOAM5317dyNKZmENXQLbmbjryHn+ctktL4PTIFjfmizqklTzzMNqyFRw
        P1gnIL4X9FHp3IE8U2OtQ9Xr7Xrb
X-Google-Smtp-Source: ABdhPJzCU9EZg8QHjMUpZvPbHcY7XGRwYGHDnBzr33KJf3drXO+yG0nCV4j5T64nUrbMkO8+QOC6cw==
X-Received: by 2002:adf:f14c:: with SMTP id y12mr21092407wro.30.1592862932064;
        Mon, 22 Jun 2020 14:55:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b201sm978225wmb.36.2020.06.22.14.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 14:55:31 -0700 (PDT)
Message-Id: <21febeaa81fcba14b090dde34e876513cd9be610.1592862921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
References: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
        <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Jun 2020 21:55:11 +0000
Subject: [PATCH v18 10/19] Add .gitattributes for the reftable/ directory
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

