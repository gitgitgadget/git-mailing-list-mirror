Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 076601F597
	for <e@80x24.org>; Mon, 30 Jul 2018 22:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbeGaAdS (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 20:33:18 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:42870 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeGaAdS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 20:33:18 -0400
Received: by mail-yw0-f202.google.com with SMTP id r144-v6so8166007ywg.9
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 15:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7rSCjFYlF/PXlu2w7OKtTcS1egP9oHo1Syor3Pfy1fY=;
        b=iPrLTdmuT4RXy5zpbbVb7dirXFzffXjpLcLQxA65Bzt0XiLrzF7yc7qvXcxbmdynm3
         XnTRUtaSIlFVHBzGXpO9bmYxXy7RQpzXg+x1m0q3RnlfAqNavaNJIli6bAiLAlzqT41y
         U0/0OstnmtuvovEx2hUMIMS8k0dfXOz5/3q8NtnsLFtc6UiEpXTs9AC/urLKO9hH4SUg
         B5amqTHBlJDDChMfl0+BQNv4byiSy2yszXQf2piMRR7SS14yJacGnE/NKk4xTWvfWgQB
         ZJLa+wmbXD+nYv2DxcpDZOue2qa6/3ka/p4RBRQASpiB8bWNt6jvV0UZ0eRHIqeFvS9J
         a+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7rSCjFYlF/PXlu2w7OKtTcS1egP9oHo1Syor3Pfy1fY=;
        b=g2jvZ+iduIGcWK1tOKxCb0oX2mXHa4SxfBTwjcwHKiLWdken5eKI3kisn4NOVz4bD8
         FtHpHFKYlG+gztbpbHDo4jBxRTqitaLCIxSMZdjMVIQ9TQCTTP3TOaANnySKzqEZbvw1
         app8JodHzHbhZiK8dK4yBFFcZwPYRjRbByXPbMjFx4ykTY9ej/DZEk1/tTrUG5sO4tq+
         txRF61u11mhTGjNu2T3CA4pELxNTUnlhMcaSx6zEmtCKFz5SR1vej+Xx4WiPxO7fXNvx
         CMATSVbB8nYMx3NlsbJEbDJoPq8PQr4P5zqWQqwCBCZIhkpDVYDb3QbR9ewMaUg48us1
         hNvw==
X-Gm-Message-State: AOUpUlEHiexdTJhWFWKTJfA8tfwqXwGS5U3anVtUt/PO8foYWFqQGwlV
        w3AE4HfIdH8V58tLe1vyrChonHgstU+xP64X0dz8JPZE3oRLWLqzj8MkbHvBZd7+2V/GoFmtV4s
        mN2ILg4/1CvRY0L26nbrGKaMdFuhy2Zj1L4HDYxNJfRu1grCa2/EhGlkBzEnZ7cooILEVEo3ymv
        Tl
X-Google-Smtp-Source: AAOMgpeoH2UL3QTQwyc25QkyMHLzfgiTRDC1E5VAwjF/uKtpJpvexI7DZ+PXDs3OH5bu30ikg9hH39Xg3WapVjSn7gVo
X-Received: by 2002:a25:6101:: with SMTP id v1-v6mr5835146ybb.87.1532991364830;
 Mon, 30 Jul 2018 15:56:04 -0700 (PDT)
Date:   Mon, 30 Jul 2018 15:56:01 -0700
In-Reply-To: <20180729121900.GA16770@sigill.intra.peff.net>
Message-Id: <20180730225601.107502-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20180729121900.GA16770@sigill.intra.peff.net>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH] transport: report refs only if transport does
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 989b8c4452 ("fetch-pack: put shallow info in output parameter",
2018-06-28) allows transports to report the refs that they have fetched
in a new out-parameter "fetched_refs". If they do so,
transport_fetch_refs() makes this information available to its caller.

Because transport_fetch_refs() filters the refs sent to the transport,
it cannot just report the transport's result directly, but first needs
to readd the excluded refs, pretending that they are fetched. However,
this results in a wrong result if the transport did not report the refs
that they have fetched in "fetched_refs" - the excluded refs would be
added and reported, presenting an incomplete picture to the caller.

Instead, readd the excluded refs only if the transport reported fetched
refs.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Thanks for the reproduction recipe, Peff. Here's a fix. It can be
reproduced with something using a remote helper's fetch command (and not
using "connect" or "stateless-connect"), fetching at least one ref that
requires a ref update and at least one that does not (as you can see
from the included test).
---
 t/t5551-http-fetch-smart.sh | 18 ++++++++++++++++++
 transport.c                 | 32 ++++++++++++++++++++++++--------
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 913089b144..989d034acc 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -369,6 +369,24 @@ test_expect_success 'custom http headers' '
 		submodule update sub
 '
 
+test_expect_success 'using fetch command in remote-curl updates refs' '
+	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/twobranch" &&
+	rm -rf "$SERVER" client &&
+
+	git init "$SERVER" &&
+	test_commit -C "$SERVER" foo &&
+	git -C "$SERVER" update-ref refs/heads/anotherbranch foo &&
+
+	git clone $HTTPD_URL/smart/twobranch client &&
+
+	test_commit -C "$SERVER" bar &&
+	git -C client -c protocol.version=0 fetch &&
+
+	git -C "$SERVER" rev-parse master >expect &&
+	git -C client rev-parse origin/master >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'GIT_REDACT_COOKIES redacts cookies' '
 	rm -rf clone &&
 	echo "Set-Cookie: Foo=1" >cookies &&
diff --git a/transport.c b/transport.c
index fdd813f684..2a2415d79c 100644
--- a/transport.c
+++ b/transport.c
@@ -1230,17 +1230,18 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs,
 	struct ref **heads = NULL;
 	struct ref *nop_head = NULL, **nop_tail = &nop_head;
 	struct ref *rm;
+	struct ref *fetched_by_transport = NULL;
 
 	for (rm = refs; rm; rm = rm->next) {
 		nr_refs++;
 		if (rm->peer_ref &&
 		    !is_null_oid(&rm->old_oid) &&
 		    !oidcmp(&rm->peer_ref->old_oid, &rm->old_oid)) {
-			/*
-			 * These need to be reported as fetched, but we don't
-			 * actually need to fetch them.
-			 */
 			if (fetched_refs) {
+				/*
+				 * These may need to be reported as fetched,
+				 * but we don't actually need to fetch them.
+				 */
 				struct ref *nop_ref = copy_ref(rm);
 				*nop_tail = nop_ref;
 				nop_tail = &nop_ref->next;
@@ -1264,10 +1265,25 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs,
 			heads[nr_heads++] = rm;
 	}
 
-	rc = transport->vtable->fetch(transport, nr_heads, heads, fetched_refs);
-	if (fetched_refs && nop_head) {
-		*nop_tail = *fetched_refs;
-		*fetched_refs = nop_head;
+	rc = transport->vtable->fetch(transport, nr_heads, heads,
+				      fetched_refs ? &fetched_by_transport : NULL);
+	if (fetched_refs) {
+		if (fetched_by_transport) {
+			/*
+			 * The transport reported its fetched refs. Pretend
+			 * that we also fetched the ones that we didn't need to
+			 * fetch.
+			 */
+			*nop_tail = fetched_by_transport;
+			*fetched_refs = nop_head;
+		} else if (!fetched_by_transport) {
+			/*
+			 * The transport didn't report its fetched refs, so
+			 * this function will not report them either. We have
+			 * no use for nop_head.
+			 */
+			free_refs(nop_head);
+		}
 	}
 
 	free(heads);
-- 
2.18.0.345.g5c9ce644c3-goog

