Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7D8C4332F
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 11:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbiCGLjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbiCGLjM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 06:39:12 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17CBE51
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 03:38:16 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id k24so13290948wrd.7
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 03:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hjKniJqS7d+YNhAz+EEmeGnQARyuyw68llrjFVXy1p0=;
        b=GK3YyupmFqwsVk+3yZa2XLkVslv87T19IwRmsatNazzCXunaz+qUuZzbiU6exV6tfA
         C6c5o5ZzHd23IaN4i8cGjr2vGws8NPcXCCtG8CWrsZItNjF6C7/d1MmAqR3C0s4noabl
         UpfE1oZsd9hXVjoBU5jifOL6ie0ukzns5MY78LsC0b+aCixHqCczzQek10ycA9ALwtxy
         yEaKYOUFhqvfHb8VTGly3N2+0BL2DWpJ00TCg0S+FlUohpeN4kDQqpYqyVjG+H8zaCyK
         0Ue9jpkrDbcRYtsFy8FSHLNKAuqKO00Dq9X7bsqJ6u4iwOaYXDdhtJyjcaIMnvh6jKwu
         LY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hjKniJqS7d+YNhAz+EEmeGnQARyuyw68llrjFVXy1p0=;
        b=04/JUdFR4e1zVWG+/YsJgb4z/vy14yKX33JPoDw5M3U+ZsiGRcaoNMeiEdlZATk6Vu
         hg5SD21HJpGQrvTef5DrVtns7ukzs/aT7PmU6EZsZO+taoG8ckmRi6xbX//xHAHyy/S6
         i9NZj4ak+gVkMQ1aUHK8u227i7mqqZ79EDrKmUexhBJw3eKbGMnuKcvpVDB/OGjhb8hL
         8kUTjbqr1uDQAkp80PIo9sF6S/tpUANTwNe4DmrIF+HwfaKe89AojE42He1RHZJRUeEY
         Wi3Pg30EQALZDGUaVPGSV2ZovAjUw5daqT62Se/kPTtmURO/wp/URl40XUwh3uMeGqdm
         Ma5g==
X-Gm-Message-State: AOAM533FR2qmVmnTmI9EtgCtMu2hpDHHktwt4U52ltC48FBOJXwF8lrw
        2P2o/RlOK+gM3rUMUrD8UHweH0pZOVgUuA==
X-Google-Smtp-Source: ABdhPJyeTu5hsoaslahwACfKQsboVf+KlA8BkK/mFC27j8qNUR42io2lmc78GNJtl0DmvqM4XXDbDA==
X-Received: by 2002:a5d:64c5:0:b0:1f1:e6b8:bd3c with SMTP id f5-20020a5d64c5000000b001f1e6b8bd3cmr5289860wri.686.1646653094946;
        Mon, 07 Mar 2022 03:38:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a14-20020a05600c348e00b00389ab74c033sm1809074wmq.4.2022.03.07.03.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 03:38:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] string-list.h: make "nr" and "alloc" a "size_t"
Date:   Mon,  7 Mar 2022 12:37:59 +0100
Message-Id: <cover-0.2-00000000000-20220307T113707Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1241.gd8d69a17521
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$subject most recently came up in
https://lore.kernel.org/git/220305.86pmn030ou.gmgdl@evledraar.gmail.com/. I.e. we
have code in-tree already that's possibly (although in that case
unlikely to in practice) keeping track of size_t-indexed with a
string_list's "unsigned int"-indexed data.

Now there are no textual or semantic conflicts between this change and
"seen", so having series (which is of course based on "master") now
would be a good thing, and help to future-proof the API.

The 1/2 here isn't strictly neccesary as part of this series, but
since a large part 2/2 is adjusting the same sort of Q_() patterns I
thought it made sense to both show existing PRIuMAX use in those
macros, and how we do those casts.

Ævar Arnfjörð Bjarmason (2):
  gettext API users: correct use of casts for Q_()
  string-list API: change "nr" and "alloc" to "size_t"

 add-interactive.c           | 15 +++++++++------
 add-patch.c                 |  8 ++++----
 builtin/index-pack.c        |  2 +-
 builtin/receive-pack.c      |  9 +++++----
 builtin/shortlog.c          | 10 +++++-----
 bundle.c                    | 12 ++++++------
 commit-graph.c              |  8 ++++----
 mailmap.c                   |  7 ++++---
 merge-ort.c                 |  4 ++--
 string-list.h               |  3 ++-
 t/helper/test-run-command.c |  7 ++++---
 wt-status.c                 | 16 ++++++++--------
 12 files changed, 54 insertions(+), 47 deletions(-)

-- 
2.35.1.1241.gd8d69a17521

