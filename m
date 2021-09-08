Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD75C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 07:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 895A360F6C
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 07:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350934AbhIHHrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 03:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347842AbhIHHrU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 03:47:20 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD97C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 00:46:12 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id c19so1089804qte.7
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 00:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8jYEYdb4/+oB77CrelK+lId/igW+AKA0EO9Jn9Fwucs=;
        b=ArfE+waGWMC+cBuDtIU90EAUmVeMIrTi+mofovds7s/viZE+VGXQOXfem4lHRQCyvM
         oHoggXTVrbdxD7GU0r4EPnUmwDMnqHA3uNtVfzCZ0UpYrkiAlJlvn1LfyD6arWjzejie
         hzjcmhnlViu1323duCIkUSDtOstEoo2qZ6sTAjzRICEzMCF6x70kPPHgWbW0oP0AArHY
         ViZ4X6K01bh/0PPaHAKFFE/rCLwfiN4cvyc0rgF2VFA3WwG5+1DbKBOFZh0eU9pQ6K99
         bd00bMXICCaFgGd2gIad6o92CRDNHvGYr6WOA8uGqO7svxb32Z9EOCgkXy58CFGZ5iLI
         cfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8jYEYdb4/+oB77CrelK+lId/igW+AKA0EO9Jn9Fwucs=;
        b=P+eFzMdG5CvNKTijm6QKu2TaMTnHHRfwFFMqROigIivIRntHWXILt07IHzyIlq5nC8
         YnfY5TFMiaa/8obBEuYdC6ddSD6wuvrYbohrUqH/8PRCb4muV0irBbhwuHgzW/DJd/tp
         0w2FgHsJxQoQDVMZedOfuarnbWn68uKNkLMnkcRNz6iChtwR9fB/HlXoyheDSJHKzvC9
         5ap1I2GmQhB5INWp87YpZ0tNm7+ocHzW/kHgfiWJospXylYkCdIZWlldZZ2atWjgIPOG
         /pkV8gQizuneEf7r3YPKEsO2N3WphcwOKLpdYQ6cUelx+lBUatRvoGsXGVl/OHn4uqTq
         hcCg==
X-Gm-Message-State: AOAM5332IiMEMn42VkH2MaMwTHop4cLD81SntFdCPEXhijrHNFtssEhd
        g3wboC7+QJtkWZnweG/sH9GviE1kdHU=
X-Google-Smtp-Source: ABdhPJyu/jPZSukGFDLC9FMB+5vB0nEDRy3oWh4s/x7TnvS2YdnfHs+t1NKKaZcTIZO1XqAvbMTknA==
X-Received: by 2002:ac8:750d:: with SMTP id u13mr2469874qtq.74.1631087171596;
        Wed, 08 Sep 2021 00:46:11 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id v14sm1122935qkb.88.2021.09.08.00.46.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Sep 2021 00:46:11 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 2/4] fixup! reftable: utility functions
Date:   Wed,  8 Sep 2021 00:45:55 -0700
Message-Id: <20210908074557.38141-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210908074557.38141-1-carenas@gmail.com>
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
 <20210908074557.38141-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

remove forward declaration for strbuf that is no longer needed once
strbuf.h was included.

add a conditional declaration for the zlib function that then can
be used in both the compat definition and the block.c user without
triggering -Wmissing-prototypes:

compat/zlib-uncompress2.c:36:13: error: no previous prototype for function
      'uncompress2' [-Werror,-Wmissing-prototypes]
int ZEXPORT uncompress2 (
            ^
compat/zlib-uncompress2.c:36:1: note: declare 'static' if the function is not
      intended to be used outside of this translation unit
int ZEXPORT uncompress2 (
^
static
1 error generated.
gmake: *** [Makefile:2571: compat/zlib-uncompress2.o] Error 1

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 reftable/system.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/reftable/system.h b/reftable/system.h
index 4f62827b83..4907306c0c 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -18,7 +18,15 @@ license that can be found in the LICENSE file or at
 
 #include <zlib.h>
 
-struct strbuf;
+#ifdef NO_UNCOMPRESS2
+/*
+ * This is uncompress2, which is only available in zlib >= 1.2.9
+ * (released as of early 2017)
+ */
+int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
+		uLong *sourceLen);
+#endif
+
 int hash_size(uint32_t id);
 
 #endif
-- 
2.33.0.481.g26d3bed244

