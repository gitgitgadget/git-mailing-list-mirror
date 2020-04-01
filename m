Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1696C2D0E7
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 11:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8801A20857
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 11:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsF777Xw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbgDAL3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:29:06 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34666 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732150AbgDAL3G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 07:29:06 -0400
Received: by mail-ed1-f65.google.com with SMTP id o1so10946189edv.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 04:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4D690/NLx/9daAF2hWG5tCfDYzmNZsPcuZnuRxKSdQk=;
        b=gsF777XwuGxfCQsgQkAOs27rfAwTUD3w5ruWIUvrea9sTwQGygwoFJ9udowfezOClK
         7M2p8Nh77/55GJkaefuJXKuH8Wf93Wf0GavnIoIBaoZXXfwy1ryGbh0AsHk6LOMX/Q/V
         2C+wPBUVHuANxeaOZJTU3vC/PkJ4rig5QNCI1zx4NSQh6KA6Qxo6uW+tnQUd4831OJi3
         P84unDEUo8HvGjp7bXI1aYzQraYa34EYstqXzh2auC8ndPRBFNqbikureaYHkKyuYni3
         KQ/3MQRk/iWwqs4dsVFP5v4MzsiacG8YA4JX+XZlEZ/daM/vN20Vubs+dhCUcOGkjKEJ
         POPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4D690/NLx/9daAF2hWG5tCfDYzmNZsPcuZnuRxKSdQk=;
        b=G4CThJ7nnDWqmfdoswejqStpiHOBmZPJhKnEjY7ItFcT8JBd1gcRnn82Eid4Tfqheu
         8v6QZ4iFu5PfCqS95nS4NsfVr5w8IPXQIXPD6rW2XHHCAYck/U/f8YiyBH44hWSveVNm
         Q1uwBQt/GIvHyW338c7v+0FFBM9HsVCDxU+kCNNeW8SawJupwsqGXV1K4F9DAcHSgRqN
         vol67DxHUGxsFztWy702pYmrbtOHZV11UiHngIhH9DeV5XYyixPF7sSBYpn4K5B6j8QQ
         kLHBShssaXffkrNOLeZlz8j/+dWjIjHgZDODtXW/f4DElg+/HLj5ToCcaLe+LMUXgBlj
         8NOg==
X-Gm-Message-State: ANhLgQ2bNmkrQ3PT031HKLGupkM46uBkx0tSre1BsTA7AdTfcfgOi7OL
        t79PCzAOfedLEijvRiwhD/lyeyTp
X-Google-Smtp-Source: ADFU+vs2sw4UByx5wXeom802Gnqpg+QdiQDDSRBsNz8hhm/6pNbyWPMJYWOhC4+pFdvc++KRhQJb7A==
X-Received: by 2002:a17:906:b34f:: with SMTP id cd15mr15923853ejb.332.1585740543389;
        Wed, 01 Apr 2020 04:29:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n62sm380815edc.74.2020.04.01.04.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 04:29:02 -0700 (PDT)
Message-Id: <d08f823844de9590176919cf7c475e4fbd89033d.1585740538.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
References: <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
        <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 11:28:52 +0000
Subject: [PATCH v8 3/9] refs: document how ref_iterator_advance_fn should
 handle symrefs
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

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/refs-internal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index ff2436c0fb7..3490aac3a40 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -438,6 +438,11 @@ void base_ref_iterator_free(struct ref_iterator *iter);
 
 /* Virtual function declarations for ref_iterators: */
 
+/*
+ * backend-specific implementation of ref_iterator_advance.
+ * For symrefs, the function should set REF_ISSYMREF, and it should also
+ * dereference the symref to provide the OID referent.
+ */
 typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
 
 typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
-- 
gitgitgadget

