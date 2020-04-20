Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D734C55181
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 21:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9DB220782
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 21:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOZMOlsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgDTVPG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725774AbgDTVPB (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 17:15:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E580C061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 14:15:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so13971924wrs.9
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 14:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4D690/NLx/9daAF2hWG5tCfDYzmNZsPcuZnuRxKSdQk=;
        b=WOZMOlshPqPxIGBsM9l2/neYCh1w/YoVJfZ/1D+bEflE5Ud4JXriwJqotM61pHm9zj
         caYHDeqAPxjyQX46XAYT53AFg6fIiWqIY1Qh4gRhgMX4pzA3qYvPrfBmYoLM1y7bnF+n
         U1zWtTm1nbTi+xNDXPvi9SrVPzI99wpZLu/TnlYmLZImMoWa8DV2skLJmPAOpmEshTBa
         YbkKj9Ij0+oROjhHuzZIjdaMT6HzzU1wQOQgBU6EDwrTTFy7CGSceJh2kLljRb8f9K60
         8zM66RGxHMvV/O0dvdKDhVoCQE3lCN8223hdMplW4NCBTzrk6v05rVmW1J3ZVQRh3Iko
         ayhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4D690/NLx/9daAF2hWG5tCfDYzmNZsPcuZnuRxKSdQk=;
        b=seh4OIvFyFLanuYpQlZBsXNlrzrQunDw15gcD7sSgW9kyOYlhcb+dxgaAyavk+if4c
         sfOO46XGGa/YeaDC16zHK2oNQRBUf/dM/oKmyYLdC5URyF2Xi0hInKez4mPVpNGtHlGl
         pSyGXoXNvj5sDbmKESIxxFSIgg3SCZe0Mfg4isKtLr/quUOVWVzXiVhwpyZZgNR+zJj4
         n0LNN+1Rdby2uH/HdXtmi0xmpbwUO7mDV3q4zDeQ10FiZYI6Se0QAWYIecA7aRX6sR+S
         d/nZuuBADKyMnUneqiRt/5I7SsJwTCYr57VvbMnhqUvnNNEC2GvqxKeoPdz4r/fII7a2
         CYgA==
X-Gm-Message-State: AGi0PuamLK6VtTnpa87op0RKFzfL+hKTlJJhlDqbPyNWisSf0W+GYDhz
        M6L6nbpwZfU40AmPAkYhGqITNI6V
X-Google-Smtp-Source: APiQypJ67u67RaHeZrxWTFo1x8luaM8g9mmEdEQt/Aj25o9xPmSlxLV5kx2kkMHhLSK7dC80mqPG4Q==
X-Received: by 2002:adf:de8b:: with SMTP id w11mr19712927wrl.48.1587417299991;
        Mon, 20 Apr 2020 14:14:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s14sm783390wmh.18.2020.04.20.14.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:14:59 -0700 (PDT)
Message-Id: <56f65a2a0d735b6c55fae7f253285b78b0cdf41e.1587417295.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
References: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
        <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Apr 2020 21:14:49 +0000
Subject: [PATCH v9 04/10] refs: document how ref_iterator_advance_fn should
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

