Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9832D208B7
	for <e@80x24.org>; Thu,  3 Aug 2017 09:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbdHCJUd (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:20:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35083 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752084AbdHCJUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:20:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id r77so1444860wmd.2
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uElRNE9iieY/fbAaLSeJzG0JvLQ1nU/julH4WfoTIbQ=;
        b=mOVY37XsrvXTpAvu/RoD/JduJVZrlMbDVw/k9cMVAZoqAFguaVGYgIoA67btB/K9Po
         7kVw6Za2lbX0+jCCBTpx1mZZUiZGaopGv7cN8VRzvNydU2SnhlGjqKxgcnG7G/KYhobp
         Jd9n1pwPf1pbiCRvFb53wA7xw4SsdEqG6FtfAuT+h42nbJIEszEfU7How06j4ZRTDfXR
         +PKLXplnDM7/s6CLK7BBRcqxW+ec/4GIw6qHfd3QyQi0j2QK0CLXZ5tKKHXZlpS6Uz9g
         1RftAbkszbsL6pyGciEwWP35tLYnTt7nuyg1smxoDRJqjXMmOqCcoymrntfiWM+VcJED
         ohQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uElRNE9iieY/fbAaLSeJzG0JvLQ1nU/julH4WfoTIbQ=;
        b=LFF5oZR/EOIbD01bSX7lcZKWbbQ3beT8npp6OTCJWfUQF/53Oy7kwvmMAk+4bQgXMI
         jEzWVtX2DofaC0vFr6uesAXN+NtVeXwJaj4WhUdLxooI2PVQCarceC3CwwSm+zRDnqvD
         lxfwpkIm/unt8HHYkfVNMWX4eyD88pf3vPMI3yA7SSw0h/T2enTFsGLipqGThEDYQXNq
         HFVhjvGyqkuNPeFfdxEwt3uk735rKSAN0/a3CpA5Si/mLgp9Res2fDquIHQGs3PYy8ef
         KIezZtJ7kM8DiRJElgyfscXRDycbhY2keZsdwJjecuTcSbRi3tU2f3V1Xiie8VMycxc7
         kfuw==
X-Gm-Message-State: AHYfb5ghpQnT4Rrc/zXmI1Fpy4mHT29fKebkLSmrZ1QjrLBFEZJNUaBY
        4zkivuiorZNp+/mq
X-Received: by 10.28.14.149 with SMTP id 143mr678614wmo.102.1501752022920;
        Thu, 03 Aug 2017 02:20:22 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:20:22 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 36/40] clone: add 'initial' param to write_remote_refs()
Date:   Thu,  3 Aug 2017 11:19:22 +0200
Message-Id: <20170803091926.1755-37-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want to make it possible to separate fetching remote refs into
an initial part and a later part. To prepare for that, let's add
an 'initial' boolean parameter to write_remote_refs() to tell this
function if we are performing the initial part or not.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/clone.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 4b5340c55f..2362dda880 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -573,7 +573,7 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 	return local_refs;
 }
 
-static void write_remote_refs(const struct ref *local_refs)
+static void write_remote_refs(const struct ref *local_refs, int initial)
 {
 	const struct ref *r;
 
@@ -592,8 +592,13 @@ static void write_remote_refs(const struct ref *local_refs)
 			die("%s", err.buf);
 	}
 
-	if (initial_ref_transaction_commit(t, &err))
-		die("%s", err.buf);
+	if (initial) {
+		if (initial_ref_transaction_commit(t, &err))
+			die("%s", err.buf);
+	} else {
+		if (ref_transaction_commit(t, &err))
+			die("%s", err.buf);
+	}
 
 	strbuf_release(&err);
 	ref_transaction_free(t);
@@ -640,7 +645,8 @@ static void update_remote_refs(const struct ref *refs,
 			       const char *branch_top,
 			       const char *msg,
 			       struct transport *transport,
-			       int check_connectivity)
+			       int check_connectivity,
+			       int initial)
 {
 	const struct ref *rm = mapped_refs;
 
@@ -655,7 +661,7 @@ static void update_remote_refs(const struct ref *refs,
 	}
 
 	if (refs) {
-		write_remote_refs(mapped_refs);
+		write_remote_refs(mapped_refs, initial);
 		if (option_single_branch && !option_no_tags)
 			write_followtags(refs, msg);
 	}
@@ -1164,7 +1170,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		transport_fetch_refs(transport, mapped_refs);
 
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
-			   branch_top.buf, reflog_msg.buf, transport, !is_local);
+			   branch_top.buf, reflog_msg.buf, transport,
+			   !is_local, 0);
 
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

