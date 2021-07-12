Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65892C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD3E61154
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbhGLQrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbhGLQrN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 12:47:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95B2C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:44:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k4so20208350wrc.8
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TVcJ8/bgaCdqqfdk1jWGa2uH4NKP6ipocDo9McX0oPE=;
        b=KWe/B1oOjNfn626dCz4UBqEZIYsjpLCABGpCnug0Sb7JbsAUpHrmw7SzU3tPQP8Bmm
         FDDUoA9LXt4/NtXr2kPlGV5ox+LszZ08GDpDuyDpLt9Mqawo621ZDZBImjI1jCrCeRXq
         8kseJY2nDsV/l9VI8b0+hwGGfTDOn4Wb7ZUIQaxeZBrj/bTIr1AsToEHxI2TSGPS7OHq
         W5x1xyL1DrTA8RSZgef6VBcixpZl5YIMvC2Br7ExSo7Dts+gAsvpkWJhoUY95EAzfLLS
         k5PmE9nbGy/GEc7UeFKWSROLHRzeblGx8ghFF3VA49pM4dGKvc6DnBqEa6qJhIORSJCo
         GSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TVcJ8/bgaCdqqfdk1jWGa2uH4NKP6ipocDo9McX0oPE=;
        b=bwXHRJ/sZ74g4W+nZCc47jN8jLHrbhX/GzMoIEDvqD8WtWrwQ0GUXyWkwg0T19wkrU
         zVtupdLlhcrv2boEYiyPToFWdpA/ILLFeMeCx63HDkzYlxQbrNX5GA0LOkrLVJqc/4jR
         E5gJAQ/HAGXTsZ3uENkAkpJwl8Ha+WDPGuZ46WvRYNrNSolCoMBt6Mc//1yia1lqOx5a
         uwgc5FwmJEBiXae75DRdgxowMHrdzzSaGC4aPqsmB14DvKbcCATaiGLiMK87qvKNdyGd
         tEoTKrF9UvOaB0KEMzBYTqmOqhX6ad7qcOZ2MDrweDFDyV9HE9SBvHo+pLVA9oxfaYsf
         u1fA==
X-Gm-Message-State: AOAM532ea+om3UYMxeusQQAgIg/KcOhiQktW5XL/pQg5LAAYUp/ItjGy
        KieaGMZL6/2HJGUlp6WsZUfXFHDiEUAUzQ==
X-Google-Smtp-Source: ABdhPJxaiR0OUITjIinz0xPdyvJthH3/8NGyj8PgP4S3EFloX83Cpaj/0NN5N+VaCPC/MF2y/vEByA==
X-Received: by 2002:a5d:6148:: with SMTP id y8mr22902085wrt.20.1626108263203;
        Mon, 12 Jul 2021 09:44:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm12988347wmb.40.2021.07.12.09.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:44:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/5] tests: migrate to "test-tool pkt-line"
Date:   Mon, 12 Jul 2021 18:44:15 +0200
Message-Id: <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is marked for "will merge to next" already, but not there
yet. A trivial v2 whitespace fix in case Junio's in time to pick it
up.

See v1 at https://lore.kernel.org/git/cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (5):
  serve tests: add missing "extra delim" test
  serve tests: use test_cmp in "protocol violations" test
  tests: replace [de]packetize() shell+perl test-tool pkt-line
  tests: replace remaining packetize() with "test-tool pkt-line"
  test-lib-functions.sh: remove unused [de]packetize() functions

 t/helper/test-pkt-line.c               | 12 +++++
 t/t5410-receive-pack-alternates.sh     | 42 +++++++++++++-----
 t/t5411/once-0010-report-status-v1.sh  | 12 ++---
 t/t5500-fetch-pack.sh                  | 15 ++++---
 t/t5530-upload-pack-error.sh           | 24 +++++-----
 t/t5562-http-backend-content-length.sh | 16 ++++---
 t/t5570-git-daemon.sh                  | 22 ++++++----
 t/t5704-protocol-violations.sh         | 61 ++++++++++++++++++--------
 t/test-lib-functions.sh                | 42 ------------------
 9 files changed, 135 insertions(+), 111 deletions(-)

Range-diff against v1:
1:  fcb53980597 = 1:  67aa8141153 serve tests: add missing "extra delim" test
2:  c3544fb53cd = 2:  64dfd14865c serve tests: use test_cmp in "protocol violations" test
3:  c1015fa6ab0 = 3:  c33f344ab20 tests: replace [de]packetize() shell+perl test-tool pkt-line
4:  ab23513b48b ! 4:  a44e1790f2a tests: replace remaining packetize() with "test-tool pkt-line"
    @@ t/helper/test-pkt-line.c: static void pack(int argc, const char **argv)
      
     +static void pack_raw_stdin(void)
     +{
    -+
     +	struct strbuf sb = STRBUF_INIT;
     +	strbuf_read(&sb, 0, 0);
     +	if (strbuf_read(&sb, 0, 0) < 0)
5:  2d22b83971a = 5:  cc91d15ef70 test-lib-functions.sh: remove unused [de]packetize() functions
-- 
2.32.0-dev

