Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B65C71F462
	for <e@80x24.org>; Mon,  3 Jun 2019 22:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfFCWWs (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 18:22:48 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:44623 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfFCWWs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 18:22:48 -0400
Received: by mail-pf1-f201.google.com with SMTP id 5so14599622pff.11
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 15:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MpignxmIJkgTLrAMbF4J69HPmNsS0BZYSCRncVOk5O4=;
        b=so/CPcf/OEevJsrJ+tgQLSAFm/JGygSbA/sjN381U8MR1OeFc3I8Pm2tgktXHhoqux
         pPo8z6szgb0YnDjjsev7HJULJsvTDOu7ayPpObuPSPMdoEJr4edpSCXIeKNe4v2OfadS
         R2ggwe7dTFObKZE5qME2WUtUGEyyzHBHcYnK/9RCmt7l3g6u67nLmeoofFXRKBLsQfcK
         ACxMAmyX6dU4I4IQQ8kVGDuMzYHhh624LAkHv34mvfhzKp+g4cZl7Q5unyzYizWJo7cZ
         HBNIxg3PO7CJ0aMLkOGycrNusHGVwm+xXBGZJNFiZUkA4G8B/j5d4lF3+F8T1lZsnFST
         +pVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MpignxmIJkgTLrAMbF4J69HPmNsS0BZYSCRncVOk5O4=;
        b=mKhQ1Rv+AiPSRyL+XJXHM9epIKT7O5MWUAa7q8yF4vkON+v7Vv7JvQYE6sdfvy4FJR
         l9QzPFNkezhVUgg00Y9yEEO/8P7OcI7mL0fXHCPqJ0WXfw4OKIDD7Vhc2Db5qBe7DzMm
         +vIRBV/WMa3fUnH4WfvaqKLAj/heN7loSc80soA3gy7YxeLYvifsRu1/vNgU3vOn97DV
         bSw9Kbp5fzVF07H3PsC5sAVUrytiTeashOv4hiiiizU0OYQ1oI6Xy/VriMZ0eQWaltPK
         3TfCpcvrXeL0A+YtZm8nB5IrWZvCRWxpGJU0h1FeJHwMOPa8XQTdNa0WpDpUoimqtBN4
         JRkw==
X-Gm-Message-State: APjAAAWfHpcMc5XeD81JVXv/P1lq5ovpo4IM1srTZOGN28beXplhzAyN
        tLRSmxMVRhfaW0b9Zxq5vSCBn7sfnipmxJU8HRs19jTdMIQnAPIaYlElqe+K3Hu9bVuCDcWtY/6
        SUCUmYuDYJUdiwiYkvHMceEbAA05KbNBNmoxHMHOyA+rJl9AzEc0WwcR1x8U=
X-Google-Smtp-Source: APXvYqy8ENBN643usOfrH/koitHiu0iKgz8l1fveRQEAx7SwQqFYjHbCClQBD4v1NDVxMA+mkIln5ukXWzkR
X-Received: by 2002:a63:d504:: with SMTP id c4mr22458054pgg.20.1559594744981;
 Mon, 03 Jun 2019 13:45:44 -0700 (PDT)
Date:   Mon,  3 Jun 2019 13:45:25 -0700
In-Reply-To: <20190603204526.7723-1-matvore@google.com>
Message-Id: <20190603204526.7723-2-matvore@google.com>
Mime-Version: 1.0
References: <20190603204526.7723-1-matvore@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH 1/2] url: do not read past end of buffer
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, jeffhost@microsoft.com,
        l.s.r@web.de, gitster@pobox.com, spearce@spearce.org,
        jrn@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

url_decode_internal could have been tricked into reading past the length
of the **query buffer if there are fewer than 2 characters after a % (in
a null-terminated string, % would have to be the last character).
Prevent this from happening by checking len before decoding the %
sequence.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 url.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/url.c b/url.c
index 25576c390b..c0bb4e23c3 100644
--- a/url.c
+++ b/url.c
@@ -39,21 +39,21 @@ static char *url_decode_internal(const char **query, int len,
 		unsigned char c = *q;
 
 		if (!c)
 			break;
 		if (stop_at && strchr(stop_at, c)) {
 			q++;
 			len--;
 			break;
 		}
 
-		if (c == '%') {
+		if (c == '%' && len >= 3) {
 			int val = hex2chr(q + 1);
 			if (0 <= val) {
 				strbuf_addch(out, val);
 				q += 3;
 				len -= 3;
 				continue;
 			}
 		}
 
 		if (decode_plus && c == '+')
-- 
2.17.1

