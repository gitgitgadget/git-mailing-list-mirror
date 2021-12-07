Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9509C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 11:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbhLGLJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 06:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbhLGLJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 06:09:58 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F3EC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 03:06:28 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id c4so28626760wrd.9
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 03:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SNhyhgQJcFuT41h4CBxjy0LvoRmmJ+Z2ga7pvRSWJ3c=;
        b=nMQhtRiW8Zcf8KThuRLOSbi9WxMBn7kXSqahnHksD9PvOduCTW5fLK3oraZyZ+UiJ+
         6c0QtX+PUSwfbgv0H8rC4Gvx8h4CGdNzWsdTYR2rkIgLBSrOv9Vi8w8ttg5BUpYp5xuM
         K3Alj69Ac3HzmWdrwRyRlDmWMZpsbqnr+QWketurs/Pe9HixRDqxceJHPFRoII6FrA7M
         WX55cgQq3MPn1qK5Y7hW5DxjRXMGw6lVVWBkGfC/BFoBU5Wo7Gy3pfrRFlsZV79nNEJF
         2sHuA58AjKAkuMGn8QLZdY4AWRXiPyBh9RgCVFwS7vVkG5TQB/X+yb9PPm4hj5AlsKUT
         XV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SNhyhgQJcFuT41h4CBxjy0LvoRmmJ+Z2ga7pvRSWJ3c=;
        b=nTXgUycV/3cb0G0hxxlCM8g8gKu6tsZ8C8F3GTNU4/BmI+jFLmWpGkyrjm6HEeLXVG
         MJSrT+csqOC+QlWHQ9nWaZ0aNEmYCGJuHfCzueefEHePillBl4M3e8YaeSX97buiAYRc
         OhZXtYpf/B6XJajIzdk0buoEZzw82YVjRLFo93xUknzw1Y5Jzdk4VDnsZWMeyjoQtr/k
         3/NDXgUlG2AVCBEN3LopyQYpDn7QrsJFfNuxDsxybUigcNYfUP1yMhaGxZ8rWf70PFSB
         d4JIDipIjpPbwjVqSeyLs1IanOP1T9bM5Q5GRuOBcGZXA6Lh+bNuAP5AkVHJvVhDaAhp
         0WIA==
X-Gm-Message-State: AOAM530zZZiIFPhSeznDWnF1hcYr/IRHPc25fogLLi/Uymsd31wxIOp8
        Kfm4kZESn5Uu1f+GRzuFN1PkZZLFAepEUg==
X-Google-Smtp-Source: ABdhPJxnTCWJCxaJgNowkRVm53XLEzZVSSn0HBlMKPsReV6hc22gIwD5ugXtj2HtJzw0F5OQDBs0vQ==
X-Received: by 2002:a05:6000:1842:: with SMTP id c2mr49706368wri.301.1638875187130;
        Tue, 07 Dec 2021 03:06:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r17sm2629587wmq.11.2021.12.07.03.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 03:06:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/4] replace die("BUG: ...") with BUG("...")
Date:   Tue,  7 Dec 2021 12:05:50 +0100
Message-Id: <cover-v2-0.4-00000000000-20211207T110440Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
In-Reply-To: <cover-0.2-00000000000-20211206T162442Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211206T162442Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of this trivial clean-up series, now with 2x more patches
for missed cases pointed-out by Junio at
https://lore.kernel.org/git/xmqqsfv5b6u6.fsf@gitster.g/

Ævar Arnfjörð Bjarmason (4):
  pack-objects: use BUG(...) not die("BUG: ...")
  strbuf.h: use BUG(...) not die("BUG: ...")
  pathspec: use BUG(...) not die("BUG:%s:%d....", <file>, <line>)
  object.h: use BUG(...) no die("BUG: ...") in lookup_object_by_type()

 builtin/pack-objects.c | 2 +-
 object.c               | 2 +-
 pathspec.h             | 3 +--
 strbuf.h               | 2 +-
 tree-diff.c            | 3 +--
 5 files changed, 5 insertions(+), 7 deletions(-)

Range-diff against v1:
1:  2a17ed9f135 = 1:  4f39177a763 pack-objects: use BUG(...) not die("BUG: ...")
2:  ab89fec50c3 = 2:  6740c5d0da8 strbuf.h: use BUG(...) not die("BUG: ...")
-:  ----------- > 3:  81e354fa3be pathspec: use BUG(...) not die("BUG:%s:%d....", <file>, <line>)
-:  ----------- > 4:  aaf952a9ede object.h: use BUG(...) no die("BUG: ...") in lookup_object_by_type()
-- 
2.34.1.898.g5a552c2e5f0

