Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A71C1F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeACAUD (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:20:03 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:44283 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeACATH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:19:07 -0500
Received: by mail-io0-f178.google.com with SMTP id k18so453523ioc.11
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/mBT6p3Y0ZQ/WyXd1jFURZ9PprfA9M6l39hvRT1CLMg=;
        b=AIFGB/apxJR4aqIb+AgQgg4J32Lngx8KAwf1J1XMK6/pvt6rWEnk5pahzbX6yNfhit
         klYRn12GE02vJZ7sQ53bHXWskvHFYA7m9LmpsT8zpkYegfBQ66QGiVqTijXcxMx2C96v
         M6yYcBQUGyR5G6owmY9CH6lRa/157qZocF3p/MHAJxiY+iL/1EGYiKAqbSYtBg5f77yA
         Tnyz4Ff1qnXQv88KrenC7eBKF710MKUYNCfNm8k4H8YsBmUsJT8qprfuocXeoI5rQjt+
         TBqi01pMnrhDp2zIdEic24fEZo5OPDIOwJwJXvAJjUcpm6vs08jFJbxyZulRouASLdBy
         b8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/mBT6p3Y0ZQ/WyXd1jFURZ9PprfA9M6l39hvRT1CLMg=;
        b=DmjH3oAv4TP3obGihwPkbBiaVeK7QWldTQdFjgtU5WBrnBB08P7h3iiuMVdr9Gw9qH
         0gMqBt44mmR7ak/25D2eFD4vhvnMi2oeTc1wjOY5iNnK/CUWUtOV3fM9jgr3AubtZXmC
         L3CBOnI93nvUv6r+RZeNo4OpF0YeMrJYRfzxqMDI1BLD1wprHA+C+xE8sPOFywAZF5s3
         A+R9uf0+01lvbcX2D0xcPrj0jX9GIg8s7OfhbVD28s0Z3tlPRf4tMYunbfEZrq3b/iBF
         L2RYXG6pQvjetIl/L10u11RIjznZI6s8tgk5U5TVo4EJsilv9xkZUZ829tfX/dO7gLJo
         +znA==
X-Gm-Message-State: AKGB3mJuE26wr7lhTSW7KD6if72t7db3QOltxrR2FHM9/ht6FOTzwROG
        UHblmIYUTdEufnIW8yvOan4LkzwZQOQ=
X-Google-Smtp-Source: ACJfBovxXIb+2xV7BgxpccBfjXPDAsMdP3ijWkURncB7ZxuN8qTT/iK3WsAZxxVG2esVzfhWrGbn3Q==
X-Received: by 10.107.83.1 with SMTP id h1mr48537938iob.288.1514938746321;
        Tue, 02 Jan 2018 16:19:06 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:19:05 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 17/26] fetch: pass ref patterns when fetching
Date:   Tue,  2 Jan 2018 16:18:19 -0800
Message-Id: <20180103001828.205012-18-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
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
2.15.1.620.gb9897f4670-goog

