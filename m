Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7505C433FE
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbiEIR7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 13:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239807AbiEIR65 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:58:57 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4902D7EFA
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:55:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id j6so28290558ejc.13
        for <git@vger.kernel.org>; Mon, 09 May 2022 10:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ar5pAoqex4NIZtMdP8szFrrlwNua7QsgqQzukT7jAT8=;
        b=Z3Hx/t8+uii+hfGND4iwzO82iaa6osGr+W1xiK59QRq4LN0J6LKFszh5u601uteHJN
         i2Jvg9zrkWy2uWuToOal0l0SL4nupVECjDevzb8NdcX4sn3bVC4qLIXiEhArk2H/+Be0
         JL9VqU/OL9wL/gKLgIeAUcbEtbbj45Wq8/0N6bOk6UuNLk9OvkW0SFkXRXZotmtvWU5b
         FyVb4RzyYul3FlaF/xwpgcvquCLnXr9V+6ODe3A1zMmbLmGkFIrGjlkJrd8aKPOGYaqs
         UI0rNdotc82g6M0t6+y60e4uNrC0TfhT86hjP04Hu23RctKds2qas1Q+nqcYh9DJ6Fcv
         nBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ar5pAoqex4NIZtMdP8szFrrlwNua7QsgqQzukT7jAT8=;
        b=bAaCB/mBOhpUygK184nsm+tzutZFVjGokFuQExPZeO9SJFR4h2oNN34FapGyB3cNGY
         Z7sRaKdw0toZqdBHGbDIbbQS3WSB5Cy7Zr//69LOV3R/kXEaubvMd2D1bST4za6nziFx
         cRUN3M+wWorOWc/zAeiZOvmEDf6cepcjQFH/Ldp1mDDwuWco7KMdf/rgPjuvsJp5mqaM
         +5UAZOdb8xFQRf040YLVsdMMj5xUNxpNUpAvxlC7rKDEuIehGW/Wq+JDDs43yNOmUFWt
         HEdZu7MejGHoEvzSevjTQBRVXSjVb3q2oX+zoMmtBfG6TJtXjF9OQgEDDvdTzOFWEstT
         DauQ==
X-Gm-Message-State: AOAM530Kasi78741a0D8niR42dMoVqh8BJViizqxqWeg/Qg4q6/Cmwk4
        Hm8wzCW5W+GZ8qiXpO6EcYEPFjqqMKI=
X-Google-Smtp-Source: ABdhPJxWuQjw5sEww5fG4dwwx02GsxHtmxbLAYUTdKhvYa8h8yf9pFsgWPOXjQ+/zttOZ1whtSVg5Q==
X-Received: by 2002:a17:906:2983:b0:6f3:c1c9:1dba with SMTP id x3-20020a170906298300b006f3c1c91dbamr15876716eje.89.1652118901395;
        Mon, 09 May 2022 10:55:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a7c:1900:a49c:b216:27f2:528a])
        by smtp.gmail.com with ESMTPSA id l17-20020aa7cad1000000b0042617ba63bfsm6552883edt.73.2022.05.09.10.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 10:55:01 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, avarab@gmail.com,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [PATCH v2 04/15] test-dir-iterator: consistently return EXIT_FAILURE or EXIT_SUCCESS
Date:   Mon,  9 May 2022 20:51:48 +0300
Message-Id: <20220509175159.2948802-5-kioplato@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220509175159.2948802-1-kioplato@gmail.com>
References: <20220509175159.2948802-1-kioplato@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Throughout test-dir-iterator.c we were returning/exiting with either
integers or EXIT_FAILURE. Improve readability and reduce mental load
by being consistent with what test-dir-iterator returns through the
test-tool. Returning mixed constants and integers could indicate that
it matters for some reason e.g. architecture of test-tool and cmd__*
functions.

EXIT_SUCCESS and EXIT_FAILURE are specified by the C standard.
That makes the code more portable and standardized.

Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
---
 t/helper/test-dir-iterator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
index 659b6bfa81..81e931673e 100644
--- a/t/helper/test-dir-iterator.c
+++ b/t/helper/test-dir-iterator.c
@@ -39,7 +39,7 @@ int cmd__dir_iterator(int argc, const char **argv)
 
 	if (!diter) {
 		printf("dir_iterator_begin failure: %s\n", error_name(errno));
-		exit(EXIT_FAILURE);
+		return EXIT_FAILURE;
 	}
 
 	while ((iter_status = dir_iterator_advance(diter)) == ITER_OK) {
@@ -58,8 +58,8 @@ int cmd__dir_iterator(int argc, const char **argv)
 
 	if (iter_status != ITER_DONE) {
 		printf("dir_iterator_advance failure\n");
-		return 1;
+		return EXIT_FAILURE;
 	}
 
-	return 0;
+	return EXIT_SUCCESS;
 }
-- 
2.36.1

