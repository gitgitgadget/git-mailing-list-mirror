Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689C7C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiCUXSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiCUXSg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:18:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8902A31A2A3
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:08:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u26so4118414eda.12
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/H3pUHeOhQe+SrPebatrTC/XrxWw4GQ1U24PBqYvkV4=;
        b=Q97Zs7EXP5LMOLKV81b7y+wYlq9rpxwD8fW9+5ZEswnao69nlrJHNsl9EY0QrlUsXA
         D9ZxrLZ36D8hdvXQK0qeUKEUnWMfWDNgfdKfubvZlGdwn/eEVa7RfeSrfODgXrwKTVzb
         /qHc9gRqnfBY7QsjvaaYiHzyE34RGkYSieS6DRg6EgmpzTNz116vHuWCG9kPBz0XmBH+
         Pwl9SnLaPGS1OaXspPSTiinYUeLXiR73zFaXemiLlx4SRo2npFhnvoIBn9ZwyQr6bEDr
         EohED8fR5NxFEvEbTGXlKZ7RJ88mtkzUCIHcIMFusoiYk+O2yWVdiTm6987s4Y/fNaYR
         QE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/H3pUHeOhQe+SrPebatrTC/XrxWw4GQ1U24PBqYvkV4=;
        b=wv3F9INCcGAw3OUZjXX6MLWW61w4BDp03IM/zizRnuDbml/s9g3ixoHIeCLUa/sqyH
         u0Hyv5kX/4Sc1usZ6NtiLVRslklk+hkoS45uDNP8VKgi9wK7BM7+Alg44D2cc38+zHsX
         T6A+TWNv40OCAMyrjnspuiVEzdxrZ4Oez9DsZh54uwhJv1mNO+QwD55OYgOI3QG3HF6/
         PQ87uqMN3P7cC1myv0bXVB1feer4lJd1lWZ0ci3wM7smaxTjnIID9J9GBnH68JDVznXK
         6eRQjUDLZ7fsQ+KYZxlBtzg9BRyMk5anE263d2TCTkxlMaKupfWMWZpf3Yom88sJl2vC
         MZCQ==
X-Gm-Message-State: AOAM533uNoR1t1tQAdjqliie5Nw8wgi2i7tc1ReIXfGheenp7mfpf8cE
        rkWJfR1VTkjoPlKAk153Aw/+2GdM/pQ=
X-Google-Smtp-Source: ABdhPJzvgZU5EAOM51Id2aFUMMGFOW29xwLkuYSO8KA6Z8JYxQwIXTNsJvkCWrwFlM5D3neG9Aaexg==
X-Received: by 2002:adf:fb90:0:b0:203:b456:c71e with SMTP id a16-20020adffb90000000b00203b456c71emr20028883wrr.244.1647903369867;
        Mon, 21 Mar 2022 15:56:09 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:56:09 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 30/41] parse-options.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:12 +0000
Message-Id: <20220321225523.724509-31-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Use the C standard EXIT_SUCCESS and EXIT_FAILURE to indicate the program exit
status instead of "0" or "1", respectively. In <stdlib.h> EXIT_FAILURE has the
value "1": use EXIT_FAILURE even if the program uses exit(-1), ie 255, for
consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 parse-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index 6e57744fd2..0ee82fb760 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -883,7 +883,7 @@ int parse_options(int argc, const char **argv,
 	case PARSE_OPT_ERROR:
 		exit(129);
 	case PARSE_OPT_COMPLETE:
-		exit(0);
+		exit(EXIT_SUCCESS);
 	case PARSE_OPT_NON_OPTION:
 	case PARSE_OPT_DONE:
 		break;
-- 
2.35.1

