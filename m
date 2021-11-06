Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7488EC433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CFA661027
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhKFVtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhKFVts (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:49:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FDEC061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:47:06 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c4so19613341wrd.9
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XrUe3kAW6gm7QTqODsH+O7+tYgPX1sZvRgrvrIJkTDo=;
        b=czKV3uunrVtlyLIi48PtzQ6AhvH6tjjkUmPMyOmjO1Ul5ymJEkEhFzfCq641gxMk7g
         yg+mrXJDtElS6S82osB2Awqexfb0SrAuc+kx7JfRDO04lUJYzoT3S49URgEFJgE2er3p
         Ek1hGJFjnbwz3vx06sLg4H0DdxSFud8ESbU/EHSbtJyfnDlvc0fdqoIac3gG0Qh5n7XQ
         8C59kPv+4J9yDVgMWLjqXinAZxgi6IEmhrdsVhQqRLOAJj9pzDeBEaMh/XKA+9e+h4eY
         FxBU02QjwGpvaptBxe9Evu0RYjUjcU2Zf+ncCbRyt7mqXOA2CX8ENWdd975EXf/FFmP3
         P6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XrUe3kAW6gm7QTqODsH+O7+tYgPX1sZvRgrvrIJkTDo=;
        b=ViO9RBDFBub+mMPP8ULgoUw31EDqpL8fDdJ8Q9SHB51827BVMuwvTfhVSXmr838kyz
         EVjPZCVCHcHI4ZiILpS+Z5wFcCAkWSJ/IqmtmXLhEAJYr4c13H9pxKzUwhIQmmgcWlRX
         H2aD5dfGqKmPFHrYIlnk+cNyYgkAfSh5U8TKrxP89KzcjcMi2zZO09Dblpi5XI/Ql0XB
         2taORMitYz8OVISKxo0s4QHISD8SamfxECluXgJE+cpb8NdukYCtJjW4DS/JtDL5YYRr
         29BLPQKpTyxKTo4IeAnC0XjmRAWUbEZrfQiLAwtkbf9fyOi+ZGQfkHr5/qVexgwROWye
         zPmg==
X-Gm-Message-State: AOAM533MdX/2QJzo6OibXi77YmdkOguIQsKtgqj4Wqag+iww8Vsu+NuG
        LGPRWVQzVAf6XSZZjX+qJPKGp49NNOZPAw==
X-Google-Smtp-Source: ABdhPJyf3QuOjdi+ukLjtiYjOmfpaAgaALsN34v34ctPZjoWDAyX/nCXpiPxYv1y+N3vN5TpLuId2g==
X-Received: by 2002:a5d:6447:: with SMTP id d7mr53383662wrw.118.1636235224793;
        Sat, 06 Nov 2021 14:47:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f19sm12736630wmq.34.2021.11.06.14.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:47:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/10] cat-file: better usage UX & error messages
Date:   Sat,  6 Nov 2021 22:46:52 +0100
Message-Id: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <xmqqlf33i36a.fsf@gitster.g>
References: <xmqqlf33i36a.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series of patches to cat-file significantly improves the UX of
the -h output, see 08/10.

This is something I hacked up a month or so ago but didn't send after
the discussion thread about whether --batch-all-objects should be a
cmdmode[1].

This series marks it as such, as the square peg of wanting to have
mutually exclusive options best fits into the "cmdmode" round hole in
parse-options.c :)

I'm submitting this now because John Cai has a proposed change to
cat-file[2] which I proposed an alternate direction to on top of this
series.

I think as should become clear when reading this series a careful look
at any change to cat-file's interface would come up against the
missing assertions of what options are compatible with what other
options etc., which is hopefully all fixed and tested for in this
series.

1. https://lore.kernel.org/git/87tuhuikhf.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/pull.1124.git.git.1636149400.gitgitgadget@gmail.com/#t

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
  cat-file: improve --(textconv|filters) disambiguation

 Documentation/git-cat-file.txt |  10 +-
 builtin/cat-file.c             | 181 ++++++++++++++++++++-------------
 builtin/stash.c                |   4 +-
 cache.h                        |   1 +
 object-name.c                  |  11 +-
 parse-options.c                |  13 +++
 parse-options.h                |  10 ++
 t/t1006-cat-file.sh            |  88 ++++++++++++++++
 t/t8007-cat-file-textconv.sh   |  26 +++++
 9 files changed, 263 insertions(+), 81 deletions(-)

-- 
2.34.0.rc1.741.gab7bfd97031

