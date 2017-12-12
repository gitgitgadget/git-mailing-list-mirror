Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BADEA1F406
	for <e@80x24.org>; Tue, 12 Dec 2017 23:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbdLLXLE (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 18:11:04 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:42763 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbdLLXLA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 18:11:00 -0500
Received: by mail-io0-f195.google.com with SMTP id u42so827094ioi.9
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 15:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2tlFprjbY5U5x+F+kDhQZOmkKI14aTYPYDLWTzAdo/Y=;
        b=tFSBwQcx1RlVe52Kj78B5VhwMGnF4ksUxuRjtpaY727cAAZ0DmGf6uU+hcp+8yRmLj
         D+i88ss+5+gg+ADMkyZaHx8pKnV03z2LAnwmUXUHGVAG5QQQiSgmV8LHOYiJOH4EFwxc
         mycQ+4C3IOfJ0qf5uJ2+9TvCURwqpQE6XxTJCf6Y4TBaki3yktv172GUmYXxj4lqdheY
         I3kKl7AD/kJhYJR3Cf4CCQz2kJ1EqtkHOQsNnTNKVVPW56ev/liXP/8mfTsm5kuVoaRD
         HP2mH0elV7HkhT4+MxbeJ2ZoMIVoVMYWiSVAcWVPSQ42U86fcTf6OifzR8v/YFiXp//S
         EsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2tlFprjbY5U5x+F+kDhQZOmkKI14aTYPYDLWTzAdo/Y=;
        b=oBewAnkg9L1vEPFmdbm6FdCI+wJ5LdrdLWpruXY+tNT7c4Y60qB1izVeRH0wsFle3I
         O7qvK5854DZKrr/uxkDuhtGnPYfd1wuHJLDu3UBSvtQWQLEftZdMNETGOQntSJDQjMYW
         cSqFD5BU306ZQHlqc+9INDtKVWAVC3mmlVy2o+CsfcL4qBoJqxUaY2evsb9RA9XWqHMo
         3KFxxLLybGn2zhryKGM3quVSoZe4iBHX0d/qP3Ipv8dmQyCUGOA8egiANot5EviFDJs3
         c/AE5qE/BeiKwI5wnKxOFJ4bDZsCsOaHDv42JvjD6N3TzbdMm59eqGN0oqnVT+jQNRqO
         EFAg==
X-Gm-Message-State: AKGB3mI0HSKUMiisZ4cCNZf1QazYeV0ZnJOESeKXL8ckfozHPBF4hXQx
        5WkMmEfXMv6LvdGV7TA7tqYttlwrc0c=
X-Google-Smtp-Source: ACJfBosXLQtsiT0Dmse8SDoTq6QXlXn2ve3TNbOAjydfV2p+UFddQRSStqvwVRE4h9INJ5gQpEUskw==
X-Received: by 10.107.183.67 with SMTP id h64mr666547iof.46.1513120259689;
        Tue, 12 Dec 2017 15:10:59 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id k134sm314296itb.34.2017.12.12.15.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Dec 2017 15:10:59 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
Subject: [PATCH] transport: remove unused "push" in vtable
Date:   Tue, 12 Dec 2017 15:10:56 -0800
Message-Id: <20171212231056.256585-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.15.1.355.gae4552cba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After commit 0d0bac67ce3b ("transport: drop support for git-over-rsync",
2016-02-01), no transport in Git populates the "push" entry in the
transport vtable. Remove this entry.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
I was taking a look at the transport code and noticed that push is
unused (and push_refs is used instead). Here is a code cleanup.
---
 transport.c | 9 +--------
 transport.h | 1 -
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/transport.c b/transport.c
index 7231d1b1b..7cc39b7c0 100644
--- a/transport.c
+++ b/transport.c
@@ -627,7 +627,6 @@ void transport_take_over(struct transport *transport,
 	transport->set_option = NULL;
 	transport->get_refs_list = get_refs_via_connect;
 	transport->fetch = fetch_refs_via_pack;
-	transport->push = NULL;
 	transport->push_refs = git_transport_push;
 	transport->disconnect = disconnect_git;
 	transport->smart_options = &(data->options);
@@ -969,13 +968,7 @@ int transport_push(struct transport *transport,
 	*reject_reasons = 0;
 	transport_verify_remote_names(refspec_nr, refspec);
 
-	if (transport->push) {
-		/* Maybe FIXME. But no important transport uses this case. */
-		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
-			die("This transport does not support using --set-upstream");
-
-		return transport->push(transport, refspec_nr, refspec, flags);
-	} else if (transport->push_refs) {
+	if (transport->push_refs) {
 		struct ref *remote_refs;
 		struct ref *local_refs = get_local_heads();
 		int match_flags = MATCH_REFS_NONE;
diff --git a/transport.h b/transport.h
index bc5571574..ab4fe7f27 100644
--- a/transport.h
+++ b/transport.h
@@ -103,7 +103,6 @@ struct transport {
 	 * process involved generating new commits.
 	 **/
 	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
-	int (*push)(struct transport *connection, int refspec_nr, const char **refspec, int flags);
 	int (*connect)(struct transport *connection, const char *name,
 		       const char *executable, int fd[2]);
 
-- 
2.15.1.424.g9478a66081-goog

