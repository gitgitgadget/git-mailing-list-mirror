Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3F8C4332B
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9536364E2A
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhBAWDJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhBAWDG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:03:06 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED61BC06174A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 14:02:25 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l12so18303012wry.2
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 14:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uzW/eYpOmlA1Eubawh6EjttB9/Fs0aZO+Ql5LOejaVs=;
        b=Oz3M34XGC0pIKC/NSv5Bd2+Rhc8zO6m9cAqCOmjYXuek0w2R2xG6ycY+FjogP0rcaq
         IPileSwpdAZrzd542ulwyV203cHXdtESDtTfz5fl1nlcqKHSZpHJrqXy5Ls9A1eOTcUY
         fQY4F8fH1r2iACItivL91WcZkjc4aHOPkRMghwopo5rmjDTpHL44Cb4tx4wJMdnDohsK
         x61lHUnvIGAd7HXbd/Hmwu7B30vifx0X2Ul4yN3QkEQBr/Ved3j+9fiyd4gTANJ162Xm
         GYWva2IXrEerdp+Z+FUhCQuma8TrGs0ecw1xRrT2EFeWjDEbM0jRLMult+9MiTote1p+
         JeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uzW/eYpOmlA1Eubawh6EjttB9/Fs0aZO+Ql5LOejaVs=;
        b=KCu7A+rKxXv8TadOfLXuhI3d3tuUDItwTwr9p6yFHuR4sbj83MrBdHRz3xk4X9ALjf
         jHU7DAyanb1za6Aw0ZCoDsjfUsmqxdF8/I67mETgA2001/9PID28IayLeFX5O+1Re+np
         ddjqpf2eHw+Y+1j2YufcwZfIsijnkrp8V+2jQmbokrfx3vouuvjy44AESn86gQ/53aml
         nJmAygGLUwKV8UdLCXIZZ0OOr771LROPgwnoYbkDOp/8/n06nETnBhDGf9ZThvnFh5PM
         +2sTRDyb7bszQcIosAQszjujHWs85cM4saNxV8hThS9X88jDS5yM4dbQrWhnQ7cVvllv
         74SA==
X-Gm-Message-State: AOAM533gByfXQo/dtCFLCnDCmPRpM2SKNAwzAdw8WuHKE8Nbbdm8EFtE
        bprnBkk8q/j4d6FdpvmQ96o+rhWG22g=
X-Google-Smtp-Source: ABdhPJwCnweZjor7R0SQahBoLug+SSpabPbaFHRyt+IjdY2PMVJqMa7KXjUj75/0MrVGxUGq76SzpQ==
X-Received: by 2002:a05:6000:143:: with SMTP id r3mr19073243wrx.357.1612216944521;
        Mon, 01 Feb 2021 14:02:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm578339wmb.33.2021.02.01.14.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 14:02:24 -0800 (PST)
Message-Id: <cf252e24b8c4da19ee9f886a1ab9c9c391d89d66.1612216941.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.git.1612216941.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 22:02:10 +0000
Subject: [PATCH 01/11] p7519: use xargs -0 rather than -d in test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

The Mac version of xargs does not support the "-d" option.  Convert the test
setup to pipe the data set thru `lf_to_nul | xargs -0` instead.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p7519-fsmonitor.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 9b43342806b..7bb37e9a6c1 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -165,7 +165,7 @@ test_fsmonitor_suite() {
 	'
 
 	test_perf_w_drop_caches "status (dirty) ($DESC)" '
-		git ls-files | head -100000 | xargs -d "\n" touch -h &&
+		git ls-files | head -100000 | lf_to_nul | xargs -0 touch -h &&
 		git status
 	'
 
-- 
gitgitgadget

