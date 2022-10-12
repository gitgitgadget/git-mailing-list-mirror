Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB472C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 13:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJLNwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 09:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJLNwI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 09:52:08 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C755FC8230
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 06:52:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a3so26398781wrt.0
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 06:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=11iKUEFGjFPu07XdNlh5rmvUPpoklPgvQpzKLU69fEE=;
        b=N+ocSEdhYt74OVBy0qI5pLVry+QZ4uzYUM8lom8ZRTLSZgN0mfxWsDdyXKMkZ0Omqh
         kVtCVz5d2nY4HXD2DiknP4HvYbJnbbfZjQzO6hPuwZZw6LE2Z0/WX4QWr+oPX3GJO1rA
         Nw4BCp+4mx+x3xx7Nd5lMEb4MXiZfd8au+b16Fh5Vr0MNxQTROzUuK//tbGy6pPV5uaZ
         g7ORvgicy/YlY/apWKcxgRtqWWITYsPlGDyI84urTip74k1cVKaOvuyUvWi544cMH/wF
         V2sxl1VungkfL28sirJyNe96kHZ4D2DpLa+F1J63ZWr5WEbioDzw0oDuzR41lDhX9fYN
         opmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11iKUEFGjFPu07XdNlh5rmvUPpoklPgvQpzKLU69fEE=;
        b=0QaRA5KOgR8SqjeJQQggmPZCzqnqC9obZlvbQMB44WrOFDuf0CZycblfwV7C5kZDz3
         evCNA2IG2cTZSO4n9gCtJlaC7zeH4hBXvdEqim+b7LpYR+YI3XiDOAHbyP5Ti1QYLtHe
         gTJowesJpabeOTPeo4GlYvRSp1tR6/qzYa4O5CzUsXDBlMm8RDVcjrk9kRyjpZyPK3Hv
         VzH0POETirf9UBGU3/kg4lu6rq/zG8/THjxB2JmRbQC95xwFtMB7Oo01Is+ZJNLE2Iw+
         pmVpXjTSWbtnMbIYjET9yf1ibvodDBGrceruqZUJCyeLvhQ9JTDdkpLLsW4bKXgr2GZ2
         o2BA==
X-Gm-Message-State: ACrzQf25Sdz/0oIKP/FECGKafk58CQit7Ga3O7YxdDiZkYfFzzGhfiA4
        Xj0ALCZCcWFUn7ZyzqQK+npgVo8oj8k=
X-Google-Smtp-Source: AMsMyM5cbwcGC8YjqbJILqF2lP7xphWEZaT4PXvT9Z0ZbTCq37lPVDw6ErdqCGlrx4YDelBp8mo2dQ==
X-Received: by 2002:a5d:648b:0:b0:22e:ee60:db37 with SMTP id o11-20020a5d648b000000b0022eee60db37mr17145971wri.116.1665582724922;
        Wed, 12 Oct 2022 06:52:04 -0700 (PDT)
Received: from Precision-5550.. ([2a01:e0a:595:6400::ae22:851d])
        by smtp.gmail.com with ESMTPSA id m5-20020a056000180500b0022f40a2d06esm11396284wrh.35.2022.10.12.06.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 06:52:04 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/3] Implement filtering repacks
Date:   Wed, 12 Oct 2022 15:51:11 +0200
Message-Id: <20221012135114.294680-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.38.0.4.g7f9724c7bf.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier this year, John Cai sent 2 versions of a patch series to
implement `git repack --filter=<filter-spec>`:

https://lore.kernel.org/git/pull.1206.git.git.1643248180.gitgitgadget@gmail.com/

We tried to "sell" it as a way to use partial clone on a Git server to
offload large blobs to, for example, an http server, while using
multiple promisor remotes on the client side.

Even though it is still our end goal, it seems a bit far fetched for
now and unnecessary as `git repack --filter=<filter-spec>` could be
useful on the client side too.

For example one might want to clone with a filter to avoid too many
space to be taken by some large blobs, and one might realize after
some time that a number of the large blobs have still be downloaded
because some old branches referencing them were checked out. In this
case a filtering repack could remove some of those large blobs.

Some of the comments on the patch series that John sent were related
to the possible data loss and repo corruption that a filtering repack
could cause. It's indeed true that it could be very dangerous, and we
agree that improvements were needed in this area.

To address this, in the patch 2/3 introducing --filter, we warn users
launching such a repack on the command line and ask them if they
really want to do it. If such a repack is not launched from a
terminal, we die().

A new patch 3/3, though, introduces --force to allow users to launch
such a repack without a terminal and without having to confirm it on
the command line.

Patch 1/3 is a preparatory patch.

In short, this small patch series tries to reboot the previous one
with a focus on the client side and a focus on safety.

Thanks to John Cai, who worked on the previous versions, and to
Jonathan Nieder, Jonathan Tan and Taylor Blau, who recently discussed
this with me at the Git Merge and Contributor Summit.

Christian Couder (3):
  pack-objects: allow --filter without --stdout
  repack: add --filter=<filter-spec> option
  repack: introduce --force to force filtering

 Documentation/git-repack.txt | 17 ++++++++++++++
 builtin/pack-objects.c       |  6 +----
 builtin/repack.c             | 44 ++++++++++++++++++++++++++++++------
 t/t7700-repack.sh            | 20 ++++++++++++++++
 4 files changed, 75 insertions(+), 12 deletions(-)

-- 
2.38.0.4.g7f9724c7bf.dirty

