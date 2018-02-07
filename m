Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5E141F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932276AbeBGBOd (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:14:33 -0500
Received: from mail-yw0-f202.google.com ([209.85.161.202]:48662 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932252AbeBGBOb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:14:31 -0500
Received: by mail-yw0-f202.google.com with SMTP id f188so4410438ywe.15
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=0SH8No6a6+RpyrEQ8lyKl2kvS1VdQjo6HHVkp23uKRM=;
        b=jO+FB9W72mC+oxYbBqWNq6thICUEkqjKWAV/K/TWRP3cqOWG/VB53Sg/2uSRNRCPTo
         CJdzkgO9nFleINLtA1armKoANE1HdeUvUYGWpgWf9ncYTcfLrDzC7UmyzfB6Lvgdvg+H
         UABm+Ca3LmYFas7RP2Fa8tPUFTb7MMFVIbbkuSyzN5HcY0tnskborX0m01bsv2I4gi+9
         KxYybCVAl0hEtfTBLkonfQMJNMyE7nLFyzZwOnqSDDGbLlpMoOFNh+QSwQRv0Rfw/p+n
         sx682hFchwny7WU13dqP53gDEDpWJw7nFwtDD0nYlqUFQOiQeet7T9kAczh9tQEXA5m4
         /KkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=0SH8No6a6+RpyrEQ8lyKl2kvS1VdQjo6HHVkp23uKRM=;
        b=q5VXdHd4zD7geWmnvjtxPBlSw3E0sdenok0KB4FpwOtcOOsqY+kgM9qFEPBSJGamjv
         GO3Hw9yhIcTjVHNURQsQo6r3EQRzwBif5lzcDrULbQz0O5o6mESWdtueL27WxqbY8cMV
         fmaZXvqPema8hy9hb7iqzm9zDyDZsDvnJFVRDZVUNdUoD0FhTjk16AI2Fdzrtpp1TUoR
         NBjkWeoZgKz3vy9APBiy1GplN3Hr3cfuzLdzEmDM5z+m3jKeqepclNdz+Nd4KwNwRmgv
         0j7Q2cX9fLkyPqcKyMczamkIfMLPIroAgczFMgXykiIR8g9aH7OUexIc1HSSvkOyg+16
         hzdw==
X-Gm-Message-State: APf1xPBGXsAR1jCaOQOUqCA3jvLfVD+sHmfQSejRFOXazjM7PJmhUn+8
        /+xxL6+cer13lN4CXf4W5h2SHZKv3/3zLYKTQ0HwJuebfJtgkvens+zwX92L4iLwHaLBKPjo27b
        66hQxmL6jSJpjtPV417vKhMJPMnM4n9AmIL1YrdoqX9CQfymbqN47HycvNg==
X-Google-Smtp-Source: AH8x226694WIF0kA7R0mvFQvRwc/iTUwHiFzA/aE7P0VTyat0qyTh2dJ/XOPITInIwA7POIaIi2QfXIs9YQ=
MIME-Version: 1.0
X-Received: by 10.129.91.69 with SMTP id p66mr2155817ywb.94.1517966070846;
 Tue, 06 Feb 2018 17:14:30 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:13:09 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-33-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 32/35] http: allow providing extra headers for http requests
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
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
 http.h | 2 ++
 2 files changed, 10 insertions(+)

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
index f7bd3b26b..a113915c7 100644
--- a/http.h
+++ b/http.h
@@ -172,6 +172,8 @@ struct http_get_options {
 	 * for details.
 	 */
 	struct strbuf *base_url;
+
+	struct string_list *extra_headers;
 };
 
 /* Return values for http_get_*() */
-- 
2.16.0.rc1.238.g530d649a79-goog

