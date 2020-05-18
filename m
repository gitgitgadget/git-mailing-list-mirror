Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DF9C433E1
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E45B20829
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwWI5K/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgERUbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 16:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgERUbb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 16:31:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB493C05BD09
        for <git@vger.kernel.org>; Mon, 18 May 2020 13:31:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id n18so946909wmj.5
        for <git@vger.kernel.org>; Mon, 18 May 2020 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y5DJtkpPQ2D1vteluVbo+K60HWFDKnD2zpgb5OcBRo8=;
        b=YwWI5K/o3s7gjxwcwtUY64qZMo7ploFdNGQVTMT6AqG8eH+tGpmgYCeFMnu1mY6HQt
         uIfYtXa28Tgxo8pm9DbItYBOfA4WfPtjWgWTirUaRtlLe78ZiNkRWlboydmsQZHqSOS9
         LWeFINlUIyvqCHGQCBZqTSn2MmTeyKbAnN9ObaZCQIsMzIBUzhqkQitzaGGwd2hu/q8I
         flYLSIvn+3hYbEG4ziAoQfO3NnAKJCUVmV/IdopFOIOctrIeoD92foEINh6dh/LIpam0
         dId7E6X6MhhYUbpLlwZz/bkDVwnfuVekxH4lHMwb/Yi76KPk/6z+AxXSKavWCwAhOSX2
         Nu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Y5DJtkpPQ2D1vteluVbo+K60HWFDKnD2zpgb5OcBRo8=;
        b=dp7KsSVzUS3iPrP+L9Qq6VkfYWXM+GV98zzr2Sw5YDs+HwOc3t2VZVf3IRUkmtDFUE
         Czi4aFyS+iP2BgXZYHbWU4WTyCaKg9Yi1a4n9B70PynnFRztETHJPVKH7myAUq94mpkV
         frFq8nCCeeQr0oVlZ7jiY74YX6lIj2lQNi4UXFR/YLgPYJa8UlMYoPD94PrKGe5Uhr9t
         Dgpa7Vv9lFJb+ASGDoPGx0c6YZGoiTa53MtLZ3SY6I+eJU16U08VwEwq7TORfMBZFuHa
         YW7hvEyref6+tRBw0s9evaJOs4sTVRywWpB82K+q10hzml6pfnxKQVaCIvatUR/LLs0G
         I16w==
X-Gm-Message-State: AOAM5336bNSlpO3doQZ5dx0V9kalIAA00S1LZtxc8rrIuGnzRsItGbg8
        u58hFqzlGb6OSwyjTLcARhr/jhLZ
X-Google-Smtp-Source: ABdhPJw/IyTCeiFfKGwN80CpxYlSUBJf5C2IFH8GhJuhXmiiO4+RkR8ph5J7CJj+3LqqiCHQ3KlPZw==
X-Received: by 2002:a1c:9e43:: with SMTP id h64mr1226210wme.0.1589833889090;
        Mon, 18 May 2020 13:31:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm787220wmc.43.2020.05.18.13.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 13:31:28 -0700 (PDT)
Message-Id: <0c953fce52aa26833cfebf051844a4c48ae645eb.1589833884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
References: <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
        <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 May 2020 20:31:18 +0000
Subject: [PATCH v14 3/9] Iterate over the "refs/" namespace in
 for_each_[raw]ref
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

This happens implicitly in the files/packed ref backend; making it
explicit simplifies adding alternate ref storage backends, such as
reftable.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 4acc22373e4..dfafd04b9f9 100644
--- a/refs.c
+++ b/refs.c
@@ -1445,7 +1445,7 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 
 int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
+	return do_for_each_ref(refs, "refs/", fn, 0, 0, cb_data);
 }
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
@@ -1505,8 +1505,8 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0,
-			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+	return do_for_each_ref(refs, "refs/", fn, 0, DO_FOR_EACH_INCLUDE_BROKEN,
+			       cb_data);
 }
 
 int for_each_rawref(each_ref_fn fn, void *cb_data)
-- 
gitgitgadget

