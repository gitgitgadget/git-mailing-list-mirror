Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271D71F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeAYX71 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:59:27 -0500
Received: from mail-ot0-f201.google.com ([74.125.82.201]:43383 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbeAYX7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:59:25 -0500
Received: by mail-ot0-f201.google.com with SMTP id a11so5955015otd.10
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=TKAQutYfLKNEFF5uCAodZKOdyGfax+qkLTXuG+mEqxA=;
        b=i11d0xiwWcFYCwPY0z+Cl1zQSYDl6qAKbgzZlkJGEUwJvo7tMB93FhxldbShtdcOaG
         ywH+0Z3UESPSljTa5tmTummjelimZJUJ9W2RnHIDwNd8lQKpofmY2hjvaBT81hISqVg6
         b/d8mFV4YPnNorLhH5V0YVgO/P+gzk0xJuXGdh+3wgdR78oTlFVGPRlKALxTmb7xoAbZ
         0QG59fErvUhXyaag9NTcvVPC23ZEn4mKcVfHeWDZaaWaxlYKBny2Js/uNNTZFlFwk9EJ
         iB4FR90UZTc3XkmZ67Eo7DeSEhw0eZjudngSIYiwcZk2FuGTmyR0e0z8fKg4MepbdPks
         BGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=TKAQutYfLKNEFF5uCAodZKOdyGfax+qkLTXuG+mEqxA=;
        b=VYeAjWZE8Fb8aqyCPo3AtHbGh1CAuNXR8tFTfl9jjuCgBbmE23BZhAvjtzEkj5gMCN
         PrqVsoIvKn41yNt01jN2X09Dtx0tzTk4h9nTp4USitsCb56xpjWm+iwm4coXtdjgqszn
         zshJF5bQlrcztlwKC5O8oqJIySWIdV2v6BAKX817dUkPvYqCRn4pebk96a+t2I4Rxm7s
         i0aJTGy1n/P7syf1qN1B9LC0mzsUrrzh6O0hXEzo6UHQnYUw/Po6LpMfFY3ILjsT9O8D
         Ty3p8IgdVX1AZz5gZXcZCZhHAUMPDW53h++rk3kHhAPQBkcSelSfZNfq3L8qawcaF5Ls
         +I8A==
X-Gm-Message-State: AKwxytfrjC5HZBKzH84cavKD+eYDffS56iMJjiHsKQlIUKTZgJ/byMDt
        EwoBPEbmJgw+ma94MGek+Q4L/s1iHtdTA45gKvtP9gkQg0WrJI5dS+yLTYUjzMqK+LuTvBb9l55
        5LXr6tGTu9jc37QVBVMw2MuO17MygactZoGPBZBDwj5qURpjlEJM4dQmf2w==
X-Google-Smtp-Source: AH8x226cY5rghMDqgFjjTu0QFiw47PTHnrwLhtOY2ltH5TEPPPsQL2TpNpk+0IJoeWW6pRnNCKWpsYEU5BQ=
MIME-Version: 1.0
X-Received: by 10.202.87.15 with SMTP id l15mr9641857oib.87.1516924765241;
 Thu, 25 Jan 2018 15:59:25 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:29 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-19-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 18/27] fetch: pass ref patterns when fetching
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Construct a list of ref patterns to be passed to
'transport_get_remote_refs()' from the refspec to be used during the
fetch.  This list of ref patterns will be used to allow the server to
filter the ref advertisement when communicating using protocol v2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 850382f55..8128450bf 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -332,11 +332,21 @@ static struct ref *get_ref_map(struct transport *transport,
 	struct ref *rm;
 	struct ref *ref_map = NULL;
 	struct ref **tail = &ref_map;
+	struct argv_array ref_patterns = ARGV_ARRAY_INIT;
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
 
-	const struct ref *remote_refs = transport_get_remote_refs(transport, NULL);
+	const struct ref *remote_refs;
+
+	for (i = 0; i < refspec_count; i++) {
+		if (!refspecs[i].exact_sha1)
+			argv_array_push(&ref_patterns, refspecs[i].src);
+	}
+
+	remote_refs = transport_get_remote_refs(transport, &ref_patterns);
+
+	argv_array_clear(&ref_patterns);
 
 	if (refspec_count) {
 		struct refspec *fetch_refspec;
-- 
2.16.0.rc1.238.g530d649a79-goog

