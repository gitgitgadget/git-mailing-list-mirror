Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9A7C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC36E610E6
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhJNURW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 16:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhJNURV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 16:17:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D97C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 13:15:16 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u8-20020a05600c440800b0030d90076dabso290800wmn.1
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 13:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0MueDq5r7eX4LuIFGdNrCJgwsXsT0zp5WzrIupeokKs=;
        b=dAozx5JHMoJOM66lTVqNFutKW0QQRTyaSDpCoykschv4DOJv50XyPAypZZxnorOHVl
         RZLOniKE0fVOpxHhDx3/wSNNo/BqbGPXhiExjmMS2KjOscJBf16HHkuiESs0QSH+SQwA
         MB2lEc595nZhv6dHWaD3UrLwbtnbngCljurvVTnCViHzcVB4EOLJLLiySrSsJCi+XCMe
         bX/1Ewki84pVhiqMg8dxOtSGP4VwLeCt3aFV4Keb5upIEqqBJNJzxlTnooWth2OFzAJJ
         2zVvTtDk3pWHa9Vck4kAkfTyS2+62BkobWIzOtWSVNETrv197xD0K09p4iIA+lyz/4p2
         GqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0MueDq5r7eX4LuIFGdNrCJgwsXsT0zp5WzrIupeokKs=;
        b=moRL7BJfxyvC4XKfRTKAOi7KOERuk5UujV+XUC62jD/aBt435ynuwcaPy9kev5Z8Nh
         mGHNdTCv9jWxgPEe64Vp4LrxeWWMp1BbTi4YQxrEPAHla648ZIn6py2Vil7xNVCtUKij
         Xkqlg2i8jaDyLLtWSzrrg5uY/EnkX6Kh0mneYEoALJOk5Ojjh0T043poMVPGElNqlCLV
         id8hBDFNhcXLF2M2fN2j0vK+vay9DlOTv65gfk91sgJT/bRhpWLqwBXMlJnZ/G/07jp2
         dWdFkQT/TDmMFxLQy2DOcD89Y6+2AOWtx/lkf+dFSI1R5mz8j+i7alEbkNDGbgIDIyX5
         ogNw==
X-Gm-Message-State: AOAM533Yxp5KzoIQ+OdlkM/UVjZoOytZ3Evr7l/6ELruMGTFC7D3OmJy
        f4d7v0EZ7HZI0sJeZ2TBUmbb7Eir4kDDDQ==
X-Google-Smtp-Source: ABdhPJwdLwOP3sCOsPa5LKDv+mETTEkrUtWJA1Cn3uoYPgS1XEMjNzAm/8BHllx6lchshOKfDifJcQ==
X-Received: by 2002:a1c:f705:: with SMTP id v5mr11472881wmh.121.1634242514628;
        Thu, 14 Oct 2021 13:15:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b19sm9199265wmb.1.2021.10.14.13.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 13:15:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] pkt-line.[ch]: dead code removal
Date:   Thu, 14 Oct 2021 22:15:10 +0200
Message-Id: <cover-0.2-00000000000-20211014T201317Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove some dead code in pkt-line.[ch], perhaps someone has an
objection to 2/2 as we could keep that function variant around "just
in case", but it's trivial to use the underlying function (or re-add
this utility), so shedding the unused code seems better.

Ævar Arnfjörð Bjarmason (2):
  pkt-line.[ch]: remove unused packet_buf_write_len()
  pkt-line.[ch]: remove unused packet_read_line_buf()

 builtin/checkout--worker.c |  4 ++--
 daemon.c                   |  2 +-
 parallel-checkout.c        |  3 +--
 pkt-line.c                 | 45 ++++++--------------------------------
 pkt-line.h                 | 10 +--------
 remote-curl.c              |  2 +-
 6 files changed, 13 insertions(+), 53 deletions(-)

-- 
2.33.1.1338.g20da966911a

