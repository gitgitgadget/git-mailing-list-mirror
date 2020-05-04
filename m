Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA87EC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC7A206B8
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9s8XGj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgEDTD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 15:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727802AbgEDTDz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 15:03:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E75C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 12:03:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e26so669356wmk.5
        for <git@vger.kernel.org>; Mon, 04 May 2020 12:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4D690/NLx/9daAF2hWG5tCfDYzmNZsPcuZnuRxKSdQk=;
        b=H9s8XGj2Ja3Z2zhPQSmElY2AkNxqG9lnC4OS/prY3Fhz2tkZWZn3Ic0sXHf/aAx9ek
         NXamJOJ2kpPTidDF75yMA2fhE9+P/2YVxaBHyxWa0zuLMwV9rirhWkdBesEKHS3+q41F
         LkeCM7h15l3DudrgZQz5RIKf/Ze/jaxqSHcT75lstqvAWHd3kFZn+bN85UGldhJFHos9
         vYiMW0V41L6dHsAFik8480ro2bPk3S/x4qvx8PlZi6mqKfEJEXKB/pZ8+Su9jpboXI/2
         8h5mpQ2g89L0w72f9+dy757WpsfmsZp77yu55PVhgq7PkEdJvVKYkMHI/v+bxxS2x1qy
         pwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4D690/NLx/9daAF2hWG5tCfDYzmNZsPcuZnuRxKSdQk=;
        b=fidsGWIEaR1HXhJYU/bsADlHjAVNEB1LTY/BZoKRXUEyBv9chFIKUo7f98B7LXh5V4
         1AJvfPJujMeVVQiuMw6STCTN4+ozXNhT07qpdTPGo3tY1K2RYX4sX+cMOSu/TJ/UDgv3
         gTlVvSQFV8gxpWbSS1bTm4416s6H55tSoA8X6GVzudKkorGHXl2TPtfRKRymzPn8b/e1
         pBsjZ677rZavsofgmSv189NcS8G8KRG15/1rfAQz/qIwhEvvUVlP6uAxS48kbNsj7i+Z
         ZJJqzRmNEWgk6Y9n3x63cN/Wz1WiVB0QegKNHYmVHo3aj1hL6Xi5kI9vQnQMd1CiHBZy
         o9Tg==
X-Gm-Message-State: AGi0PuaXCV+wGdMhoUd/In/HLiWK4/ly5qfVdkMwX/qTftoKHdrcy4rY
        Xq2rQ3t1e6i6H4VHn2twN1oamK5m
X-Google-Smtp-Source: APiQypLtnMwRan7X4ssJdiXeOCCq8IRDzrS/ORu/5Xp++ObDcUUhO2dZOXQaLnGi5Xb/L5C8FsFUdg==
X-Received: by 2002:a1c:b757:: with SMTP id h84mr16140971wmf.188.1588619033264;
        Mon, 04 May 2020 12:03:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w15sm3362999wrl.73.2020.05.04.12.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:03:52 -0700 (PDT)
Message-Id: <6553285043b2f004cca646aefd59c509324d4da3.1588619028.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
References: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
        <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 19:03:39 +0000
Subject: [PATCH v11 03/12] refs: document how ref_iterator_advance_fn should
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

