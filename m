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
	by dcvr.yhbt.net (Postfix) with ESMTP id 567251F462
	for <e@80x24.org>; Tue,  4 Jun 2019 17:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfFDR51 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 13:57:27 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:47659 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFDR51 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 13:57:27 -0400
Received: by mail-qk1-f201.google.com with SMTP id l185so4273503qkd.14
        for <git@vger.kernel.org>; Tue, 04 Jun 2019 10:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JURdK7/4ldjw3H/6O9EyWWraJAfMhqF8Gi4ilftxmZg=;
        b=XZ7BCkAqd4LvX5TMKHRAaBdIKT5mA5/h+goOTZ4PUfFW7nNBvx+yIx0hQv4nW6UbW7
         DvTvPfz8CbcPn/ZAqsldaBbtxZPFtWGHQGTuQIhvHOtONv16DKcwQkGMrdv7qu84mK4m
         /iFCxrNReecD4hczC6QEJZVU8Qbww+cuuZPdrEM8VTWRf21ByuRB3ZpLY/q2kave04mg
         Emvx9vtTuVWVy1yOg0ONwxdiXc3P3qtfl4Lz7xwHK+V+iYIJWx0DX+wX6b/iZtn4KOqk
         kAnxM/t4uphmRDCl7fJSq/ONgOURldCNzc0krqN4qQHoj1C4cUt8hWO7GmSAQhepzVQG
         aPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JURdK7/4ldjw3H/6O9EyWWraJAfMhqF8Gi4ilftxmZg=;
        b=Rq8GAJ0PWGEf7BeILKMgaeMbsdyiMNLh7kiMyqblxDVhYG1DZnCB1IflCNvFSoSCEz
         /KZNdptsfYq7mUoE+GZFBQD9Y46rG5ruAhUyw4YgQQeQFV2pmWjHWC5Oo+ooMQfuXv50
         NG5mqHmWSDHCWh7Z1eHNoZIGRsEdmzwGmmJJnsqQJZy+aQrAxBpjO5YrZwtopAXbaPBV
         4A1HBI4NyOOZjIT+L7keQ9oPTbwfv53aQ7QISHcWNeM9h+ed13djaZFg9N2jzNkciyKl
         Q+OXvbmmuzDdDl5k3m4gSJ8fOy2bo3BOw7IE/CMO1YcuPcWcrIgLVhW7ZzUDxhSZy0Mj
         2Pbw==
X-Gm-Message-State: APjAAAWqCb2k42c29buQvrbb5+tcrPYuXy24i2Lcvyin0NCgyFlTOpvu
        ewNHLL11fp9TwEjXL3KWuoGYf8d7ftxKn6TzZolGUEZeCJ6xRywy+d7L+DSU6SY0a0HkKu6wNO+
        NEQCdfNvSDVVEalHY8tH9ikh9ngAcorpHaonXpekEwekM3xPs9IwCRQ6N17A=
X-Google-Smtp-Source: APXvYqzBQKZGAow6kqRK4Efw2aukSJSHaXTbW27+WooWpV0ngVpsY1cU3/IK/ynhumW6r/T36OBwlVgCl6zu
X-Received: by 2002:a0c:9e55:: with SMTP id z21mr28653380qve.45.1559671046172;
 Tue, 04 Jun 2019 10:57:26 -0700 (PDT)
Date:   Tue,  4 Jun 2019 10:57:05 -0700
In-Reply-To: <cover.1559670300.git.matvore@google.com>
Message-Id: <d3d6316a2aa4691c630b1bb2db6c3ac706aaaa31.1559670300.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1559670300.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v2 2/2] url: do not allow %00 to represent NUL in URLs
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sandals@crustytoothpaste.net,
        jeffhostetler@microsoft.com, l.s.r@web.de, gitster@pobox.com,
        spearce@spearce.org, jrn@google.com
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

Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Matthew DeVore <matvore@google.com>
---
 url.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/url.c b/url.c
index 9ea9d5611b..1b8ef78cea 100644
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
 
 		if (c == '%' && (len < 0 || len >= 3)) {
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
2.21.0

