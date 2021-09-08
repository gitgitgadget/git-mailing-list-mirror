Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AB4C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 07:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E23760F6C
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 07:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351060AbhIHHrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 03:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350731AbhIHHrV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 03:47:21 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AE5C06175F
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 00:46:14 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 22so1602048qkg.2
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 00:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fggER/0eLEI+c7gd088LckwH+XWNUrajimbW0gPCslE=;
        b=duZ+j6VN36GdK7P+c9qFIzRcvySHxFj9vjLbl9/2NNvjo8QMQCLhZ0YZxC1MXu24hC
         4TqgsMkccSJcckxhigQxLYl6cNJu9qf1lkkEapojXOEgxsCqu8irkuyaKNtMFCy5ZMlI
         GczDZMw/pocsnxo6ltmcJzV8SAKaXJPgTqbP4oQMtbl0rB/PI3nsONLt6UZEQBdcrBeq
         v1evUVdmceXVzIPz4VMDk2CPy/GX+PZMJM5UM5mkw9CmTDbJGcpN2vVoJcoGgryXV5YC
         9Roo5k47ykGsxr08SI0/1ZpdUfq3ZM/1PVlD358LDcP0J3m1LbVuplHDkbtGYjOiI4zK
         WNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fggER/0eLEI+c7gd088LckwH+XWNUrajimbW0gPCslE=;
        b=TgcYEI90dQt0lFuZgfzzCpxjRdLwxRRGIcYsAn4QUFmuANa+RFzFBw6jYwnpsX+4z9
         dpNDZb0S4hihOxj1e9nt+k+/actACxTQO+PAz+4og1ry/sftKrJxqw7QFqX1QySAxL4L
         wwquCfcMHAc14RsaxoRK9D88wnY4PTmVPUbPLNnPIoJozO+LMzt/K5NWbW0tB40g2ap+
         8hD75eV6zzW/Fc6io7f6Y+Kxr5XPtxvVhL/HJSYRji9S3YLE4s2vG1cc9qkDTOHXULXv
         PyYkANr4RxfYeoPqhrtsBPCUQemX3dT2AYLvwYT05Ga6FwVtRNlGIBLYzKwjPyMfz7xf
         gXCA==
X-Gm-Message-State: AOAM530zcGg3yb7JubSxcs9tPcDhPtBLAn9vCAAspB4mlJcuB9dQjgJ9
        fiqeTVPPp6HB5is+DmP0TetOc1BtLzM=
X-Google-Smtp-Source: ABdhPJzOev25iscn/LlbYovlAMvh3gyxPN7IN9KNGCjFDM0vi4Nm+3VF7KMu1AhhnKWziEx1CWFHYw==
X-Received: by 2002:a05:620a:166d:: with SMTP id d13mr2030961qko.491.1631087173497;
        Wed, 08 Sep 2021 00:46:13 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id v14sm1122935qkb.88.2021.09.08.00.46.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Sep 2021 00:46:13 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 4/4] fixup! reftable: utility functions
Date:   Wed,  8 Sep 2021 00:45:57 -0700
Message-Id: <20210908074557.38141-5-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210908074557.38141-1-carenas@gmail.com>
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
 <20210908074557.38141-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 reftable/basics.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/reftable/basics.h b/reftable/basics.h
index 096b36862b..0645b74196 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -54,7 +54,6 @@ void reftable_free(void *p);
 void *reftable_calloc(size_t sz);
 
 /* Find the longest shared prefix size of `a` and `b` */
-struct strbuf;
 int common_prefix_size(struct strbuf *a, struct strbuf *b);
 
 #endif
-- 
2.33.0.481.g26d3bed244

