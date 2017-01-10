Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6110520A93
	for <e@80x24.org>; Tue, 10 Jan 2017 08:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760457AbdAJItJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 03:49:09 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35405 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760375AbdAJItH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 03:49:07 -0500
Received: by mail-pf0-f193.google.com with SMTP id f144so9037641pfa.2
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 00:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CqEsiFGTMsu2ZMxZIM7Bv7nE+yLjy5THZRy8o6eKnD0=;
        b=YAOjgQdvNXaPajYnn/M4gdrn6ExPG1j60XwYIX8Ith2ZQXOzJ05IZ+IPiJHGOIB+/2
         YIXvi8IbiIczOYqXW+LMpW/URR54Bx7lumcfANdQM/zXn8QoHkaz6qzrQJyc9qlEH0pK
         YxSyhvgxZqUifAElJx6m23jqYXzLNBv3R3Q1eZA5XCNvPJVK4ws0InsZsypgEJlEtkId
         9I7XhD5nYiTEatPQrYqet9iJqK1nmwE8PmWHpmB2Z3QQqdT7ZeCm1fmrGHUu2MMFEabi
         wIPKJsbb2ZGHf/psjcRNdGwt+8rx+svYCmtWu/ebDiHIfCn8F8FZddg3+EcnPb5KfCkg
         3U6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CqEsiFGTMsu2ZMxZIM7Bv7nE+yLjy5THZRy8o6eKnD0=;
        b=QPL8c49QLMZI66cGQbNrUd13tnZ+IG1QYK3NKKYAdHnqy2pDEaAhL0wa0FGOxu2vwk
         A5fL2erTDx/uLnGkR4yUoysGSCCCc/tKMm3gDYJXk+Dw7sKshDh+EE+TFfdPZmj0Bpoy
         F3vSlD5w5P7XvIzANr2S3lpqnsmElBineVpfZyHDbrImixO8fwcIIA4zdXWqIYLDLmw7
         ikIOU2LHN7fgn+kCBY8rcxs3jMErraTAgtEBGkiFSkfcuWknOUcMrDk5m57GG23xfWia
         IAaWzxkeOXWKn+z2aM135sJOQPDHBwXRd+X7XZc4473RqmOsjSGAgmjKGm7ETfY4WT7q
         rB7A==
X-Gm-Message-State: AIkVDXJneNAJinAgk+1HCZh8ZrOguEf1/OKEXcZnpwCjsdA5G4h1vDVB+1y+sfiN3OGkVA==
X-Received: by 10.99.124.66 with SMTP id l2mr2741740pgn.116.1484038146619;
        Tue, 10 Jan 2017 00:49:06 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id m12sm3411983pfg.92.2017.01.10.00.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 00:49:05 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 07/20] ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
Date:   Tue, 10 Jan 2017 14:19:40 +0530
Message-Id: <20170110084953.15890-8-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170110084953.15890-1-Karthik.188@gmail.com>
References: <20170110084953.15890-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Borrowing from branch.c's implementation print "[gone]" whenever an
unknown upstream ref is encountered instead of just ignoring it.

This makes sure that when branch.c is ported over to using ref-filter
APIs for printing, this feature is not lost.

Make changes to t/t6300-for-each-ref.sh and
Documentation/git-for-each-ref.txt to reflect this change.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Helped-by : Jacob Keller <jacob.keller@gmail.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 3 ++-
 ref-filter.c                       | 4 +++-
 t/t6300-for-each-ref.sh            | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index d7ab4c961..94c6b88fa 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -121,7 +121,8 @@ upstream::
 	"[ahead N, behind M]" and `:trackshort` to show the terse
 	version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
 	or "=" (in sync).  Has no effect if the ref does not have
-	tracking information associated with it.
+	tracking information associated with it. `:track` also prints
+	"[gone]" whenever unknown upstream ref is encountered.
 
 push::
 	The name of a local ref which represents the `@{push}` location
diff --git a/ref-filter.c b/ref-filter.c
index 47b521cca..998991873 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1073,8 +1073,10 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		*s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
 	else if (atom->u.remote_ref == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours,
-				       &num_theirs, NULL))
+				       &num_theirs, NULL)) {
+			*s = "[gone]";
 			return;
+		}
 
 		if (!num_ours && !num_theirs)
 			*s = "";
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index e67c694c3..a2e3f5525 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -382,7 +382,7 @@ test_expect_success 'Check that :track[short] cannot be used with other atoms' '
 
 test_expect_success 'Check that :track[short] works when upstream is invalid' '
 	cat >expected <<-\EOF &&
-
+	[gone]
 
 	EOF
 	test_when_finished "git config branch.master.merge refs/heads/master" &&
-- 
2.11.0

