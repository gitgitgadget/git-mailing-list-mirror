Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A70441F404
	for <e@80x24.org>; Tue, 27 Feb 2018 21:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbeB0Vaw (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:30:52 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35114 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbeB0Vau (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 16:30:50 -0500
Received: by mail-wr0-f193.google.com with SMTP id l43so277862wrc.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 13:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UTPoUgCtTVTcd4YwpPzsuQVXSSp4wa+Mk/VvQqpqAe8=;
        b=jF8g3GAgS1OCVnF5L3T/nVhukIMkoOCkAvdYpQ2JfLiuG8IzvVHz+rCEMbefAyT6LG
         OxlPXacumRekyNZ/10+UlWkj88sDcljWre/HL5W80lLkBw2RaxAymXt3wpSW68vfRCRw
         Tg7vWb6gcsIVqzmgFLY3Vg8BDxuRd7aBwk/XEWFzNI9NjmWWTJkLKhneiCxycaV5vinw
         5TtBnOXJMHk+mk8b3vriwg4D1xhXU6idsP9FLGa5ua/HmfhpFz77QeumL9mSLuhgLrzX
         CcqL63RNU/xBt4hUYFHYKR8fhs39HNpYfjwACTfCDgZxQW9QqJhmU+3rGMr5Oh93cmeK
         7Zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UTPoUgCtTVTcd4YwpPzsuQVXSSp4wa+Mk/VvQqpqAe8=;
        b=dq7Rvs76hk47JIfu1CP249JQ0gndLIrrtmw9kYmOQ2IdaTJ5zg4cDeyZ/LECOWbsPa
         NG/eBvRIWnJAtpRcDXJsX7QBJcFLubCCur19nfKrUE6Wmu81fp4HB8I+vpDa8r7eJyrU
         ojF1dB2kbNulibNKC5414gDgYsArb/cDnEyvh+mzyQr+MObRdFuAse2bnfZXfKMDrs0R
         +Z8QWyCc/5hvEA4qpWnwoj/f1Bf9NtqExM0wfS1jK94UShemcijIi3HJhRULtZMREFuv
         Ygs9pwWUG8ZRofa5u3h9EYk70/rjEp3Gr+UjNOyrjvMUZY/jkWlPn9oF72ksa5pLZ7iL
         5KAA==
X-Gm-Message-State: APf1xPDcS741hgL8U/nKehA1xugKW5XrGTzwsHDwX77GE9Zx9lrI4iMB
        onRjfNoTFwu/YSraD4aVxSZ4jxSB
X-Google-Smtp-Source: AH8x227V2ksXsCxy8u3toHUjD+TmQ/Jn4kCVqNk4kHfEnULkzwScZ7s8wX9I2Zdo0ifBfpIqI63ANg==
X-Received: by 10.223.184.230 with SMTP id c35mr12950927wrg.190.1519767048532;
        Tue, 27 Feb 2018 13:30:48 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id t91sm126888wrc.21.2018.02.27.13.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Feb 2018 13:30:47 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/5] merge-recursive: always roll back lock in `merge_recursive_generic()`
Date:   Tue, 27 Feb 2018 22:30:11 +0100
Message-Id: <b19db05a8d8a98977788c04908134915eebc86a3.1519763396.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1519763396.git.martin.agren@gmail.com>
References: <cover.1519763396.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we return early, we forget to roll back the lockfile. Do so.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 merge-recursive.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index cc5fa0a949..7345125691 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2198,8 +2198,10 @@ int merge_recursive_generic(struct merge_options *o,
 	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
 	clean = merge_recursive(o, head_commit, next_commit, ca,
 			result);
-	if (clean < 0)
+	if (clean < 0) {
+		rollback_lock_file(&lock);
 		return clean;
+	}
 
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
-- 
2.16.2.246.ga4ee44448f

