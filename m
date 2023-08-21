Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E81EE49A6
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjHUVoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjHUVoP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:44:15 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D957194
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:12 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5920efd91c7so18981317b3.2
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692654251; x=1693259051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1nEgjLbW1muImALuZZyXVL7jJVqMiM2vmZmrliyQ7cU=;
        b=jGghZr6HmSlWf7af34F3Sa2yPXEvmZns55pWZXCAGOh8jfUcEeCCCAB8eU5YS+nDAO
         uX3tuw3rasCKle38dJqw6gHKwYrBI+5KlTPL+8R/eUuTlIlh4bf/+zTOWLzERV2dS6Ns
         S1DHcH9sNMqf+Ehyx8dOCI4vgUiofPXGSyrV8BbIcaOvLslh9o/doBiK5N/j1cO8m0DQ
         KQITiEOXG8TVNoBGvex+JvMp1IbdYAOW7vgKLYKXx3Gb6koVHAZMpVhVMtz1Zu6cKRY/
         IQxJ9O+szoeCzNoXIfkh6ZKmkMt7dnpXSCx55xjosoC0XQXD7sG5EauY9HamS5oEO676
         tKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692654251; x=1693259051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nEgjLbW1muImALuZZyXVL7jJVqMiM2vmZmrliyQ7cU=;
        b=a7ddBBDcIv5YOvVFME+UGcDJu1vhnWCIwdYvHNqLcGRAolJRyMzuPLLr+7xobbbUYZ
         fXFC9ePOE8GqOZ9xvPb5pHr5NklKm13L5CQQsFsVUtfqIxx3o8xXfbS2B+tuvlBjJkqw
         jOaza0AkNCzEshiSKVdze8EvNIzHQD+CMyrX2IJtHY3qr3T6pURQF1jNlSWU9kfXs8RQ
         cWhymioqF1C2Hq66m49Zhn0C6krPz46+l+wisEEpG0lUyB6LNpD3T15EhkvWpEfPxOkV
         igFt0LYplqpR7Cq2S8vDAF9FQsFRvFgnlYGSqOsfsYwoxsbUmfeQfDz5bvUGOk7uN32t
         egIA==
X-Gm-Message-State: AOJu0YzwGsW4VsL++TX+1aL/mR/lpcHmmdH6RG9EMTrqGyUEJfPgEIOQ
        mX7YzSxze/kQC0nmqsseAnlTHvQbHh4Vp5MX7PukTQ==
X-Google-Smtp-Source: AGHT+IGSm4x4WOvpZsjn3HctXd+c5iwWmMP5BqaoT9vyoJBjjV0R1Uag65mv+/Avf24JYRL6lg+AJA==
X-Received: by 2002:a81:9208:0:b0:58c:4e63:109 with SMTP id j8-20020a819208000000b0058c4e630109mr8892293ywg.0.1692654251152;
        Mon, 21 Aug 2023 14:44:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a124-20020a818a82000000b005869ca8da8esm2416848ywg.146.2023.08.21.14.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:44:10 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:44:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 05/15] t4216: test changed path filters with high bit paths
Message-ID: <de585ce7f3c0bac504b59656abf444ecd360fd97.1692654233.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692654233.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Subsequent commits will teach Git another version of changed path
filter that has different behavior with paths that contain at least
one character with its high bit set, so test the existing behavior as
a baseline.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t4216-log-bloom.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index fa9d32facf..2d4a3fefee 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -404,4 +404,47 @@ test_expect_success 'Bloom generation backfills empty commits' '
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
+	(
+		cd highbit1 &&
+		echo "52a9" >expect &&
+		get_first_changed_path_filter >actual &&
+		test_cmp expect actual
+	)
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
+	(
+		cd highbit1 &&
+		test_bloom_filters_used "-- $CENT"
+	)
+'
+
 test_done
-- 
2.42.0.4.g52b49bb434

