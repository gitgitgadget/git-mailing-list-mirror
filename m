Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF35BC7EE29
	for <git@archiver.kernel.org>; Thu,  8 Jun 2023 19:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbjFHTWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jun 2023 15:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbjFHTWL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2023 15:22:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6822F2D4B
        for <git@vger.kernel.org>; Thu,  8 Jun 2023 12:21:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bb39aebdd87so2165219276.0
        for <git@vger.kernel.org>; Thu, 08 Jun 2023 12:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686252093; x=1688844093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WAU4mFyarVRSXProlLj3eG6Lsz8OWHDMir+yNiKc+vI=;
        b=FNpjYNAquXvIzHlmgqIa9VHZdO8nPCaWixfM2Zf8qqDflkKWROqsj0Y11MNPr5UNgX
         6+B7orrjSihmZH2CsKXUSRNK4iJRNoEtjC9ImFICaltN3AsB8JmGjv+TeR6obO0G822G
         n6z/67pVxAt4iEqsZfQVIMFv/Z0raMm1+LRsdx1jmbp13VllGrDqSSvR/cylRceSib4H
         6KQqomDn575ew7fKReVGSMSmA7fjsJQQVwuKivFSKz8Jg2LGbhQKSeMZnXS3gYgA/+oS
         aUQgoJPhUnwMma2F/gnDvp0XbTlSAhJD/j/L7JSZA3XYZbMZUHL5eTKq3oHrDx3kuN73
         UcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686252093; x=1688844093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WAU4mFyarVRSXProlLj3eG6Lsz8OWHDMir+yNiKc+vI=;
        b=LMatNE91gdtVJmCIpXNzxsXlaxZe9moOtx+Q56tb6EteQPy9zhO2/Jc+micAB6SRIQ
         YvOgI0fbv67nCSPNjuZ+qH73y2Xde4TpltJgDNgjXB+7GU9STFPsk62jnek4Uf/aJcOs
         XQ9zHzQjAyl9iJzRJIkedGR6wRkuCK161ji2H2r7mQ00qQjbDmPF8JsH+yyN2hKEwV9H
         bgrnsDO2RGUII9yItbdom66YvpB+nmZPyjaR4rcaj/qHPEkAFc3H8JzjzqsIt1mX/bi0
         tAqFH60DF9KiU3GhWLjZejipEOjFi9EKe8mzMgCmJI5wFEIXHpZsqKf4zbUJvwa1nmn1
         fSWA==
X-Gm-Message-State: AC+VfDwy3tQkp+Ymor+QXJdkbN4vcS0mecw79Ztl5XhiWXu9/kVWYaWH
        H0AIYAyVbpjrkS1A5craltlhfmW2OVN64/zJEbeAJFHwLktV41FAUkrdYwwqLwZdjUCaZaWWxxA
        1m4kKbxszVwYsaYAj5TbhPTLggMyCOLWKh+tCeEpMBZFZWY4WyMt0xECLWtP29I1KexU+JgALcx
        6i
X-Google-Smtp-Source: ACHHUZ7CxrklWAn8dmrokGbY3fG8fEmSBxk8Z6D7asAKLcSooeFefO++In58l5BlYZnS/7TGWsfZ28U6wbgPFezCE+RX
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:bde7:a867:45f9:3528])
 (user=jonathantanmy job=sendgmr) by 2002:a25:8c07:0:b0:bad:2b06:da3 with SMTP
 id k7-20020a258c07000000b00bad2b060da3mr297125ybl.3.1686252093336; Thu, 08
 Jun 2023 12:21:33 -0700 (PDT)
Date:   Thu,  8 Jun 2023 12:21:23 -0700
In-Reply-To: <cover.1686251688.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1686251688.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <aa4535776e08004e86e2a3061e4a45c466d89024.1686251688.git.jonathantanmy@google.com>
Subject: [PATCH v3 2/4] t4216: test changed path filters with high bit paths
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subsequent commits will teach Git another version of changed path
filter that has different behavior with paths that contain at least
one character with its high bit set, so test the existing behavior as
a baseline.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4216-log-bloom.sh | 55 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index fa9d32facf..f68df24bd5 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -404,4 +404,59 @@ test_expect_success 'Bloom generation backfills empty commits' '
 	)
 '
 
+get_bdat_offset () {
+	perl -0777 -ne \
+		'print unpack("N", "$1") if /BDAT\0\0\0\0(....)/ or exit 1' \
+		.git/objects/info/commit-graph
+}
+
+get_first_changed_path_filter () {
+	BDAT_OFFSET=$(get_bdat_offset) &&
+	perl -0777 -ne \
+		'print unpack("H*", substr($_, '$BDAT_OFFSET' + 12, 2))' \
+		.git/objects/info/commit-graph
+}
+
+# chosen to be the same under all Unicode normalization forms
+CENT=$(printf "\xc2\xa2")
+
+# Some systems (in particular, Linux on the CI running on GitHub at the time of
+# writing) store into CENT a literal backslash, then "x", and so on (instead of
+# the high-bit characters needed). In these systems, do not run the following
+# tests.
+if test "$(printf $CENT | perl -0777 -ne 'no utf8; print ord($_)')" = "194"
+then
+	test_set_prereq HIGH_BIT
+fi
+
+test_expect_success HIGH_BIT 'set up repo with high bit path, version 1 changed-path' '
+	git init highbit1 &&
+	test_commit -C highbit1 c1 "$CENT" &&
+	git -C highbit1 commit-graph write --reachable --changed-paths
+'
+
+test_expect_success HIGH_BIT 'setup check value of version 1 changed-path' '
+	(cd highbit1 &&
+		printf "52a9" >expect &&
+		get_first_changed_path_filter >actual)
+'
+
+# expect will not match actual if int is unsigned by default. Write the test
+# in this way, so that a user running this test script can still see if the two
+# files match. (It will appear as an ordinary success if they match, and a skip
+# if not.)
+if test_cmp highbit1/expect highbit1/actual
+then
+	test_set_prereq SIGNED_INT_BY_DEFAULT
+fi
+test_expect_success SIGNED_INT_BY_DEFAULT 'check value of version 1 changed-path' '
+	# Only the prereq matters for this test.
+	true
+'
+
+test_expect_success HIGH_BIT 'version 1 changed-path used when version 1 requested' '
+	(cd highbit1 &&
+		test_bloom_filters_used "-- $CENT")
+'
+
 test_done
-- 
2.41.0.162.gfafddb0af9-goog

