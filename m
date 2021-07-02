Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D60C11F6A
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 09:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6465361410
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 09:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhGBKAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 06:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhGBKAK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 06:00:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BCDC061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 02:57:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l1so6273094wme.4
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 02:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O91GLh09fm4I+EAWUiM6sdxrJfS3YtM1cp0aK9WPlTI=;
        b=EpNF+esxZp8wGpR5Ao7ftYyX4itO6JGO6hMw8sQDz1z4v3RJs5CmElWAuRxp6wIoXm
         LD9EMcEE96zkkEennCYUCIvNfADnkGDzbkpx117hgqalSiskqN11uQk+/a2V0/FVDt+U
         wkQn8PFhxPGSqrEdgvga2PSMoppVQE9l2g7FsBTJOJIo6Jj2pENj7qqYdiHxulUJOuos
         qvSKoqtMySgI91Bj6x6ek7Ry5fdTsgH+sMCB3RtzT/gGi+apc/azPqJAWQFTNurpKdOw
         Mq/W3YnOSVgfrJGY4yu7f3tCz1l5jQjsk97kRKAW/gG231LYkVwEYOiTPMmrBaD4SUsD
         BccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O91GLh09fm4I+EAWUiM6sdxrJfS3YtM1cp0aK9WPlTI=;
        b=cQETa0/dilFasK4wHMJzSUhnw3HcNVjJPYBw85DKMEncXgQ/s+AI76R8TyuxIIDT6a
         NVu4JnOZvekZowyjImHAgGKhzXJHPz1IysNpl3Jth87Ir5+RDZcUPpLFkhJHSBLUEvXO
         /7NSUAla8s6iAAfOVH0HaujQsypv6+LmdL9paJiTICvNG459aN75xtZdRgu9TE+DmiL5
         ONMkR83PNZw0fNCGLkez1BWBDZPZHmWn2GfvPblnBmFuog3TQPFACtsGLuVzGCtOspJT
         c2Hs2s5zkK6tKHTnl3DG4kO+DbYmugE2Sxi8c1JfS2mTFD0A7jsVps68E44FqOsIi9iz
         XHqA==
X-Gm-Message-State: AOAM53093yk8XJ42CQUqw46AaiLgQ/b5JcWyTforWXZ6N0V2JbTlwTzB
        QweC7FQaP2B57s+cZ7HMDYLoIL52XPJhwg==
X-Google-Smtp-Source: ABdhPJwUG/p6Fwh93W64OPqUGQ2vO2ogWu/sBC8OCiC2kosy7V+AyaFlJiY290Pbn9KhunNqBT4IBw==
X-Received: by 2002:a05:600c:221a:: with SMTP id z26mr4618848wml.45.1625219855918;
        Fri, 02 Jul 2021 02:57:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m6sm3307713wrw.9.2021.07.02.02.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 02:57:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/3] bundle.c: remove "ref_list" in favor of string-list.c API
Date:   Fri,  2 Jul 2021 11:57:29 +0200
Message-Id: <cover-0.3-00000000000-20210702T095450Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.632.g49a94b9226d
In-Reply-To: <cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This re-roll of v3 changes the discussion in the 1/3 commit message,
it incorrectly referred to SANITIZE=leak when I meant valgrind.

I also changed the bundle_header_init() pattern to use the same
"memcpy() a blank" as in my parallel series to do that more generally.

v3 at:
https://lore.kernel.org/git/cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (3):
  bundle cmd: stop leaking memory from parse_options_cmd_bundle()
  bundle.c: use a temporary variable for OIDs and names
  bundle: remove "ref_list" in favor of string-list.c API

 builtin/bundle.c | 74 ++++++++++++++++++++++++++++++------------------
 bundle.c         | 64 +++++++++++++++++++++++++----------------
 bundle.h         | 21 +++++++-------
 transport.c      | 10 +++++--
 4 files changed, 104 insertions(+), 65 deletions(-)

Range-diff against v3:
1:  3d0d7a8e8b5 ! 1:  8e1d08113e5 bundle cmd: stop leaking memory from parse_options_cmd_bundle()
    @@ Commit message
         about those fixes if valgrind runs cleanly at the end without any
         leaks whatsoever.
     
    -    An earlier version of this change went out of its way to not leak
    -    memory on the die() codepaths here, but that was deemed too verbose to
    -    worry about in a built-in that's dying anyway. The only reason we'd
    -    need that is to appease a mode like SANITIZE=leak within the scope of
    -    an entire test file.
    +    An earlier version of this change[1] went out of its way to not leak
    +    memory on the die() codepaths here, but doing so will only avoid
    +    reports of potential leaks under heap-only leak trackers such as
    +    valgrind, not the SANITIZE=leak mode.
    +
    +    Avoiding those leaks as well might be useful to enable us to run
    +    cleanly under the likes of valgrind in the future. But for now the
    +    relative verbosity of the resulting code, and the fact that we don't
    +    have some valgrind or SANITIZE=leak mode as part of our CI (it's only
    +    run ad-hoc, see [2]), means we're not worrying about that for now.
    +
    +    1. https://lore.kernel.org/git/87v95vdxrc.fsf@evledraar.gmail.com/
    +    2. https://lore.kernel.org/git/87czsv2idy.fsf@evledraar.gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
2:  e47646d3a98 = 2:  5ce376682b3 bundle.c: use a temporary variable for OIDs and names
3:  f1066ee1b9a ! 3:  3e5972e4184 bundle: remove "ref_list" in favor of string-list.c API
    @@ Commit message
         Before this the add_to_ref_list() would leak memory, now e.g. "bundle
         list-heads" reports no memory leaks at all under valgrind.
     
    +    In the bundle_header_init() function we're using a clever trick to
    +    memcpy() what we'd get from the corresponding
    +    BUNDLE_HEADER_INIT. There is a concurrent series to make use of that
    +    pattern more generally, see [1].
    +
    +    1. https://lore.kernel.org/git/cover-0.5-00000000000-20210701T104855Z-avarab@gmail.com/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/bundle.c ##
    @@ bundle.c: static struct {
     -	oidcpy(&list->list[list->nr].oid, oid);
     -	list->list[list->nr].name = xstrdup(name);
     -	list->nr++;
    -+	memset(header, 0, sizeof(*header));
    -+	string_list_init(&header->prerequisites, 1);
    -+	string_list_init(&header->references, 1);
    ++	struct bundle_header blank = BUNDLE_HEADER_INIT;
    ++	memcpy(header, &blank, sizeof(*header));
     +}
     +
     +void bundle_header_release(struct bundle_header *header)
-- 
2.32.0.632.g49a94b9226d

