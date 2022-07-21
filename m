Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B59FC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 06:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiGUGj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 02:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiGUGjz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 02:39:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0AD3AE56
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:39:54 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so287017wmo.0
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I59nUiVM7bifav3l71CXP5muEXdTeoGw84gnvJGWfhQ=;
        b=orgo47zsGbUVsHo8qCqc2k3Wb08MtiE+pAf2IGw/PhL2hxvY8HTQUh9kuL/OO1kcYV
         TMPnZ5SalsAsenJuTxg3ECKx/DVHhiDC07KBS55DgCiRbpRK8XYVqDDQiVhCBojTMtLq
         MkuFAZVFm5owJyVLDTGQZZLnUm3ItpYotJl/Zyx+UhNnd9HMc9EdHTsHBZHQOh+ISQk6
         5vneyN2tAnWGCEC22kBWVJg6v5hWOSEcOerpVtYz2Q6gU2MsNYIONdXuob9W/ZOqN/1d
         AASZCMMHKTw5riVXcIqAGkdJWK3/t24IPz2gn+U4iCptq15O/tg0+Dtgs4WcpfhKSINf
         toPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I59nUiVM7bifav3l71CXP5muEXdTeoGw84gnvJGWfhQ=;
        b=M8YJY4bp6oAwmbl8OTtQZGTOmYpNrLKXSzUlo0z03gspmDfjqk3Zpvn53jcDbKQBKr
         ZD1Avhe8imvhyrSIwApwD/LtqUmcndu2B88JODsdyjQf33VkotLHO2392slcS9Bood5o
         PuXOdVNDDpk/IhlgrU3AejYPvSjXUk7VMktWiRiaMnC5Cz4RJ/f19BU8kIDDFbfk0ou+
         mdWv7/BanF6JAe63PmRGFku1x+OcdMz3e4bZKjpJtUEBEryztgDWwNJK+/Fj0UeXwyYY
         LJBe8zeNmxHbv6nEogvcNy2ASpFSNrUYD95Up+J4gSeCbkDJHqhPDvi+gu9Ybm3wk52+
         RGpg==
X-Gm-Message-State: AJIora8FnXavJCoP8IWCaepViWWZzjSONK4eH+69q3zx0qNBs4NeULK5
        9W/uzNha0yWstP30ECsaXRcoJsn39/ilKA==
X-Google-Smtp-Source: AGRyM1vh3kjyZvBjJ/vUO6VB/n/WeRCRXn4Ie4GCxPXbh8fx7WRLx9VkKgarIBrVauVmrV54a5ASNA==
X-Received: by 2002:a05:600c:a42:b0:39c:9166:5a55 with SMTP id c2-20020a05600c0a4200b0039c91665a55mr6677767wmq.141.1658385592456;
        Wed, 20 Jul 2022 23:39:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r67-20020a1c2b46000000b003a308e9a192sm4641137wmr.30.2022.07.20.23.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:39:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] string_list API users: use alloc + init, not calloc + strdup_strings
Date:   Thu, 21 Jul 2022 08:39:43 +0200
Message-Id: <cover-0.2-00000000000-20220721T063543Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a small follow-up to Junio's
https://lore.kernel.org/git/xmqq7d471dns.fsf@gitster.g/; This is a
small set of fixes to use the string_list functions rather than
peeking into its guts during initalization.

I've been running my local git version with these changes for almost a
year, but for submision I wrote a coccinelle rule to cover most of it
in 1/2, along with a tests using the new recently landed coccicheck
test support.

The 2/2 is then things I had to manually change still, which weren't
covered by the conservative rule.

Ævar Arnfjörð Bjarmason (2):
  string_list API users + cocci: use string_list_init_dup()
  string-list API users: manually use string_list_init_*()

 contrib/coccinelle/string_list.cocci     | 8 ++++++++
 contrib/coccinelle/tests/string_list.c   | 7 +++++++
 contrib/coccinelle/tests/string_list.res | 7 +++++++
 notes-utils.c                            | 4 ++--
 reflog-walk.c                            | 2 +-
 refs.c                                   | 4 ++--
 resolve-undo.c                           | 8 ++++----
 revision.c                               | 4 ++--
 8 files changed, 33 insertions(+), 11 deletions(-)
 create mode 100644 contrib/coccinelle/string_list.cocci
 create mode 100644 contrib/coccinelle/tests/string_list.c
 create mode 100644 contrib/coccinelle/tests/string_list.res

-- 
2.37.1.1095.g64a1e8362fd

