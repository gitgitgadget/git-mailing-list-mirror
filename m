Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 771491F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965038AbeB1XYo (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:24:44 -0500
Received: from mail-yb0-f202.google.com ([209.85.213.202]:38752 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964893AbeB1XYl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:24:41 -0500
Received: by mail-yb0-f202.google.com with SMTP id u99-v6so2380051ybi.5
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=16/E7ewdza0nqtU7krbEepVdDx3gbxa0tyfZLcBPLgM=;
        b=ltTjmTg59W8YN9ITrBw40NPzpM6y+39NJm3lq+IzABvwUKdRCymZAEr2lg0TBYOwAy
         m7JF+UQX5f8IYkyIRJ0XIt7Dv2BwlYacrD7Lw0+Fi9KqRp3c3xr2IlGkFutazWTgWujo
         kG01XjOhCQFi5LQ3gYYS3ManwZIjWqZHY3iP3XKVRA8RZ8xODYjT/rn8wsqb17/1M3XP
         Jqz1Rk9puk1uUFKvYuTGlZ9vfaK1k8JWw0iomW4mpipz6ufWptwiuMTJRju/fz0N9uuk
         EcD2lUiOBIVu4z3I1qWIWqbywjAOI80/5pvYAvdZjTl8R2ZEh/dkveeYXLNnxsiN33Hk
         6kOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=16/E7ewdza0nqtU7krbEepVdDx3gbxa0tyfZLcBPLgM=;
        b=JI09l0xqF8fnqfwb/43kssUitYQHJcq9kGCjlj8Hd4xTva8Q8+iQ/RpUWE0lsYRL0t
         c8hTwQUmfGAPYJXkov2xXiUfUR78LOt4QRT6EUccEIPwW9QUCoBGbMFI5xnIkEzqmPhn
         ekfJCBSnvzsoqF9IpSrBxtnBs+783noysW+BvUosibTeAqE5gAj/1QHHGy4sM52W0Rgf
         Hi6ktjNgw8znaM9esPfeEVGq2QsiffiKfjJ9/NJv5YNg/+qj2vuwy7/5bdd2cwh1cnP8
         m16pEtQEwVN8SNgI5q26QW+zhoFFgOWMmZlPJVKX4ZlT8SezsYt96YWvIDECQSrDHyJm
         fTlg==
X-Gm-Message-State: APf1xPA7pMjyGWMCGBN8r0vfgafqToHs9IdrF6js6NwyHtnmQmR/11jG
        tMiOBeELk0eadTDZYzpXHl75FxvIcLMBMyk7Hv7bRaO24aKANnm8E5SGDBc7kSNvBISikXat3eQ
        QK3p28qsUeGjcXYpqzOzZAfS8gcsXqjBr63Gm9/DVqsrnrAKNH79VmlJbLA==
X-Google-Smtp-Source: AH8x226gMfBMGvg1PeUETojpvTMYpziKjG1o1DsOxJ4REJEK+7dxYroE67lcTQzR8c4TpfjxzdrC4Bw7u6U=
MIME-Version: 1.0
X-Received: by 10.129.76.206 with SMTP id z197mr9900215ywa.178.1519860280788;
 Wed, 28 Feb 2018 15:24:40 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:48 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-32-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 31/35] http: allow providing extra headers for http requests
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
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
index 597771271..e1757d62b 100644
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
index f7bd3b26b..4df4a25e1 100644
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
2.16.2.395.g2e18187dfd-goog

