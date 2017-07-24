Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3AB31F89D
	for <e@80x24.org>; Mon, 24 Jul 2017 08:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753067AbdGXIU4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 04:20:56 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36641 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753020AbdGXIUu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 04:20:50 -0400
Received: by mail-wr0-f195.google.com with SMTP id y67so16035249wrb.3
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 01:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=LXoHH4ZN9Gqd5wsHI21FRkfk8q0M+6HULh04IYyCd1c=;
        b=UBTGyE9BgJ2QEJQsz+jHR4DsAYCHhgWT4hMJfMA7S/5hNjBSame6o9SwflOhrCWwQ4
         h7n5wTsqHrKoBGneBX8yA+UHSBJ/nuICdrDn/9FSPRmmdDuTxuhIyWsUAG8nAqznYVCW
         kF1iRUdeXs5QotYOedoSmdAEEdT7PnuFxJGQLCSnx2dUQjUBlKSkyCYh8Bq7ZC5hJFDR
         KLAEWPB45+o8wWYAVAM9fs2RR2wtyaaG+jSEVaNq2CQkjvLrpLvWF3swWmqUwfbAfAyF
         DnkOLVwRuncUiRax1wv5qut33RJI/809DeJquM4IJ7SMkBWYTCtxn++4ASt7e0qHrMoC
         JWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=LXoHH4ZN9Gqd5wsHI21FRkfk8q0M+6HULh04IYyCd1c=;
        b=AUgFyJTivrInabggwAduia5JCrKQXxlHyVry2pLTD0kmy7xrLolEFftyFTl6cMzyxi
         k6E67pqELFPB2U1c1/OpsFOEJpAIUZQCUkMgKPFkzVNiCDnFg6It5P9xCBFiuGW29pfz
         GKH6vG9nOFGjHiGvDLXxx0s67JL9lW6U+hqv7XGSI6lyrF/LtOU+EtoBpE3zFMaehgVp
         YML6K5tWr8aImL+GzKT9ms9hvlKSqANtNPR3IIznc2MDMBGATI2pYaYyWCOdcP5xHKvJ
         PuUFdG18qPOsGJnmbTW2beWM4PVVfMDwb2OQUcV2KqaMwXShqhNuMeXbIIvcVxY7WyqC
         qjkQ==
X-Gm-Message-State: AIVw113rM6dUP3u2L+MdnGQswQGtae20LgCo6QaBp5Zi6WfdU4Ecd704
        84vCiZGtZb7CYGiV+yk=
X-Received: by 10.223.139.134 with SMTP id o6mr14837621wra.207.1500884448681;
        Mon, 24 Jul 2017 01:20:48 -0700 (PDT)
Received: from donizetti.redhat.com (94-39-195-172.adsl-ull.clienti.tiscali.it. [94.39.195.172])
        by smtp.gmail.com with ESMTPSA id 16sm1212191wrx.26.2017.07.24.01.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jul 2017 01:20:46 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 0/3] interpret-trailers: add --where, --if-exists, --if-missing
Date:   Mon, 24 Jul 2017 10:20:41 +0200
Message-Id: <20170724082044.26199-1-bonzini@gnu.org>
X-Mailer: git-send-email 2.13.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

These options are useful to experiment with "git interpret-trailers"
without having to tinker with .gitconfig (Junio said git should ahve
done this first and only added configuration afterwards).  It can
be useful in the case where you want a different placement for the trailer,
or for scripts/aliases that don't want to rely on specific .gitconfig
settings.

Compared to v2, the main change is that option order on the command-line
is respected.  That is,

	--trailer 'acked-by: foo' --where end --trailer 'signed-off-by: me'

will only apply where=end to the second trailer.  Likewise,

	--where end --trailer 'signed-off-by: me' --no-where \
	--trailer 'acked-by: foo'

will only apply it to the first, reverting to trailer.*.where for the
"acked-by" trailer.

Paolo

v1->v2: support --no-* options, minor code fixes

v2->v3: largely rewritten to respect option order on the command-line;
	keep trailer.h namespace clean (Christian)

Paolo Bonzini (3):
  trailers: export action enums and corresponding lookup functions
  trailers: introduce struct new_trailer_item
  interpret-trailers: add options for actions

 Documentation/git-interpret-trailers.txt |  24 +++++++
 builtin/interpret-trailers.c             |  73 ++++++++++++++++++--
 t/t7513-interpret-trailers.sh            |  66 ++++++++++++++++++
 trailer.c                                | 113 ++++++++++++++++++-------------
 trailer.h                                |  43 +++++++++++-
 5 files changed, 267 insertions(+), 52 deletions(-)

-- 
2.13.3

