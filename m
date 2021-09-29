Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE09C433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 00:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB7E8613D1
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 00:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243441AbhI2Au0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 20:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243396AbhI2AuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 20:50:25 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731E9C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 17:48:45 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id c6-20020a9d2786000000b005471981d559so789243otb.5
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 17:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aRUUjtSFWC2Gu29zLeo6QdhRGrMa/aHI7IcaEr3qv8E=;
        b=BbRZNZ8nbu9y0tMYUI4x+VkH/moAkG+Vx0lCh/pyeG6aj1xCh7xlHbrH4BUw89+tHf
         Pc1aJQarIUPYisOwZQLqyekvqCrPZteQLLVw+Xr9Dy+JdGycgUJuc5f4xKsEYwxddTu6
         kwi6UX+82NZmjyRDGQRvOanlTDcuLkFPrvj9od/FBWWL/YO1oFjyulmJfWggkYaNycvG
         804UV1mG5Z4GE9XuEtIbw4CAEm9ujLnxtIy2JxOAYXYyd+L4vBKhZDk4o8g5zw8Yo3Cp
         8H6I65bS8eMxIj667NO3QiPBJFsE+PSWhPTF8tZP3ca3XvlRAVSzSGIX5mLtSvhcgwa1
         s/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRUUjtSFWC2Gu29zLeo6QdhRGrMa/aHI7IcaEr3qv8E=;
        b=FxMX+sAaB1beGehioDwZJfxVcsgrsvBFREQ9W162mVOAUaGZwFq/N/UZNYkKxk3a4E
         i08XKyt3Gi7dCFv8XLlDTmc0/vJEX94VHswA0GT8zjN/xMAkOt0BBaEk661ANrmFBlWw
         R3yPe0Gd19DfkMw5lwULExhYzLS6oEglOZFzLbEcnxtEwXJkVJKN4my6fE1MRl7DjfUK
         swXmqejzc27aI1JZuq6KqtfIJqPZET4hifpU5PUhXlv8Vi6O4wmLw1n3V1A1AmHqBpJo
         lW689sw3L7ZoGHyoEBdJjpN/KTz2wqmyOwy6I0Gcm6IDsylAyzBm2A/AhJ7gJKbLZ6yk
         /hZA==
X-Gm-Message-State: AOAM531JI0axfKIycWvo//VHtFkyhFSj8ImGTkjv4F1cQ0mwVOTkEPzZ
        arrFp4OmEk6hM4dNdlCfjO2WQdZNKVoSew==
X-Google-Smtp-Source: ABdhPJw7ZWHCw1cn29ukciwWXXh4pn94BAlXYx0y9B3tcrrBtYddD7EhwUMAsqU7szWRS/zJVZLsVQ==
X-Received: by 2002:a05:6830:210c:: with SMTP id i12mr7725861otc.102.1632876524492;
        Tue, 28 Sep 2021 17:48:44 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id r18sm159924ote.28.2021.09.28.17.48.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 17:48:44 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, gitster@pobox.com, avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v4 0/3] js/win-lazyload-buildfix
Date:   Tue, 28 Sep 2021 17:48:29 -0700
Message-Id: <20210929004832.96304-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20210926100512.58924-1-carenas@gmail.com>
References: <20210926100512.58924-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series includes all changes from v3 and an additional patch that is
based on the one that was originally[1] published as patch 1 from a different
series that depended on this one.

Range-diff looks weird, but that might be just another bug in format-patch
as it looked fine when calling range-diff directly.

[1] https://lore.kernel.org/git/20210928091054.78895-2-carenas@gmail.com/

Carlo Marcelo Arenas Belón (2):
  lazyload.h: use an even more generic function pointer than FARPROC
  Makefile: restrict -Wpedantic and -Wno-pedantic-ms-format better

Johannes Sixt (1):
  lazyload.h: fix warnings about mismatching function pointer types

 compat/win32/lazyload.h | 14 +++++++++-----
 config.mak.dev          |  8 ++++++--
 config.mak.uname        |  8 +++++++-
 3 files changed, 22 insertions(+), 8 deletions(-)

Range-diff against v3:
-:  ---------- > 1:  d2c470f9bc lazyload.h: fix warnings about mismatching function pointer types
-:  ---------- > 2:  2d84c4ed57 lazyload.h: use an even more generic function pointer than FARPROC
1:  a731848d01 = 3:  a731848d01 Makefile: restrict -Wpedantic and -Wno-pedantic-ms-format better
-- 
2.33.0.955.gee03ddbf0e

