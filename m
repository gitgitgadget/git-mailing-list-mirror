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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D988DC433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C30B86112D
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbhITPh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 11:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbhITPhv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 11:37:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170D9C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:36:24 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u15so30930621wru.6
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JxZ883T7/40ehnE1C9Wcit7uGo6rCuzaGwJ2rCX+cMk=;
        b=SytR7/CDpvGxwYs5jad53bn1ugslIIU+zblG5Iy/K1JT8Mm6hik7+sMbxVL4ssnBnD
         5DE6ZirpVxNgn+z7MveMlpGr325pxUHEwxAIOBjVSvCapWNT2YVN4rCWzO00pXNjd371
         /L7QdOcg96RKmaG52uKyP6GoWwgbpIzoM5X87Dwk/X1bduUI17TqlYBPkaaOL6PDHfjk
         D146xMNfa+a8fnFriGKuJ88liFd026mb23bhMqqevzBM2AFfM4cBqNVdicM7feLwp3gE
         ZPrwpiKLlqNonl4CMclK4E9/U4tWdIu5M3F+gj9MMRPzQFoOZxQyiV0TM/MDD5/fHZZz
         Og/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JxZ883T7/40ehnE1C9Wcit7uGo6rCuzaGwJ2rCX+cMk=;
        b=Yx4dLvBTIHPGukN8Kgr/oBPQEbTIOaaIClVsaV3i2jgdQHuiTi9laKm29HkpkYk+qG
         7YJ/PlIXOhMvbH4emRQwFYtfZUc7mtNRCiYKQe1ud4YCsXriqqaz+IDyBVSNvnyTlq3/
         DTFFUIxnWmu0g290r+KDGILIQzLtEJsbDtsqTP+vXHiMoiZ5gy0srKOErRQwBmAG2un7
         cfsyH10TOm9h9/+i+/vn37d5hCHqhiPt/rKLt2AWoi0Okuk9lRguhlIuKNj/AXPA2A+h
         RYVr8je4gs6fSdfPy860/HmaGQF/rNiTv4N4waMoecWWovZ2Q3GOwu0MIwaeHRbXzdBT
         N4cQ==
X-Gm-Message-State: AOAM530ImuRWOq8aSvyOGb5utDS+2tU/bXV/RmsTGG4Us+osM9nsLmqw
        AOTIHdKvzq02hXC6Dvzjw65sP0/6sQY=
X-Google-Smtp-Source: ABdhPJwHoUXU8gmyq0KrF7vE00woLlsIHmltKKS+1WjabXjhj1iTqldACfvglsb+CsOI/XNBw/Mt+w==
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr13048769wrz.29.1632152182773;
        Mon, 20 Sep 2021 08:36:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9sm20584235wrb.36.2021.09.20.08.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:36:22 -0700 (PDT)
Message-Id: <82b6ce0dd6a8934c202dfd38f89daf81e0ed45c7.1632152178.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
        <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 15:36:15 +0000
Subject: [PATCH v2 4/7] simple-ipc/ipc-win32: add trace2 debugging
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create "ipc-debug" category events to log unexpected errors
when creating Simple-IPC connections.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/simple-ipc/ipc-win32.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-win32.c
index 8e889d6a506..a8dd46bd922 100644
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
 
@@ -109,9 +112,15 @@ static enum ipc_active_state connect_to_server(
 			t_start_ms = (DWORD)(getnanotime() / 1000000);
 
 			if (!WaitNamedPipeW(wpath, timeout_ms)) {
-				if (GetLastError() == ERROR_SEM_TIMEOUT)
+				DWORD gleWait = GetLastError();
+
+				if (gleWait == ERROR_SEM_TIMEOUT)
 					return IPC_STATE__NOT_LISTENING;
 
+				trace2_data_intmax("ipc-debug", NULL,
+						   "connect/waitpipe/gle",
+						   (intmax_t)gleWait);
+
 				return IPC_STATE__OTHER_ERROR;
 			}
 
@@ -133,17 +142,31 @@ static enum ipc_active_state connect_to_server(
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

