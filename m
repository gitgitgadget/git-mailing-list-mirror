Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2A4C43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 21:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiFFV4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 17:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbiFFV4I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 17:56:08 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312A63BA7A
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 14:56:04 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id x75so8525574qkb.12
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 14:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=iNnX4Fgb/DKWuJ4KzrF1JLJ1KMD/BDr4oOX6gw/on6M=;
        b=g4bVlcafiYVMsYRyARrN3UHV/X+Zw6jwoWn4SuURcgDJqmyvZKR6sqSv5U2XLRQ9oa
         z5WUQt1J5YL05Xm+6fKlNLpSKzt29N26FaG7XJjsmIcr+DobzFLA/r3enmAT0OWis90I
         qbC6IkLdYrTZVE0aECbmufzohkjlqaaOAr27UuIUtbOoT226quehxRTD3pRtOevyqNGZ
         K88wKXMM+6EvJxE+v9vsAWxCrjhnyTPp+mf6rjXevBQLnQeWx/62FOqCeqNVJ6G2GnzK
         UqlJ2hqJRyFPKAxoZys3N18wxEfbyr2ivVl4pi2/V7s+y8fH93jlJtqTTlZdTpfbvSve
         Nd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=iNnX4Fgb/DKWuJ4KzrF1JLJ1KMD/BDr4oOX6gw/on6M=;
        b=Rw6PmyicZpynMPEfGQEROdL5BaOx7xoTRuucJ7aE89dG6xQvy7xeQcVCW8LUX+eWhl
         nqj9lkmePnoPbRHwDbuy2lpdlQfsD09mUJ0Y4burcdBwUI+YP+r1ByrB4C4BChz/UWwL
         ih2nXYoLC/L/Oy5BRZkfh7AuzD1Kw5saLgBVCrSGgC3p6LB5C9qx5z8esOUDFVaBA4V+
         riI18CrjXkfsT4FsVAqgMi88jVL74E2XbXhKFg10SJWz5dnzQVivP/3pKtn3Cc/CYMwt
         YYXe8pg3qTRZ8bGW+6VwOUVm3GlqaLh4heoOnvx/GF6fsn9AWUzCtXtuqjEYb1fE2ei3
         vWTQ==
X-Gm-Message-State: AOAM533FSoPIJMy31Qql+FCQVF9HME3Uv99TiGCdD2dopF++x9vjdkZg
        wBWHPeyoBzYNlzlVFWLr0x6Wqy2xgf0Nmukh
X-Google-Smtp-Source: ABdhPJxgE9JaFj7ZUeICggkcDuQBoIeNpq+W68vKNHXcTKvZVJo2KmIsr8T1emzPwv93xNjne9/Dag==
X-Received: by 2002:a05:620a:254f:b0:6a6:313:3ccc with SMTP id s15-20020a05620a254f00b006a603133cccmr17252754qko.716.1654552563159;
        Mon, 06 Jun 2022 14:56:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cm10-20020a05622a250a00b00304ea1e39a4sm3835083qtb.77.2022.06.06.14.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:56:02 -0700 (PDT)
Date:   Mon, 6 Jun 2022 17:56:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com
Subject: [PATCH 0/2] builtin/show-ref.c: support `--count` for limiting output
Message-ID: <cover.1654552560.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This short patch series adds support for a new `--count` argument for limiting
the output of `show-ref` (à-la the `for-each-ref` option by the same name).

This is useful in contexts where a caller wants to avoid enumerating more
references than necessary (e.g., they only care whether a tag exists, but not
how many or what they are called) but doesn't have control of the output stream
(e.g., they are in Ruby and can't pipe the output to `head -n 1`).

The first patch is preparatory, and the second patch implements the new option.
This series doesn't conflict with my recent [1], and can be applied
independently.

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/3fa6932641f18d78156bbf60b1571383f2cb5046.1654293264.git.me@ttaylorr.com/

Taylor Blau (2):
  builtin/show-ref.c: rename `found_match` to `matches_nr`
  builtin/show-ref.c: limit output with `--count`

 Documentation/git-show-ref.txt |  7 ++++++-
 builtin/show-ref.c             | 29 +++++++++++++++++++++++++----
 t/t1403-show-ref.sh            | 21 +++++++++++++++++++++
 3 files changed, 52 insertions(+), 5 deletions(-)

-- 
2.36.1.94.gb0d54bedca
