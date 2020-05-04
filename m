Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3494C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 13:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A50C22078C
	for <git@archiver.kernel.org>; Mon,  4 May 2020 13:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOz20a9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgEDNbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 09:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728129AbgEDNba (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 09:31:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221EFC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 06:31:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d17so20903121wrg.11
        for <git@vger.kernel.org>; Mon, 04 May 2020 06:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GBAL+MKWIqnHyoVOy+P35kOcjiR8O0DGiJOxd5GbuHI=;
        b=DOz20a9emF9NfjLS2oOI7JIonVYmaidNQ9gFT+JMQfIGp/lmJLQRO8qyakN4+jF0S3
         kIaQ6ByhJfgjSE/QEtXXVNT5LLZxCvYW07eNuxxdX+QW7k7mhIZVlxtqi95CZybBylvU
         90kUvZBNwVTDIoHTPpkWHJiI8MjS+vEysb/w05RQ+OGiQWmLrWl2ZfsfJS/DmW0B+ASH
         hFYVXHhAUBVj5RBnn4O98h4D7Qej2YNaUf6ZW8lkl2G8cfpJNF/w3VI0bcSGjH2l/vgN
         m+GW3oUIVLFs7uXKvuk67msiy7+UcPZFaWa0Xx0s7FF5VrhcvKmsrbGLdojV3zh+i0DA
         Vo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GBAL+MKWIqnHyoVOy+P35kOcjiR8O0DGiJOxd5GbuHI=;
        b=HtDBfm4dRqU60MT3pkfJUlLzxQ+Lgj9NnTGf8XCkYAZLphVwDpjGQ+uk8UK12WY+yT
         YyoqC0FTwi8udgisUjtBnvOZAH2vHG1NnIfUBZOyjwVjQHjM0ALa7UNx2PPzka8LOcNd
         JZNNk7+/fXBponbp7iqnn3oB9c3gwIrlh1HAGIzfKir7J+p5wkqZ0kfrOlB6kx8ZDbDs
         QIo2xZZMPaIMTW+5pkistI1lDRjc6FnA4lBxUNNT9VX3a1b99gXIyUPwaQPU7j4qQ3W+
         PLvIwjtQmEmGL+BGZAhOMkyuG29RbaLirrMIaFeXdhpNCy7OCCH/v1+8r70mgRgX6AbX
         MbDg==
X-Gm-Message-State: AGi0PubU22yhHgtygAcgWYq+bub+GnLGUFLsG3li5V5Z9Ro+wBP7/qWf
        +4fSodRIdKtvsNjI5QS6jMVMbmmU
X-Google-Smtp-Source: APiQypJnPiwQqvkhL8RwCZPCvTWLwtRDDTShmmtqo6JWTyQJDRJDfJPsQutuClIVxG2DGecjvQ25Ig==
X-Received: by 2002:adf:9444:: with SMTP id 62mr15573793wrq.68.1588599088681;
        Mon, 04 May 2020 06:31:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7sm18653253wrn.78.2020.05.04.06.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 06:31:28 -0700 (PDT)
Message-Id: <ff60fde10919b6b8c54ecb8f38b710fac37624e3.1588599086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.623.git.1588599086.gitgitgadget@gmail.com>
References: <pull.623.git.1588599086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 13:31:22 +0000
Subject: [PATCH 2/6] fixup! Add reftable library
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Do close the file descriptors to obsolete files before trying to delete
them. This is actually required on Windows.

Note: this patch is probably a bit heavy-handed, releasing more than
necessary (which will then have to be re-read). But it seems to be
enough to let t0031 pass on Windows, so it is at least a clue as to what
the fix will look like eventually.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reftable/stack.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/reftable/stack.c b/reftable/stack.c
index 2e32f7671c2..3c5f4a43130 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -941,6 +941,10 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 	}
 	have_lock = false;
 
+	reftable_merged_table_close(st->merged);
+	merged_table_clear(st->merged);
+	reftable_merged_table_free(st->merged);
+	st->merged = NULL;
 	{
 		char **p = delete_on_success;
 		while (*p) {
-- 
gitgitgadget

