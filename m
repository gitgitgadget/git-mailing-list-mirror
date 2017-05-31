Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53CE01FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbdEaVpU (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:45:20 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34482 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbdEaVpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:45:16 -0400
Received: by mail-pf0-f179.google.com with SMTP id 9so18589088pfj.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZV30R2i7xwEKdcw1AZbUKuQNJkssVrCmrLLlvZNM8gY=;
        b=tjye8Ki37rbWBbbW/FZZN1J/itrkpbiUrx+bolnUuW5mXYS7zTPbyHk5SxrHlX92tQ
         fSkPdBCcVJoD2HmWR+ZnjgVUUaUIEsXzY1/iemj6peVj4uMVR0UtqGy1Q03U5eYWhU1Q
         dY1CXR0ZZkXtBFIzyJKRCNU5qQ1KNg/upsEgm4XM7Q7IVVbs5JJrr1yTbGt7sSaSkTlh
         E9EXGvCX1tJq1/DvFf8b/c6fBzix5iZsaFxn5qMu02TzDFZ4ZuxS0WO5+NxZTVZ/lf9S
         jJzXzdzhtbsoVkCv7PcSwAXYFvYnsyJkKOYt3/gEYPQLMqwKgXlReWoJ5uQfHwevsCjd
         m/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZV30R2i7xwEKdcw1AZbUKuQNJkssVrCmrLLlvZNM8gY=;
        b=Qrs2uSBP5AG43jHv2Mr4eFUZymqM8ozSfmDhUGVYuzWgdMLIbTIu3Lm2kd0HXjg2OY
         1oNUIR+baWqG38iyseiquEzEbZgSHPmmlBpUt0cEKd9ORN9tQLFbcrL/AD05fg83ytK/
         kcQB+idlpGCQHhqnBLh9l4S/DOYgeF0dLBO8mFwZ9UUDqERcjOyXVJXJrSaWcmp6AD/x
         WNIOKzOiPntdbH0x/JFPGv6hSyjfjWaHPCmQHH2yp/C6tN2n7kCf7uwW1vTFUNldpCbE
         OHm6gmHEg+2dJcoKCrP9H+EPA89JnJnKYkzN+a6n0KWDrMvdcvkaBVp5cJpENlEfSd0t
         4w3Q==
X-Gm-Message-State: AODbwcBY5KJKYna8A7kiBVn0ZSOe6zFhSoHToIfjeUU+P6YBzoVK/kTr
        LpXKPFon1MkOSqdq
X-Received: by 10.84.218.142 with SMTP id r14mr89951619pli.69.1496267116047;
        Wed, 31 May 2017 14:45:16 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:45:15 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 27/31] ls-files: convert prune_cache to take an index
Date:   Wed, 31 May 2017 14:44:13 -0700
Message-Id: <20170531214417.38857-28-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 289c6b2a5..e2d8fb7f6 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -381,30 +381,31 @@ static void show_files(struct dir_struct *dir)
 /*
  * Prune the index to only contain stuff starting with "prefix"
  */
-static void prune_cache(const char *prefix, size_t prefixlen)
+static void prune_index(struct index_state *istate,
+			const char *prefix, size_t prefixlen)
 {
 	int pos;
 	unsigned int first, last;
 
 	if (!prefix)
 		return;
-	pos = cache_name_pos(prefix, prefixlen);
+	pos = index_name_pos(istate, prefix, prefixlen);
 	if (pos < 0)
 		pos = -pos-1;
 	first = pos;
-	last = active_nr;
+	last = istate->cache_nr;
 	while (last > first) {
 		int next = (last + first) >> 1;
-		const struct cache_entry *ce = active_cache[next];
+		const struct cache_entry *ce = istate->cache[next];
 		if (!strncmp(ce->name, prefix, prefixlen)) {
 			first = next+1;
 			continue;
 		}
 		last = next;
 	}
-	memmove(active_cache, active_cache + pos,
+	memmove(istate->cache, istate->cache + pos,
 		(last - pos) * sizeof(struct cache_entry *));
-	active_nr = last - pos;
+	istate->cache_nr = last - pos;
 }
 
 static int get_common_prefix_len(const char *common_prefix)
@@ -662,7 +663,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		max_prefix = common_prefix(&pathspec);
 	max_prefix_len = get_common_prefix_len(max_prefix);
 
-	prune_cache(max_prefix, max_prefix_len);
+	prune_index(&the_index, max_prefix, max_prefix_len);
 
 	/* Treat unmatching pathspec elements as errors */
 	if (pathspec.nr && error_unmatch)
-- 
2.13.0.506.g27d5fe0cd-goog

