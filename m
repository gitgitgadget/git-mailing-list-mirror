Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D508BC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E87161404
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbhDWHa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 03:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWHa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 03:30:26 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57F1C061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:29:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c15so38361189wro.13
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kk37cMEqOKvqY9CKuuYiKX3hyOALn7xSMZMjPn2oBi4=;
        b=e10U4PYZil4FnLmylggPKcELR0x9GJlgftIlyl1KsGx70mAk613HwLIKwr20j07fnL
         Sdlopg1K8VJfINFRDg+6fYOed6zA7ecdUhu9Zg3vxHl2MNBW/imodgxaPIjx6y0N0vQ0
         mGrgS6wU/UoRVS9ZVhyp9GWKJhS8uCSp1XWHzwUeRGRQneewJPwrdBO3bbRdossXooxX
         EPhR+0uF8cyFefIz4Hg1Gfr3xU1/on7l3EA+MvScAphpj+MPthYFAj8jtn42J4uuybG/
         XZ7iqp9qKq8R1CnOts9RfHaMUQ5QcdPlTft2010mSa5iXBRaN/o12JQFItutJ7llVj6i
         tBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kk37cMEqOKvqY9CKuuYiKX3hyOALn7xSMZMjPn2oBi4=;
        b=HXuGIY2kUIqWFyvebNHX67BHJFS+O4TQl/bRKNasvXSpv9Ffc5nLfacaEC2L59szLf
         HOOfEsb92XyypgifuzYDh+rVgv6U25ZFWEDd6QjWwEIDkRPl4QUmh6ykhMbJoTJdV0j3
         6XGIE9saD5riNy6rZF24ggTW7M7b3PREkv+/gQm3c3cKLS0LQ2qem42zAhlCLjeZM4WY
         Y9YhluD1FZZlrZswl/q5lwxtzCzu14EtTPThgctJ/GoYHcGEsRzB02WCXDVYcaDEgbBY
         8mS7nkqBlBWXTQNqi9zI2wfqLk+s892vOR8uCrtNu5BrjTz5SnusGtTqpPEPoZjgIc5P
         u5eQ==
X-Gm-Message-State: AOAM533IBrC1vLGKGN0sHp4YHtucIFPw8LcS+mFER8p0JOT8Rh5AfXzv
        i5VCuelpOLg1XDdYkbZ7rvzKUBZ9vq3WNQ==
X-Google-Smtp-Source: ABdhPJzgygMCTo6DdSh9X6cpKXt3ZxyuSYWS0BKbhJ791brG1VqdiXxA+uPCwOAo5u88m/YRvvVJ8g==
X-Received: by 2002:a05:6000:1848:: with SMTP id c8mr2950149wri.210.1619162988517;
        Fri, 23 Apr 2021 00:29:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r19sm8681648wmq.33.2021.04.23.00.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 00:29:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/4] test-lib-functions.sh: trickery to make -x less verbose
Date:   Fri, 23 Apr 2021 09:29:42 +0200
Message-Id: <cover-0.4-00000000000-20210423T072824Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.734.gdef39492517
In-Reply-To: <cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes the "-x" output less verbose for our various helper
functions, mainly using the trickery of feeding "$@" to "test" to rely
on it to die when given too many arguments.

Since v2[1] I ejected the 3rd patch. I thought some test-lib code was
removed, but was only grepping t/, turned out it was used in ci/.

https://lore.kernel.org/git/cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com

Ævar Arnfjörð Bjarmason (4):
  test-lib-functions: normalize test_path_is_missing() debugging
  Revert and amend "test-lib-functions: assert correct parameter count"
  test-helpers: rename "path-utils is_valid_path" to "is-valid-paths"
  test-helpers: split "file-size" into "file-size(s)"

 t/helper/test-path-utils.c  | 13 +++++--
 t/t0060-path-utils.sh       |  2 +-
 t/t1050-large.sh            |  2 +-
 t/t5319-multi-pack-index.sh |  6 ++--
 t/test-lib-functions.sh     | 67 ++++++++++++++++---------------------
 5 files changed, 45 insertions(+), 45 deletions(-)

Range-diff against v2:
1:  ba9d6251ad5 = 1:  26a3d552d88 test-lib-functions: normalize test_path_is_missing() debugging
2:  5f8e5ad27f5 = 2:  3a570321770 Revert and amend "test-lib-functions: assert correct parameter count"
3:  44948c6ace9 < -:  ----------- test helpers: remove unused test-tool path-utils slice-tests
4:  ae5dc5d03b3 = 3:  bf35091a112 test-helpers: rename "path-utils is_valid_path" to "is-valid-paths"
5:  947791d9535 = 4:  ac0b920c041 test-helpers: split "file-size" into "file-size(s)"
-- 
2.31.1.734.gdef39492517

