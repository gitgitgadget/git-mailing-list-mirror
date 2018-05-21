Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AC851F51C
	for <e@80x24.org>; Mon, 21 May 2018 23:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeEUXkK (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 19:40:10 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:49622 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbeEUXkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 19:40:09 -0400
Received: by mail-yb0-f202.google.com with SMTP id j129-v6so11078334ybg.16
        for <git@vger.kernel.org>; Mon, 21 May 2018 16:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=Fd41e11prUBJX1LHk7sF/78BhNyOjYEZpeu0Sk+4hZw=;
        b=CcVg1+BZ8AYzd0XFv7s4Zfi4D7ev/O7x+bvwFiD5HBCdzqTiBKh+VbP4C4d6fpS7EP
         UyhQl9lFaX8Q3RmZvR/H01zkr62ZGtQvFNpvYxb8e7T8nAV4lg8Ugf/RPWsZ5NGL9XA+
         KFQdKEkckMu/FeOckymAIAt7SaRH15fu5TZgtjiq7QRBGbutVytsgrVf6hJa0eI/Rl5s
         dqkpr5kzbhiGodPE7XVPOJfNlzu2nxDsdqJS3iP48HpYzS/XUd8axH48iyrkWOqSbWON
         ATBjxlBYR8AwHXO5P+LqR/MmYpj2sJwPbNSht558w/bsCsssTEfxE69VzNRrRTDevdJv
         nfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=Fd41e11prUBJX1LHk7sF/78BhNyOjYEZpeu0Sk+4hZw=;
        b=UClzO3B+szrlgBYmRERtaUe+R7aDpxdBNCz6ZfNXG7R80ihNlw1ZCURYgbP4+c6czQ
         ditwtEQ9d7pA+qDC3knMOQ2ubOqHizSdoP7cdekfA0RKq/ewycpwbbQgpRS8TXLKr9jk
         B68/imG34iTc21YDfKPYnxu8+7rtQISMgUGfxIPIWkuCOAsWIgzZmPMHeV99Q265dqvd
         pUpznvkBZmYL4D1k/fLSgsWrYIiL3HF2d/wSGw6XE5pwQPwhUxwyLAkhWlq9BloVWw0G
         NgzwkP+yVXB/M5jNoWuCherEcLWJ9CndPV04uwoIz4LKmf7ll0Z54OZo8V/UiVJd+y26
         YV4A==
X-Gm-Message-State: ALKqPwcWGv/Rf1AT0CvsuaP13BTkJ0Jq+FofJH4tsmGi8bdZAxI5GlYu
        dZJcXUnhCF16PVlwOLo8r9Ad4HZyGAQFQO2XLNttMvjNnd0sVc2VmB04DYxx+Ye+9ryxVrFUx9R
        xY0xHJ0JFxIv7CIgbXcfSNqbNlC14SzcmJwYYPuxQKMDIAWCyDwIfaugqRg==
X-Google-Smtp-Source: AB8JxZomiRIn0yMTBKNQUhC+aWbBcRT7JVolZegS3AMGq/xoJqblIf9M47w225nIWMGVRouoLj6uKEAJ7Fg=
MIME-Version: 1.0
X-Received: by 2002:a81:330d:: with SMTP id z13-v6mr6318462ywz.159.1526946008347;
 Mon, 21 May 2018 16:40:08 -0700 (PDT)
Date:   Mon, 21 May 2018 16:40:03 -0700
Message-Id: <20180521234004.142548-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 1/2] remote-curl: accept all encoding supported by curl
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Configure curl to accept all encoding which curl supports instead of
only accepting gzip responses.

This is necessary to fix a bug when using an installation of curl which
doesn't support gzip.  Since curl doesn't do any checking to verify that
it supports the encoding set when calling 'curl_easy_setopt()', curl can
end up sending an "Accept-Encoding" header indicating that it supports
a particular encoding when in fact it doesn't.  Instead when the empty
string "" is used when setting `CURLOPT_ENCODING`, curl will send an
"Accept-Encoding" header containing only the encoding methods curl
supports.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 http.c                      | 2 +-
 remote-curl.c               | 2 +-
 t/t5551-http-fetch-smart.sh | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index fed13b216..709150fc7 100644
--- a/http.c
+++ b/http.c
@@ -1788,7 +1788,7 @@ static int http_request(const char *url,
 
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
-	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
+	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
 
 	ret = run_one_slot(slot, &results);
 
diff --git a/remote-curl.c b/remote-curl.c
index ceb05347b..565bba104 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -684,7 +684,7 @@ static int post_rpc(struct rpc_state *rpc)
 	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
-	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
+	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
 
 	if (large_request) {
 		/* The request body is large and the size cannot be predicted.
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index f5721b4a5..39c65482c 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -26,14 +26,14 @@ setup_askpass_helper
 cat >exp <<EOF
 > GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
 > Accept: */*
-> Accept-Encoding: gzip
+> Accept-Encoding: deflate, gzip
 > Pragma: no-cache
 < HTTP/1.1 200 OK
 < Pragma: no-cache
 < Cache-Control: no-cache, max-age=0, must-revalidate
 < Content-Type: application/x-git-upload-pack-advertisement
 > POST /smart/repo.git/git-upload-pack HTTP/1.1
-> Accept-Encoding: gzip
+> Accept-Encoding: deflate, gzip
 > Content-Type: application/x-git-upload-pack-request
 > Accept: application/x-git-upload-pack-result
 > Content-Length: xxx
-- 
2.17.0.441.gb46fe60e1d-goog

