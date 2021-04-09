Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326B5C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 080A5610CD
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhDISMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbhDISMO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:12:14 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8C1C061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:11:59 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id z9so5456340ilb.4
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SDGKy41XqkDSXhJ1++SeUTTUQsq4CUovBkrBgBCqmr0=;
        b=V8ya9Ou64l4OZSHYEl30Bn6aiolsGdFAuK4nTTgSpymswy4ObvM0zBTu2DJ3kBsw8K
         Sj0Bu3suchb6KG4zRHnYvrcV8xF78L9QvnUCpCrbBqa9gW1m4quOm655TrbgPb7XIA6c
         9Vo5JMJ3oXTQ+/IESnh4upB0c+W4rMjy6sV7j7vem4KxnO1SNiHedHZk7XgkQmLymPj6
         A1L4RL/IROkz2QHBSxx7jQDuBCtXZZvOHaZSh8BHXWGU7KKUctQuHMTklal38D73W5WV
         b0YjZ5qhhgUFYm9H2wd/itUaWpRExQIFBhR1/bAQET5rriGByIC2JUXSuS44KaAh2V88
         Jm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SDGKy41XqkDSXhJ1++SeUTTUQsq4CUovBkrBgBCqmr0=;
        b=TMUktqYlB3YfPeng5uv2catM0CjU51XASM4uJpZDRdBq0CAKSOL5iWWeJJj7w8++S4
         sKFJCr/d3C68umN716Wfv8UsnQMQtFOLRrbZVAEpp3X23So54wrZ7+u7EXUmgQhf9uTM
         NdQjeuLUeg/aOadj9EUOK3JE/lK2S7cnfSRTYF1TlDVFx5s5qYYd+axkqpAZ+wVq8b9f
         JP2OeoAVN05yABPc50lwRlrsd2e4WFPqISVLaXA1KanUgkclaTfvGw8KPz3j1K23mmZG
         t6fkMfUO/IMY2PKgf/jHqJo1xXuOfTb1U0S0f0b8SdycTwri10vE0oPcWCnnzBZROQcl
         +A6w==
X-Gm-Message-State: AOAM533WeyYqCKq2iPHCexxamf/A/dyF/Bj8hrJEm3izUIN6oX5Y81Ss
        97fF/uf17cQtM60jCQGmueMspz1NhTr2NyRF
X-Google-Smtp-Source: ABdhPJzn/SVAwRfUEwnCHD27a7DirdgzmMJyU5FkTo3yxhhBGxnIMqpnp/iDAvX3wPkIQyF8gULWsQ==
X-Received: by 2002:a05:6e02:4b1:: with SMTP id e17mr13199992ils.94.1617991919056;
        Fri, 09 Apr 2021 11:11:59 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id x20sm1532088ilc.88.2021.04.09.11.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:11:58 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:11:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 15/22] t/helper/test-read-midx.c: add --checksum mode
Message-ID: <060ee427bebdb6f45766c173878a9c056f312baa.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
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
index c655a9bf35..a5ac8b41a7 100644
--- a/t/lib-bitmap.sh
+++ b/t/lib-bitmap.sh
@@ -236,3 +236,7 @@ have_delta () {
 	echo $1 | git cat-file --batch-check="%(deltabase)" >actual &&
 	test_cmp expect actual
 }
+
+midx_checksum () {
+	test-tool read-midx --checksum "${1:-.git/objects}"
+}
-- 
2.31.1.163.ga65ce7f831

