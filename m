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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FC7C43216
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 09:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B7961053
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 09:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243551AbhIAJVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 05:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243578AbhIAJVA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 05:21:00 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371A1C061760
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 02:20:04 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id p2so2983134oif.1
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 02:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SlKUDLfoH4z/bLGF2rRhDcu69U+sWQn3YUqA0ft8t18=;
        b=JIpp2hNxFmbWwFXAsRiZnGc7armM5btRH43CDy2Ck2zOQCSH5PodfMI7DqTZpcy7Va
         W/tz8p1TbW88vy6vtE4CakOxW6FWNcwMB4QSwnZt3nYz65wnigssv9yPvp7OTjkRkyOU
         hRYzY5nXzh0UxRUNGkhC4FcyPjaynltvhc+98sZSXKz+WDVJ/Ll4oFBFJy+r774sM6ot
         bJ/9UpCAn8U2YuugE6WCDzoamsYAUCPt2wEgPnirAYKe1qT/5K++alMD7DpSQ+oErdSe
         9fxcV1HVZULsR2l6Qb34PnOg8/ueWrccYJrOvF/s6Px+g6cbi3QmixRaHJ/dUx+/WWvz
         /wjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SlKUDLfoH4z/bLGF2rRhDcu69U+sWQn3YUqA0ft8t18=;
        b=dPadCKuXVBpjI4BBKpqbWaUG+nM6FNTzwRAzt/WPZt+Ocu0u0IvPtNYAcxRVzxNszb
         PxuuZC7iPP657jawDbUOBp5nHoMe50g27Xd8ktuxdyC8GrLtX8w3oVXlgOZpQ4RqZRHj
         5hMe3QQh5USLCS+VQ/xT3BFLSDCCgKyyVJSFDc3II7pL2ZxQex2DYZ8w8C4Hhnb9a5Ei
         7Ev6O+SyfdE/mUFG/X9OqNubkfChTrJFfm+SlIoKt6AmlOWTRFc9DH9NHe8vdBcB93P+
         Mn3+F6OaUJRew8aJxm9zgbJLmZUhepB+EYVg8tauAvVvcKMHoh8bXnVPXMKiZl+iGfb3
         0djw==
X-Gm-Message-State: AOAM531P6iN2Cq53anLo8H9uJD02uEONWa7ae39t+p6zM382yD6lBkql
        4aE80+mZWtGBxx3ujgNRkk4+9/+FLN8=
X-Google-Smtp-Source: ABdhPJyvBE+H+Iim9X6mpU+nwtu5UJd5unooSPqMfhBFubc+gb23EgQ4/Uhne9BQTw10ZA28zo6pSA==
X-Received: by 2002:a54:4f8a:: with SMTP id g10mr6479176oiy.81.1630488003155;
        Wed, 01 Sep 2021 02:20:03 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id s206sm4161597oif.44.2021.09.01.02.20.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Sep 2021 02:20:02 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, phillip.wood@dunelm.org.uk,
        gitster@pobox.com, mackyle@gmail.com, sunshine@sunshineco.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH v2 0/4] developer: support pedantic
Date:   Wed,  1 Sep 2021 02:19:37 -0700
Message-Id: <20210901091941.34886-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210809013833.58110-4-carenas@gmail.com>
References: <20210809013833.58110-4-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

WARNING: this will break CI with seen when merged and unless the
kwown pedantic issue still remaining from fsmonitor[0] is merged
first (expected to come in a reroll)

this series has a different subject than v1 and that is currently
tracked as cb/ci-build-pedantic, but is a reroll (even if it discards
all changes from v1) and was originally suggested by Phillip as an
alternative.

because of that, it might conflict with changes proposed by Ævar[2]
but that are still not in "seen" AFAIK and merges cleanly otherwise.

first patch was suggested[1] by Peff, so hopefully my commit message
and his assumed SoB are still worth not mixing it with patch 2 (which
has a slight different but related focus and touches the same files)
but since it is no longer a single patch, lets go wild.

patches 3 and 4 are optional and mostly for RFC, so that a solution
to any possible issue that the retiring of USE_PARENS_AROUND_GETTEXT_N
are addressed.

Carlo Marcelo Arenas Belón (3):
  developer: enable pedantic by default
  developer: add an alternative script for detecting broken N_()
  developer: move detect-compiler out of the main directory

Jeff King (1):
  developer: retire USE_PARENS_AROUND_GETTEXT_N support

 Makefile                                      | 22 +-----
 config.mak.dev                                |  7 +-
 detect-compiler => devtools/detect-compiler   |  0
 .../find_accidentally_concat_i18n_strings.pl  | 69 +++++++++++++++++++
 gettext.h                                     | 24 -------
 git-compat-util.h                             |  4 --
 6 files changed, 74 insertions(+), 52 deletions(-)
 rename detect-compiler => devtools/detect-compiler (100%)
 create mode 100755 devtools/find_accidentally_concat_i18n_strings.pl

[0] https://lore.kernel.org/git/20210809063004.73736-3-carenas@gmail.com/
[1] https://lore.kernel.org/git/YS7c3169x5Wk4PlA@coredump.intra.peff.net/
[2] https://lore.kernel.org/git/cover-v3-0.8-00000000000-20210831T132546Z-avarab@gmail.com/
-- 
2.33.0.481.g26d3bed244

