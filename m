Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD5DC54E8F
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726D4206F5
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeINFY00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbgEKTqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 15:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731477AbgEKTqk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 15:46:40 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF51C05BD0A
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:46:39 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id 50so11970757wrc.11
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8Di+ub7Vu1B1mswWsCEiJVVgD+CuYWhR+R83SbUaxog=;
        b=YeINFY00meJOBJWF0MqyvnGLQRc0NSOPN2mnhIq2m7zMxm4oAEFQUhAzQmSAHWWUrj
         Jun4uyPAo6YhyTsNZXNm01r0f1iXa2o6O1of7hw/LN3t0RoTWhYCMrmFYufdEO/yOT+e
         YSkPIqbIOt5PcE5B2yMNTRWXPpkMUrIpdqqwOxMvZzrk2GrEzvCVvYUq4ts/iC44C8Uo
         2mLhuDcXiQvM0OvOURYblZwxTAEPtxq4IRfDKsZjmcB72z/Aoz15pNjwyBR5jiZ50JHu
         cG15o08Da7q1/+oQnrFH7I073jod/KP/csNVA1Gl1zjE7hEFQg0BuF4AKlnoMq6AhldI
         qUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8Di+ub7Vu1B1mswWsCEiJVVgD+CuYWhR+R83SbUaxog=;
        b=W4sBrmmlFsXpr+/sODTddjsKs5sfNThlpRc8sEStgNRM48cPUCKa+EK3yxIcTOYLQH
         yjSwW0bLY/wHm+A1g3rRauWaO5gzXnoG4aTSB5iGp5/D1f4nGNIaPLoWgAu3PWBLx/DP
         0CyCsepfJh33sDfpwY+10ngquWOkNC57oTzNEf2NJgeBwPUpxF49z3Wk/0aq593Qivr1
         FovK6hGmX3OYMk3esehkue0DIWjg69VNcvAOhYxcfqBoDCOpBHwIpcANauNd5O4m0Dos
         Txb+vp25EST2xAKh4kuYMB8DyrvrAG6zOq1AG7ORkPQlglyy87dNJ1AtFwQM34+Z39Fh
         Zkzw==
X-Gm-Message-State: AGi0PubmWDScVzNaS9f2pPI7M+2v1AkQ7ZIGrI2uKTecFMLUkLQlAS9T
        iYnni98OQcN5lZh5ztg+BlRtxK9W
X-Google-Smtp-Source: APiQypJfFIRROoK3WS6y2sFgZ8sD+o8h3UVCoG2y0/Fyj6FTYa0JD/7z9lQBc8kjRMX2t/Gls36JvQ==
X-Received: by 2002:a5d:4447:: with SMTP id x7mr20648474wrr.299.1589226398274;
        Mon, 11 May 2020 12:46:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o205sm14329725wmo.32.2020.05.11.12.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:46:37 -0700 (PDT)
Message-Id: <3becaaee66ad56484599f9055fbd6b7ec66c2982.1589226388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 19:46:23 +0000
Subject: [PATCH v13 08/13] Iterate over the "refs/" namespace in
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
index fc72211a36f..79c63d60dcb 100644
--- a/refs.c
+++ b/refs.c
@@ -1444,7 +1444,7 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 
 int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
+	return do_for_each_ref(refs, "refs/", fn, 0, 0, cb_data);
 }
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
@@ -1504,8 +1504,8 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 
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

