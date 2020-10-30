Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16930C4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9777F21582
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mutual.io header.i=@mutual.io header.b="sXCmBpMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgJ3Dok (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgJ3Dok (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:44:40 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED82CC0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:44:39 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 13so4112119pfy.4
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mutual.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V8jHo+OR8tOmwxcwpK0gLSPHe5bj17C8vOuBTjQVBII=;
        b=sXCmBpMuzsZiwoplYXvDiKW/FJZ1+owuyjWAEKUvA1sQAJ//HVLmLK4xV4wGh/afTE
         AgPeBfqv2aE53fRJzZycz7L2jLMbXC70+bLRQEYqty/LoJ0RXBFk0jm+Mqa3yl7wRItz
         TSbrc5Qg0ZX5igg8IRdn0y+E3eap3MpS2fUdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V8jHo+OR8tOmwxcwpK0gLSPHe5bj17C8vOuBTjQVBII=;
        b=LLXE/wtboaWCXfQheW+IdEbg5f8erQSvovEjOBi1hZlvNaHuJNWkEbWADvz0MU9Im8
         FGCOGoTj/vdERcbF+ZlA9kUiLvcLQDf9S8XJBdChlRKTBuZTzildQfdA7Okl5NvH7jPI
         GEQHW+QmsG88nsLCV2qd3cYAm+wA5iaBxodc+BQN4l3pJwGcbAEGCF6fgXWJbKNDqwkf
         ea31AH7bTXm+zpQmJq9PTG84fI1/YN76wfB4uBAvntGXVvavfcnY1MFj1v2zj7DVRBcc
         mJ5IuF+sqaXBNlQHyiHC7P9lUudWosocvX/JmUJjDjxMmmilzTQhvaJUuIlc3C32V7X9
         233A==
X-Gm-Message-State: AOAM533wd8Lkpi4mrQ5TNH0LZXK4y4F1seOfFO1Wt+031p6W7oFn3KTF
        3k4qFL/niyoyOwK2SI2FDvsHZ7nDsjZQEEAF
X-Google-Smtp-Source: ABdhPJzzFRq7//d5PN86m9OSQx0CBIN5N2oCGAGvi5TCGy3HvQ0R0s+wxW2ZFQXl97cCTvIgS6ttlg==
X-Received: by 2002:a62:6dc2:0:b029:152:637c:4cf5 with SMTP id i185-20020a626dc20000b0290152637c4cf5mr7430363pfc.15.1604029479277;
        Thu, 29 Oct 2020 20:44:39 -0700 (PDT)
Received: from shawarma.mutual.io (23-115-137-209.lightspeed.sntcca.sbcglobal.net. [23.115.137.209])
        by smtp.gmail.com with ESMTPSA id a8sm3877671pgt.1.2020.10.29.20.44.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 20:44:38 -0700 (PDT)
Received: by shawarma.mutual.io (Postfix, from userid 502)
        id 178DE20A472C; Thu, 29 Oct 2020 20:44:37 -0700 (PDT)
From:   Daniel Duvall <dan@mutual.io>
To:     git@vger.kernel.org
Cc:     Daniel Duvall <dan@mutual.io>
Subject: [PATCH] upload-pack: allow stateless client EOF just prior to haves
Date:   Thu, 29 Oct 2020 20:43:22 -0700
Message-Id: <1604029402-19593-1-git-send-email-dan@mutual.io>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1604022059-18527-1-git-send-email-dan@mutual.io>
References: <1604022059-18527-1-git-send-email-dan@mutual.io>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During stateless packfile negotiation, it is normal behavior for
stateless RPC clients (e.g. git-remote-curl) to send multiple
upload-pack requests with the first containing only the
wants/shallows/deepens/filters followed by a flush.

When run in stateless mode, continuing on without first checking that
the client request has reached EOF can result in a bad file descriptor
during get_common_commits.

Instead, upload-pack should gently peek for an EOF between the sending
of shallow/unshallow lines (followed by flush) and the reading of client
haves. If the client has hung up at this point, exit normally.

Signed-off-by: Daniel Duvall <dan@mutual.io>
---
 t/t9904-upload-pack-stateless-timely-eof.sh | 22 ++++++++++++++++++++++
 upload-pack.c                               | 13 ++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100755 t/t9904-upload-pack-stateless-timely-eof.sh

diff --git a/t/t9904-upload-pack-stateless-timely-eof.sh b/t/t9904-upload-pack-stateless-timely-eof.sh
new file mode 100755
index 0000000..9a116c6
--- /dev/null
+++ b/t/t9904-upload-pack-stateless-timely-eof.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+test_description='stateless upload-pack gently handles EOF just after want/shallow/depth/flush'
+
+. ./test-lib.sh
+
+test_expect_success 'upload-pack outputs flush and exits ok' '
+	test_commit initial &&
+	head=$(git rev-parse HEAD) &&
+	hexsz=$(test_oid hexsz) &&
+
+	printf "%04xwant %s\n%04xshallow %s\n000ddeepen 1\n0000" \
+		$(($hexsz + 10)) $head $(($hexsz + 13)) $head >request &&
+
+	git upload-pack --stateless-rpc "$(pwd)" <request >actual &&
+
+	printf "0000" >expect &&
+
+	test_cmp expect actual
+'
+
+test_done
diff --git a/upload-pack.c b/upload-pack.c
index 3b858eb..2b128e4 100644
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
+			reader.options ^= PACKET_READ_GENTLE_ON_EOF;
 			get_common_commits(&data, &reader);
 			create_pack_file(&data, NULL);
 		}
-- 
2.6.1

