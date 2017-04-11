Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31BB920970
	for <e@80x24.org>; Tue, 11 Apr 2017 20:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753433AbdDKUWi (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 16:22:38 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35844 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbdDKUWe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 16:22:34 -0400
Received: by mail-lf0-f67.google.com with SMTP id 75so1001386lfs.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 13:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m4i2WgRNKf9o0Uv+VFbfwPrEq3hFpSgQWuHSXdg9CSs=;
        b=pBscxNG33mK86b+zEPOu97vwUqBLoQ04DJkoOWAzH4dQlAAh/tRkVoq2m9FjGqM7Mv
         LGMh2j6x/Ldof67OW9yoE40hS2L0PURLP+m9OHbA3BE12MN93f3/un33HCcJf/9qdVEW
         p9uPPKe/jUkNbE51asHG7LQmEB25+A1L2jJAnqc1HZ7BFhfu4fDspYcZnmF+YFv8Hd9Y
         RfZO0eq+H5WimfJ95iEoXeX3Dt9CfHxT4HcdSJEn90uMQ61Ql+T3yp9V7MtwxYqfZXLO
         tHpKRL/GzzLLqha9orfB61iB0HVdnjM4Y4PifJmq+3c33yK71oqDe41NAEOsooBxD6bl
         Yybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m4i2WgRNKf9o0Uv+VFbfwPrEq3hFpSgQWuHSXdg9CSs=;
        b=iDI5ZykuE3784h2D3FcvdvlB1vEPhwQ42S5q+kqPSf9V21hnIUgoUKfqMD7GBTmKA7
         mW4EAe+oo0gvbmTkcO4xL0KT7JfVuBEW/94MeAx1GwskxKtgXwE8+oRr6DDLthNxuAdr
         pSrn9fyF7jB+jvJNUuEW7twBTutuKvBoPRaSKcdx7GxH/PXAes0zxhv53dKemjk/y0Cc
         hjuXK+0ziXgdr7uIK7jZuTK+f6s0EGYx8wd4DjizvO+XXbWbtk+VIntG9heLaEmMiHwn
         D8VEXk3jgphqNnm1fV/RQGuWs+KqOg5aumnv0Srm5Glt73RvgMIDACqRp/JDDNlZf+3o
         BoDw==
X-Gm-Message-State: AN3rC/5nN/6N3BjlZisvKAoa0VC4Ca0PqpsIuhoBGNtCznhU2p5P72F5HXWBIP96gcexlg==
X-Received: by 10.25.209.20 with SMTP id i20mr3022709lfg.49.1491942152930;
        Tue, 11 Apr 2017 13:22:32 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id w78sm3681421lfi.23.2017.04.11.13.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 13:22:32 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Knut Franke <k.franke@science-computing.de>,
        git@vger.kernel.org
Subject: [PATCH v4 2/2] http: fix the silent ignoring of proxy misconfiguraion
Date:   Tue, 11 Apr 2017 23:22:19 +0300
Message-Id: <20170411202219.20165-3-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170411202219.20165-1-ryazanov.s.a@gmail.com>
References: <20170411202219.20165-1-ryazanov.s.a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier, the whole http.proxy option string was passed to curl without
any preprocessing so curl could complain about the invalid proxy
configuration.

After the commit 372370f167 ("http: use credential API to handle proxy
authentication", 2016-01-26), if the user specified an invalid HTTP
proxy option in the configuration, then the option parsing silently
fails and NULL will be passed to curl as a proxy. This forces curl to
fall back to detecting the proxy configuration from the environment,
causing the http.proxy option ignoring.

Fix this issue by checking the proxy option parsing result. If parsing
failed then print an error message and die. Such behaviour allows the
user to quickly figure the proxy misconfiguration and correct it.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---

Changes since v2:
  - new patch

Changes since v3:
  - fix grammar (thanks to Jeff)

 http.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/http.c b/http.c
index 8be75b2..82664dd 100644
--- a/http.c
+++ b/http.c
@@ -867,6 +867,9 @@ static CURL *get_curl_handle(void)
 			strbuf_release(&url);
 		}
 
+		if (!proxy_auth.host)
+			die("Invalid proxy URL '%s'", curl_http_proxy);
+
 		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
 #if LIBCURL_VERSION_NUM >= 0x071304
 		var_override(&curl_no_proxy, getenv("NO_PROXY"));
-- 
2.10.2

