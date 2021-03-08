Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B6DC433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8125B65260
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhCHUFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 15:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhCHUEn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 15:04:43 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B4DC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 12:04:42 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l12so12785333wry.2
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 12:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FocwDB1TD/a0PuxJF7NMmXeb4ZpYvEs4N9rqlz3mKpE=;
        b=BZznUoupucDnOKlSpvdXoHTq6Wp4SiH1nqWMcO2cIbbx3bv1hyjD2AZxXKhnNuZvaK
         51lNw+KtkL5WKO9Z/gJd5WyytxWz7dijQ69pZaTuec/U/tbcqn1r8RVtfPBsF4IYvR28
         O5oe+aR0+2QMDWy6+pJV+UjgOzfeivcS85AYSy85BYKlG6TfU7uwL3DZ4mb/OHXXMrFy
         uziHFNJoBT/k6RXJ/w9vmrgYvaF2xOjwgK8wKKtC/A106c2ikTEK0+pPJI6SUd4K056K
         qq9SYIZdFBAkbenkwnSHsgs+uIwpRLodLE9RjEwJnbINSMCCudKJutrEaSI12wOAC/zZ
         a1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FocwDB1TD/a0PuxJF7NMmXeb4ZpYvEs4N9rqlz3mKpE=;
        b=cFzG/Ll55f62F1coSO2X1cxgGVnv1SybmNRIVhtHW6r4bK8uyCIaYMMv2joh+sp67z
         Z2+d3FTl7xWu3J3HiDKnNEij41lNYE9eIbyj+ksAEf2CjZUuy8bHknxFe+W/KUx7ULJh
         fq7Eereyd96lKw28aqUA9Owv2YLa9+CYvJ7EyZDtbxGXMN2oo9+dp2zvijXsz4pxpoq5
         tVsh7tXJoQav6Jv0oiN1lk8OgE/HHWgJeje0pKFGG1VZl9UlMelJfaqtWkXtzsbB2sBu
         vsgs4NT6f/VxurVEC9xCXkv/zpGw/uIsAj0XzaGldGuxyJdNqwgzL7HoLrHoDtN7NoTf
         YvLQ==
X-Gm-Message-State: AOAM531zsILrHWQSViYcm5chEYWQlUUqx8dhPgvLLgQesJFS9HnIS2yu
        0TucRqdGLk6WSHyZoU01Ir8CEt/sQHAo3Q==
X-Google-Smtp-Source: ABdhPJzXQwD3dg2mMg0w+61udNd6LunxoD4U9c3r9c0x39RY7qNL4FcJ1mJ+taqlWsEV4eUbxN1QWA==
X-Received: by 2002:adf:f78f:: with SMTP id q15mr23661834wrp.383.1615233881282;
        Mon, 08 Mar 2021 12:04:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q15sm20790786wrr.58.2021.03.08.12.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:04:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/7] improve reporting of unexpected objects
Date:   Mon,  8 Mar 2021 21:04:19 +0100
Message-Id: <20210308200426.21824-1-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.210.g0f8085a843c
In-Reply-To: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have some errors that say "your OID %s is not a blob" or whatever,
now with 5/7 we'll say "object %s is a %s, not a %s" in most cases.

Then 7/7 fixes a regression which AFAICT is from 2005. So it's pretty
obscure. When you craft an invalid tag object saying an OID is a tag
instead of a commit, we'd buggily invert the two types when reporting
that error.

The solution to that in 7/7 may not be ideal, but is the best one I
could come up with, so feedback on that patch & this whole thing is
most welcome.

Ævar Arnfjörð Bjarmason (7):
  object.c: refactor type_from_string_gently()
  object.c: make type_from_string() return "enum object_type"
  oid_object_info(): return "enum object_type"
  tree.c: fix misindentation in parse_tree_gently()
  object.c: add a utility function for "expected type X, got Y"
  object tests: add test for unexpected objects in tags
  tag: don't misreport type of tagged objects in errors

 blob.c                                 |  16 +++-
 blob.h                                 |   3 +
 builtin/blame.c                        |   2 +-
 builtin/cat-file.c                     |   2 +-
 builtin/index-pack.c                   |  15 ++--
 builtin/mktree.c                       |   2 +-
 builtin/pack-objects.c                 |   4 +-
 builtin/replace.c                      |   2 +-
 builtin/tag.c                          |   2 +-
 builtin/unpack-objects.c               |   6 +-
 commit.c                               |  24 ++++--
 commit.h                               |   2 +
 fsck.c                                 |   4 +-
 object-file.c                          |  15 ++--
 object-name.c                          |  18 ++--
 object-store.h                         |   2 +-
 object.c                               |  62 +++++++++++---
 object.h                               |   9 +-
 packfile.c                             |   4 +-
 reachable.c                            |   5 +-
 t/t6102-rev-list-unexpected-objects.sh | 113 ++++++++++++++++++++++++-
 tag.c                                  |  14 ++-
 tag.h                                  |   2 +
 tree.c                                 |  27 ++++--
 tree.h                                 |   2 +
 25 files changed, 282 insertions(+), 75 deletions(-)

-- 
2.31.0.rc1.210.g0f8085a843c

