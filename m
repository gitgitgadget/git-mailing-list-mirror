Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400DBC47257
	for <git@archiver.kernel.org>; Mon,  4 May 2020 13:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A9362075B
	for <git@archiver.kernel.org>; Mon,  4 May 2020 13:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kkz+HC86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgEDNbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 09:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728418AbgEDNbc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 09:31:32 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87874C061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 06:31:31 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so9079174wma.4
        for <git@vger.kernel.org>; Mon, 04 May 2020 06:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p9wLXKAFSLFCWoje36n1B+Hg8h4ejYOaBtdMVAqK7n0=;
        b=Kkz+HC86popgE/fXexF9sEWZiXliI8L1bdfnnpo47bcFIrwAUSpAgqV8LV3wm5WEWs
         B+LJhTQkKKqZ0vhnN/YknIk//1fcNiw9qB1otaLglq/pywpdPMNKKjvi7mfFqZP+SWGJ
         0Gz3qjF5n8MZHEt0HQKV2eB3G7YAJjzyeiYmbvN+klVmQhD+rCTexBM6+lf5g1J4jxjO
         A+d7ONd82ynjurUog3gOB5U5bGwHbFj5iQVl7POI0y1PtImWZTqepIGyl2YBigePFbvS
         waxOoncEwaSvtgNzEhPh0fPMQbJBvU+DZkfYS2oBfcIiJFnMLLjuPQnq/deY07ZwPUkJ
         LRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p9wLXKAFSLFCWoje36n1B+Hg8h4ejYOaBtdMVAqK7n0=;
        b=Cc6Nn903VybS1X3rzW4VbMpC+z57hzld2+3/IuuA8f76En6IqjI1cfkMFW/m88+UrJ
         cMEwzlT0S983dCi/flc57zzxnkpC0WtVw1A0EPbVaaMwjU/QLU/e6M4/LRtaRZaeLrXN
         kJcgbrucCLeufyHCL+h7Ekuieoa1Lst7qOGbSNMr/PJ2MhQLva0tat6Ax6DIYVWqplwW
         msreu8q5chO7FETFDk0hsMOACs+PAf4dGc3+5rsVl+eQ1P5mzbxRkpZxxwHTQ2yf2MJ0
         feap9iG1oqvGoWBifXvsRIQoGxzqcEbWBo3QZeOjhA/HckrIaGqY20OGtSc4vAIZVwPI
         uuWw==
X-Gm-Message-State: AGi0PuZpvgE7c+8cIKZCkExigpmYLfcwFFFkIu1SVlxHHcwQ1uXpPesC
        04idTUKpSQH8ajjy4zjVsraDTD6k
X-Google-Smtp-Source: APiQypLHxB74RtqldCHPmcphKdYN6uFKde0h5vbqQ4+Ighy9IAgBKdkgUNg7w10DaLeXxX6ZfPEHaA==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr15734029wmg.114.1588599090233;
        Mon, 04 May 2020 06:31:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f83sm13413829wmf.42.2020.05.04.06.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 06:31:29 -0700 (PDT)
Message-Id: <c41b25e963973dac1eb50cd3ae1f79741bc89ed1.1588599086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.623.git.1588599086.gitgitgadget@gmail.com>
References: <pull.623.git.1588599086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 13:31:24 +0000
Subject: [PATCH 4/6] fixup! Add reftable library
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

`usleep()` is unportable. We need to find a way _not_ to use it.

For Visual C, we can use `sleep_millisec()`, but the current design of
libreftable seems to be _really_ keen _not_ to depend on anything in
libgit.a.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reftable/stack.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/reftable/stack.c b/reftable/stack.c
index 3c5f4a43130..2d0b831dda1 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -289,7 +289,12 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
 		free_names(names_after);
 
 		delay = delay + (delay * rand()) / RAND_MAX + 100;
+#ifdef _MSC_VER
+		sleep_millisec(delay/1000);
+#else
+		/* TODO! fix this, `usleep()` is not portable enough for us to use */
 		usleep(delay);
+#endif
 	}
 
 	return 0;
-- 
gitgitgadget

