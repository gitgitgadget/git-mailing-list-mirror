Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F94C1F463
	for <e@80x24.org>; Thu, 19 Sep 2019 21:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404785AbfISVrZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 17:47:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38167 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404752AbfISVrX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 17:47:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so51739wmi.3
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 14:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RazKrauLyf3eR3loNnETxuCAj8KIdKjh9EVcghLs9To=;
        b=nuMOY4GzZ9+2MvBiVNcFa3B2Ie4bHczKd7x4gLVVH3bkkleOefk6QirZa3uQKpWcqw
         QBLKJPHgaogAMGfQde1xFlEJsLtJFOFxzyo75ippQLt6zLhjifL368S+pnZeeFuGG/k8
         LdjQvEQKUn1E2IeThoYWgap1zORH0jbS8PsnPr/IUW+A/ZhtYD0Ijmx+XZjMavXxxCtZ
         2xGhJd4DPkxPAvovBosReqDRSVEEOVjD3ugDsbXeJhQ/PN/yia5rMfm1mbdWUdY3rSlZ
         gx/I/zRhpCZW2GUU0IVh2hGdKSVWZZuMymk1q3u72tE4u+zWLo3JY27ldjV19fsoVIz6
         FrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RazKrauLyf3eR3loNnETxuCAj8KIdKjh9EVcghLs9To=;
        b=VdBF1tFuM0fSWvBXJVBqIRLJm5bJCu7DJzmV6/0QO2fEoC5aak1iQqXw+zo63xu1rU
         rDDfgFvk+M+6OtOIDF72kmJbIqx329vLT6kNSBjpk8WyP6b/4qrj/GpKKL7B0fg+J7z5
         jT7D4Y2WziroHeGh6IB7EsZhSVHnQYN84EUrem7KJZjXPyqLwU2UlXAujYO8zHyDdSsi
         bn6xAxFWvwIu9ohIwBKWh3f82gC5XhSDXltssyF4Cwm0ARZ+4dF3fvLzx6F29C/CYDa8
         vu0XBVp/deot/eaQvmV3LJKP+VWmYCRJOeY3+4Fpq5ghJ6875GstsgIEwjlhjRZ1D0hC
         4/eQ==
X-Gm-Message-State: APjAAAUV583g7Bjv7QFrkTJ5tUEq3nCbKgVmUXXLYIh9GkBqOnyrucoE
        1dfaDd/Qrl3EP1FIqA1vRaEu5MxQ
X-Google-Smtp-Source: APXvYqwrMbNjx9KidYSlHBkH50seo4vVCZo+cBS0kw/cu1brtXE+dKXB8RtjUsgm7xuWTiQPpeV+Qw==
X-Received: by 2002:a1c:ed04:: with SMTP id l4mr21014wmh.81.1568929642478;
        Thu, 19 Sep 2019 14:47:22 -0700 (PDT)
Received: from localhost.localdomain (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id b12sm12280wrt.21.2019.09.19.14.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 14:47:21 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 03/15] name-rev: use strip_suffix() in get_rev_name()
Date:   Thu, 19 Sep 2019 23:46:58 +0200
Message-Id: <20190919214712.7348-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
In-Reply-To: <20190919214712.7348-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use strip_suffix() instead of open-coding it, making the code more
idiomatic.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index c785fe16ba..d345456656 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -317,11 +317,11 @@ static const char *get_rev_name(const struct object *o, struct strbuf *buf)
 	if (!n->generation)
 		return n->tip_name;
 	else {
-		int len = strlen(n->tip_name);
-		if (len > 2 && !strcmp(n->tip_name + len - 2, "^0"))
-			len -= 2;
+		size_t len;
+		strip_suffix(n->tip_name, "^0", &len);
 		strbuf_reset(buf);
-		strbuf_addf(buf, "%.*s~%d", len, n->tip_name, n->generation);
+		strbuf_addf(buf, "%.*s~%d", (int) len, n->tip_name,
+			    n->generation);
 		return buf->buf;
 	}
 }
-- 
2.23.0.331.g4e51dcdf11

