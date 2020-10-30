Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52266C4742C
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 01:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2FC520747
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 01:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mutual.io header.i=@mutual.io header.b="a4dTQanh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgJ3BvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 21:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ3BvA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 21:51:00 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29707C0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 18:41:27 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j18so3916517pfa.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 18:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mutual.io; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uBzOuqw/5ZQBaQciKY7vJIzRT9Kdt3DzX8zHCf4q1u4=;
        b=a4dTQanhvpDgjcGx+xSnVximI3z+xag2eIEi0ahgPI70Fg0QSfplj+rqLfLjF9pXda
         VwbeaMOFRnjK1gRzOPxwMCTjYQR5D2Wo4HF/iK4p/gYRCjpxy+T5iir+QNfYZn0YCypK
         m8BayiLkpITLxPfZK4jefuJZAZC1M4dWMOZZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uBzOuqw/5ZQBaQciKY7vJIzRT9Kdt3DzX8zHCf4q1u4=;
        b=a7vG6YPpfO9NI7+GMDfrKyFpIfyAJuDq8V1EHOzzoqFFJXzdwDaEJjrNKtICQqgCsf
         zjxO7hd8o/eJWkEGM9BPJDXKZlX2e/y963IxLTweS27yHLSt+9iV2hrwtkn39D7Rnf1M
         UQxy8160iL2ysSFckZ01URYcGCiTcoorLPedzFrmbj583yTqucLxVUTKaOMFMW7vLoKV
         cvE5Y7GQY+lZT/rV5kl0yKBCPY9ovn18VMIZWiHLGHKX/e5cP2T8ZLCGRqkGBsWwvk/y
         KrgZg8ximWkdEOXLp2HaGMq5oT53zsch4IrQViO73Kc8DRxt8iPLDbbbNabpq2al/wlq
         rI9Q==
X-Gm-Message-State: AOAM530/Mof4AC4Jy8nddjvTAutjp7IEAT64fhXdZQLW9camJG4QqJ6g
        05oecGy5eA5hjjIRFVxm4u5CXg==
X-Google-Smtp-Source: ABdhPJzyhRPbxRmTAu47vSThbU/YL6R0ZrsWQMT8phXAXCQAu1bOExmtNB5haKM2JTqnfWCXG1aMKw==
X-Received: by 2002:a62:4e0f:0:b029:156:13e0:efa7 with SMTP id c15-20020a624e0f0000b029015613e0efa7mr6878644pfb.73.1604022086684;
        Thu, 29 Oct 2020 18:41:26 -0700 (PDT)
Received: from shawarma.mutual.io (23-115-137-209.lightspeed.sntcca.sbcglobal.net. [23.115.137.209])
        by smtp.gmail.com with ESMTPSA id c12sm1105237pjq.50.2020.10.29.18.41.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 18:41:26 -0700 (PDT)
Received: by shawarma.mutual.io (Postfix, from userid 502)
        id B8B9B20A4345; Thu, 29 Oct 2020 18:41:24 -0700 (PDT)
From:   Daniel Duvall <dan@mutual.io>
To:     git@vger.kernel.org
Cc:     Daniel Duvall <dan@mutual.io>
Subject: [PATCH] upload-pack: allow stateless client EOF just prior to haves
Date:   Thu, 29 Oct 2020 18:40:59 -0700
Message-Id: <1604022059-18527-1-git-send-email-dan@mutual.io>
X-Mailer: git-send-email 2.6.1
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
 t/t9904-upload-pack-stateless-timely-eof.sh | 24 ++++++++++++++++++++++++
 upload-pack.c                               | 13 ++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100755 t/t9904-upload-pack-stateless-timely-eof.sh

diff --git a/t/t9904-upload-pack-stateless-timely-eof.sh b/t/t9904-upload-pack-stateless-timely-eof.sh
new file mode 100755
index 0000000..f8385a7
--- /dev/null
+++ b/t/t9904-upload-pack-stateless-timely-eof.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+test_description='stateless upload-pack gently handles EOF just after want/shallow/depth/flush'
+
+. ./test-lib.sh
+
+D=$(pwd)
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

