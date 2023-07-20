Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE411C0015E
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 21:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjGTVrD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 17:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjGTVqz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 17:46:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987452711
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 14:46:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56cf9a86277so11467357b3.3
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 14:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689889613; x=1690494413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nlYS3iTTbxfDxEyECy6fXD1bm88MIvxlAxLP22TjoGw=;
        b=VOh2qMsgoOEmpPsuge3jJjGQTMXe5vvjy3uVNyC82YVZkXPsXLC2W8HwTtjLOiiPlU
         EPhKVvD3/u2h9rYaK5xJgNalp3u7iiqO61IFUxrQ0duVX165GHFImK69q7l5XCgTrsDc
         nnsw3BU2VkRwE0cJG2JwJi9vFjZDym1Q9PaIDBrX1lhmqcGJExgcYOGFBNsPHU0BqNGY
         Xk42EYxKCJqKRTfEQ4TGuhgRIMwBJ71Va1mB4L+2dUj0SEkjkQiS/zjHO+CFhQvcfEM1
         feekC/oC9PrXTaRZAvRHx3/ZvSOUHHqCbSZdCNXmyRfULQaKiJnSuLhkL/Me8Tret3AK
         qmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689889613; x=1690494413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlYS3iTTbxfDxEyECy6fXD1bm88MIvxlAxLP22TjoGw=;
        b=VmZ5xIxARNn3K/hi5WeyWL5QuFZ48vv5urc6TdXnBnczaUjrbSxjqCwO5kFAsPhm3W
         AoE06r+CZfVCS4zH7JfPMuC0OrdBYxRZgbgUOU7JgTaEq6TPYfCqEsyhlaSkAmV0I/Fu
         BvJEEOPizwV2Qr9m3T/NyRvLVnU4iZTWzGQ5MLzgHDOWxYq+LDXWSMpcebyX5+20MGt/
         u3t6HlQ01fsRv3FTlCvbVJZEmtUpMGyqK2LQhhaCWjhcslA7zjLTzJHPsCJvHLHsy84r
         v3i8+idvSac4tVGdUELmbd76CA4/77+5k0RhFhzF6C0hOIDK48UVbaNngeMEgFXnyoFq
         0N4Q==
X-Gm-Message-State: ABy/qLZrwH8mSgQvAy2Pbh/aCJvVdjua62KXFILAJDtqQBG7xABjikeG
        Mpf2u1szyilShF4OMQ8YQlj/2RDclLdKUp8gNcD1MoX/KVwUB604Tt03I11/1a3ldOsi8d4C9xI
        VT5p/BW2bWWfLF7G6u36swdUTX0OvMzOk9Sp8yEqQDl3LNVQ9wY8SdvJ5P0ONLxZYehi9fZJCQT
        Zw
X-Google-Smtp-Source: APBJJlEk3ut4uWQLKZmoEWz5n7JOAgx156TJeA3h0yn5wf+FV6EMB0sQxS4A296aFe8CQ2UteEBd1sKFXp7GsrZDYRIN
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:387b:f15b:5fda:c8a5])
 (user=jonathantanmy job=sendgmr) by 2002:a81:b202:0:b0:583:4551:858d with
 SMTP id q2-20020a81b202000000b005834551858dmr3019ywh.9.1689889612705; Thu, 20
 Jul 2023 14:46:52 -0700 (PDT)
Date:   Thu, 20 Jul 2023 14:46:38 -0700
In-Reply-To: <cover.1689889382.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1689889382.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <5276e6a90ecb84cbca3b14a27dc055cf81d27ac3.1689889382.git.jonathantanmy@google.com>
Subject: [PATCH v6 5/7] t4216: test changed path filters with high bit paths
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
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
 t/t4216-log-bloom.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index fa9d32facf..c49528b947 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -404,4 +404,43 @@ test_expect_success 'Bloom generation backfills empty commits' '
 	)
 '
 
+get_first_changed_path_filter () {
+	test-tool read-graph bloom-filters >filters.dat &&
+	head -n 1 filters.dat
+}
+
+# chosen to be the same under all Unicode normalization forms
+CENT=$(printf "\302\242")
+
+test_expect_success 'set up repo with high bit path, version 1 changed-path' '
+	git init highbit1 &&
+	test_commit -C highbit1 c1 "$CENT" &&
+	git -C highbit1 commit-graph write --reachable --changed-paths
+'
+
+test_expect_success 'setup check value of version 1 changed-path' '
+	(cd highbit1 &&
+		echo "52a9" >expect &&
+		get_first_changed_path_filter >actual &&
+		test_cmp expect actual)
+'
+
+# expect will not match actual if char is unsigned by default. Write the test
+# in this way, so that a user running this test script can still see if the two
+# files match. (It will appear as an ordinary success if they match, and a skip
+# if not.)
+if test_cmp highbit1/expect highbit1/actual
+then
+	test_set_prereq SIGNED_CHAR_BY_DEFAULT
+fi
+test_expect_success SIGNED_CHAR_BY_DEFAULT 'check value of version 1 changed-path' '
+	# Only the prereq matters for this test.
+	true
+'
+
+test_expect_success 'version 1 changed-path used when version 1 requested' '
+	(cd highbit1 &&
+		test_bloom_filters_used "-- $CENT")
+'
+
 test_done
-- 
2.41.0.487.g6d72f3e995-goog

