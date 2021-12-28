Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0439FC433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 13:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhL1N2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 08:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbhL1N2y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 08:28:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D2AC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:28:54 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r17so38422414wrc.3
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WklqUxuEMIzzxnRWQLy5XbautfCbKIf3wAOCcMJloHU=;
        b=AxuyHWyvkMRZY03hQDkHzi6bGYwzs5OvZXsh3gKCgkJc9Yh82wsGw2L0BPn15hklvv
         ugYj9OPR6Ya5I3fHoTFapbLG5b+z558+LefuCnHN+n1o437+2nor+qnCTq/qXfI4oGtn
         WNYVx/R9XpyFbwOijMiM9S99bPP8kDpk6Ni9GJoxuAd9ml43GdfWywDeK07oyglxOjpL
         pIlRAOISBNfxhH95MDr1Va4NrnSXmYgztk0w66se+2QzPhNLlRm0QUL4xYZ5N9RvRIJ0
         jVPGj3bymujqN4obSo+tUQmIV130WS31MPQa8wOrJDE7o8fWMiF/i0c64+2KkAAVH1iR
         qU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WklqUxuEMIzzxnRWQLy5XbautfCbKIf3wAOCcMJloHU=;
        b=IiWz23Ii8rWgMuvx0EbI2NxsUlSNXkBzyJ/k2i2lnXMknf2GwPBxwl0IUXol9rap5A
         MeBS3v5yJVyJaMgn7RP/MrDHF8QSCckl7HrvP7iKtTslSZDDsaJ6ZHBHMp+jqPNt0m74
         KOxqO7nEhgPZTJ48D8wWvoZB2MlvWvJcsuPGlCo0acjaZfArVX7ccoVEx4rVxYVyB8s/
         pZHl65kMgzXkJLKQknbfqJy2dsgjP6uZ2nrRfQhQXjOHuKZz04jxYgk7RVafEOecMpLb
         UZHe2tPXQ2QjOBI5sOYLRbxpIXnT9LUBglWdZJvMiGtngU2s1em32ayfwSDXmpVN8Z5h
         E5cw==
X-Gm-Message-State: AOAM530hklxTWhTpIDGIk5andV1ts445yjPBj3iPGMrustK6GMhjbTV+
        T87rKfXL3v8Zk3RnQDPVirLYTsDE9bXdENsq
X-Google-Smtp-Source: ABdhPJxVwGK32qnibNs7ynSjqDhkePlXWpDmmMs6PGlMc9lD7sJvMaJq5qeqieAADZssRaz37UY+0g==
X-Received: by 2002:a5d:648b:: with SMTP id o11mr14017606wri.227.1640698132786;
        Tue, 28 Dec 2021 05:28:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11sm19695868wri.101.2021.12.28.05.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 05:28:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 00/10] cat-file: better usage UX & error messages
Date:   Tue, 28 Dec 2021 14:28:40 +0100
Message-Id: <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
References: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series of patches to cat-file significantly improves the UX of
the -h output, see 08/10. For the v5 see[1], for the new usage output
see [2].

1. https://lore.kernel.org/git/cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com/
2. https://lore.kernel.org/git/patch-v6-08.10-af22a4cb134-20211228T132637Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (10):
  cat-file tests: test bad usage
  cat-file tests: test messaging on bad objects/paths
  parse-options API: add a usage_msg_optf()
  cat-file docs: fix SYNOPSIS and "-h" output
  cat-file: move "usage" variable to cmd_cat_file()
  cat-file: make --batch-all-objects a CMDMODE
  cat-file: fix remaining usage bugs
  cat-file: correct and improve usage information
  object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
  cat-file: use GET_OID_ONLY_TO_DIE in --(textconv|filters)

 Documentation/git-cat-file.txt |  10 +-
 builtin/cat-file.c             | 182 ++++++++++++++++++++-------------
 builtin/stash.c                |   4 +-
 cache.h                        |   1 +
 object-name.c                  |   8 +-
 parse-options.c                |  13 +++
 parse-options.h                |  10 ++
 t/t1006-cat-file.sh            |  92 +++++++++++++++++
 t/t8007-cat-file-textconv.sh   |  42 ++++++++
 9 files changed, 282 insertions(+), 80 deletions(-)

Range-diff against v5:
 1:  e771bd38792 =  1:  e52834a343f cat-file tests: test bad usage
 2:  291312e2fb5 =  2:  02622592803 cat-file tests: test messaging on bad objects/paths
 3:  0689dbb248c =  3:  ff717088a28 parse-options API: add a usage_msg_optf()
 4:  2a28b39430e =  4:  c4078ce9222 cat-file docs: fix SYNOPSIS and "-h" output
 5:  2d90c12fe7b =  5:  9573437374a cat-file: move "usage" variable to cmd_cat_file()
 6:  227805d1804 =  6:  30ed6617de8 cat-file: make --batch-all-objects a CMDMODE
 7:  e6ea403efe0 !  7:  bf24dd063c9 cat-file: fix remaining usage bugs
    @@ t/t1006-cat-file.sh: do
      	'
      done
      
    -+test_missing_usage() {
    ++test_missing_usage () {
     +	test_expect_code 129 "$@" 2>err &&
     +	grep -E "^fatal:.*required" err
     +}
    @@ t/t1006-cat-file.sh: do
     -	'
      done
      
    -+test_too_many_arguments() {
    ++test_too_many_arguments () {
     +	test_expect_code 129 "$@" 2>err &&
     +	grep -E "^fatal: too many arguments$" err
     +}
 8:  16b6bb8aaf2 =  8:  af22a4cb134 cat-file: correct and improve usage information
 9:  47543c57135 =  9:  7bf5654e8f7 object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
10:  63920969ca8 = 10:  56826ac73e6 cat-file: use GET_OID_ONLY_TO_DIE in --(textconv|filters)
-- 
2.34.1.1257.g2af47340c7b

