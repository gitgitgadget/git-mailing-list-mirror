Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61F8C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 11:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbiESLmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 07:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiESLmj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 07:42:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF05B227D
        for <git@vger.kernel.org>; Thu, 19 May 2022 04:42:38 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so2552051wme.3
        for <git@vger.kernel.org>; Thu, 19 May 2022 04:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5dzS3cEwWlFX5AzLinIUwNrzP9pY8WfEFDAPhaOiZJs=;
        b=PQLtG+3RIvkoTwYW0dJll3eknDnaT5exC98eVwDnZMk2cYy/3KZezIpB0R8eHacAAX
         zbe2yrtg+fuVDEaz//qyVtOQ5r4uQtRi25sU2ctPyUudZ4VRRPleD4Q92L6+W3yBGG8V
         6SGKkAt76S/cKrRXrL0cITLiacaYTYVpP7wslWFhG3bHNhYPW+xjVz5Smr3AWsyGbwrn
         8EEFsEAokdmOrLZ1ntyiRNGuH1AAAjbNpji9C9Qqomte0zroo6JW2pVki4VT5tZEICul
         evFvkmd0DZDusHcljpLRpyvdrsBwnRR9f3rNSQI+yxaFW6mDgsCmMe6eYNfSpIC6ygU6
         4utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5dzS3cEwWlFX5AzLinIUwNrzP9pY8WfEFDAPhaOiZJs=;
        b=f5zH/TREdf5Hs1WmZad78c0uiMGJQ+Q83IQGAbcPNes7rNCDBYvdCzzsyMBnkPEfP/
         Zecq3jauSxzWJCzIpqn5zriDgVTNrCQQbTZO01DUMPq/hZAuBYife7BL9cCG1mNeKv0r
         DJI1va7spUFryHFlvIzpKuPOGAplGEpiCnDebj+Am4o7thmd4+2cl0xDPwA825oCVlzb
         wceGC6Qz+Nd4ien0zexzf4D3n62g/Flf4S3QmCTZEE5/KBtvdGsPKvn6st/LDF2JIJci
         mX8Tk1IWps8GzdkcRPTXsiTs6R81jWsUR/9ChuMkUVBE2zI0M/9+wAU9+oeWK56SeX4O
         3e/w==
X-Gm-Message-State: AOAM533mvNbQ4NG9GcVI8i74U8vRX8o5i6eQltZ3zabFmQRTQ1YaGX7T
        VNyGE7yocf2qQ9i3imUNJtNVz6N6o36Hvg==
X-Google-Smtp-Source: ABdhPJyeRlUTuSgwmTOp4m1L0CApBWcNF+NUI82yRM6m+HxcWq3XvOS95ZzNEQHMyQ5sfFMUkFKEBA==
X-Received: by 2002:a05:600c:4f49:b0:394:8125:8b6 with SMTP id m9-20020a05600c4f4900b00394812508b6mr3902022wmq.80.1652960556670;
        Thu, 19 May 2022 04:42:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f25-20020a1c6a19000000b003942a244f45sm6561984wmc.30.2022.05.19.04.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 04:42:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        derrickstolee@github.com, jrnieder@gmail.com,
        larsxschneider@gmail.com, tytso@mit.edu,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 0/2] Utility functions for duplicated pack(write) code
Date:   Thu, 19 May 2022 13:42:26 +0200
Message-Id: <RFC-cover-0.2-00000000000-20220519T113538Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.952.g6652f7f0e6b
In-Reply-To: <cover.1652915424.git.me@ttaylorr.com>
References: <cover.1652915424.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Minor cleanups thath would semantically & textually conflict with
Taylor's
https://lore.kernel.org/git/cover.1652915424.git.me@ttaylorr.com/; but
which I noted while reading through it.

The 2/2 here is something I wrote before spotting
https://lore.kernel.org/git/1d775f9850f00b0c3d1e9133669a6365c8d7bbba.1652915424.git.me@ttaylorr.com/;
which does pretty much the same thing. but IMO it's better to put this
in hash.h than chunk-format.h.

The 1/2 then fixes the minor NEEDSWORK in that series:
https://lore.kernel.org/git/8f9fd21be9fcdda5c73d800fc66d1087d61a6888.1652915424.git.me@ttaylorr.com/

All of this can be ignored for now, I can submit it after cruft packs
land (if I remember), or if Taylor's interested in picking it up in
some way...

But I figured it was useful to send it along in liue of "maybe do it
this way" (2/2) or "can we just create a utility function for this?"
(1/2) comments on the series itself.

Ævar Arnfjörð Bjarmason (2):
  packfile API: add and use a pack_name_to_ext() utility function
  hash API: add and use a hash_short_id_by_algo() function

 commit-graph.c  | 18 +++---------------
 hash.h          | 26 ++++++++++++++++++++++++--
 midx.c          | 18 +++---------------
 pack-bitmap.c   |  6 +-----
 pack-revindex.c |  5 +----
 pack-write.c    | 12 +-----------
 packfile.c      | 14 ++++++++++----
 packfile.h      |  9 +++++++++
 8 files changed, 52 insertions(+), 56 deletions(-)

-- 
2.36.1.952.g6652f7f0e6b

