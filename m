Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE9DC433E3
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2957B20702
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rapOb22t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHXRmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgHXRmT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 13:42:19 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57702C061795
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:42:19 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so4571815plk.10
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JKkzv5uHWjStIPLmBqjV+ImS+rOXWcOFxrifeT45Lcw=;
        b=rapOb22tMWGjwb5+mo+TBYNAHXpTfIvy/RSrJbSt7CncifEjPQQb59CyToGXH6Lclh
         rCiq10E/DgiDynLv7oi45vkIOyqyhVjNmK/jbeUac1LOIOh1XIlEjkqbOg8OdNPp9WwK
         tqMUisAZf5AhaefzWEQ96PItB1Ymv2Vj699dBFAVan35ThUzSWOPNRvAlLKlnklAyZka
         eCiXnKQHP6Ha1hv6uJBcS/Uj/nGe2wIqWEUX0cuUvVbeacAlefWcpqykeIw7qzCKdRV+
         7wAaYyGiZ59ooZ8NnitUmtXt0E1dOoqgynM7qdZlzSDaOGVFf/MOHt1KwZZJ3xe3FA8m
         Ujqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JKkzv5uHWjStIPLmBqjV+ImS+rOXWcOFxrifeT45Lcw=;
        b=SIrvc+DqsUOmiRDA+jpjjwWDSYS7q8T0PmTj8AFBv++cMYFHroXjlzN3Lg4d1lsbH/
         jKojCY+HZQOdWrZQ4M/TdtQsxp3gp6DXNJVvBVIERxvnUMmWVT7H/7uUFUwR383QdQ1s
         J+IQtInxY4m0qvTiGkCO6qb1+yjy25/X2o77FUnkJCRi3feyzPPRyngKurdLbTfUvGxc
         R/3nKbO/J8QshVifVbOsN90QmeZKi/hoTTIEN1O3ks+kS1YUN08R8HsxVeeTJVbqO0nh
         /+tw+rr4Fz+e0/3b8TjH3nPZGlXBrOyFW3ULzPkxS/enNTU2io9BDgYa6jQbOQLUxDkO
         86DQ==
X-Gm-Message-State: AOAM532RFrKZiwm40NX8jRgsGLHVSQGzePu+dzxerR0iRLlNffh8QhTi
        NUQ3abucE4l0ZcIUF6ykF5SrHHVn3VIq5w==
X-Google-Smtp-Source: ABdhPJyI3FJsed0Rm8r14v6liWXpvxMycU3SWU9Y0gObF5QEXGWPXikKkyGXD2YM1LGKNQQDIpIXLQ==
X-Received: by 2002:a17:902:8d8a:: with SMTP id v10mr4453774plo.249.1598290938851;
        Mon, 24 Aug 2020 10:42:18 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id b15sm9773162pgk.14.2020.08.24.10.42.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 10:42:18 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v18 06/10] doc: add document for capability report-status-v2
Date:   Mon, 24 Aug 2020 13:41:58 -0400
Message-Id: <20200824174202.11710-7-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200815171740.6257-1-worldhello.net@gmail.com>
References: <20200815171740.6257-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Add ABNF notation for capability 'report-status-v2' which extends
capability 'report-status' by adding additional option lines.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Documentation/technical/pack-protocol.txt     | 43 +++++++++++++++++--
 .../technical/protocol-capabilities.txt       | 17 ++++++--
 2 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index d5ce4eea8a..7547b9ca89 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -503,8 +503,8 @@ The reference discovery phase is done nearly the same way as it is in the
 fetching protocol. Each reference obj-id and name on the server is sent
 in packet-line format to the client, followed by a flush-pkt.  The only
 real difference is that the capability listing is different - the only
-possible values are 'report-status', 'delete-refs', 'ofs-delta' and
-'push-options'.
+possible values are 'report-status', 'report-status-v2', 'delete-refs',
+'ofs-delta', 'atomic' and 'push-options'.
 
 Reference Update Request and Packfile Transfer
 ----------------------------------------------
@@ -625,7 +625,7 @@ Report Status
 -------------
 
 After receiving the pack data from the sender, the receiver sends a
-report if 'report-status' capability is in effect.
+report if 'report-status' or 'report-status-v2' capability is in effect.
 It is a short listing of what happened in that update.  It will first
 list the status of the packfile unpacking as either 'unpack ok' or
 'unpack [error]'.  Then it will list the status for each of the references
@@ -647,6 +647,43 @@ update was successful, or 'ng [refname] [error]' if the update was not.
   error-msg         = 1*(OCTET) ; where not "ok"
 ----
 
+New capability "report-status-v2" extends the protocol by adding new option
+lines in order to support reporting of reference rewritten by the
+"proc-receive" hook.  The "proc-receive" hook may handle a command for a
+pseudo-reference which may create or update one or more references, and each
+reference may have different name, different new-oid, and different old-oid.
+
+----
+  report-status-v2  = unpack-status
+		      1*(command-status-v2)
+		      flush-pkt
+
+  unpack-status     = PKT-LINE("unpack" SP unpack-result)
+  unpack-result     = "ok" / error-msg
+
+  command-status-v2 = command-ok-v2 / command-fail-v2
+  command-ok-v2     = command-ok
+		      *option-line
+  command-fail-v2   = command-fail
+		      *option-line
+
+  command-ok        = PKT-LINE("ok" SP refname)
+  command-fail      = PKT-LINE("ng" SP refname SP error-msg)
+
+  error-msg         = 1*(OCTET) ; where not "ok"
+
+  option-line       = *1(option-refname)
+		      *1(option-old-oid)
+		      *1(option-new-oid)
+		      *1(option-forced-update)
+
+  option-refname    = PKT-LINE("option" SP "refname" SP refname)
+  option-old-oid    = PKT-LINE("option" SP "old-oid" SP obj-id)
+  option-new-oid    = PKT-LINE("option" SP "new-oid" SP obj-id)
+  option-force      = PKT-LINE("option" SP "forced-update")
+
+----
+
 Updates can be unsuccessful for a number of reasons.  The reference can have
 changed since the reference discovery phase was originally sent, meaning
 someone pushed in the meantime.  The reference being pushed could be a
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 2b267c0da6..91fd976094 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -22,9 +22,9 @@ was sent.  Server MUST NOT ignore capabilities that client requested
 and server advertised.  As a consequence of these rules, server MUST
 NOT advertise capabilities it does not understand.
 
-The 'atomic', 'report-status', 'delete-refs', 'quiet', and 'push-cert'
-capabilities are sent and recognized by the receive-pack (push to server)
-process.
+The 'atomic', 'report-status', 'report-status-v2', 'delete-refs', 'quiet',
+and 'push-cert' capabilities are sent and recognized by the receive-pack
+(push to server) process.
 
 The 'ofs-delta' and 'side-band-64k' capabilities are sent and recognized
 by both upload-pack and receive-pack protocols.  The 'agent' capability
@@ -269,6 +269,17 @@ each reference was updated successfully.  If any of those were not
 successful, it will send back an error message.  See pack-protocol.txt
 for example messages.
 
+report-status-v2
+----------------
+
+Capability 'report-status-v2' extends capability 'report-status' by
+adding new option lines in order to support reference rewritten by
+the"proc-receive" hook.  The "proc-receive" hook may handle a command
+for a pseudo-reference which may create or update a reference with
+different name, new-oid, and old-oid.  While the capability
+"report-status" cannot report for such case.  See pack-protocol.txt
+for details.
+
 delete-refs
 -----------
 
-- 
2.26.2.543.ge7de2a6e37

