Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCA4C20987
	for <e@80x24.org>; Thu, 29 Sep 2016 19:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755721AbcI2TWF (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 15:22:05 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35493 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755701AbcI2TWC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 15:22:02 -0400
Received: by mail-pa0-f46.google.com with SMTP id oz2so30503387pac.2
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 12:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=88WI8qvKYsr/oe/RKaJRojuvyW06XUOfaAb/q0mSgic=;
        b=X/h3/twrvSShYtsE9L+i90S65UpgnVodmCr45jECUKaFZkbpEXlZDU27e7Kvs/i8J2
         qWICVKe7nwr3jQ4KW8AUNojGWt6313T0NJh8ptGxqIpMlbrND+0fe5lM8hN7NO6TrZM3
         qUu+M7TKEMyqvDhC7pDkbrfPWQ9wT8FRKbj4WkwJJKGzR957a5J9WfS8DG1rHpIbQMXK
         g5+nFIgOW69/fP8N3kNuCkEQTi/uTGkRLF62vALHhfEPi2tkGW+IFP5VW82vAfK5n/gv
         P3842/5+h757HMaB7Ljk30RBl7mu2/Dl8vZc9tPzQcgTNd5O4duaLOcPIm1Rikx/Kf7z
         R60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=88WI8qvKYsr/oe/RKaJRojuvyW06XUOfaAb/q0mSgic=;
        b=Wc82BWWoFZcG4DGha/GsOERfmJVMPSIty28jKJnvrNerK2pLNKORBlNm48v/ApDST6
         HZfGNxW5z2S2e7IVMxBUCd7E6WNBQAOSq4x9n7dJ+tWVerdWZTtM3w1NnK1rIrVBII0I
         6M/1mbh7CUnzTIzYYbm4VyUVk1wPAJ3Qvjve8aNJmzn9L7A0nffAAbITfiH47WDp+jtM
         kN1FagPn6bZQDNvK6ZruQei9o5ySAg+ryrA2dVgu32vtFG+m7rIs/GdqL37hZZVrCLka
         RRoAqun1wETutSo0en1XGYwmrudlHo+xpth/eBiLm33VLa2tJvvr25U7fwvioRBVauTQ
         Hfkg==
X-Gm-Message-State: AA6/9RmlXZCmKmgKXt1Htt+1w7+Lw4/qgCQGwHWiJozTHupCdlvDci3d9ds/0mwPBpFV9b/W
X-Received: by 10.66.120.69 with SMTP id la5mr5102897pab.65.1475176908466;
        Thu, 29 Sep 2016 12:21:48 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id e1sm22184087pap.11.2016.09.29.12.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Sep 2016 12:21:47 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC/PATCH 1/2] sequencer: refactor message and origin appending
Date:   Thu, 29 Sep 2016 12:21:37 -0700
Message-Id: <44fe5d92cdcd1b952fe44c9e0b37a1dbf55b38b8.1475176070.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1475176070.git.jonathantanmy@google.com>
References: <cover.1475176070.git.jonathantanmy@google.com>
In-Reply-To: <cover.1475176070.git.jonathantanmy@google.com>
References: <cover.1475176070.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the appending of the commit message and origin information into its
own function, in preparation for a subsequent patch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 sequencer.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3804fa9..b29c9ca 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -443,6 +443,33 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
 		return 1;
 }
 
+/*
+ * Appends the commit log message, including the cherry picked notification if
+ * record_origin is nonzero.
+ */
+static void append_message(struct strbuf *msgbuf,
+			   const struct commit_message *msg,
+			   int record_origin,
+			   const struct commit *commit)
+{
+	/*
+	 * Append the commit log message to msgbuf; it starts
+	 * after the tree, parent, author, committer
+	 * information followed by "\n\n".
+	 */
+	const char *p = strstr(msg->message, "\n\n");
+	if (p)
+		strbuf_addstr(msgbuf, skip_blank_lines(p + 2));
+
+	if (record_origin) {
+		if (!has_conforming_footer(msgbuf, NULL, 0))
+			strbuf_addch(msgbuf, '\n');
+		strbuf_addstr(msgbuf, cherry_picked_prefix);
+		strbuf_addstr(msgbuf, oid_to_hex(&commit->object.oid));
+		strbuf_addstr(msgbuf, ")\n");
+	}
+}
+
 static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 {
 	unsigned char head[20];
@@ -534,29 +561,12 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 		strbuf_addstr(&msgbuf, ".\n");
 	} else {
-		const char *p;
-
 		base = parent;
 		base_label = msg.parent_label;
 		next = commit;
 		next_label = msg.label;
 
-		/*
-		 * Append the commit log message to msgbuf; it starts
-		 * after the tree, parent, author, committer
-		 * information followed by "\n\n".
-		 */
-		p = strstr(msg.message, "\n\n");
-		if (p)
-			strbuf_addstr(&msgbuf, skip_blank_lines(p + 2));
-
-		if (opts->record_origin) {
-			if (!has_conforming_footer(&msgbuf, NULL, 0))
-				strbuf_addch(&msgbuf, '\n');
-			strbuf_addstr(&msgbuf, cherry_picked_prefix);
-			strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
-			strbuf_addstr(&msgbuf, ")\n");
-		}
+		append_message(&msgbuf, &msg, opts->record_origin, commit);
 	}
 
 	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REPLAY_REVERT) {
-- 
2.8.0.rc3.226.g39d4020

