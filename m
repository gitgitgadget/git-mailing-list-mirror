Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB5DC433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 17:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBDB20675
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 17:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uefRSr6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgGGRlK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgGGRlK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 13:41:10 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9F7C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 10:41:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z2so23848699wrp.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 10:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D0cA3C0eG7kggyL8SeHset03gOJsYQxzQOj2Aw+eoHU=;
        b=uefRSr6ZMZQbO0zqqvDVrUrU7vtFudGGaaPC//eFzzCUn6f0l/l1C54vYCzAngLQP0
         kMdcaw+Oee0p/nztNIU9kHMdx+3gqm581ACw2S+pd/OMp5l+rPWJqT0XVDOxfE4Jp8su
         +72Umi34L0sBIQOrNsjPXuasV5vYi2xIrZZV9rJlNs2eMSbASMEGKyjRYZUAWW+SPNaA
         XIb85PB2wzfVhJ9eNVOrMwlJVXu1ENwx9lM0EnnlJIr+BEoAbd7ajnPz3uFTOnixPW6L
         5t0DQY5WH6GJrxNytaCLR6BBSp1u/z6BbZoHp7rL9j2jmJJDbHTMSRqfsokTIZHLfZpV
         F5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D0cA3C0eG7kggyL8SeHset03gOJsYQxzQOj2Aw+eoHU=;
        b=KwIqlDzcjf4OVSB5iry4RVyBV/Qcg6zstPXDbU7ZfGzz9r4MWaCwSX38aWMfJOoSg0
         QF7Xbryx1YL2nYW3RVE1OkigK0Cxxqkfpbq3hsooYoPMVBLT7IZtk/qujV4ONvkcUXoh
         tj3QA1ATNmsdRFpzrfGDLIvUSw7J0kkUJt3QeZpnmglHxHbayHBDZpf5Yp2NgC71oFos
         rMB2DDV31TqbvLmO3CisrTzISO5fQa4GmO3DDwh6FVQO1p8yxMmB/pNYW1gYofnEYDZJ
         GAFMd28e4Fg7ocVVwFf8c94+d33gMHRbX24XtflKsW0eKODwNXn0dAiQhFDO9t/RQPPQ
         vGmA==
X-Gm-Message-State: AOAM532wQ8zCV+WLehSbz5bDzwFgZSZHeIzVd8Rx513LIwamvVzc7lLK
        XUYD9p00BYI49Dr3THm4mHSA+tRuYiw=
X-Google-Smtp-Source: ABdhPJyyFEhMcV10tUnWvxpIWi9JntQD3CLOzZXIoH5NVJbYJXwVd1oVE3XV8dmcEOXjRlrcx9/VjA==
X-Received: by 2002:adf:f04c:: with SMTP id t12mr52045546wro.382.1594143668082;
        Tue, 07 Jul 2020 10:41:08 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.97])
        by smtp.gmail.com with ESMTPSA id c194sm1977405wme.8.2020.07.07.10.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 10:41:07 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/4] t6300: test refs pointing to tree and blob
Date:   Tue,  7 Jul 2020 19:40:48 +0200
Message-Id: <20200707174049.21714-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.460.g66f3a24dd5
In-Reply-To: <20200707174049.21714-1-chriscool@tuxfamily.org>
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding tests for refs pointing to tree and blob shows that
we care about testing both positive ("see, my shiny new toy
does work") and negative ("and it won't do nonsensical
things when given an input it is not designed to work with")
cases.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6300-for-each-ref.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index da59fadc5d..371e45e5ad 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -650,6 +650,28 @@ test_atom refs/tags/signed-long contents "subject line
 body contents
 $sig"
 
+test_expect_success 'set up refs pointing to tree and blob' '
+	git update-ref refs/mytrees/first refs/heads/master^{tree} &&
+	git ls-tree refs/mytrees/first one >one_info &&
+	test $(cut -d" " -f2 one_info) = "blob" &&
+	blob_hash=$(cut "-d	" -f1 one_info | cut -d" " -f3) &&
+	git update-ref refs/myblobs/first "$blob_hash"
+'
+
+test_atom refs/mytrees/first subject ""
+test_atom refs/mytrees/first contents:subject ""
+test_atom refs/mytrees/first body ""
+test_atom refs/mytrees/first contents:body ""
+test_atom refs/mytrees/first contents:signature ""
+test_atom refs/mytrees/first contents ""
+
+test_atom refs/myblobs/first subject ""
+test_atom refs/myblobs/first contents:subject ""
+test_atom refs/myblobs/first body ""
+test_atom refs/myblobs/first contents:body ""
+test_atom refs/myblobs/first contents:signature ""
+test_atom refs/myblobs/first contents ""
+
 test_expect_success 'set up multiple-sort tags' '
 	for when in 100000 200000
 	do
-- 
2.27.0.460.g66f3a24dd5

