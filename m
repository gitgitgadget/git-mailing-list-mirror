Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B1EC54FD0
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 00:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A6492076C
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 00:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X5PHci2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgDYA4O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 20:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgDYA4N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 20:56:13 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44716C09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 17:56:12 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id x6so9577711pjg.5
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 17:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EjUdYcjtPXrbSKt5waieqhcSK5nuDWJvtaDB7KMGWF0=;
        b=X5PHci2sM+GAWOPjDjilH1JlopnaPmmzii7FOEYOr+uh0aW8B8zqgiR25O1I55xZ3F
         Bm7RlcfsCMJ1qFhhlLDWMOrGIJNofZHtyEjEk3hbDWUfI59Z2dH0tERzmLVCI6L26nxJ
         X5B3Ma6fpsmIxNc9Qe7O1WxleWR7+74I8zGn7uUmSLY8fYtI3y4KGIrz59vMSk6xCcv0
         dAQvzRpS8xw3AsVzzMOn40RGVVBlwthhj+MlVs5Dfcrg/BKAfo6KVZrXGmfxMlZIoTXR
         u3bpdsM4H4xq/EGaSlX+fNX+RqYPp/VM1euQrtoMa29Oyt2xQgtYGk04jjCOfUVRVZg1
         /pLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EjUdYcjtPXrbSKt5waieqhcSK5nuDWJvtaDB7KMGWF0=;
        b=jmGft0IqInDB7HYtKVsdAClk/TEwmuyQRFIJF3IShtPTk7ke8kyXrP5YAV8WdjHG4o
         F0Gz5jyfq+WO+BUhUgxHp1CD8IF5hRDYhIgBf4dJGsL6BJx2wvhdLq6WseJ7ddKc3L29
         OE8hK8AV4j54N0NJZblVFFql8V7HRLNjNbbiz7FVaw/5jZUrWi3x1r1F2LG14J4EskTO
         wOFBYJtwrcokq6hTUeikVtrY+/Ly+arCAgDQrtpJFuBPkERczD65aJlMCZg2OxYLqdLC
         UFvULGPGjFz17CQKVGlxIEN9Dq/wj8Wm7grGaJQk+K6+InI6LjTOk6fhTEoAkqnDamUC
         ij5w==
X-Gm-Message-State: AGi0PuZ8XECl8nwPA1vtn6AfwmbS0uiKyhOhhdpxNLLiovewLrD9MDB1
        2gJ4JKfhhvPvXClKM4Y95KoSG8VGMGeyfgQWdze9naC27iI/H8U8nIN+9L5ikfFNR6sr+nNk5Dw
        eAvwTSpRYjQ6xnr1/cEtwEHJZp2r0+dImtdwBNn3Vq0SknQPXjhXpp8leVLFlb4YD4nXCosqdtU
        YK
X-Google-Smtp-Source: APiQypLFM5gmZ305+cRJqSs3MJfOfD4QOR5i2mMVsdXXk8WT56exxPBXNRNws+Np5rBmULQhEk5gaBqQHzoZPknj1El5
X-Received: by 2002:a17:90a:65c8:: with SMTP id i8mr9338742pjs.156.1587776171556;
 Fri, 24 Apr 2020 17:56:11 -0700 (PDT)
Date:   Fri, 24 Apr 2020 17:56:02 -0700
In-Reply-To: <cover.1587775989.git.jonathantanmy@google.com>
Message-Id: <8499d5268e49b6b823b0b9312d77e41e311d9a75.1587775989.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1587775989.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 2/2] fetch-pack: in protocol v2, reset in_vain upon ACK
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        jrnieder@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the function process_acks() in fetch-pack.c, the variable
received_ack is meant to track that an ACK was received, but it was
never set. This results in negotiation terminating prematurely through
the in_vain counter, when the counter should have been reset upon every
ACK.

Therefore, reset the in_vain counter upon every ACK.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c          |  1 +
 t/t5500-fetch-pack.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index 7d15c7af81..8551c07ed9 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1287,6 +1287,7 @@ static int process_acks(struct fetch_negotiator *negotiator,
 
 		if (skip_prefix(reader->line, "ACK ", &arg)) {
 			struct object_id oid;
+			received_ack = 1;
 			if (!get_oid_hex(arg, &oid)) {
 				struct commit *commit;
 				oidset_insert(common, &oid);
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index fcc5cc8ab0..98e1442cbf 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -404,6 +404,36 @@ test_expect_success 'in_vain not triggered before first ACK' '
 	test_i18ngrep "Total 3 " trace
 '
 
+test_expect_success 'in_vain resetted upon ACK' '
+	rm -rf myserver myclient trace &&
+	git init myserver &&
+
+	# Linked list of commits on master. The first is common; the rest are
+	# not.
+	test_commit -C myserver first_master_commit &&
+	git clone "file://$(pwd)/myserver" myclient &&
+	test_commit_bulk -C myclient 255 &&
+
+	# Another linked list of commits on anotherbranch with no connection to
+	# master. The first is common; the rest are not.
+	git -C myserver checkout --orphan anotherbranch &&
+	test_commit -C myserver first_anotherbranch_commit &&
+	git -C myclient fetch origin anotherbranch:refs/heads/anotherbranch &&
+	git -C myclient checkout anotherbranch &&
+	test_commit_bulk -C myclient 255 &&
+
+	# The new commit that the client wants to fetch.
+	git -C myserver checkout master &&
+	test_commit -C myserver to_fetch &&
+
+	# The client will send (as "have"s) all 256 commits in anotherbranch
+	# first. The 256th commit is common between the client and the server,
+	# and should reset in_vain. This allows negotiation to continue until
+	# the client reports that first_anotherbranch_commit is common.
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C myclient fetch --progress origin master &&
+	test_i18ngrep "Total 3 " trace
+'
+
 test_expect_success 'fetch in shallow repo unreachable shallow objects' '
 	(
 		git clone --bare --branch B --single-branch "file://$(pwd)/." no-reflog &&
-- 
2.26.2.303.gf8c07b1a785-goog

