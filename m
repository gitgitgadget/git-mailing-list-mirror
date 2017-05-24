Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77B4720209
	for <e@80x24.org>; Wed, 24 May 2017 21:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162732AbdEXVku (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 17:40:50 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35558 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1035934AbdEXVkn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 17:40:43 -0400
Received: by mail-pf0-f170.google.com with SMTP id n23so147413105pfb.2
        for <git@vger.kernel.org>; Wed, 24 May 2017 14:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MJXr91NFt8GH0E6kLhW7m5KtfvDV26zLt4zSaGoVCyM=;
        b=m3eZkaUvyfAoIObRgeBSdHlUJJrbQMAOSVmWLPUpzPp53ZkdVauewvmAeZ4+cJADEI
         S8YbenrAEdF8rVF3zC4KDMwKbU+Xt4F2woPbTSIqNewembw63PZvYr4EH4rIvbqJLJ3G
         proNIcLDvkfMw7iMPjJfoUXQ1m+PuusW9tahRC3WVF6Yd6I8Hm7f8fDZKl5BOyN8kOVo
         786xXlrB5ADtiwYht3M1lJNtcSOXGcfQodHeEgvCg8StoH7cy1eOfXdRVJrDxvwl04Ll
         19YlDGvuggu4EBNBf/odFDDfvdHZ0RArNK7yeoeSAzPOCzr4zeLmUXm9Pz3iic32c35M
         NjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MJXr91NFt8GH0E6kLhW7m5KtfvDV26zLt4zSaGoVCyM=;
        b=OlU8EGVxjtlHJJV3Xp5Xzw2WAdCCmjPHlEGC9+dpu9d2+E0v/PXVLBut/YKXtwVAuW
         074IGLxvXr+WGRpUS+sK5fbHlZGI9+W7r669965H15ZrXwy9wUWT8sPzbZR+A9CndlKy
         Q51KfvWqmilqfFnBLoCayE2IFQ8+MaecUeOIiOqFAvrRkOXZnZYKWvXS5cDcjkSBeG3i
         GvjK7rzSrgN7d/2ttt0E9dkHGDpbKWLDqvDfd87ylgvv/KI/1WqjQGlG4DGtNeFb6tT5
         tdBdMPciIF8JKgPJpIomg71A9Og131RTQQ76Ky0QWhOacNSCt1BGDK5Zr1eRKFG6KXlD
         UeOw==
X-Gm-Message-State: AODbwcADX20Bq1mP6Wv4Ob7f5HESomRN4QriZk26Gnpn7FqmSj0IWSoC
        zGEnTkcbGwCoxdV7
X-Received: by 10.98.159.19 with SMTP id g19mr40519216pfe.189.1495662042619;
        Wed, 24 May 2017 14:40:42 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:70df:e59:d409:fbba])
        by smtp.gmail.com with ESMTPSA id s82sm11649326pfe.57.2017.05.24.14.40.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 14:40:42 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 01/17] diff: readability fix
Date:   Wed, 24 May 2017 14:40:20 -0700
Message-Id: <20170524214036.29623-2-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170524214036.29623-1-sbeller@google.com>
References: <20170523024048.16879-1-sbeller@google.com/>
 <20170524214036.29623-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have dereferenced 'p->two' into a local variable 'two'. Use
that.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 74283d9001..3f5bf8b5a4 100644
--- a/diff.c
+++ b/diff.c
@@ -3283,8 +3283,8 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 	const char *other;
 	const char *attr_path;
 
-	name  = p->one->path;
-	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
+	name  = one->path;
+	other = (strcmp(name, two->path) ? two->path : NULL);
 	attr_path = name;
 	if (o->prefix_length)
 		strip_prefix(o->prefix_length, &name, &other);
-- 
2.13.0.18.g7d86cc8ba0

