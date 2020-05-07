Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56971C4724C
	for <git@archiver.kernel.org>; Thu,  7 May 2020 10:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2930120870
	for <git@archiver.kernel.org>; Thu,  7 May 2020 10:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFWdHA2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgEGJ75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 05:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbgEGJ7x (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 05:59:53 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B015C061A10
        for <git@vger.kernel.org>; Thu,  7 May 2020 02:59:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u127so6083277wmg.1
        for <git@vger.kernel.org>; Thu, 07 May 2020 02:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=GFWdHA2Wtu1ta9UQMWcw17Ak4MRAcZM/IoN51D6ujstJy/3nJtoE4yIX8IjUwRlpTs
         xIEo8W0TTep50hRaDc59cJClMNsTIaeUzyLv36pkgjlmO8z2cktR/bir8k7DP0soFvSJ
         bCpaojm+PpUn7OjYhNQrb/aQv5YkRdEujXfCmH3B2MKdUxKikr948/j4lhxCX3N36a9u
         jbgZuP92JJ/CwSiDtCN9J8xS6EPHJMnoCeSVuFB+OLh7kH82jU06M8z1Ywya+KBUcHCl
         cf6/RdNMXmFLQNzSWFAkt29r2206/qRJpmL5iaHs8I3UYK5mdkoCYhrAyYRg2VVd7Pjm
         xLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=FPCGzwb9gU4A2aimYHujIhKsl6h5YT4R9bBmj9nX5ikiF0gu/8HMjHw1aUYi8oygrS
         Qc7+6daDtVSU83JUoMLvSnp/jm4+EIfTM49CqE0fR8imHsaGKTj0D57Mws4coz7xv32p
         n/2sQ2kNBp7v3PEPCu29yGo3DK3brjYTjEIGgyLNgOU0NqoLD07609BbiwRa5hJ7lk2K
         WVtPQY8VhrW8uUIiXoXLuqrhjrmZjPfxZO3dwCBXm9E22r6OKmo/Bs65PDJlbay0JT6Y
         6HSAmxV7psDIqnrfvjzO5d+xHlU+fdmYlLYTJC+8QD/6sCVrhAh1QI8GqQLsAHynDOVN
         gACw==
X-Gm-Message-State: AGi0PuYdUJNEXTCoKfYhTtJxlLwS0PF2t65HwHbF6ZiJhsKTIovcjg+i
        bbvx5BXIOHAqLKIQ9Ll+xZ/4RoR/
X-Google-Smtp-Source: APiQypLQotIVpqwAPt0zJiX884kBhwUMldKKyfZwuHDBK/bd9WOfAzMcrYtH7xKsWXXoYBt7UBS04Q==
X-Received: by 2002:a05:600c:2157:: with SMTP id v23mr8828479wml.149.1588845591667;
        Thu, 07 May 2020 02:59:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t71sm7578716wmt.31.2020.05.07.02.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 02:59:51 -0700 (PDT)
Message-Id: <7dc47c7756f67522d6279d1936e9d43d9438f215.1588845586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
References: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
        <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 09:59:37 +0000
Subject: [PATCH v12 04/12] Add .gitattributes for the reftable/ directory
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

