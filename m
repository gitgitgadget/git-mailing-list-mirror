Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3240C4332D
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9415B61606
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhBRMfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhBRLIm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 06:08:42 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863B1C061574
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:44 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v1so2442863wrd.6
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pPvLMTrnIy4/LP65MPzkONF17MZ/QjkK6o4etkcYwzE=;
        b=FZo738IM0q5IKqgzk64cC4uGjfbcXIrvJcG5bx9TafjXtE06xdRn1wptR0BS5JwBxi
         yUp+vpGOT2q37DN+eLZS0axbyp+1fxz/RQMthlIVPWHad8xh0tjhd+uMCncTmfk4fCrr
         I1volFxUjIRUIVeMTH7m5j68OzBjLU3wCffCT7rI/sw1n6+zm8IMbq6bg0QKs7DKtV+Q
         Qywu0stNsP1jaqWpsW3TE4Maz08gij3VEfh6rvjpyhVgqJWEs3ejv41Ppp5EtZXFGtq0
         rmmuJ8lEnJ2QOc8Vc+kgEnKQKj/jlHK/T3p0DhXQiLjYWL1L9X9uhL3J4KLem9hygcmu
         lGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pPvLMTrnIy4/LP65MPzkONF17MZ/QjkK6o4etkcYwzE=;
        b=qb3mBhOwA0Pdnj37EkOR5hdT5K+gD33a7w/B5DbHFyB6w4byUXwDFMtKj7Pgq4PJf6
         FLyVLg9W82bzMVCy0VdFsMXLiZsLGegkSxK+DB0i69HKg2PEl/D/3nxGIUQwuZmPpIBO
         UEKsGy2En/cIAlOg1V/TrKdw5BAlhFeBVBuxbT6Jy3KS60cC0Kag44WoAfgQjHqyo6e9
         +ruodaVVNrBSEX6CO1BedF7lxqPZH5ZvlDp74o9hRUsiu5LaH1zcQK2Ofz5wZ+2+T7kl
         DBw4eVuCnPw3JHei84rxN3sU6MNw6sHfGCXuPqCSBXR17MTaX1OXw9SszWJl3Lma2MUq
         JPhg==
X-Gm-Message-State: AOAM532/1lvtz781x2dySMxiIKZ2OFMD6VxI9KFKqw5Uqlz5jBr1ATmA
        osudcX/sumclq1NURuHUlUIa8dqBoTh7pQ==
X-Google-Smtp-Source: ABdhPJw7MYI2XgFeS/AqiJHeGsBgNmoUL6CG1aeFrQI68kQ0YPxljaacQYnu5vP5rJ1llCeqMqoAnQ==
X-Received: by 2002:a5d:5246:: with SMTP id k6mr3698777wrc.7.1613645922848;
        Thu, 18 Feb 2021 02:58:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm8604376wrn.11.2021.02.18.02.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 02:58:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/10] fsck: API improvements (no conflicts with 'seen')
Date:   Thu, 18 Feb 2021 11:58:30 +0100
Message-Id: <20210218105840.11989-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210217194246.25342-1-avarab@gmail.com>
References: <20210217194246.25342-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As suggested in
https://lore.kernel.org/git/87zh028ctp.fsf@evledraar.gmail.com/ a
version of this that doesn't conflict with other in-flight topics. I
can submit the rest later.

Ævar Arnfjörð Bjarmason (10):
  fsck.h: indent arguments to of fsck_set_msg_type
  fsck.h: use "enum object_type" instead of "int"
  fsck.c: rename variables in fsck_set_msg_type() for less confusion
  fsck.c: move definition of msg_id into append_msg_id()
  fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
  fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
  fsck.c: call parse_msg_type() early in fsck_set_msg_type()
  fsck.c: undefine temporary STR macro after use
  fsck.c: give "FOREACH_MSG_ID" a more specific name
  fsck.h: update FSCK_OPTIONS_* for object_name

 builtin/fsck.c           |  5 ++--
 builtin/index-pack.c     |  3 +-
 builtin/mktag.c          |  3 +-
 builtin/unpack-objects.c |  3 +-
 fsck.c                   | 60 ++++++++++++++++++++--------------------
 fsck.h                   | 26 +++++++++--------
 6 files changed, 54 insertions(+), 46 deletions(-)

Range-diff:
 -:  ----------- >  1:  88b347b74ed fsck.h: indent arguments to of fsck_set_msg_type
 1:  1a60d65d2ca !  2:  868eac3d4d1 fsck.h: use use "enum object_type" instead of "int"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    fsck.h: use use "enum object_type" instead of "int"
    +    fsck.h: use "enum object_type" instead of "int"
     
         Change the fsck_walk_func to use an "enum object_type" instead of an
         "int" type. The types are compatible, and ever since this was added in
 2:  24761f269b7 =  3:  f599dc6c8f3 fsck.c: rename variables in fsck_set_msg_type() for less confusion
 3:  fb4c66f9305 =  4:  33f3b1942c1 fsck.c: move definition of msg_id into append_msg_id()
 4:  a129dbd9964 =  5:  28c9245e418 fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
 5:  d9bee41072e =  6:  d25037c6f18 fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
 6:  423568026c3 =  7:  66d0f1047cc fsck.c: call parse_msg_type() early in fsck_set_msg_type()
 7:  cb43e832738 =  8:  7643a5bf211 fsck.c: undefine temporary STR macro after use
 8:  2cd14cb4e2a =  9:  7c64e2267ce fsck.c: give "FOREACH_MSG_ID" a more specific name
 9:  1ada154ef23 <  -:  ----------- fsck.[ch]: move FOREACH_FSCK_MSG_ID & fsck_msg_id from *.c to *.h
10:  c4179445f22 <  -:  ----------- fsck.c: pass along the fsck_msg_id in the fsck_error callback
11:  c1fc724f0e8 <  -:  ----------- fsck.c: add an fsck_set_msg_type() API that takes enums
12:  8de91fac068 = 10:  a98a3512629 fsck.h: update FSCK_OPTIONS_* for object_name
13:  29ff97856ff <  -:  ----------- fsck.c: move gitmodules_{found,done} into fsck_options
-- 
2.30.0.284.gd98b1dd5eaa7

