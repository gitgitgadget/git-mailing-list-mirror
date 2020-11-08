Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0D4C4741F
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17B1720657
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAHbNhfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgKHVlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgKHVlq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:46 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6213C0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:45 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 74so9573353lfo.5
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wH5lezwYC3Zj4pfYQSJSrzR0Zof/a66wlzNTt5jMg30=;
        b=UAHbNhfR71bOPOYa5xPYTovIdEgNsQgEQi8PuQQbUErGfQTMN9VDDO2pQV0MJ/BJuj
         u2Hdw3eb5wymvtBZqn9KtbqC07zuLgk+ITtH+g9dqWZv+74NWegQwEob2jmzjL8aIC1o
         Jbm7GxattFJMI1MF4dDOT733m3QuuPtJWyKF4eRd656gpOVTYN03J4j4YpaqE4s50ADD
         zsD2M3qGBQ05/aeUunWbuxLVvmmk4e9z6ly7k7dm0Is9IpIh1hP05bP/YxGE3iQZ3FyZ
         QtYBVDVQYnUvOPZh+v5jNXIFsOkQQl2t6xi4qtyDdkHZmv/iLJN+9/c5n4jgOX/1Db0R
         an1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wH5lezwYC3Zj4pfYQSJSrzR0Zof/a66wlzNTt5jMg30=;
        b=pwTXfOMGnzQStvtgttl0qgUqTL3cepei4yIJSgUoMFucXS9NUIuOpabLWGtXqxMgWb
         irc2k1BQwBK0lbevFpPfkPOrl6X+G7rDb/Ct4EjKmC/ys/3Hi7biLUXeA2DdXfsgAKHv
         fS5ea6ecNqRqz85ElWSPmMbX/l8e3S5FpcHRJ/gVExOqw6ljwO+fDLdaT+aLQ9KplcDz
         X2bAAXZNwDqY3IV8gK5UBshsuxGFZwfwHcqxdtV94FCSbKvL8iTNRLE54L5FxjMOTW0i
         OZDAHjPkPKezEniaK92dgdNzwu8dt1iXEfSHRvB7I1d53xfAWE2XzBxCYWuCXcguFMX9
         67pQ==
X-Gm-Message-State: AOAM533acMikc62jANlsUhZAvr4FaBUz0IZA6D+u/Yy3wSlLyZ953jao
        MJTlc8vkzHCfObNrXr81xH8=
X-Google-Smtp-Source: ABdhPJw2c956kC9lYa/o6Gx3Dd5Gqf11QQpPcghaoW/vkCxqOzi0M7gj6+Zt3TjfoXNYa3xU56FQVQ==
X-Received: by 2002:ac2:51db:: with SMTP id u27mr541918lfm.32.1604871704477;
        Sun, 08 Nov 2020 13:41:44 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:43 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 26/27] doc/rev-list-options: document --first-parent implies --diff-merges=first-parent
Date:   Mon,  9 Nov 2020 00:38:37 +0300
Message-Id: <20201108213838.4880-27-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before introduction of new --diff-merges options, --first-parent
implicitly changed the default diff format for merge commits to
showing only the diff with respect to the first parent, and there were
no way to get such format from "git log" without affecting history
traversal logic that --first-parent causes.

Now, after introduction of the --diff-merges=first-parent, the
--first-parent simply implies the former, and this patch corrects
documentation accordingly.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/rev-list-options.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 002379056a07..ded383e62ae5 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -129,6 +129,9 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 	adjusting to updated upstream from time to time, and
 	this option allows you to ignore the individual commits
 	brought in to your history by such a merge.
+ifdef::git-log[]
+	Implies `--diff-merges=first-parent`.
+endif::git-log[]
 
 --not::
 	Reverses the meaning of the '{caret}' prefix (or lack thereof)
-- 
2.25.1

