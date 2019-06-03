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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5575F1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 21:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfFCVo1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 17:44:27 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:34150 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfFCVo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 17:44:27 -0400
Received: by mail-pf1-f202.google.com with SMTP id o184so3953707pfg.1
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aP9b36dPhJup7puCR99RO4RR4U0WM2dM56bT/mLsJcY=;
        b=tXs1a1IV9AHKFaUQw6daNJF2E6zpXSOYe6nQH+e/hbdfp4TGbz+kMZe4itrDVuq4Lr
         QC9dbwdW5mHsApYoOn0BNnfxOGXOJLHI9FjbGewKdWeSm6cSgLZv0Lp3uu4iIrWho/L8
         pELfHDkt/jDbmLAXymKm0gYrC0Fd2ix5Z3u1q+/oupo1WMBX6hsLTUqbqT/eJTIVGJKO
         ymoUwFLOf5TfEiiKp7uIH3QK0p7l4jvr1fmzSJuYyH03RvcsdapuU2GyaM1luRMA5K6G
         Sy4RKz08KerwF4J7nB9yBCDA2D5SEmdsr2lLlWqr3sWJDAH2IdLcY2NNesmL+3e8KvXi
         0QAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aP9b36dPhJup7puCR99RO4RR4U0WM2dM56bT/mLsJcY=;
        b=SYDjmKdVbqXpabmt99W3DBkRdvRE83kV+CvytJyv0wzK75pNC5Tv+Eac93oyYoPDsh
         wjde4vaTLJG7rEG6GQIPVCOhJTd3X1WWc7Z0HD/Egba8chg1GU1EP8vmNdZtZpXBKjVy
         uM5BiS2vKXl2kQvY2kZBCM5M2mw6p/jFnXsaj5HU59Cu9DP57xZwd0OOnu5qtPmcSwaH
         g/nMlegf5wJWO7WuHhrm+LJWWn6ihTBJ5SQYD5e+LwigGszBUC1FfERHpk+/vHDbsVkA
         W+YB7vDSDsrbJ8V36iCjv8lcnLhFKAGaUR/3fNTi8lykCIVDrd7c7qWNOERzPToSNMYv
         9XZg==
X-Gm-Message-State: APjAAAW4ruBGC4np8iLYvE6/2fKGCmN3kRNxpWO0RjPA85vHeXe/669w
        yoibz1ctIO228pox5VWHkIq1zVH8FQPCpyscy1PxLicxbJqJ1FfDQes07HyQdaWVg/xZCjmQpqd
        NGc62apf7CbCds4KNxd6agtIoh4mcaP+48jCXDH0/NdZlhQgHT/DvY9xbudA=
X-Google-Smtp-Source: APXvYqyYhOO7xhrQVuUTFb417jAtgLD0U81g794Z4Ng5jQMhG04cEm2Js6wm6ZTVok8cgisXd9zmLt95ZV7x
X-Received: by 2002:a63:1b1e:: with SMTP id b30mr30595580pgb.180.1559594747755;
 Mon, 03 Jun 2019 13:45:47 -0700 (PDT)
Date:   Mon,  3 Jun 2019 13:45:26 -0700
In-Reply-To: <20190603204526.7723-1-matvore@google.com>
Message-Id: <20190603204526.7723-3-matvore@google.com>
Mime-Version: 1.0
References: <20190603204526.7723-1-matvore@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH 2/2] url: do not allow %00 to represent NULL in URLs
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

There is no reason to allow %00 to terminate a string, so do not allow it.
Otherwise, we end up returning arbitrary content in the string (that which is
after the %00) which is effectively hidden from callers and can escape sanity
checks and validation, and possible be used in tandem with a security
vulnerability to introduce a payload.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 url.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/url.c b/url.c
index c0bb4e23c3..cf791cb139 100644
--- a/url.c
+++ b/url.c
@@ -41,21 +41,21 @@ static char *url_decode_internal(const char **query, int len,
 		if (!c)
 			break;
 		if (stop_at && strchr(stop_at, c)) {
 			q++;
 			len--;
 			break;
 		}
 
 		if (c == '%' && len >= 3) {
 			int val = hex2chr(q + 1);
-			if (0 <= val) {
+			if (0 < val) {
 				strbuf_addch(out, val);
 				q += 3;
 				len -= 3;
 				continue;
 			}
 		}
 
 		if (decode_plus && c == '+')
 			strbuf_addch(out, ' ');
 		else
-- 
2.17.1

