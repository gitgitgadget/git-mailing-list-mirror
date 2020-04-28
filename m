Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB11C83001
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 00:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB36C2078C
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 00:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="upCwcmTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgD1ABU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 20:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726307AbgD1ABT (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 20:01:19 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C66C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 17:01:19 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id w9so20659745qvs.22
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 17:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jhi7YYxgd+qjn/dE9OhwjUHW2psV52DHLTswLoRyL1Y=;
        b=upCwcmTgLf3joaCNw5W3Gx2eIK9zy/n+sH8EDZYU2bT3gkaLwJ9F1Ol13li6dZf7ON
         FpKAvYiOzzM1ix5AjkjB0udYysDC0cfCXbOYWR7K9jxbpJadqgrwCpM9UAVMNay4uPNU
         V1Bvs/D0jY6o94EMFYUcCeSvZ7nGjGLzJqqSYI9Vx7JtKkl+sEnh0LZaHLzB0Fa/+nxR
         IaT6TEEBgajGTJIS2axUsMXOXSwpxDBhs8vNMCDnmEfG+S2aoRXUBolI/SLUoX8KSLIh
         eQdlEpyqH8SpIlQJewN3vROT/AGEtruw2nUl1QH/qxUncg/FPBNp+ScZHBIwa/J8loM0
         LL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jhi7YYxgd+qjn/dE9OhwjUHW2psV52DHLTswLoRyL1Y=;
        b=GjxnAptwm2EOwXcQ1cKsIieZoPgfbqOj1vC2hu6h9AiG6R1VBwW0qmXUiiMV6g3bST
         ylXti3zdhWLhgYe0h48OAIYf++yOiwlFuDkCuMOz12n/xZwmKwD/JglCF5/xO8c9jMw3
         e2cBAbIyqmlFcUDePkLBXv0zq57rCqGEFZbqFU2rmpk5a7/2kYkWVdByCeXTbMs0O4zj
         TlO9cy+I968wJVEygQhNVuRhd+P1jKntLeE6wtueWevFzcXzYe61Sw+3b4RiafYTsxDc
         GTDmNFHZOGFbM9myklewCYA3dExOHxGU5BuN3jjrSjEFUV5jo2b8DZ/njm9gV7Ej0uLx
         SF7w==
X-Gm-Message-State: AGi0PuZth4FbJsK0zl5LTxb7/uCetBN/rHTLZWF1Mi1mczDPLEblz00T
        V70CP0RsJyauGXT0q7Zl3MXOugwRXWqx0JkaV368AV+vBdKvcSRnenm0B0wF4DjmLdIH8em1AOy
        wtNm3yYiptxUC8dOQch9DPz1FM0mg0tNy09pSMPJQPkHJHoUxd9useGTBoa3h7Fb9ax4Xay3HXu
        Jw
X-Google-Smtp-Source: APiQypJ0vKfK6hbNBzec7T7GDImazNmm+4Nwm+DhAXYUYOi1PKa4g9gvHRxPildBMfsTqqJYCPDg9tmPt2j3awtwl4zN
X-Received: by 2002:a0c:aa85:: with SMTP id f5mr22436147qvb.51.1588032078580;
 Mon, 27 Apr 2020 17:01:18 -0700 (PDT)
Date:   Mon, 27 Apr 2020 17:01:10 -0700
In-Reply-To: <cover.1588031728.git.jonathantanmy@google.com>
Message-Id: <e89646cb9ab1164d866ba9747575cab9199e3f62.1588031728.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1587775989.git.jonathantanmy@google.com> <cover.1588031728.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v2 3/3] fetch-pack: in protocol v2, reset in_vain upon ACK
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        jrnieder@gmail.com
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
index 76691dc6c0..edbfc2af1c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1307,6 +1307,7 @@ static enum common_found process_acks(struct fetch_negotiator *negotiator,
 
 		if (skip_prefix(reader->line, "ACK ", &arg)) {
 			struct object_id oid;
+			received_ack = 1;
 			if (!get_oid_hex(arg, &oid)) {
 				struct commit *commit;
 				oidset_insert(common, &oid);
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 961cd6beec..52dd1a688c 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -403,6 +403,36 @@ test_expect_success 'in_vain not triggered before first ACK' '
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

