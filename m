Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07449C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAB8461378
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhFNRag (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 13:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbhFNRae (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 13:30:34 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B104FC0617AF
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:28:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id g20so18030618ejt.0
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QsegIPZps3bq7b0WAw6MJBW6+mv70QvWVGxtZdFSnvY=;
        b=k7bK0oy4QfCgps2wob5WWislY27dm3gTIHyql0uLpBBOEMfAZfVPEFbEVeg2j8OAbc
         GV1p0r+7xz3ap1yYuIOK9U9BD6fp42oZBZmcoKW0yWebAL5QNfGtl1zQeEQ/DBKI9Bv0
         rsQE8lyD3nwRnZcYHYIo5G9ixtE+/Uyxkiaqwo3qPZuOjEOx7Q6bXkq8AtBtTRQt1E9Z
         fKBhR1yhwM07hKUeJUCPdPM5MQNi96MQEyoVk0JM8clr+dOwGri4aQ6egkLUFOWL0SRs
         J+aEPXQTWFTBfj6Ssit5exTQAR/VKBfacoFsjrCQoKtnFdMDq7DqloWo6UsEwPP+a++o
         rkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QsegIPZps3bq7b0WAw6MJBW6+mv70QvWVGxtZdFSnvY=;
        b=qpdtnTvAJOt3QfynJFO0gHxDJPV06p90FtvBwUCDbQDRW7OqqCUN8MbYRlAgBF/ypx
         iMdxl9vtjipTrMoXt9vJsck3UwpHZtvY1CMxyPfi7XVGiTrnTWWkUyppipBfHAwFC4QF
         +sMTrQrJ4pbOJKISyAcVsspFy62Srx1z7ZXUi1vGNTAYwuxa8bGl0CLzQzUFJJ6zehPD
         lRcLBlKoapWAvZRrTcRMp5+0ywzQ8a33yh5JdlASOOISe/u0mZYC9HbpIEAhXtdGKy3r
         e7qxqwev/5F7+fHpxv4YUn1YbP4Z2RfvKewKAo2Q74ZxVzQJknGJM2dC9obQ/X4taDep
         mcLQ==
X-Gm-Message-State: AOAM530y7qChKl7tZdMB2yPnENhvrpOp1VdemxL3eGdZaZ4YeWJn79Vv
        aJ9TilrjJe12pfpgdMpMwJeVqcsAcnOPFw==
X-Google-Smtp-Source: ABdhPJwyEV4EjBEnVXYEad9Xkf6XKthfVragzVSERFzpWaPpsymeGzhevfYGvXzYzArJEcj5CCPnAg==
X-Received: by 2002:a17:906:7c4d:: with SMTP id g13mr16455910ejp.216.1623691709099;
        Mon, 14 Jun 2021 10:28:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a24sm9376233edt.96.2021.06.14.10.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:28:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/6] mktag tests: test update-ref and reachable fsck
Date:   Mon, 14 Jun 2021 19:28:21 +0200
Message-Id: <patch-4.6-0359becdc92-20210614T172422Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.555.g0268d380f7b
In-Reply-To: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the mktag tests to pass the created bad tag through update-ref
and fsck.

The reason for passing it through update-ref is to guard against it
having a segfault as for-each-ref did before c6854508808 (ref-filter:
fix NULL check for parse object failure, 2021-04-01).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 43b67a149f8..f5a51d11f81 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -44,6 +44,8 @@ check_verify_failure () {
 	'
 
 	test_expect_success "setup: $subject" '
+		tag_ref=refs/tags/bad_tag &&
+
 		# Reset any leftover state from the last $subject
 		rm -rf bad-tag &&
 
@@ -59,6 +61,20 @@ check_verify_failure () {
 			test_must_fail git -C bad-tag fsck >out 2>err
 		fi
 	'
+
+	test_expect_success "update-ref & fsck reachable: $subject" '
+		# The update-ref of the bad content will fail, do it
+		# anyway to see if it segfaults
+		test_might_fail git -C bad-tag update-ref "$tag_ref" "$bad_tag" &&
+
+		# Manually create the broken, we cannot do it with
+		# update-ref
+		echo "$bad_tag" >"bad-tag/$tag_ref" &&
+
+		# Unlike fsck-ing unreachable content above, this
+		# will always fail.
+		test_must_fail git -C bad-tag fsck
+	'
 }
 
 test_expect_mktag_success() {
-- 
2.32.0.555.g0268d380f7b

