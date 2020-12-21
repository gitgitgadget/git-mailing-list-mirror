Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DA9C433E6
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A71C23106
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgLUSZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgLUSZh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:25:37 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8424AC0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:24:56 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id y17so12036468wrr.10
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PaSmZ/RBecu+NFyjcFfJUxhbi320cgCBZWTJ9QUWVDw=;
        b=h8hwBtl7Vy/w56QcGoZP0Ej4JzpYo4PRTt/KExBwPDQZpYHz/IViGiNDCaSzV0p0Fg
         pW5EF0xGSE1QcDGZqOpVibPBuONHCxkLbxDaGqKjFMTA8mMqx5iGdJwYasV+8cnmukXB
         U3WnpWDojdZAO/vF3gQs0T5sF+NudlGsKYkbEYVaVkUCjcNLJS1aizStEpS9uRuNoxeD
         EQwRgALU+LpOaQVzPxVE/TmjoV4ZO8OHo/Nkuf0eD3/XTE2UW3QhGsJ63YgSbpQVvpp6
         a6KlGD6lediwvA7GY1voAaHgbTOTkKukjqsnwk8+z+CyQtUvHCdjWFQAq4cdW/BqgOWY
         0t+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PaSmZ/RBecu+NFyjcFfJUxhbi320cgCBZWTJ9QUWVDw=;
        b=QMRDzCgzTU3ef9yUv8HdkdwUh+CNMtUfeofbZgX8zAR0m5eYTSpfZhmfUHc2actm7p
         Fx4n2yymR2qUb5GIpvzP+nPsYKzx6MaxSkU3v/rrSPFqAEc2KfHzggCRSluP8U4Gn1cG
         nGidDyW2kA9jzvyzwNO7AMwkjCEsDxA6Et/vASXIxm0cDlxr3ntbtld757cNl/WOt6Nu
         hgIh1Y1YSKfLjQyKNGD6JSltWciYELMawunuUQ+cVKY/1bb5uaDCYT2i8RPiANk+8y2e
         puIk6DamoQOp0SljhaHpDcwDOwzRSesC7pKvCkNevQ6XQy6k/Iao7aDEnRiwEgmPfmmk
         XR6Q==
X-Gm-Message-State: AOAM531+zI0voRowMWDYXXIw6uPG/OAGRnARg1Lk/mJz0MTwu8+Ok7VM
        YhfZSdEBQnb/4Mt70D+PaBqeYBZBLNQ=
X-Google-Smtp-Source: ABdhPJzVAyMyQINl8Tz3bgTsZdGNVhiBksN4Yuvudl7Na3ZaagdljbsalAvOmXAuokMXq3J5O9ceJw==
X-Received: by 2002:a05:651c:cb:: with SMTP id 11mr7330969ljr.509.1608564067248;
        Mon, 21 Dec 2020 07:21:07 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:21:06 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 30/32] doc/rev-list-options: document --first-parent changes merges format
Date:   Mon, 21 Dec 2020 18:19:58 +0300
Message-Id: <20201221152000.13134-31-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After introduction of the --diff-merges=first-parent, the
--first-parent sets the default format for merges to the same value as
this new option. Document this behavior and add corresponding
reference to --diff-merges.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/rev-list-options.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 002379056a07..96cc89d157d2 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -130,6 +130,11 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 	this option allows you to ignore the individual commits
 	brought in to your history by such a merge.
 
+ifdef::git-log[]
+	This option also changes default diff format for merge commits
+	to `first-parent`, see `--diff-merges=first-parent` for details.
+endif::git-log[]
+
 --not::
 	Reverses the meaning of the '{caret}' prefix (or lack thereof)
 	for all following revision specifiers, up to the next `--not`.
-- 
2.25.1

