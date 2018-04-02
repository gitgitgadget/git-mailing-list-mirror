Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1891F404
	for <e@80x24.org>; Mon,  2 Apr 2018 22:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754765AbeDBWt1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 18:49:27 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33689 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754747AbeDBWtK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 18:49:10 -0400
Received: by mail-pl0-f68.google.com with SMTP id s10-v6so4146301plp.0
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 15:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ODKrOjTVKvT7es1uSqZzm9T4/PM2DgC0VJIoWWTUVuw=;
        b=aUVhMBCQc3Aii/Bd+dUJGXhEriHbGcX2gVRHmXaliTDNzKrklzUtOIhAL7DnhXtmas
         7hP+fUbDRxCZmwi0kerKyP7uzMZ9/zrZ3cxoyfJWM4radDjtPZgxBMBoLOWTn0f5LXOl
         P5sKRYNj8IqQbuZbCshJFd6rXXTCn7r0hj1ybPv71vTYQ8CmFqhjSUvS9w+gTbeLVKwp
         2Hi2FvPRjqhKxI01e8cV9HOiJaJiq0sRBEfZfy2WH+I9gqh2knHW6SyvmBR21xIU1bh7
         Dl+o2UX4RilWGlP1r+4C+IxUnxsHnCp33h3d5D+BFgjavcrvo+RpJ+2VCya8zWVsGKNq
         dqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ODKrOjTVKvT7es1uSqZzm9T4/PM2DgC0VJIoWWTUVuw=;
        b=bCBQa4p241z4W0j5BZDd/pWU/gf8PfBShYbN80wdWFOaBrNH2be/yVO+4OJCjsWrgv
         sy4HBRvhiMKzi2nHImmQzWeM3/pwVveUxNurqd63lUyUPuJ88aV8wqGt5ExKXR40PV7I
         MFTT4Z1h8Tm38uz8C8PYfpRryaKT3+tdMlW10e1HrqAf008S4zMoaNxqH5XMwO8YpqVq
         doRyePI5XTvWpf6MH5UsYKODIHkqj4BMW1paupoo4xmxXUc4SH9xhvk+HVcqAnKOtzpb
         z9wm8k2/rYRMqTQC/Gur6a5oPnhajlGrYqiw8fvYEx9/WDgCzHL9tdvnZcqPplYuMuNh
         8GQg==
X-Gm-Message-State: AElRT7HNdrhJcdmICu2pLwjnur8BABqV6yzenFJwhKZzEkOvfyomSbX1
        +m4weXQMJ19wONM0eGJnpAI4Ow==
X-Google-Smtp-Source: AIpwx48ghlw511ykzaMz5tsmwOJQCNsmXQn5Pm0DwIu+Mcx0Iu7iEyCipOI7NigJzyeW7UWhTq0JcA==
X-Received: by 10.101.85.72 with SMTP id t8mr2920474pgr.347.1522709349496;
        Mon, 02 Apr 2018 15:49:09 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id q62sm2606178pfd.61.2018.04.02.15.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 15:49:08 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com, jacob.keller@gmail.com,
        simon@ruderich.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/7] diff.c: do not pass diff options as keydata to hashmap
Date:   Mon,  2 Apr 2018 15:48:50 -0700
Message-Id: <20180402224854.86922-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180402224854.86922-1-sbeller@google.com>
References: <20180402224854.86922-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The diff options are passed to the compare function as
'hashmap_cmp_fn_data', which are given when the hashmaps
are initialized.

A later patch will make use of the keydata to signal
different settings for comparision.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 4c59f5f5d3..52f6e02130 100644
--- a/diff.c
+++ b/diff.c
@@ -842,13 +842,13 @@ static void mark_color_as_moved(struct diff_options *o,
 		case DIFF_SYMBOL_PLUS:
 			hm = del_lines;
 			key = prepare_entry(o, n);
-			match = hashmap_get(hm, key, o);
+			match = hashmap_get(hm, key, NULL);
 			free(key);
 			break;
 		case DIFF_SYMBOL_MINUS:
 			hm = add_lines;
 			key = prepare_entry(o, n);
-			match = hashmap_get(hm, key, o);
+			match = hashmap_get(hm, key, NULL);
 			free(key);
 			break;
 		default:
-- 
2.17.0.484.g0c8726318c-goog

