Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 131791F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbeCORdG (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:33:06 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:38603 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbeCORdC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:33:02 -0400
Received: by mail-qk0-f202.google.com with SMTP id p189so4871498qkc.5
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=jVXVww5A5bn1Ppw0juUPt9s7aHF1mStWQ991AV7l9w4=;
        b=D7lROFSCD5DbIRSsdC8pMp3+tzwbHE+GrMsYIbtjmZAiA81Ggv2FO7RfPpgSN5bYUG
         s9Og0KwxfqiuBB4dVT/7uK+qiWcsKjXAjUvWLi+VE6TSNx41jlTzm62uLUgo6KOnoWCr
         B6UPcocr4UhJPlr4YnW+axg37vFqCZ6q8HTrjWn9x6fdCDOxqevVIfOWosLnu6YBT5MK
         pCbyi2EQ3fRo/So4RWwmpnH0i5H/d5RRZTTnWfeEwXwY9IGqeSRJQMgUbFwCDOn2HVGj
         mHMhiYCugf6Uj7fX0hgO/GIdC7wae42XAqWIUKzkjZOshO3KU4YaOOIe5HAWOKhag/Wi
         ySLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=jVXVww5A5bn1Ppw0juUPt9s7aHF1mStWQ991AV7l9w4=;
        b=tl5bxbq6CFQpEavzUoPaXOjGq1fDhxE+EZxYyLQLBmSshb5sKC0vpqZ2rrHxy8/Am/
         V7yNLzrTQfVEWaKWzkL9dxBmzMKfQqpY0XuGpX7t8LporlkRGUoSRG6dDKk0Lg5sJkqK
         l3tEIoyE+r22VSzFogqOHmulLs1x5iriySBhEd7aGLktgS8S9oNDiQAakffw5i03ZvNy
         rLqwhPfDXbt0ifDFggHmH+uRw2ztNvkzkHZozK3tHW3F/8T/bRn7d4/moM5bvhdEMxaz
         u9kINRlQ1FCP4tswxc95Im9aYlCpYfcOLgAOPewgywBpbxi29P+LreirvTKeCM3gRr50
         vpew==
X-Gm-Message-State: AElRT7EubRgE2uWmlL4WCAHbArLxgRkjVESUCwiSC1TlQ8k85cHRREC5
        vWuUgw3tZIvZuC+ZKyT/vYojnkM82+IquuxouMRQxA2+SU8+lult7p2NRhoS7M9KjxiUH4sr/GQ
        uE6zJAtJPtzjbBFBpSqmIPr6ZOrn94K5PgP0BJht8z5SIkJLDPn80NgEWeQ==
X-Google-Smtp-Source: AG47ELtSYiKwcsgXNQwIgsSi+PBdhC7EhMPQC41bb0Kx8Y+V33G7mPlQgxqVdkEkC/AB+V3NLWfXOaEcWHY=
MIME-Version: 1.0
X-Received: by 10.200.9.2 with SMTP id t2mr6149322qth.62.1521135181738; Thu,
 15 Mar 2018 10:33:01 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:38 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-32-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 31/35] http: allow providing extra headers for http requests
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

