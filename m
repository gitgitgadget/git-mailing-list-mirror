Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8C1C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BBC72087D
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhkK3oJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgH0PqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgH0PqC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 11:46:02 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C742C061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 08:46:02 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g29so2632916pgl.2
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 08:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EJIwL0GuMSH7186cn3RBGxkVisJ7WkzCx/NSn6JCajM=;
        b=NhkK3oJxU7wZOf52MgilkQNGfLxBzRrqGqA6dqcLjEwrP3vLKPfKnYHJGWrcGZGeIy
         tEQsqvoUIeOFbtzXHohBS9gmKqRwIZd9qtIQcRtY3EGWqgfnciHjhlJRg2miTKZV8r1L
         skieB1g8kqVUoBaQ7u5Qkx+8MlFpzZT9ok/yI9TplL2OuUwKGi84ptp8IfEIX+XifO9V
         6uLrBsjwt62WTQhddnrp3DeeHkdgyezaJjR2+VVBfHZarxgMQq+Mqt/yQ+Spv4ttdrav
         yyr4biYuWeaWdCdkY2CPFeJlJzgtx83HKonxsM5Hvq1hjPWuPqXBB2CM4XIBW26ixVG5
         Ew1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EJIwL0GuMSH7186cn3RBGxkVisJ7WkzCx/NSn6JCajM=;
        b=GgfYqvdHny+yj632SKiYoNa7TGLiA6Eh5dWx0o3HJN/7zrsN+8fGajy33KbGDo39Qz
         DhkyTVZT9iejzb2Sto3lXqASHDP5G40KU//BUP6wE6GcAQb+KRz6THIDP2AwsMLubpNX
         yxBRmZLV03wY1Q83E1cmPlCigiwl5M2PKU7HB4RjY3S9AbJ9Rzpmv2LQApEjK0s3ghjK
         8Kwpqq1iTQJW8gh9wwPmoVA0BfPcZUerHXHElrzUP3GMFJL2mx0G3qltrhBXzVlaf/gZ
         FQRgdv6UGC/00kHFLRdzl47tP6fNeLAuQ1r/Zo8UNrxz6h8O3owFt7otw2Ecvo9zZrcp
         swpw==
X-Gm-Message-State: AOAM531n6sTF5+UeZxSL/+uvyBXlFTv27nAablua1d7YagUqorUwlPP2
        +DUEPboqa1jAwrB7rrZJPxs=
X-Google-Smtp-Source: ABdhPJwSxaREb4QsR3ckw+Geb6u2RFxLlr8/ZVScebuZi8clTwxA2DQUZ4gsZCo6ZIzkJPND62yOvQ==
X-Received: by 2002:a17:902:a714:: with SMTP id w20mr16937743plq.8.1598543162047;
        Thu, 27 Aug 2020 08:46:02 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x5sm3129218pfj.1.2020.08.27.08.46.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 08:46:01 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v19 06/10] doc: add document for capability report-status-v2
Date:   Thu, 27 Aug 2020 11:45:47 -0400
Message-Id: <20200827154551.5966-7-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200824174202.11710-1-worldhello.net@gmail.com>
References: <20200824174202.11710-1-worldhello.net@gmail.com>
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
 Documentation/technical/pack-protocol.txt     | 41 +++++++++++++++++--
 .../technical/protocol-capabilities.txt       | 17 ++++++--
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index a4573d12ce..e13a2c064d 100644
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
@@ -647,6 +647,41 @@ update was successful, or 'ng [refname] [error]' if the update was not.
   error-msg         = 1*(OCTET) ; where not "ok"
 ----
 
+The 'report-status-v2' capability extends the protocol by adding new option
+lines in order to support reporting of reference rewritten by the
+'proc-receive' hook.  The 'proc-receive' hook may handle a command for a
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
+  command-status-v2 = command-ok-v2 / command-fail
+  command-ok-v2     = command-ok
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
index 124d716807..ba869a7d36 100644
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
@@ -284,6 +284,17 @@ each reference was updated successfully.  If any of those were not
 successful, it will send back an error message.  See pack-protocol.txt
 for example messages.
 
+report-status-v2
+----------------
+
+Capability 'report-status-v2' extends capability 'report-status' by
+adding new "option" directives in order to support reference rewritten by
+the "proc-receive" hook.  The "proc-receive" hook may handle a command
+for a pseudo-reference which may create or update a reference with
+different name, new-oid, and old-oid.  While the capability
+'report-status' cannot report for such case.  See pack-protocol.txt
+for details.
+
 delete-refs
 -----------
 
-- 
2.26.2.543.g44b58e439b

