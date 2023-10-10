Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3887CD8CB6
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 20:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjJJUeT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344214AbjJJUeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 16:34:09 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C20DE
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:34:07 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7741c2fae49so399677585a.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696970047; x=1697574847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nid45Zo12ttb0THUqfggGnjWqUBDgJZZ2rA2o/8mJoc=;
        b=D5v/VRXah50gykoECRBmqU/TEV1qtqisBzoneGKyD+jcKPgNcedVQTvhGMF94+MPfh
         2sawpFhhEjQ/xDsOF5N+7Ryzpivj2kSK8nLMejX5PIZQO+ElOfcltHs5kkGpx79i98Pk
         gp2WdNSNAEsZP+kQ1QVbh51iQBi8is5Z0pWM7sUJ+PkbSEy8Jhc6AOvpPN9nPwd+5O0b
         Pfw1cMn6O6ZZxiFx7D4jOCBHdLkekChoPAsBTa6eJQLCcGrV093rtJ2tWTrTjXNGZV5G
         2Nwq8CEMFv/rEabAxJYQhnPttqaPBuiLxf3yl4vhSEmSY9tAmRM2IeWLtwSWNzIDcClo
         F3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970047; x=1697574847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nid45Zo12ttb0THUqfggGnjWqUBDgJZZ2rA2o/8mJoc=;
        b=RcMH6wUT/8DadvbQM5nTj3CaNMuheInjV8o2g562T6WJjdq9CqOzpxNFj1sIR+OM+E
         m1VcqB57avyekcnIiEaDzn4RcE65wWWV9i/5pZQDQmPcl0jqkkjgOO+Xnw0yWgyJsqK9
         K+rkrLWDZDN2CTvbFbWtBk7DkEbFJezqG15p7Uba8EZfy9yiGLQazGb10/HW38qFESEk
         Qj8ZDhiWfMyWFk+fM35ePuSmzxv/l74cGxOqL2AzegEwlecr3p7h0SddWdTSN9Tiwgxu
         iKn5yLGeh5xg5moOgnlLNkYBA2ygWmxlrt1sagjnYXhrFGf6YkxxJdeHCQhdlnjlCYOG
         Dg7A==
X-Gm-Message-State: AOJu0YxL/U6etxNt6QgrItnDDq+SHOnfuG5wUaO6rNIESTSqUnIzaYxq
        Y2klP1tIvCoZxnz28QDO26ZMgtlPwZ7/VP7O7zy3ag==
X-Google-Smtp-Source: AGHT+IFOu4ZtB4miM0mmYLnmvhDguzDB1DIdsVnEfcM8pdWSvK/augCjGlQQEeCs7reZDA8igFSA9Q==
X-Received: by 2002:a05:620a:f14:b0:765:a8b2:18dd with SMTP id v20-20020a05620a0f1400b00765a8b218ddmr22796864qkl.20.1696970046909;
        Tue, 10 Oct 2023 13:34:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d1-20020a05620a136100b00774309d3e89sm4638793qkl.7.2023.10.10.13.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:34:06 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:34:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 15/17] object.h: fix mis-aligned flag bits table
Message-ID: <1f7f27bc47eba053731e75fb7a4cb330065f6caf.1696969994.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696969994.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bit position 23 is one column too far to the left.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object.h b/object.h
index 114d45954d..db25714b4e 100644
--- a/object.h
+++ b/object.h
@@ -62,7 +62,7 @@ void object_array_init(struct object_array *array);
 
 /*
  * object flag allocation:
- * revision.h:               0---------10         15             23------27
+ * revision.h:               0---------10         15               23------27
  * fetch-pack.c:             01    67
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
-- 
2.42.0.342.g8bb3a896ee

