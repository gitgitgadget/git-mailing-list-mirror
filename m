Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6131F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 23:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753648AbdKJXNY (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 18:13:24 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:52272 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbdKJXNX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 18:13:23 -0500
Received: by mail-pf0-f195.google.com with SMTP id m88so426306pfi.9
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 15:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YCnoWMcHmkjZDvN6hlx5zvYIXd1zQu0qxtL5U5/Cfdw=;
        b=tBkrnFde0V9lPjSg2WD9NXZb5L9xr5swr6M6bfgSLy1HNqJQwRBtSA7JAYr4UWdtSa
         l4AAr5yGh4s2zdBNcBYBRSDVZOdht3CRK5qmUKyjJe7RrWrL9vSb5dmZoK/eI4URd6Nu
         A/7HoAv1y8fkNTN7FpTFPZOemMi6VUoz40C0AdpVsUHGZSh39B3S7V9A5kyUtfAJa7Du
         dAwRCwFccVqB7YqQG1I/atoBPT+K7lgOI+77okQfzPd7/wJUKxXQy59Wgjy3TwjN/Dod
         HkGmJWSD/2JW/OiA/E2cXJPzHNhlhSF3tRbhfre6C8KbZvp8UAwoVMg1hzypJfLs+yR+
         WHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YCnoWMcHmkjZDvN6hlx5zvYIXd1zQu0qxtL5U5/Cfdw=;
        b=PKnbPMJTUqwKlmoc8TosGV+fi9RgymYj79AFwObVraoUPGpNs9HXC64dGBBtHLbcya
         /sRXJ7Raikwv7rYN73yRwP6rI75zNmKU4UOgqIFtEFU8BC7wJDnio9egttxPc9X4FmXN
         BH03oLx78sebqPiROTjNJ3+wUXX+Udmzuj2iNARYkBtZZx1T//gAkmocXZwszjKpQIha
         /1Pb3aqmcKBXAo4tAYATUTuG/6JQYms43XGuWtN/vJDUvXNpAh4eRxFjgcx00ZVJXp5z
         j5zR7uCZmxf7mqWOg26RinZKllrxkAg4guG2DZt9sMLSYCHv0Qd/SfAbe8+h1flzyImL
         t1WQ==
X-Gm-Message-State: AJaThX4sghOhsfhABo9nCKbwHXzOJ0NBmdoL7wkspw1qXIPk3APKTVO0
        aXQyDQtS+ub6r79l7zbr4g/57O4=
X-Google-Smtp-Source: AGs4zMZHXm2ikhC92vWPnPa5ZB7UUlL/Ygg/hdcpWW+NoR2n/g9o8bfLexMdqiZS+myrmaxFDwnhkg==
X-Received: by 10.84.130.41 with SMTP id 38mr1875913plc.387.1510355602404;
        Fri, 10 Nov 2017 15:13:22 -0800 (PST)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id f6sm16248063pgo.11.2017.11.10.15.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2017 15:13:21 -0800 (PST)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH 1/2] merge: close the index lock when not writing the new index
Date:   Fri, 10 Nov 2017 15:13:13 -0800
Message-Id: <20171110231314.30711-2-joel@teichroeb.net>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171110231314.30711-1-joel@teichroeb.net>
References: <20171110231314.30711-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the merge does not have anything to do, it does not unlock the index,
causing any further index operations to fail. Thus, always unlock the index
regardless of outcome.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 merge-recursive.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 2ca8444c6..225ff3fb5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2184,9 +2184,12 @@ int merge_recursive_generic(struct merge_options *o,
 	if (clean < 0)
 		return clean;
 
-	if (active_cache_changed &&
-	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
-		return err(o, _("Unable to write index."));
+	if (active_cache_changed) {
+		if (write_locked_index(&the_index, &lock, COMMIT_LOCK))
+			return err(o, _("Unable to write index."));
+	} else {
+		rollback_lock_file(&lock);
+	}
 
 	return clean ? 0 : 1;
 }
-- 
2.15.0

