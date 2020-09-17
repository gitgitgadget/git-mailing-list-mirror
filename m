Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DB4C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 11:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 511CE21655
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 11:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQTXK58e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgIQL3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 07:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgIQL3D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 07:29:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC45CC06174A;
        Thu, 17 Sep 2020 04:28:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a17so1662729wrn.6;
        Thu, 17 Sep 2020 04:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6NxjoOjgOUfz73asSaMrUPJ8xzTASv0BQwLmCO1ZT1o=;
        b=PQTXK58e7Lz0t7w27aiw2XlTYwlX9HneHHPvIzC/HR35tSoN1Py5wrQtuj4IFwrMU6
         OUcmz+LoJSYbQYHVZDjlD413EnJbThH3lb82XIczhE55KqfdiX5sSjCTKxnG+g+Xb7dJ
         JkKHC3xF9IMIKL3hP3Oo4DocLLENpEHYpV446NHXgU+UA/dowZLjcu6ernfbjaS/GY3W
         hpFegsOG2MVYtfmHu80LNlST9KuXtr6R0F5LLBHHCDtwQoywYev4mvkqcHQBIBLuxyQ9
         g/F4VimQzkQR3dk8Blus9miVUecWDqbKhoAvU2OSRKegsDGiNT+oyjgCm1pnmJvlyHLV
         8AVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6NxjoOjgOUfz73asSaMrUPJ8xzTASv0BQwLmCO1ZT1o=;
        b=DyNzhS7iOXZ2OjaexnRXLQcLS9xcmk6eAz17EKvvwiXE4a3817p3Y205+xRLxHWINZ
         K+nzbhIg2sM5cF6EFezLYcIuKra+LC93V6prfqHzzNguJEPkK+5zYuVMuvvaLiXaB356
         Y41Mfo9ylLJAgXjZioZtcWuwdb/7xVMLWIQA2uu+1hA2XVJak6KNSI4CytSCbSgexDSk
         ibPwM9mtvTrZYiozBqM9geh1CUQtPoGh6ucZb2tffCIYaYeWNx5NxZD3K6LyONABVJjZ
         yxO4PIIc+ZyhgJlAwclcleGa/DXNmX8p54xWBofk+x0Yz7cVkRT4ZMEy5ILLlTqbckri
         BvJQ==
X-Gm-Message-State: AOAM531Q4hbeyX/b8OJ+NAKlkYTG0LM6gc0J2iKkdSK5fdPuhP3eSqlG
        5GcBH3ca/lm6bgaGmOwaRevh+3OnADA=
X-Google-Smtp-Source: ABdhPJxS583EJfuS3WHTJRs5d/gyOAmTDKrgCUaiyZxAE6QrXVewdYA9IV4FjkBwxj25jyEJGfnWrQ==
X-Received: by 2002:a5d:43cb:: with SMTP id v11mr33360405wrr.188.1600342129159;
        Thu, 17 Sep 2020 04:28:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t16sm38781127wrm.57.2020.09.17.04.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 04:28:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 0/2] should core.fsyncObjectFiles fsync the dir entry + docs
Date:   Thu, 17 Sep 2020 13:28:28 +0200
Message-Id: <20200917112830.26606-1-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <87sgbghdbp.fsf@evledraar.gmail.com>
References: <87sgbghdbp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was re-reading the
https://lore.kernel.org/git/20180117184828.31816-1-hch@lst.de/ thread
today and thought we should at least update the docs, and per my
earlier E-Mail in
https://lore.kernel.org/git/87sgbghdbp.fsf@evledraar.gmail.com/
perhaps the directory entry should also be synced.

I kept linux-fsdevel@vger.kernel.org in the CC, it was in the original
thread, but more importantly it would be really nice to have people
who know more about the state of filesystems on Linux and other OS's
to give 2/2 a read to see how accurate what I put together is.

Ævar Arnfjörð Bjarmason (2):
  sha1-file: fsync() loose dir entry when core.fsyncObjectFiles
  core.fsyncObjectFiles: make the docs less flippant

 Documentation/config/core.txt | 42 ++++++++++++++++++++++++++++++-----
 sha1-file.c                   | 19 +++++++++++-----
 2 files changed, 50 insertions(+), 11 deletions(-)

-- 
2.28.0.297.g1956fa8f8d

