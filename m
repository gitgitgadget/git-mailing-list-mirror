Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76F881F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752355AbeCNSdd (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:33:33 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:47536 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbeCNSda (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:33:30 -0400
Received: by mail-vk0-f73.google.com with SMTP id n23so2673339vke.14
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=jVXVww5A5bn1Ppw0juUPt9s7aHF1mStWQ991AV7l9w4=;
        b=DPat4sQxzIqq5EfA4wuwZTKZJVn2K2psS0A2EWTlePDUjrikdyuXJ+lOlo21v3K6q+
         Ysqm5JnH6nouRN5izMk12gKctaFLxb0iJ6aW8mPJ7e97b+6bAWng8enayNQByuYfMcmR
         IDF/N03CqZIAl5GW+ISAbJtW6nbEaxgyEHRAQuhbrcQXFFSGfQLhnB4a/AtuVVaEL0vb
         KfHOsnXNx7hmFqA8qkbblecFiBX347mXmx+YNFsXc+9SzbrJOVukQ3y/djQBxSSx3P6I
         EEQ9VYGJyxwJrtW4Dcxl/CEtOcK8qP1SsHu6elGP/wEOVYPuOFE+EEIPLPpwnJj0LA6H
         AbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=jVXVww5A5bn1Ppw0juUPt9s7aHF1mStWQ991AV7l9w4=;
        b=bYlqx9G+EpODF0u7h+AggZR/aiJkBszKK9DvT6K7Ie8TmiStM5Q9tiTzzjobCI1/J/
         PMCLP5Cqkrm26Q4YfR48n1UT+XKwS8pn+cvqtUeWLJ4cNO98U59cY+A13ji0k9xBTznS
         oiKKHF23Z8H6GBgk5vFxR7ap4DUbRP8ES6QaQ7CZABbmk0CjIA4TAm5p/HGQJyID92cY
         SL8P1ncis27ESx2Wx8Awv8QuegIvibJq36EcylSc1quWjuBmp3jP7I/juTPCksGmibmP
         j/tuY5wwFrC18sW658sXUMnwvrsf7o/0bTBbRyvkRplbTrL1FCK10uk1vzM8WIsf2zI+
         rD/A==
X-Gm-Message-State: AElRT7F6jpdZjVpjt7pQqna1ABKGZYyIiKGqtc3m8S1M+5krNB51lwGv
        QNgdigEWDMxoj6gqiZH+SJJGWZ231XqNX1jQfG3TL8e8nKO3F+a4TYWyWr+xJeblsu+OEKM6lxm
        M+8avZ3c5MXe3mTYZHM7KO5VQogIO8f8LzVgi13dGLj1YquwSMB76pDUcFQ==
X-Google-Smtp-Source: AG47ELslAusRwnbIsm9aGLMDFlthuN9qk6keBJPfmjIex51b9mkrXDDfiV7koPAOpPZdwXNj/ie75DKh/qk=
MIME-Version: 1.0
X-Received: by 10.159.54.36 with SMTP id r33mr2460088uad.2.1521052409415; Wed,
 14 Mar 2018 11:33:29 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:32:08 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-32-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 31/35] http: allow providing extra headers for http requests
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a way for callers to request that extra headers be included when
making http requests.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 http.c | 8 ++++++++
 http.h | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/http.c b/http.c
index 5977712712..e1757d62b2 100644
--- a/http.c
+++ b/http.c
@@ -1723,6 +1723,14 @@ static int http_request(const char *url,
 
 	headers = curl_slist_append(headers, buf.buf);
 
+	/* Add additional headers here */
+	if (options && options->extra_headers) {
+		const struct string_list_item *item;
+		for_each_string_list_item(item, options->extra_headers) {
+			headers = curl_slist_append(headers, item->string);
+		}
+	}
+
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
diff --git a/http.h b/http.h
index f7bd3b26b0..4df4a25e1a 100644
--- a/http.h
+++ b/http.h
@@ -172,6 +172,13 @@ struct http_get_options {
 	 * for details.
 	 */
 	struct strbuf *base_url;
+
+	/*
+	 * If not NULL, contains additional HTTP headers to be sent with the
+	 * request. The strings in the list must not be freed until after the
+	 * request has completed.
+	 */
+	struct string_list *extra_headers;
 };
 
 /* Return values for http_get_*() */
-- 
2.16.2.804.g6dcf76e118-goog

