Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE967C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF5760FDB
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhDMMLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhDMMLA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 08:11:00 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDCBC061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:10:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x7so16187846wrw.10
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x/Fv5nvPCiV5XXNujP9bGc5N3QByd/ZNiPhrkayfR0g=;
        b=Z5yufAQRLb3m80snAJNubJ+HhPOK1J24Kt5I+blAdDY7udJBZzyxK69/CXeQGACD6R
         84JCvWF3YfdrEPz4abpiJTkwskLpDURavE+JbHzSYd2fwiKIRPQca2kOGKmSMhkMLdSH
         wqIhbzVDCVbG+jhLfRxKViFIsx4lEkT2xkx0T9SzyhZrwxqN6C2kNrLmvYZgOmTY+6fd
         NVvGgelknOn0GPc6Eghseg7NbzQA0KvCw5bx1na/lT2XKeI/Tcz+apTahoUZin63lbWM
         clPQ/m0ff/gtYvw8JbgJWjVQ1pbvYcW18B4jSjGaSzkU/ACJYtfBFDcJjQWKF79ocYjl
         IOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x/Fv5nvPCiV5XXNujP9bGc5N3QByd/ZNiPhrkayfR0g=;
        b=WcpMNkvgjbe+Mnpq8kkB3A5cVO0QjAq5+BEFEh/ZlATTDNLPB+qC8Y2cwQRDfgwNNK
         X420Dvinm2X6dBhGnSZcNgB5Fef4OCCzPNzYK4TQ7z/oqHHsSu+yzH6gUMXYXcCuVi5f
         HmkA67WW1cofxU58cv9w+gPt6sCOtOvIWxxUnuR0jOfEvKfcTg6kYFsJ2OHYTsP+p7Kh
         HCv9JHVuVOZFvtuIje7Y4VmYh5Nio505qQNk6QAyzmtpPaLdGlxPQTL4MkC1LK4Q3z25
         L/OCnNQorZuJbDu/gvfLjjGlN8RTi9f2ngXga69fXbbLs9mmNci5y/S02BiW38UvHAqj
         XXWA==
X-Gm-Message-State: AOAM531qg6QvMqGJ8OX8kMxw/ygU5G9G2hhA/SU0OexV+jNmE5Vtt7ne
        Q7FJBh0GsdZriNSw5/RsMH0RviromxQ=
X-Google-Smtp-Source: ABdhPJyknukNx/fsD8AFWpAyURKgYeunP1LHkL+OXcqyGhslxnlEEPj9qbvObF8SNHg6KyKYWhAxIw==
X-Received: by 2002:adf:f308:: with SMTP id i8mr17150620wro.209.1618315839717;
        Tue, 13 Apr 2021 05:10:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm2377514wmi.7.2021.04.13.05.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 05:10:39 -0700 (PDT)
Message-Id: <pull.1002.v2.git.git.1618315838582.gitgitgadget@gmail.com>
In-Reply-To: <pull.1002.git.git.1618255954484.gitgitgadget@gmail.com>
References: <pull.1002.git.git.1618255954484.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Apr 2021 12:10:38 +0000
Subject: [PATCH v2] refs: print errno for read_raw_ref if GIT_TRACE_REFS is
 set
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The ref backend API uses errno as a sideband error channel.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    refs: print errno for read_raw_ref if GIT_TRACE_REFS is set
    
    The ref backend API uses errno as a sideband error channel.
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1002%2Fhanwen%2Ferrno-debug-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1002/hanwen/errno-debug-v2
Pull-Request: https://github.com/git/git/pull/1002

Range-diff vs v1:

 1:  9b150c5563f9 ! 1:  1e9a8990e7f2 refs: print errno for read_raw_ref if GIT_TRACE_REFS is set
     @@ Commit message
      
       ## refs/debug.c ##
      @@ refs/debug.c: static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
     + {
     + 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
       	int res = 0;
     ++	int saved_errno = 0;
       
       	oidcpy(oid, &null_oid);
      +	errno = 0;
       	res = drefs->refs->be->read_raw_ref(drefs->refs, refname, oid, referent,
       					    type);
     ++	saved_errno = errno;
       
     -@@ refs/debug.c: static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
     + 	if (res == 0) {
       		trace_printf_key(&trace_refs, "read_raw_ref: %s: %s (=> %s) type %x: %d\n",
       			refname, oid_to_hex(oid), referent->buf, *type, res);
       	} else {
      -		trace_printf_key(&trace_refs, "read_raw_ref: %s: %d\n", refname, res);
      +		trace_printf_key(&trace_refs,
      +				 "read_raw_ref: %s: %d (errno %d)\n", refname,
     -+				 res, errno);
     ++				 res, saved_errno);
       	}
       	return res;
       }


 refs/debug.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/refs/debug.c b/refs/debug.c
index 922e64fa6ad9..286987b72166 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -242,16 +242,21 @@ static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
 	int res = 0;
+	int saved_errno = 0;
 
 	oidcpy(oid, &null_oid);
+	errno = 0;
 	res = drefs->refs->be->read_raw_ref(drefs->refs, refname, oid, referent,
 					    type);
+	saved_errno = errno;
 
 	if (res == 0) {
 		trace_printf_key(&trace_refs, "read_raw_ref: %s: %s (=> %s) type %x: %d\n",
 			refname, oid_to_hex(oid), referent->buf, *type, res);
 	} else {
-		trace_printf_key(&trace_refs, "read_raw_ref: %s: %d\n", refname, res);
+		trace_printf_key(&trace_refs,
+				 "read_raw_ref: %s: %d (errno %d)\n", refname,
+				 res, saved_errno);
 	}
 	return res;
 }

base-commit: 89b43f80a514aee58b662ad606e6352e03eaeee4
-- 
gitgitgadget
