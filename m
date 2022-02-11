Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E879C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353513AbiBKU4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:56:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353475AbiBKU41 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:27 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEB2BA4
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:25 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k1so17171488wrd.8
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k7UbqWA9ODqQBMwY8Vbpj0COHUFu+Dd3K69yMB7cUwE=;
        b=Bzhv5gwJ8ZX+OboXmLcQvV2ytppHinu6dAWI43/4Xtnk4uBsK66EriBY5CL6fC+BCr
         D4T8q1Zw2IdsM88A8drCrGLtPJ+8PU3tUh3+6vQGviUalvzIvYn8oaONbAjt6XHc3AUD
         AFvgjwXqmq53RT8GHHEiFOuKemmpiu/bPElwZvk3ZVZa19zBPS6J6Pf0s+QSoEl6EtJa
         jHfH1aSEXv1OSLcqO1oJ0WapxZWi0owvqJXeZSFAAbzzgSC/EOziSDnAlQ3UB0kZU9TI
         rKDxbEKYuxFF6zbMi39KAatkpo0XcPrH6cqKgB/SAEqXs9PrdO5V7jIqbXVvl+ko7AJW
         KSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k7UbqWA9ODqQBMwY8Vbpj0COHUFu+Dd3K69yMB7cUwE=;
        b=N5BGtwm5QeL7vloTJxZkxzQZokIEd2VoCLIpKm9ch9vkDl92yte+PeL+ks2EQpUoW2
         dWGPznGJlZd8sOykDFJRPCS7X6MIh6YXlaWd7tPxTeSc6WBb092SfFXYhaXQAnATreee
         5Nus8NRIJkZGlzyuBoSUKPIgcdZ/XIA3KEj3dXChKk8R3IeCFUWFAhR+k9QqF6zqo43k
         /lI+Lkr0CLlvz4SQElDhNuyGdb4S/HsbN/88dO+OPLgNAakMKUaQp1OpnV+QN6ymLLER
         FWK95XVNbbRWO/1t9xbEQByOkY/SW8YLkorilwgF9cqZM8XQVqb4cOxX5h0WaSvCWeJW
         f7ig==
X-Gm-Message-State: AOAM530CzHAPJ0qhaOZFTTTkrqdC6SERBRQXEHAoZI/AKXb4hIJ6obUq
        bcdWEc9OqhXJ5cCoK8HyBYHnjLRPdww=
X-Google-Smtp-Source: ABdhPJwZwDMowM46pnxLDGXMCUXBYrt8WNH5jk8hILjo0fNrZM6P0jGagjgbeLCO+vi5slIy2ua1PA==
X-Received: by 2002:adf:f58f:: with SMTP id f15mr2686045wro.192.1644612984430;
        Fri, 11 Feb 2022 12:56:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13sm10628236wro.89.2022.02.11.12.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:24 -0800 (PST)
Message-Id: <8e738a83bc5beb1f222d5ed8591fe2c8aa9ff6f6.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:55:53 +0000
Subject: [PATCH v5 04/30] fsmonitor: use IPC to query the builtin FSMonitor
 daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Use simple IPC to directly communicate with the new builtin file
system monitor daemon when `core.fsmonitor` is set to true.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fsmonitor.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 17cba68235a..4287aad6bbb 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -241,8 +241,41 @@ void refresh_fsmonitor(struct index_state *istate)
 	trace_printf_key(&trace_fsmonitor, "refresh fsmonitor");
 
 	if (fsm_mode == FSMONITOR_MODE_IPC) {
-		/* TODO */
-		return;
+		query_success = !fsmonitor_ipc__send_query(
+			istate->fsmonitor_last_update ?
+			istate->fsmonitor_last_update : "builtin:fake",
+			&query_result);
+		if (query_success) {
+			/*
+			 * The response contains a series of nul terminated
+			 * strings.  The first is the new token.
+			 *
+			 * Use `char *buf` as an interlude to trick the CI
+			 * static analysis to let us use `strbuf_addstr()`
+			 * here (and only copy the token) rather than
+			 * `strbuf_addbuf()`.
+			 */
+			buf = query_result.buf;
+			strbuf_addstr(&last_update_token, buf);
+			bol = last_update_token.len + 1;
+			is_trivial = query_result.buf[bol] == '/';
+			if (is_trivial)
+				trace2_data_intmax("fsm_client", NULL,
+						   "query/trivial-response", 1);
+		} else {
+			/*
+			 * The builtin daemon is not available on this
+			 * platform -OR- we failed to get a response.
+			 *
+			 * Generate a fake token (rather than a V1
+			 * timestamp) for the index extension.  (If
+			 * they switch back to the hook API, we don't
+			 * want ambiguous state.)
+			 */
+			strbuf_addstr(&last_update_token, "builtin:fake");
+		}
+
+		goto apply_results;
 	}
 
 	assert(fsm_mode == FSMONITOR_MODE_HOOK);
@@ -315,6 +348,7 @@ void refresh_fsmonitor(struct index_state *istate)
 				 query_success ? "success" : "failure");
 	}
 
+apply_results:
 	/*
 	 * The response from FSMonitor (excluding the header token) is
 	 * either:
-- 
gitgitgadget

