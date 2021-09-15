Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFED2C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9DF661130
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhIOUhq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 16:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhIOUho (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 16:37:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C58C061767
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 13:36:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id s24so3153430wmh.4
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 13:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I60jO8u2FyLK2dJK68MVRXusZqnqzffKspnxldXFzkM=;
        b=SKQ2qeCw4FeKjpOSUaJcEATo+tMMF+cE8f2xi9wY9fgylZRs1Y8X4YLlvIEM+leqRZ
         j1DPuGQcsvGG/LTgEL2/nicpaY0aNU5kQisti4P+3Pe5Nbl5ElZ/zcmUq1qwLlJLRHUj
         VtgDBy7kOmV2DtCPIjhoMkMCglv5e9mruFM3PhGaDVcRkHlsrrUioEPZ9D5Y8CZlX0wp
         rfoSq48UPV2LBUkSgnrx9adnqTXkL+MQ8OoGKZnURGsynPTH+D1wSLm39qtvZzK5jwoS
         +wiUAWkH2iYpJkhUYa1swAfYP9GdAWe7ad0m1NW9NdrcD7YatxWJV1tPYA3w1P1qsfQC
         K2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I60jO8u2FyLK2dJK68MVRXusZqnqzffKspnxldXFzkM=;
        b=Np/2IEee1kzL+qVdRwUjZU36XN/Nokj3ggmHGsazBpfpWtNbVUQwn2nzUuQxrmw1+u
         Anss9z1xTYx+AlNDAduxKQF0lDGkhXRNLfRM+/Lr9MYHUc0aMy4WiBfy1IUbPAkrRL0v
         ncCu4/yL3Qrhlv+eVEPafadb9czSEsRo7KXMepyvctWtGOOhqsiQf2gQ9fJeMpOVfvlX
         6EuV0y1TJDoY42h6MWgozDiS2mWFcdAcebmkTBM+G/S1L02Hvr3OM+mydd3dc6fGw6aw
         oqY8EGfFl6PvL0B+ognHDbp7SLn1ponEXIhn+huTvkJSjrcPjup6daS279gCjf9s4a7C
         AIIQ==
X-Gm-Message-State: AOAM530mHoU3byYnXXzECUoPyz58wXWL6CRvYZ4ExM7E59QI+9xh3v2k
        wEk7YhaFqscLV03yAHYCJh9NonCuN7Y=
X-Google-Smtp-Source: ABdhPJy4lJ7XP9drButdO6LC5B6qVQkH1xmBa+GiymmNxgiMCZYDSk6lu0vJlvsuu9h6tNCggi36nA==
X-Received: by 2002:a05:600c:40c4:: with SMTP id m4mr6575310wmh.64.1631738181357;
        Wed, 15 Sep 2021 13:36:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3sm987002wrt.28.2021.09.15.13.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:36:21 -0700 (PDT)
Message-Id: <30b7bb247c3c8531119f99e293d84b1836297251.1631738177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Sep 2021 20:36:14 +0000
Subject: [PATCH 4/7] simple-ipc/ipc-win32: add trace2 debugging
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

Create "ipc-debug" category events to log unexpected errors
when creating Simple-IPC connections.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/simple-ipc/ipc-win32.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-win32.c
index 8e889d6a506..6c8a308de13 100644
--- a/compat/simple-ipc/ipc-win32.c
+++ b/compat/simple-ipc/ipc-win32.c
@@ -49,6 +49,9 @@ static enum ipc_active_state get_active_state(wchar_t *pipe_path)
 	if (GetLastError() == ERROR_FILE_NOT_FOUND)
 		return IPC_STATE__PATH_NOT_FOUND;
 
+	trace2_data_intmax("ipc-debug", NULL, "getstate/waitpipe/gle",
+			   (intmax_t)GetLastError());
+
 	return IPC_STATE__OTHER_ERROR;
 }
 
@@ -112,6 +115,11 @@ static enum ipc_active_state connect_to_server(
 				if (GetLastError() == ERROR_SEM_TIMEOUT)
 					return IPC_STATE__NOT_LISTENING;
 
+				gle = GetLastError();
+				trace2_data_intmax("ipc-debug", NULL,
+						   "connect/waitpipe/gle",
+						   (intmax_t)gle);
+
 				return IPC_STATE__OTHER_ERROR;
 			}
 
@@ -133,17 +141,31 @@ static enum ipc_active_state connect_to_server(
 			break; /* try again */
 
 		default:
+			trace2_data_intmax("ipc-debug", NULL,
+					   "connect/createfile/gle",
+					   (intmax_t)gle);
+
 			return IPC_STATE__OTHER_ERROR;
 		}
 	}
 
 	if (!SetNamedPipeHandleState(hPipe, &mode, NULL, NULL)) {
+		gle = GetLastError();
+		trace2_data_intmax("ipc-debug", NULL,
+				   "connect/setpipestate/gle",
+				   (intmax_t)gle);
+
 		CloseHandle(hPipe);
 		return IPC_STATE__OTHER_ERROR;
 	}
 
 	*pfd = _open_osfhandle((intptr_t)hPipe, O_RDWR|O_BINARY);
 	if (*pfd < 0) {
+		gle = GetLastError();
+		trace2_data_intmax("ipc-debug", NULL,
+				   "connect/openosfhandle/gle",
+				   (intmax_t)gle);
+
 		CloseHandle(hPipe);
 		return IPC_STATE__OTHER_ERROR;
 	}
-- 
gitgitgadget

