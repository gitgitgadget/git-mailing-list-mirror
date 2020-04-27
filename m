Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5615C81BC0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2C3206E2
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSg019sr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgD0UUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726826AbgD0UUc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 16:20:32 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D42C09B051
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:13:45 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k1so22103809wrx.4
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4D690/NLx/9daAF2hWG5tCfDYzmNZsPcuZnuRxKSdQk=;
        b=KSg019srd1V/vzrToPWt6SWsK4DW9bJGdX+CLae0dkOcBYycWE86rFg/G+Qxz2kf8m
         D38tkLuey87+mj+nFc4TdNOqBLNEsIRyV67hDhE1AOSRzMDPCurDxTtny0fEfoFUdlHc
         OTjyLTXKhw2NPtdhYIcMfHy6nM7BWhyipTP0z9mw/eG0T0HryHCoWB3vc/Mw8S8Gd3T9
         IpTBaIulE/EPsqTi+dZkQCrH9Jt0pe6tkrWloPLhOT4rOWXFZTBFEiJXGLNN56yFC2pz
         8aTLB+EAujVdVQh7nf2HA/5Qopn7xhbo62nBCK9a/AAIItnGYkOa7FuBdT2ny3DXN1Na
         Ow1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4D690/NLx/9daAF2hWG5tCfDYzmNZsPcuZnuRxKSdQk=;
        b=UOZ6BIQXYop+crNqcr+QZWr5uXnhVspl1ziQ+uyNHeO36ehHAIuzXqEuBVos0DHv1Q
         FuGxguJxuoGbFdCuV1QQ3BqiIkHLVCybFi9P9pSxakzmxnpxKLZDyrm0mhTuXunvTkmH
         Z0oZX2Iq5Ir7ky74E5vywqYxKPAL/qoIacYAp8RG/rZURzOhSzjgUBqc/YD78Mx1axrp
         Njl86q/NLjPf/Ptwa168LQLZhnDhbBjthCC/svbNIvwCnjpQgMII81Kc4uHXisWu9ls7
         w5UDXRZmHKSYxP2Ct1K+G9xHJlPweZpfZ0IK+X6EBCBPBIvh43a3p+yqkk4WuzNNuAFU
         expQ==
X-Gm-Message-State: AGi0PubOv7JpekvXwPpOUx6QWTFqULI1G5pr+Q72oYWcAYM1QzHna32k
        jEA268qWdjKEmJL7Te7b7hUUj5sp
X-Google-Smtp-Source: APiQypIFa5bUePNoTqqkavgNmORxuEFBKUg6J9YfunbwE/Ck2rePODBJM39+q8XABzk2mY3+uevQHQ==
X-Received: by 2002:a5d:474b:: with SMTP id o11mr29019993wrs.391.1588018423462;
        Mon, 27 Apr 2020 13:13:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d143sm321006wmd.16.2020.04.27.13.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:13:42 -0700 (PDT)
Message-Id: <fd67cdff0cd74bd9d9bc504976a642a89dbb1e3b.1588018418.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
References: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
        <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Apr 2020 20:13:30 +0000
Subject: [PATCH v10 04/12] refs: document how ref_iterator_advance_fn should
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

