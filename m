Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472D1C433E2
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 16:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24DCC20725
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 16:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSJrVHqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgGJQsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgGJQsA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 12:48:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50BEC08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 09:48:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l2so6564642wmf.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lYrDVd7wyGZYsrhz66x2LRHV4OKXEXPgDl0TkGx8avk=;
        b=hSJrVHqFFFGjcutOj/q1JtE124ECyVgTbYR7nw54ds83eDrqQHUL07Qb3HT5t5EmpD
         El0/fEfqGM/pxVnEj0Oa3i/zpDJxEi5mTci7bLu26cnvCRIhMxb6zkHy6cssAl9oRRkV
         htb8KvkgrRKpWdeHgQ6kOiGbjVD6RDvtvzLZApCINpH2P8XPGdS7OQv3d84moH4/BZwd
         6y9n6Ntyr/1HOKxN3AAk3CpT0q2eVu7zSl1x19NV+EUf64oAWQKbiUoUpo7/sEHWLQfI
         ph9Wm+7oVngm7+skTxwU2ee25iJYdmP7gNG4pooqh99mXwsdyLNpxCj6ZREA/4R29Y2w
         BnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lYrDVd7wyGZYsrhz66x2LRHV4OKXEXPgDl0TkGx8avk=;
        b=dF2EVWQSAoVzvY5k6bbAkepfmdiJr9/9ZYsYkb0IylGPs67TtzNLK2tvG/7BNIaRpE
         b8xO4lpeLqUmh1QEHW2NunoQLnSsBHApmYj8/CL30HSnrEbCVsgCMFezG5dDFDuXGcG9
         MBtKC20F0P4LcgjBV+R6tnSjOm3SSv6atMCQ+l2JU6lM+aR6ClwydCGxJUBIgn4WDdde
         N1F2AV4oA6Pf0zUSHec1EkvNs8WYktKrtybb2oKYdImDrqlHyT5YGw3ucgKgC/nCvfNv
         UhuiVYprNHBWo486+b+W7fdMMdiMtc8GprCaRgiA7IBX/YQaDlTUEMneumU7n+Cml6gy
         jhNA==
X-Gm-Message-State: AOAM533s7c2Ivf4qsjahambsYd/n4qqwxdI7Hu+7vD/vp69oHMcIu7cn
        aey+xocPPm/YFaAOemNWUrepJBj83hI=
X-Google-Smtp-Source: ABdhPJxT/aWrxBtEXPPt1VTIkcg9en1157DAuOwo+kpyKI9QbwHTuh09jNNdO5JMU63e040ImPKsSA==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr5930656wmk.175.1594399679131;
        Fri, 10 Jul 2020 09:47:59 -0700 (PDT)
Received: from localhost.localdomain ([185.228.229.54])
        by smtp.gmail.com with ESMTPSA id m4sm9883385wmi.48.2020.07.10.09.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:47:58 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 2/3] t6300: test refs pointing to tree and blob
Date:   Fri, 10 Jul 2020 18:47:38 +0200
Message-Id: <20200710164739.6616-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.347.gb620d8b0da
In-Reply-To: <20200710164739.6616-1-chriscool@tuxfamily.org>
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
 <20200710164739.6616-1-chriscool@tuxfamily.org>
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
 t/t6300-for-each-ref.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index da59fadc5d..e9f468d360 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -650,6 +650,25 @@ test_atom refs/tags/signed-long contents "subject line
 body contents
 $sig"
 
+test_expect_success 'set up refs pointing to tree and blob' '
+	git update-ref refs/mytrees/first refs/heads/master^{tree} &&
+	git update-ref refs/myblobs/first refs/heads/master:one
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
2.27.0.347.gb620d8b0da

