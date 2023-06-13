Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84E6EB64D7
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 17:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjFMRkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 13:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240139AbjFMRkO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 13:40:14 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC9C92
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 10:40:13 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56cea71b98fso53977917b3.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 10:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686678012; x=1689270012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S5Ld424b2SW5L73WULsBu6R0b4Rdh3QrXIgHBgMO1f4=;
        b=aukZc02cWg3fpSfzoLUExTQWqmI8ng1qYR/Et5JoiyONpan99pTqHMHyD32D4jzAjg
         BHo5IkcZlegjMJVLRFLxbWISO0it1UWU/p4ulT0+601A3dIaPugU6e9KL1/WFTaqU4JQ
         c2YCAkkqgF+YH69OS6TfRrERQeHTajTzDk/PMST+LGL8pHn+NuCqgvQaHeZKfJIhPH18
         TZr2fMlOZ2/5ttvQOtme/O58YK19ZkUNPhCALh9T2GVW0lEFO2eeWkGcqnMLcHnbZEzp
         lsDhemUQ0YqOYdtweahe7ePWaekFcNHzB++Ierx4zHtJQpHoue2aTlzfN86AYloIF5Y5
         gqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686678012; x=1689270012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5Ld424b2SW5L73WULsBu6R0b4Rdh3QrXIgHBgMO1f4=;
        b=HF7kFvbkzPzAjD4O61sD2+aiAuvDKUlwp3V/rEwwp7LkbCu1NQYulI2inN07rGnGvb
         /UNTqnoTG35KWC2qckJRzvREVf/rChsQhMtQQPW5n2cfOTAv1fa5s137kNBO0HYEStc4
         jzkBfOu9+QyI7WXT5G0Oo2kkD7E8bmd/lGziCepOyqQqEZFUITuF9X+jN2v42lPpJSd8
         V53WLE4SfO/beWSno9Ffz9Z5XEwInZo0pjtNwkm5rmvka31Sw3ggV6YOKz1qhBPW5jLO
         3NN+pnNNxOfCQsI06zn93TlAHSxZqO51NUmvpw1RZPqYkoOSeTmlaxwKkwYW9DOVlzcz
         w1+g==
X-Gm-Message-State: AC+VfDypR/UWkGHswD+pdNDLZMAk4DgqXRIwNFXHlzbv2+qtmvn+/Hfo
        m3rKZoL66j5dQ+NKLdeUFsOS4m5wCODHoc9g0glQFJcZoHbj3yQW/8kLefOwcnDJmPU5/BQ2jHP
        ojD/v34iK6j+TkAk7LAneQ0PCfELN95LI17dvSVDq7QNDAWVTquxjWrz3fOMnW75CZZcPjI7nL0
        ZB
X-Google-Smtp-Source: ACHHUZ6I9b8/f9ro2AuHoFrWVMuRYe7t9/TMNngVPvlaDI46dn7XpfnX2uRjZAL4wylOYtJD9eLO4idPxwWYKJGMDJ3x
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:5e39:4d58:c992:1db0])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:1447:b0:ba7:8099:c5f2 with
 SMTP id a7-20020a056902144700b00ba78099c5f2mr479643ybv.8.1686678012250; Tue,
 13 Jun 2023 10:40:12 -0700 (PDT)
Date:   Tue, 13 Jun 2023 10:39:56 -0700
In-Reply-To: <cover.1686677910.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1686677910.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <f095e2b486489290bb6da2fc23e9caa7da4af40d.1686677910.git.jonathantanmy@google.com>
Subject: [PATCH v4 2/4] t4216: test changed path filters with high bit paths
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
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
 t/t4216-log-bloom.sh | 46 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index fa9d32facf..baa0c48897 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -404,4 +404,50 @@ test_expect_success 'Bloom generation backfills empty commits' '
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
+		printf "52a9" >expect &&
+		get_first_changed_path_filter >actual)
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
2.41.0.162.gfafddb0af9-goog

