Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883F9C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F9C7206B8
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMVOlHLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgEDTD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 15:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725981AbgEDTDz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 15:03:55 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6213EC061A10
        for <git@vger.kernel.org>; Mon,  4 May 2020 12:03:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e16so384423wra.7
        for <git@vger.kernel.org>; Mon, 04 May 2020 12:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=nMVOlHLaPU9h8vvvFevmjhknuB+DxkZK5S/BDUdrjD6TlVIpko0wE+Ti0R92nYUac7
         HeLQnhaalKJ6YOWnousVB2W/hdlfLE+glLyPW4ci6tHWOO+5fEOFHaQ+cAufF/zClDoU
         fvM8qUwGw/qgxrtm/nlhDJTsZprzlf57vQIJwR1UOBwcfLQNWSp9jF3KjfswAI6BXTpg
         IL6uVvfO32SoUqnuRy9UbQY2Z5W1XEdgbuFd9oojHH9UiEcgqGhlwbNYnKTsHTL2L52e
         SsVzn7nR+6BKLDeijSG7ZvojpL/vrf59Q3AyxEvnPSul50rgKR7FqD/g6KNFRkDiw6mh
         hMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=ORDXCBjJ/WU+ogji2R2x75gh+vE2hNppoFUlQAakTYHy8sFWh7djr2D9DzsStuJVoy
         +/IM1pWpy1/KXsr0WI7IrhCq9Yyxwy2wI1PpmhGV9RV21i5h9GFX0AxPqGuIog5yUW8l
         h8KNsDMM07vS4JHXax7Qit7l3MLXtYX9f0Xtr1AF6esyzmlG9RSB1pPRTZxXWWcq3kCO
         MtuC1FYnT82GkSpGWP82TMttCS+cKV3hcJ1Yw+5ZQgUouVLbp+oAHfH9+NmdzkTlXwhB
         QZYtPWTCJTGpV5U2/GFARRn1sasxEXJ5Zis0mLsT/DbiDojHKAEvJwBVTJAnhNX1b7G9
         6XEg==
X-Gm-Message-State: AGi0PuYRPuV+lnbRBjLEi9kbGJKeIFG9BcLxlH8+Er7L8qC/r7taQgAQ
        5ba8ypHk5tqQRICjX87P0NWYfhfx
X-Google-Smtp-Source: APiQypJe9qz4yfasMb7/2RVn+EK/NhU8Hu26pXPopVMMBBXUQlsn8+lvHbV8JPmK9jJxTwSvwxtV/Q==
X-Received: by 2002:adf:a297:: with SMTP id s23mr860847wra.54.1588619034053;
        Mon, 04 May 2020 12:03:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k5sm3987430wrx.16.2020.05.04.12.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:03:53 -0700 (PDT)
Message-Id: <7dc47c7756f67522d6279d1936e9d43d9438f215.1588619028.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
References: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
        <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 19:03:40 +0000
Subject: [PATCH v11 04/12] Add .gitattributes for the reftable/ directory
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

