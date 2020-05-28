Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73399C433E2
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57656208DB
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6qr3C1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgE1Trf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 15:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406681AbgE1TrF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 15:47:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609A7C014D07
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:47:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x14so549799wrp.2
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=Z6qr3C1EyyyLtX36viWjQsSJ+sYrLOqF3vCPzqrkNZre1thUd1f1/Kc2VYEJHCGBLs
         ussbzEGaFMdpbvFihDNiKbvh+QynDlABsyex2vmr3eX2uUNnckvkoHz7B+Tgd22R+tEv
         0h6faDusecqivj1t+9vEib7ynCx4IWd0P5TIi1p7EIahe8lRv+Z0Eso/hL14vSREVNT1
         6cYH26pzSruDC2cVcEDn+/8i0qc+x/rmkxazrYMr2WLj6CyaijzNnxvSKUoTVZCVCw4t
         xL/hrHY4L6xRKNkn4d4F0Q8ywd9n4G+Vpd0U1iUZoexDJ7QGzo2xcWSO6CR4fLJA+NbP
         YajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=CoFpO8atEdQYmmrWAXMYPc8pJix0qK+OJtdobknhz5MGL+piCtlcV3vdd3csHEWwAa
         e/bwpHklxLzo3imhzSHsNi/KZDAVoiLkAyqDEm/0iWWPZhJf3r4hRlLneW2/pkPnJhwR
         94B6O2CgxYsxNhMS3uT/Y8wIYwn9tXRI6NWELDFxdwGgMaxYbS1DjJtp+nxUzstj9quw
         KPXgObj6F0kcPvIQR4OFXoGotqk9g6DCufoWi+X1Ptn8FZ8seNOUYgCe5vUih3nUyNSN
         +sTk6WuqXGqVyrxU9f3fFlLushgOPzmKOsjil7x1pqHH6gYrVjPLvyzWmkJ1KRmwk1NK
         VXqQ==
X-Gm-Message-State: AOAM533BBWM+8QjnHN0q7gXsxOVY7dGU5PTy82WhLa0Qbrm9PejiLAHh
        7uqp6NU3gO2X8+JyAv3WhJWeMlV/
X-Google-Smtp-Source: ABdhPJwe1fr5EH7bedbdpFxF+pqRchojCce2yZmbt7A9rezq5LiSISHo4yHulI9RICZYSkFfYipd1A==
X-Received: by 2002:a5d:54c3:: with SMTP id x3mr4898588wrv.312.1590695219111;
        Thu, 28 May 2020 12:46:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6sm501909wrx.80.2020.05.28.12.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:46:58 -0700 (PDT)
Message-Id: <dcbd000e7f7d3dc48c7dc9eee75636a9abfbd31f.1590695210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
References: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
        <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 May 2020 19:46:44 +0000
Subject: [PATCH v15 08/13] Add .gitattributes for the reftable/ directory
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

