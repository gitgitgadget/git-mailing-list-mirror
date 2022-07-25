Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E6AC43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbiGYMj0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbiGYMjS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:39:18 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09AF1ADBD
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bp15so20326825ejb.6
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kPNWGnupjGHCgGvAXRO3Y8gzz0I8k0opZJIiSMB1T7w=;
        b=Hsxt3aZOW23B2tlCJZ/pFpfj9DhsaAOozURBCxR8DiFjg1r7s0eG0ptFYjcurU4d8L
         600pUEvPrvIJWtva5WUFtkmfDEP5YVGPxlWtyeJCIiRDZFBr9o3fr+rfzM0p1IZP2ynt
         ifmWuKyOl6zcyrVhw1DcjeddctqRHgfcoM9m5YiPl23WCRgE8Dc/ScKunsk1s4iIBXUV
         0nWvqtMT7mAMebfBc3mMyXfmQHxziWQXFCb8V/bctAAfpQlpylPz6NmjLIe9T9DTTd2n
         PKTf+2f25EpEDPaRHKGUzCtLHm1+O7VPM0Dh7USttBoIJw/u+2tg/RhLYBXvZnsYn5f8
         bRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kPNWGnupjGHCgGvAXRO3Y8gzz0I8k0opZJIiSMB1T7w=;
        b=VAA0DrHCfaJP+SZouK8Vh+v7ne5pnXdsB+Zs5iPzv3E67qE4BXiHnM1txuE7VnQFdE
         Wz/vPhmuQM6M+F8LI20cS0jXJsj4vhdk1qJNu0E3Toc9qBdxXMU40euWAGAAXL2I1nUY
         yT6errH9/JRTzvUiGk28MsvFFSPHgUUhZavWZDZIAhvV2/U90qmGyAOwBBu6birgeL1d
         LP8jJY7W9+IJy3TDaPmw5ibilIk9ydbNOs1EwwnCz0y/uBFyNreBlzlgqTlCLoVCZRNz
         gU7JT5jG0jO+QDoPr4BhpNLUCd+Ye2tWpJOXePoqabupkathsJ/OBlfrLlv7kQV0z1aA
         2/OA==
X-Gm-Message-State: AJIora9qJxsOQBANs/3e/25rv/vU+VDBA2k+HWRCJ2vivN2LzNfjeFiG
        o+HFz1eOEqwLMItGE6S+qrUY8a7Iv9M=
X-Google-Smtp-Source: AGRyM1tJEuAF9LlW4EUjyQL+VBhOayXiY912BZOL9ZnQBbcljRpoi92fH7m7lRKn69My6Avg8bG+Vw==
X-Received: by 2002:a17:907:7347:b0:72d:78bb:b0d7 with SMTP id dq7-20020a170907734700b0072d78bbb0d7mr9641594ejc.45.1658752753886;
        Mon, 25 Jul 2022 05:39:13 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id fd16-20020a056402389000b0043a7134b381sm6922616edb.11.2022.07.25.05.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:39:13 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 07/20] parse-options: clarify the limitations of PARSE_OPT_NODASH
Date:   Mon, 25 Jul 2022 14:38:44 +0200
Message-Id: <20220725123857.2773963-8-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.1.633.g6a0fa73e39
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the comment documenting 'struct option' to clarify that
PARSE_OPT_NODASH can only be an argumentless short option; see
51a9949eda (parseopt: add PARSE_OPT_NODASH, 2009-05-07).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 parse-options.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index 591df64191..8cbfc7e8bf 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -109,7 +109,8 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
  *				is last on the command line. If the option is
  *				not last it will require an argument.
  *				Should not be used with PARSE_OPT_OPTARG.
- *   PARSE_OPT_NODASH: this option doesn't start with a dash.
+ *   PARSE_OPT_NODASH: this option doesn't start with a dash; can only be a
+ *		       short option and can't accept arguments.
  *   PARSE_OPT_LITERAL_ARGHELP: says that argh shouldn't be enclosed in brackets
  *				(i.e. '<argh>') in the help message.
  *				Useful for options with multiple parameters.
-- 
2.37.1.633.g6a0fa73e39

