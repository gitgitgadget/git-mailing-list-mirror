Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FE9C433E9
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F1964F41
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhCQSV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhCQSVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:21:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7230EC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:25 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v11so2832123wro.7
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TTEfu+yAtM4EH9C+MXnOphrNzv2WHfSFRJGRl2nPKgQ=;
        b=Yzf/sANpeOkx6Eb+sJZ7jpyZOOX8UINWUZ/G21RJ34K0BJsidg8ZXhapnAIN5Eyg2K
         vjj0hnLDRijyWJ03FCUogykQdH/ah1bcZNR+J8ub1D+hyceChnpc7cKX2Njbs2eyLN2b
         3sGUljqxHDAFrpSfkYiUGiTSm7QrRD833bAKV1x3Jf1zjHD19WO1dZ4IuJGvi6WIsREB
         mVGDVNAFXhrCAtZiN5W8VXvRjhnYp37m8MbnZuqJV4+I14mgNZSUYiffoX4wdz6vboLQ
         U0XhDWEM+pY6lFZ/onjPWW5yIq2Dv645cCUUrK25zekMVyZiOcfk1zOOSlA55P+bB+Ag
         6c6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TTEfu+yAtM4EH9C+MXnOphrNzv2WHfSFRJGRl2nPKgQ=;
        b=jIwbAqdpEDyyX0XS+/1cVyRrZV4TU4pg1Z6gDjDoXx/ctqIaORQhs7//2gevHSkvcw
         E1ioHD5M8fvhTJybw6G2kA+9xUhZxvkJagLtlmyBPVglXLjK7U8OrgyjohRkOhW9mDjk
         b/3XiPyXBC9C7LReoTuwoBwnwoeAnUmhjQuxvOFLQfBJATh2JExD0lzt/EUJq4tHBQwB
         fp3R1PZcpyL7HE9Ktkg+nVfFCftwTGVRPuXt9oRyIc8unrLBrM2zcQg3mgLSWyOMhae5
         aSrfagZE82scEtfVp1YQ+g708PGeV36mB/jyXzvrV3jC54rtCA0WfZm7bSSlYKxVrtmk
         PThQ==
X-Gm-Message-State: AOAM5305af3n11lb5Si7YpC8aw1WDiZhsWS0Gb1BvhwgojZf7PrLZvKI
        8AWZfmXyS+NzPzjgWLDhEDTqWxHm7RO9QA==
X-Google-Smtp-Source: ABdhPJxiovDT2QMUXjRs+rj6o5mhKK3MbF9yo2pK41w5H2lgQfahVdIYW5TRyvpcI8a/3DA2+vUf/Q==
X-Received: by 2002:adf:dd48:: with SMTP id u8mr5661903wrm.139.1616005284010;
        Wed, 17 Mar 2021 11:21:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x23sm3177205wmi.33.2021.03.17.11.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:21:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 17/19] fetch-pack: don't needlessly copy fsck_options
Date:   Wed, 17 Mar 2021 19:20:52 +0100
Message-Id: <20210317182054.5986-18-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210316161738.30254-1-avarab@gmail.com>
References: <20210316161738.30254-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the behavior of the .gitmodules validation added in
5476e1efde (fetch-pack: print and use dangling .gitmodules,
2021-02-22) so we're using one "fsck_options".

I found that code confusing to read. One might think that not setting
up the error_func earlier means that we're relying on the "error_func"
not being set in some code in between the two hunks being modified
here.

But we're not, all we're doing in the rest of "cmd_index_pack()" is
further setup by calling fsck_set_msg_types(), and assigning to
do_fsck_object.

So there was no reason in 5476e1efde to make a shallow copy of the
fsck_options struct before setting error_func. Let's just do this
setup at the top of the function, along with the "walk" assignment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/index-pack.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2b2266a4b7..5ad80b85b4 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1761,6 +1761,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 
 	read_replace_refs = 0;
 	fsck_options.walk = mark_link;
+	fsck_options.error_func = print_dangling_gitmodules;
 
 	reset_pack_idx_option(&opts);
 	git_config(git_index_pack_config, &opts);
@@ -1951,13 +1952,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	else
 		close(input_fd);
 
-	if (do_fsck_object) {
-		struct fsck_options fo = fsck_options;
-
-		fo.error_func = print_dangling_gitmodules;
-		if (fsck_finish(&fo))
-			die(_("fsck error in pack objects"));
-	}
+	if (do_fsck_object && fsck_finish(&fsck_options))
+		die(_("fsck error in pack objects"));
 
 	free(objects);
 	strbuf_release(&index_name_buf);
-- 
2.31.0.260.g719c683c1d

