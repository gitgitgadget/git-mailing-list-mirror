Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C54C47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AA3206F5
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBUrBR5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbgEKTqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 15:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731534AbgEKTql (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 15:46:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE101C05BD0B
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:46:40 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l11so6594343wru.0
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=hBUrBR5Sd7bVCmLIrN5jYxEfXaMu2NsfJeXbo1W6maAdgWfedfQqVWd1mgZav5bQPz
         69JqrtJ5XrBpPTKK7xN4cjsiMTo1zCOURImhUDX9jhWIFyQC4NVcMkZQJXgVW7dHDhJx
         VvJ0nhUC39Jp+a+xALfbkJOmhTQj40IYntIfrboPrGutYasUpO/AtouwjpCWv9cn2RP+
         pr/chn/8MmGM6tV97qQ0makc2FTaVz0mEW+kU7X5pZOoxYfvH6DPd5F+kv/XguhA5U9j
         r++YHjk/tABDl9S/8Pfl0CXcB8Tbc8MN1iLG9VcGd+CJQWVzmrQSHTIGoETsgUSSJtxD
         w+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=BXpZB9DxFXYHnIaGZu+G/L7TcanTbNFmxmsqpGneTntg8pSRmnc17kPtiZ/0JcDomG
         onuADO84/D3ShxqhrxmhSALW4nzcn/sQoaDVSPJ4YDgVPGmyuJjeBIGrSyWfbNkxd26y
         tLqEROxSonSbEgRk0DGrxDQHLOKc5QsZsz/IeVtupRwr6mKpV406wyOIvScCPoiASmz3
         vMwqtOXnIoeCTthusifGsZSlImJOZMzK2w7gwnaMSWJQ9LaEle1J5a18iOTAeOMNo7VH
         E0/n+GDRqpCnss4lmM9dNcT7MBtW5s9f49wMoYTVcQWbsBkGCWjUyJFf48ISutlgDGfl
         k9pw==
X-Gm-Message-State: AGi0Pube3NEuOZ6ZtSLgs2Uo6UKneU/h9yW8kqxU+HToqLkMQ4sQndJj
        BL4fuShUvv5x7a5ALZS8FWINCAeO
X-Google-Smtp-Source: APiQypKdx4Fyp6vMmjFM8xS0D82KiDqsahLCrZV/xw6JuW/fzS59EMf9/V4kqA/MqCdCt6MZ5jzVZQ==
X-Received: by 2002:a5d:5607:: with SMTP id l7mr21183114wrv.370.1589226399389;
        Mon, 11 May 2020 12:46:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h27sm8548206wrc.46.2020.05.11.12.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:46:38 -0700 (PDT)
Message-Id: <a6f77965f84e3506ee5d264c2262220d450d3a77.1589226388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 19:46:24 +0000
Subject: [PATCH v13 09/13] Add .gitattributes for the reftable/ directory
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

