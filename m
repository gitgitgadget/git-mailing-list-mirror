Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 549D820970
	for <e@80x24.org>; Tue, 11 Apr 2017 20:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753421AbdDKUWf (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 16:22:35 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34013 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752790AbdDKUWd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 16:22:33 -0400
Received: by mail-lf0-f65.google.com with SMTP id x72so1008746lfb.1
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 13:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jung5PZGm6jt1Fg2wMmFxqfcI11O0dsvsb78B4Vt404=;
        b=VZ81v2uQsZVSaNCPGGgzhGZsV/dki90gRi4bdnIRn/MKzqCYkQk95Yfjko7MQ0XtZP
         5glAuzIxm/DiN4/bq5wX1HDoIwgU0CYULyOPIj39vbj5x9SQHLLXzeTziOMInxyjKEeJ
         AfQ73BzGDmq9nJUvcyUoqH+jq/d6xGo+92oM0BEPzPQjXaXrhBeUt+OqQmvEFBZoPF41
         5J6aIYZsbEJdGwzZLRHx3sJGVqo/mbc8AH8O67hTsE0KqbfCOx559UjXsGxd5VnMHx5X
         B4ypBkmZfJnO4x01KX9DBa/5F4oOIQtYTs1Fgy/VTjpE5jWTnMgBTx7i+WtrhvMWybuA
         I1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jung5PZGm6jt1Fg2wMmFxqfcI11O0dsvsb78B4Vt404=;
        b=QuzU+c/KZb6e/HhGVJ2XO+0Tt0w1X92fzxllyT+0gxm8EZFVqfYkIc+0NcPyA5VRbh
         GfnWnaZwNY9YablyYcIFpFW1EUsN7lyEyMIfn1CpmrQBdyg1dz1PaGs0dWwOuIebD/Nt
         LX1D3RFapWqfM+Hjwn991vIFyashtHCWa+B/61CsPuaDQgAvUXt7SDtT/iHtyWoTI4Ku
         7AmpDUeU4qv3EaL2fMMcLq45MPm2lo/q5vZyHWU7AlS1kXTpZrMPm85uqzK2aQsR3byM
         +mHljT9hcRCsFtP+4i5v+mYOY6m5XfRDvwBTUSsbTfOlCdameSfr9LPUjlfCGUeZt6Pg
         NusQ==
X-Gm-Message-State: AN3rC/4WkOaNPSRp3zoeunjS3CiVIg/jlXMytuFWKiCAa86YRsUt48Jpt3Jy3Gbh5QIbVg==
X-Received: by 10.25.72.9 with SMTP id v9mr2769762lfa.74.1491942151944;
        Tue, 11 Apr 2017 13:22:31 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id w78sm3681421lfi.23.2017.04.11.13.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 13:22:31 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Knut Franke <k.franke@science-computing.de>,
        git@vger.kernel.org
Subject: [PATCH v4 1/2] http: honor empty http.proxy option to bypass proxy
Date:   Tue, 11 Apr 2017 23:22:18 +0300
Message-Id: <20170411202219.20165-2-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170411202219.20165-1-ryazanov.s.a@gmail.com>
References: <20170411202219.20165-1-ryazanov.s.a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Curl distinguishes between an empty proxy address and a NULL proxy
address. In the first case it completely disables proxy usage, but if
the proxy address option is NULL then curl attempts to determine the
proxy address from the http_proxy environment variable.

According to the documentation, if the http.proxy option is set to an
empty string, git should bypass proxy and connect to the server
directly:

    export http_proxy=http://network-proxy/
    cd ~/foobar-project
    git config remote.origin.proxy ""
    git fetch

Previously, proxy host was configured by one line:

    curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);

Commit 372370f167 ("http: use credential API to handle proxy
authentication", 2016-01-26) parses the proxy option, then extracts the
proxy host address and updates the curl configuration, making the
previous call a noop:

    credential_from_url(&proxy_auth, curl_http_proxy);
    curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);

But if the proxy option is empty then the proxy host field becomes NULL.
This forces curl to fall back to detecting the proxy configuration from
the environment, causing the http.proxy option to not work anymore.

Fix this issue by explicitly handling http.proxy being set the empty
string. This also makes the code a bit more clear and should help us
avoid such regressions in the future.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---

Changes since v1:
 - explicitly handle this case instead of mangling the common code

Changes since v2:
 - fix grammar (thanks to Ævar)

Changes since v3:
 - no changes

 http.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 96d84bb..8be75b2 100644
--- a/http.c
+++ b/http.c
@@ -836,8 +836,14 @@ static CURL *get_curl_handle(void)
 		}
 	}
 
-	if (curl_http_proxy) {
-		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+	if (curl_http_proxy && curl_http_proxy[0] == '\0') {
+		/*
+		 * Handle case with the empty http.proxy value here to keep
+		 * common code clean.
+		 * NB: empty option disables proxying at all.
+		 */
+		curl_easy_setopt(result, CURLOPT_PROXY, "");
+	} else if (curl_http_proxy) {
 #if LIBCURL_VERSION_NUM >= 0x071800
 		if (starts_with(curl_http_proxy, "socks5h"))
 			curl_easy_setopt(result,
-- 
2.10.2

