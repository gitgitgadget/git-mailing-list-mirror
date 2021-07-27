Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE2AC4320E
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E84EE60F9C
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbhG0VVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbhG0VVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:25 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7ADC061796
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:20:09 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n19so496435ioz.0
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZPrEzB0xIK/wOTqk4WBQW79bWc96glFVTSqPVLHOsMY=;
        b=BigBgSo4Pr6EGl/JPADB6M37LvFEB6gqufHHRiKvDZQuS50Gj7pxrAJxBL3itbM068
         dW2MsgbBKxI5bB5M2FveJgKc3OxzNcwoEEYybg97SC05IswEPJkWRgXBW1oa+ClbHDWi
         UbPqPRy9IYGEjSJW6U6ShgufEoXv2jr33zFMbVD2ghxvUNJa/LxK7canv/+ogyJGiM/u
         VDkt1PwzcJoGZt/grjldpnGfxspciRyaK1Ikva+KRPcPlNf5IYP5rH8+7fLKUW2UQdbh
         YmPnF+mytFtJTKFbb3CTWcChaf/ZLe1/tkOcmBbujCxg2R3nFuj66DbR4WA1To/kj2WV
         reqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZPrEzB0xIK/wOTqk4WBQW79bWc96glFVTSqPVLHOsMY=;
        b=XIT0f+Ww0bFuoIo3HmasFQZeuvNt0AZ8ri4POvBwqUlKqsLpfTtNcX+fPoJ2+x+xX3
         K6mPt4qDPozij+TapQKjqvz81rfHeEasyVfBcrXBGGVIrgmCn9l+XfkR4HTzjrhLWueD
         kN2eWrK6GTXEKF84D5lfHRjdusyezhrhYxQKq9Rsqr6Lip5RXE/hgehT7OAZcBA9DN1Q
         H7lQeaeEjFxy6n9+v2GO7agIR+a/GNRYYwoSggdhY0gyVZ/+PmuwWXPvVMMWq0K6/r5d
         955wQI7JuPIAe3k21BVqy1HJ2+nCp9biYmXD1srxSBm6Jgh2U5thq+sHnmxCOpfkgWD1
         htQA==
X-Gm-Message-State: AOAM533ofJNXwsOJmHF7reP/lF4Q9rQMD60DEFxBOICvaecZ9a/6yAPL
        /LjWV35pYwM4GSdQzU7KBTcLXulwqiR81WaG
X-Google-Smtp-Source: ABdhPJwu/TVdoAf/tW8c8mR+l+p4w8TT5oR9OkuXa0gAhoG3Omitx2v7ZFuMOdVmvWclzKgR9709sA==
X-Received: by 2002:a5d:9ccb:: with SMTP id w11mr20627575iow.174.1627420808611;
        Tue, 27 Jul 2021 14:20:08 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id d9sm243609ilu.9.2021.07.27.14.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:20:08 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:20:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v3 17/25] t/helper/test-read-midx.c: add --checksum mode
Message-ID: <60ec8b3466e7f94610a45bdd1c79feb06e439429.1627420428.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1627420428.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subsequent tests will want to check for the existence of a multi-pack
bitmap which matches the multi-pack-index stored in the pack directory.

The multi-pack bitmap includes the hex checksum of the MIDX it
corresponds to in its filename (for example,
'$packdir/multi-pack-index-<checksum>.bitmap'). As a result, some tests
want a way to learn what '<checksum>' is.

This helper addresses that need by printing the checksum of the
repository's multi-pack-index.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-midx.c | 16 +++++++++++++++-
 t/lib-bitmap.sh           |  4 ++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 7c2eb11a8e..cb0d27049a 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -60,12 +60,26 @@ static int read_midx_file(const char *object_dir, int show_objects)
 	return 0;
 }
 
+static int read_midx_checksum(const char *object_dir)
+{
+	struct multi_pack_index *m;
+
+	setup_git_directory();
+	m = load_multi_pack_index(object_dir, 1);
+	if (!m)
+		return 1;
+	printf("%s\n", hash_to_hex(get_midx_checksum(m)));
+	return 0;
+}
+
 int cmd__read_midx(int argc, const char **argv)
 {
 	if (!(argc == 2 || argc == 3))
-		usage("read-midx [--show-objects] <object-dir>");
+		usage("read-midx [--show-objects|--checksum] <object-dir>");
 
 	if (!strcmp(argv[1], "--show-objects"))
 		return read_midx_file(argv[2], 1);
+	else if (!strcmp(argv[1], "--checksum"))
+		return read_midx_checksum(argv[2]);
 	return read_midx_file(argv[1], 0);
 }
diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
index ecb5d0e05d..09cd036f4d 100644
--- a/t/lib-bitmap.sh
+++ b/t/lib-bitmap.sh
@@ -260,3 +260,7 @@ have_delta () {
 	echo $1 | git cat-file --batch-check="%(deltabase)" >actual &&
 	test_cmp expect actual
 }
+
+midx_checksum () {
+	test-tool read-midx --checksum "${1:-.git/objects}"
+}
-- 
2.31.1.163.ga65ce7f831

