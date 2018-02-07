Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA2941F404
	for <e@80x24.org>; Wed,  7 Feb 2018 23:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbeBGXoG (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 18:44:06 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40839 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbeBGXoF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 18:44:05 -0500
Received: by mail-pl0-f65.google.com with SMTP id g18-v6so1052091plo.7
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 15:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yOUebeGRSd3N3lVkMPIw+gyRm/bqtSmSGmPZNdc2y4s=;
        b=rGaGdOmhpYaLBbF1INcJS8g6S1QsP+GokcLzjmT1XymA+po0YDMIxtZPOODkhLoW/3
         VZ9X0IxJxpH332t2gR8FZkWmLx7cyfnpguT4udB8CxZaLTgfMi7xK7/ZsYvW5/schmXm
         iUjhEDuHiQ2979Fb0jX5iln1coAGuhhUimrXeNg2RuPRihqs9x38wOqn1pSJwFk44Ued
         DsBMQHRw/m8zkcDxTx80YtLcjs/sEO/41vLBfG630nDoD+YM7X9rj4VNiEuCNYmytpri
         WRg+0OnAlMtoLzLgvNXAq9tc0Y0xeNOh0FM14fbEBOSrFQLyXQ9g41iI0oeu8nI42jGO
         HZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yOUebeGRSd3N3lVkMPIw+gyRm/bqtSmSGmPZNdc2y4s=;
        b=Ac+3j4c9/94oQszaaEmJJJro8YF4Shyl4kOY+v3Ty+jXL+OQOH/DrgdKbl0Pgezbxp
         QgRPO+zVBJ2U9mTx5pzoVzmD+vJKt7nRVeEfoQQqYY8PPfClxppadCZjCzHkiglJnsPS
         7bJzJeXEGC3gbjHzXQZTNzp8dsvGZAEfDm2uNDzwhfytps/NV0did/30+zdIPyHWR3EZ
         X1PqDpjsuEpNDBnPT3GvSn3rxt2BN0rwOb32Sk3t+0HKX6lWJK1dfnAu5VyTgOD13afb
         wxv4oTP2Cjqcszy08AFQqRMJwLlXf8ITNsjjTqm8OtTHHT1lhBTV6fTk/eNNLY/Oe6Bh
         sKkQ==
X-Gm-Message-State: APf1xPCpL1NskydmV9wgI6TC050rKSvkvF4PTe1fB2AzmLNfGrN54Vea
        mskwOaw3ygIzBW70YgC9QtqAcg==
X-Google-Smtp-Source: AH8x226scwEI8/Cl1NbbOVamGwGP3NghyBpmlmXTerbwKVC/Z941cISCmqSzCiayknYGSX+7pE/bvg==
X-Received: by 2002:a17:902:59c9:: with SMTP id d9-v6mr7577865plj.146.1518047044748;
        Wed, 07 Feb 2018 15:44:04 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id w12sm6011821pfd.86.2018.02.07.15.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 15:44:04 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sunshine@sunshineco.com
Cc:     artagnon@gmail.com, avarab@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, mina86@mina86.com, mst@kernel.org,
        pbonzini@redhat.com, sbeller@google.com, viktorin@rehivetech.com,
        zxq_yx_007@163.com
Subject: [PATCH] send-email: error out when relogin delay is missing
Date:   Wed,  7 Feb 2018 15:43:59 -0800
Message-Id: <20180207234359.31493-1-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <CAPig+cQZr=UN3KC3LnaKy=oUYd1inbtDgi_pDuhPXf9HgFOdNw@mail.gmail.com>
References: <CAPig+cQZr=UN3KC3LnaKy=oUYd1inbtDgi_pDuhPXf9HgFOdNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the batch size is neither configured nor given on the command
line, but the relogin delay is given, then the current code ignores
the relogin delay setting.

This is unsafe as there was some intention when setting the batch size.
One workaround would be to just assume a batch size of 1 as a default.
This however may be bad UX, as then the user may wonder why it is sending
slowly without apparent batching.

Error out for now instead of potentially confusing the user.
As 5453b83bdf (send-email: --batch-size to work around some SMTP
server limit, 2017-05-21) lays out, we rather want to not have this
interface anyway and would rather want to react on the server throttling
dynamically.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-send-email.perl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 340b5c8482..bc0d3ade16 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -379,6 +379,9 @@ unless ($rc) {
 die __("Cannot run git format-patch from outside a repository\n")
 	if $format_patch and not $repo;
 
+die __("When a batch size is given, the relogin delay must be set\n")
+	if defined $relogin_delay and not defined $batch_size;
+
 # Now, let's fill any that aren't set in with defaults:
 
 sub read_config {
-- 
2.16.0.rc1.238.g530d649a79-goog

