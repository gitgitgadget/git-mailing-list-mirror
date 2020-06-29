Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78068C433E2
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51917204EC
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwWH0qOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgF2S5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729633AbgF2S5L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:11 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908A3C031C41
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j4so15187819wrp.10
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+Z8vEIBY7dqXeqqNBUPsNw/E+iUxatUcmVMbFcKVLzc=;
        b=rwWH0qOwv7jSejQszuty7aGZPI3YRU6BoOQ+m8by/e5qPHy5Xz3GqkwxkEcgpsCuIF
         h26LXOxkpQ8NkkPTf9NPxBWRH0dEzBUGw9NbQWy/ynWnLdCMuu/1/rRHOu8p/aoOPikg
         AcenYe3Ya3yuQOiWEe40SUG0OPSwCXCVdUVZjg0UK80wp1g2nXNdBRLEqrFMdL7h1/fi
         TxWgSw03ljpMUuXd90nIur2L3MJqk6guTYcOC6jgrjUiYnyxO2NGYT4Y2deKKdV/DuSe
         AfkyPVMw4wGFZ31ZyJIY7jh1wb7kRDzwcV9NkWVALsZeiWepHKYh0IFYmbs1D63wooEs
         zESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+Z8vEIBY7dqXeqqNBUPsNw/E+iUxatUcmVMbFcKVLzc=;
        b=pjQYqlMLZ8hawxhA/7RO9vlo3NZ9DPsDF+B3UbrHmAqDJVkZ9eTvcB1kCnUEcHteKw
         GFuE2V0fkTl1b2jYig3sK1elEQWdVRNtDJF0DRD3mVM8ReagTf7mvqlrDLPMYAOGGGgl
         3wjt14A5k0FnXW7mfaP694llv/Okv0cCtti0GOpQeCMJ8HQtSW+3yOW9TTA5UN8LJyNn
         vAozbpyAcEn7ZfljrTdDVjcFivmsNOcxBtr/akAwwSWmAceaSDdBK3IWYLVHiH6zWhvL
         NzvuPykQArp3kPPtXu8Z+CstmP4R+26c/kXGSIyODbuMxX9TtvE2qTvxptoQ1M8HmIh8
         J4ag==
X-Gm-Message-State: AOAM532zUeIWOEGRWsVJGhNLpaYsRvOy7wufDXoJlHL/sjRKLkN74SFa
        2dXBOsjZmroYF6gAUqAGrx5lrfoWRFE=
X-Google-Smtp-Source: ABdhPJy6533Cyz0chbugusUCp+pM4mSt2gn6VWxnns7wXZ61sQMUy1P4QILVgyf/yBFCLVJCAuAQvQ==
X-Received: by 2002:adf:eecf:: with SMTP id a15mr18398510wrp.83.1593457030228;
        Mon, 29 Jun 2020 11:57:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d132sm758693wmd.35.2020.06.29.11.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:57:09 -0700 (PDT)
Message-Id: <e4545658edb011262924d60ab166a4dbc39c6dd4.1593457018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
        <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Jun 2020 18:56:49 +0000
Subject: [PATCH v19 11/20] Add .gitattributes for the reftable/ directory
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
index 0000000000..f44451a379
--- /dev/null
+++ b/reftable/.gitattributes
@@ -0,0 +1 @@
+/zlib-compat.c	whitespace=-indent-with-non-tab,-trailing-space
-- 
gitgitgadget

