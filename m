Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AFEC00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 22:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 645AA221EB
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 22:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mutual.io header.i=@mutual.io header.b="Sedx2u+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgJ3WfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 18:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3WfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 18:35:16 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7503C0613D5
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 15:35:14 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id i7so4466183pgh.6
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 15:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mutual.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xD2NK5GNZrYbvmgX+KCZuodT6c6miHc7yrve9STzzIw=;
        b=Sedx2u+9ziUdugkDmP4QhmGdDhvOtqjxlbdv06khqOiSkrJ4/QSoWVKoo4Rc6LUCr/
         WwktSFQPInKuBbmJloWw4M5VZwsyOsqbdQE0bvEv6lWzXoFay9aZc3UR+cWV8qpWxx0D
         d2bhhyOZ3IbQX3Bf7Shm2zAC7/F7bMantufMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xD2NK5GNZrYbvmgX+KCZuodT6c6miHc7yrve9STzzIw=;
        b=SbSj0YpZTv3w/nG0bhX4d//EaHQ2JSa9EeF8cC0vbf8OqSBpYwKirhbZjIlmzmacDW
         8gJNIZiVHTJd7uy5O9UQLuVTqYK1E7/DWMol9NbqPN3/t52PGoEOXHnNbFrHGl4cLQlc
         5000vel+X8jBRpcCyZyTLam+RKZpTr00zAQBqb/IAJ+SIXOdmFgvrjLZqjSUnDy+ag++
         Mzr5SnBSR7TP6Ht+DDWZDrbKyuvPV6wDC+GFQloCTwju7KRrvlckT61VXAxAOSgyDaCl
         XzU87/2w7NVTslXM48m52iKIJFVn1SP8J3YE5NwjzRn/7iA3CEgBl7s90k/JRX1C1Sw/
         eFNg==
X-Gm-Message-State: AOAM532O79lxDoK9m2iEYX1FJ5FQbsgVaInePiiJCTnVqWPiPRyNLqVh
        8wIA6U2KEk6bgOmVVasx+dlJ0QEMfClmnfv5
X-Google-Smtp-Source: ABdhPJzip1/f+PqkuhSBctI7LyUE7k9ySWKSQDpQdryIZrvove65ANvCOFFMunU4mBxTLdTxWmc1rQ==
X-Received: by 2002:a63:174a:: with SMTP id 10mr4028700pgx.212.1604097314381;
        Fri, 30 Oct 2020 15:35:14 -0700 (PDT)
Received: from shawarma.mutual.io (23-115-137-209.lightspeed.sntcca.sbcglobal.net. [23.115.137.209])
        by smtp.gmail.com with ESMTPSA id w16sm6919437pfn.148.2020.10.30.15.35.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2020 15:35:13 -0700 (PDT)
Received: by shawarma.mutual.io (Postfix, from userid 502)
        id 2FA862172A55; Fri, 30 Oct 2020 15:35:12 -0700 (PDT)
From:   Daniel Duvall <dan@mutual.io>
To:     git@vger.kernel.org
Cc:     Daniel Duvall <dan@mutual.io>
Subject: [PATCH v2] upload-pack: allow stateless client EOF just prior to haves
Date:   Fri, 30 Oct 2020 15:35:04 -0700
Message-Id: <20201030223504.45978-1-dan@mutual.io>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <1604022059-18527-1-git-send-email-dan@mutual.io>
References: <1604022059-18527-1-git-send-email-dan@mutual.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During stateless packfile negotiation where a depth is given, stateless RPC
clients (e.g. git-remote-curl) will send multiple upload-pack requests with
the first containing only the wants/shallows/deepens/filters and the
subsequent containing haves/done.

When upload-pack handles such requests, entering get_common_commits without
first whether the client has hung up can result in unexpected EOF during the
negotiation loop and a die() with message "fatal: the remote end hung up
unexpectedly".

Real world effects include:

 - A client speaking to git-http-backend via a server that doesn't check the
   exit codes of CGIs (e.g. mod_cgi) doesn't know and doesn't care about the
   fatal. It continues to process the response body as normal.

 - A client speaking to a server that does check the exit code and returns an
   errant HTTP status as a result will fail with the message "error: RPC
   failed; HTTP 500 curl 22 The requested URL returned error: 500."

 - Admins running servers that surface the failure must workaround it by
   patching code that handles execution of git-http-backend to ignore exit
   codes or take other heuristic approaches.

 - Admins may have to deal with "hung up unexpectedly" log spam related to the
   failures even in cases where the exit code isn't surfaced as an HTTP
   server-side error status.

To avoid these EOF related fatals, have upload-pack gently peek for an EOF
between the sending of shallow/unshallow lines (followed by flush) and the
reading of client haves. If the client has hung up at this point, exit
normally.

Signed-off-by: Daniel Duvall <dan@mutual.io>

---

Changes in v2:
 - Replaced unconditional flipping (XOR) of PACKET_READ_GENTLE_ON_EOF bit w/
   `&= ~` to flip it back off (as it was when reader was initialized in
   previous clause)
 - Renamed test filename to group with other upload-pack related tests
 - Refactored test using packetize helper
 - Clarified in commit message that file descriptor is still valid but client
   hangup/EOF is the core issue
 - Added possible real-world effects of bug to commit message as suggested

---
 t/t5705-upload-pack-stateless-shallow-eof.sh | 24 ++++++++++++++++++++
 upload-pack.c                                | 13 ++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100755 t/t5705-upload-pack-stateless-shallow-eof.sh

diff --git a/t/t5705-upload-pack-stateless-shallow-eof.sh b/t/t5705-upload-pack-stateless-shallow-eof.sh
new file mode 100755
index 0000000000..cc9d4baa0b
--- /dev/null
+++ b/t/t5705-upload-pack-stateless-shallow-eof.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+test_description='stateless upload-pack gently handles EOF just after want/shallow/depth/flush'
+
+. ./test-lib.sh
+
+test_expect_success 'upload-pack outputs flush and exits ok' '
+	test_commit initial &&
+	head=$(git rev-parse HEAD) &&
+
+	{
+		packetize "want $head" &&
+		packetize "shallow $head" &&
+		packetize "deepen 1" &&
+		printf "0000"
+	} >request &&
+
+	printf "0000" >expect &&
+	git upload-pack --stateless-rpc . <request >actual &&
+
+	test_cmp expect actual
+'
+
+test_done
diff --git a/upload-pack.c b/upload-pack.c
index 3b858eb457..5dc8e1f844 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1344,7 +1344,18 @@ void upload_pack(struct upload_pack_options *options)
 				   PACKET_READ_DIE_ON_ERR_PACKET);
 
 		receive_needs(&data, &reader);
-		if (data.want_obj.nr) {
+
+		/*
+		 * An EOF at this exact point in negotiation should be
+		 * acceptable from stateless clients as they will consume the
+		 * shallow list before doing subsequent rpc with haves/etc.
+		 */
+		if (data.stateless_rpc)
+			reader.options |= PACKET_READ_GENTLE_ON_EOF;
+
+		if (data.want_obj.nr &&
+		    packet_reader_peek(&reader) != PACKET_READ_EOF) {
+			reader.options &= ~PACKET_READ_GENTLE_ON_EOF;
 			get_common_commits(&data, &reader);
 			create_pack_file(&data, NULL);
 		}
-- 
2.29.1.1.ge14d223

