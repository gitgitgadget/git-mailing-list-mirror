Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BC6C7EE2E
	for <git@archiver.kernel.org>; Thu,  8 Jun 2023 16:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjFHQZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jun 2023 12:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFHQZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2023 12:25:29 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327FF2D7C
        for <git@vger.kernel.org>; Thu,  8 Jun 2023 09:25:25 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-566586b180fso7010007b3.0
        for <git@vger.kernel.org>; Thu, 08 Jun 2023 09:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686241524; x=1688833524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3gsvk45dhJfH7QYGYy2F/HZGCeRV1n6lf/CqK0tN5iI=;
        b=WwAKdxo259xfLabA711k5D/7mKJXqi9IFhPhxNsc8BDJQVf/fCz1pmZqUUmyBtOeMS
         fBkj7EmMiLebjIFhHOvTIBQaC+urif0AIDtDV/yb2ThUE0pJEG8zjdSTiWzdHxXM1FcE
         LvE3rZO4s3+Z3ZE5dc12wivDgruCcP/s4DVMSOLVIbjEIPgrq8jHQ7zpoDw1bW25Oync
         wVU1MfFKldoPTQ7q872lv2PZH2Z/C6Hz+gB04tUAncl80yRWydgmCLWGXjf6pd8tNpZX
         NU6YFP2vBOJmZmGoZERqxKke51Kt66pjyrSsLqMqkE1ieQ997jdNA7Hn29oJ8efscRtZ
         MwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686241524; x=1688833524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gsvk45dhJfH7QYGYy2F/HZGCeRV1n6lf/CqK0tN5iI=;
        b=i/usGnn+ipLD4tSWeaNOqeT2VtnQtwpP5jlsBn6nyb04JwfkRaZ7qme2DqiPW9utkC
         vw92GKX53hiJnOx9ctzHNNdDtDphhlC8pRUj7rozmLtJgYEDFPjq5xSXprexYTek3zMd
         sQKFpGS4KYjJMj5u3l6UBtBY6HQz9khe5/zM3nlAPVpddHfsOU60kO52cs/M7q2mqgIG
         PYZWqzbc9/8Il42fjsMGmKG6eQw/Az3XYYELjmTkdmFWPdonvcbbbNItIeuHRhqGuQzF
         Tj8Z7xL304ZVUwWHKeE26zoVzaeuqm58fuwCNqqw9DqLptwf/0pitH0404AxmdP/EZo7
         rmqA==
X-Gm-Message-State: AC+VfDyvruwgBkrOqQy3sR8lC3cIxXbaX6ry2VqxzSIOJFyr6IEC/mR5
        Zspw51XVcDaQB6ZLjnziYzdyC9EtMv4JPs4qAN76u5A9
X-Google-Smtp-Source: ACHHUZ5oYdqY3FZbVSeJZPaNYsE/ENYzn3btg9XHBNEjm1WDnE7rDFNx3x2gZ8FnbyloA5K78/xMQg==
X-Received: by 2002:a81:48c7:0:b0:568:d586:77bf with SMTP id v190-20020a8148c7000000b00568d58677bfmr185378ywa.23.1686241524169;
        Thu, 08 Jun 2023 09:25:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y63-20020a817d42000000b0056507de3d82sm6705ywc.104.2023.06.08.09.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:25:23 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:25:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/3] object: add object_array initializer helper function
Message-ID: <1fff8208746c4c6e0dca7bdfb554cc69e6ead5b4.1686231639.git.me@ttaylorr.com>
References: <cover.1682380788.git.me@ttaylorr.com>
 <cover.1686231639.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1686231639.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The object_array API has an OBJECT_ARRAY_INIT macro, but lacks a
function to initialize an object_array at a given location in memory.

Introduce `object_array_init()` to implement such a function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object.c | 6 ++++++
 object.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/object.c b/object.c
index 6d4ef1524d..f1adb458b6 100644
--- a/object.c
+++ b/object.c
@@ -356,6 +356,12 @@ void object_list_free(struct object_list **list)
  */
 static char object_array_slopbuf[1];
 
+void object_array_init(struct object_array *array)
+{
+	struct object_array blank = OBJECT_ARRAY_INIT;
+	memcpy(array, &blank, sizeof(*array));
+}
+
 void add_object_array_with_path(struct object *obj, const char *name,
 				struct object_array *array,
 				unsigned mode, const char *path)
diff --git a/object.h b/object.h
index 5871615fee..114d45954d 100644
--- a/object.h
+++ b/object.h
@@ -58,6 +58,8 @@ struct object_array {
 
 #define OBJECT_ARRAY_INIT { 0 }
 
+void object_array_init(struct object_array *array);
+
 /*
  * object flag allocation:
  * revision.h:               0---------10         15             23------27
-- 
2.41.0.3.gb80d17c938

