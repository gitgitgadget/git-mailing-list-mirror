Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDBA51F453
	for <e@80x24.org>; Thu, 27 Sep 2018 19:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbeI1BoU (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 21:44:20 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:56841 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeI1BoU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 21:44:20 -0400
Received: by mail-qk1-f201.google.com with SMTP id v65-v6so3584120qka.23
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 12:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4/aVI0SPMVCxN+uLZb4o+JMD//324UsaUVHgk9AeVQI=;
        b=cuQR47NXoLa2NN/xPvfoUxbUpXoru64tXGJNsw4oYuFJ3lg88r0j8DuqhoTG0O4mpI
         4BB11aN1rDuJd6nLQ3mU/c6ohLnsGlsepnJ/r1c5xhNZ3TorsLRZ7fWhuxTpQqU3a/mr
         i7nN8b41bU9nBA7iof+d+GYLyJSqzqWGzWOwBaq8DULcst/Rmbi9RrGzrFzJCQY9d3Li
         t5rcdtNAmJMOr5MiQ4gkGu4YG56VCdu3szV7JJ/gqzbrbgKw1CnDvxU0kGz126ZCyXF/
         WHHIzXCqFDo8q8NtS57nGutHqeEh5xsgY6+TUZelTUmwEWUV/x2CWqsJcqiZmXarfA7f
         trrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4/aVI0SPMVCxN+uLZb4o+JMD//324UsaUVHgk9AeVQI=;
        b=FfK64qo3/PPl3oXyekNkq6MCni3GhQryAfxwj24E2xpTpmhLGhIEh/+KdyV45sPLoE
         EiBhu1avWMKWxd8eounq1qW2kqb7MqkxelkLM2akjIE8lyCv8UySUWmlyxdjQPrHA/Sc
         SvLkE7LlMloYjHydUD64dXJgjKGt0e3G8jJivfn31bNJQHCiviAWXVCqslBAciXzofgg
         IqtMd0Ef8H4E6OnFKuccZhjmeVX5Ubc6Zzg6xUKqkRQQbu028ef90EvkclIRfaA6w6s6
         a5qZuNSoDaw+ko4VfvMt0K809dw6IqPHeCUpdL9OfX3ciWDDeBPasytyzjnBW4RrO43k
         eLEg==
X-Gm-Message-State: ABuFfoijdcX0JzE4vsO3301VJWtwncMLu5tmJzXWtivHhNnJnUwcMJfb
        A6nX2eeUsz7Twitn1Ji8ABFSZhNh1TUmX9wsAbine9sAi/Ysfq28pSG7gdDm3QIzT5l/GTXAOMQ
        VvoExYt5TGCx4RcSRST8TJxxcQJKUgiuRBRS0AktrgVYiChKcP4nMVjYU2DfTjeBV67Jh3EBFZA
        Rp
X-Google-Smtp-Source: ACcGV62uiLlhiRLrTruNefd6qffC67Hx4UY5p47QsRGW10FE29xl/+wzlcZg0AeGDRuXi2Ppc7x5CYkQ/p5jJwzHtQsI
X-Received: by 2002:a0c:a8cd:: with SMTP id h13-v6mr3329873qvc.39.1538076272057;
 Thu, 27 Sep 2018 12:24:32 -0700 (PDT)
Date:   Thu, 27 Sep 2018 12:24:05 -0700
In-Reply-To: <cover.1538075680.git.jonathantanmy@google.com>
Message-Id: <61ad64245470e51cb97988e0f2f5ea76c9e2276c.1538075680.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20180925225355.74237-1-jonathantanmy@google.com> <cover.1538075680.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [RFC PATCH v2 2/4] transport: do not list refs if possible
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When all refs to be fetched are exact OIDs, it is possible to perform a
fetch without requiring the remote to list refs if protocol v2 is used.
Teach Git to do this.

This currently has an effect only for lazy fetches done from partial
clones. The change necessary to likewise optimize "git fetch <remote>
<sha-1>" will be done in a subsequent patch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c           |  2 +-
 t/t5702-protocol-v2.sh |  5 +++++
 transport.c            | 13 +++++++++++--
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 75047a4b2a..15652b4776 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1598,7 +1598,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 	if (nr_sought)
 		nr_sought = remove_duplicates_in_refs(sought, nr_sought);
 
-	if (!ref) {
+	if (version != protocol_v2 && !ref) {
 		packet_flush(fd[1]);
 		die(_("no matching remote head"));
 	}
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 3beeed4546..a316bb9bf4 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -286,6 +286,11 @@ test_expect_success 'dynamically fetch missing object' '
 	grep "version 2" trace
 '
 
+test_expect_success 'when dynamically fetching missing object, do not list refs' '
+	cat trace &&
+	! grep "git> command=ls-refs" trace
+'
+
 test_expect_success 'partial fetch' '
 	rm -rf client "$(pwd)/trace" &&
 	git init client &&
diff --git a/transport.c b/transport.c
index 5fb9ff6b56..4329cca8e5 100644
--- a/transport.c
+++ b/transport.c
@@ -341,8 +341,17 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.server_options = transport->server_options;
 	args.negotiation_tips = data->options.negotiation_tips;
 
-	if (!data->got_remote_heads)
-		refs_tmp = get_refs_via_connect(transport, 0, NULL);
+	if (!data->got_remote_heads) {
+		int i;
+		int must_list_refs = 0;
+		for (i = 0; i < nr_heads; i++) {
+			if (!to_fetch[i]->exact_oid) {
+				must_list_refs = 1;
+				break;
+			}
+		}
+		refs_tmp = handshake(transport, 0, NULL, must_list_refs);
+	}
 
 	switch (data->version) {
 	case protocol_v2:
-- 
2.19.0.605.g01d371f741-goog

