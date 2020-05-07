Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB17C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 09:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026B92192A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 09:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CH8RQzCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgEGJ75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 05:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725953AbgEGJ7z (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 05:59:55 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FCCC061A10
        for <git@vger.kernel.org>; Thu,  7 May 2020 02:59:55 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id v12so4279556wrp.12
        for <git@vger.kernel.org>; Thu, 07 May 2020 02:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gP2mKurovl5RI1/nfB8JPBDqHhvSxbSjyPMBXIBnAvA=;
        b=CH8RQzCg3pMDZuPPBx2horMlY9x7KI5K3DCsPB6bXZ8wsu8IDPAecdCFj9dhiJu1mK
         r5DTflq5oCK38cSMVa7OWZhP3doIpzpDNW9yKG5N3ZWYTD8cm/re/9utYrEmx5saINYg
         JCSvIM5Igz8wmYMVHKkYqksJk1ibuR3vaHb1yfuvfEEw8Hb4W8VaOcqYW2EPPZGmHhzy
         Zi0zx4URbSSSqJgbG9/mWcT/igWiPZ8PgXa7Beojk3k9JHw1rLAEP5ewoo+V18klK4Dj
         +jqlrUGI3SG2Qb4HMqJ7plxAGTGMQKaft4t4T8fji75Vk9Um44ZzgQoEaz7diXXHM+w2
         umSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gP2mKurovl5RI1/nfB8JPBDqHhvSxbSjyPMBXIBnAvA=;
        b=FjqP/tBPrFIBE16PSFURUY9EodNMi+SFh22QVH/44gQ8aBk4Jzh6AMiUftorOaY7F5
         7+xH8JrIBHzbwoPwevtdvXa5Hzp4VZrL1j429KQl0lF3/rN25oWWt9npSjJt7ZM6teJW
         9wlOhvj3eeqR2W2X+3KxI0Guw/ijSJ5tENkeonC099/Z4qAKZ0eBZc9X9AJYjDXCXWXr
         sLJv6ylK8IZhKxHH7vK+sQtl6262d7/eOzGbfCm9vnLnpdc0Ico6RQD/f4ZlhKvZCD+x
         widVuJFhr7cITrV0EMUtMGu6OOZYMHYOojqmzwxz0pIdpy+ZprhiuUJdZATNTwigW6fc
         rwew==
X-Gm-Message-State: AGi0PuYWga+bevAxWmrUaFZQzM5oWtzbhskgdawReagHgyPYe74X/61v
        8NzdWJJwG9MIoCLQndcJLpqiCEDy
X-Google-Smtp-Source: APiQypLBrxP9Yl82G8PaAnN8HMC0mwM0QDWrUaZwV8TcQeEbR6jac4hOlPe1MF3EERHTp7lsThOwig==
X-Received: by 2002:adf:810a:: with SMTP id 10mr15355256wrm.101.1588845594218;
        Thu, 07 May 2020 02:59:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 2sm7393683wre.25.2020.05.07.02.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 02:59:53 -0700 (PDT)
Message-Id: <6d9031372ce23a3ab25e504e4a0294b68844e27a.1588845586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
References: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
        <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 09:59:40 +0000
Subject: [PATCH v12 07/12] reftable: clarify how empty tables should be
 written
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

The format allows for some ambiguity, as a lone footer also starts
with a valid file header. However, the current JGit code will barf on
this. This commit codifies this behavior into the standard.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Documentation/technical/reftable.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index ee3f36ea851..df5cb5f11b8 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -731,6 +731,13 @@ version)
 
 Once verified, the other fields of the footer can be accessed.
 
+Empty tables
+++++++++++++
+
+A reftable may be empty. In this case, the file starts with a header
+and is immediately followed by a footer.
+
+
 Varint encoding
 ^^^^^^^^^^^^^^^
 
-- 
gitgitgadget

