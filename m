Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0743CA100D
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 20:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243802AbjIEUgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 16:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241436AbjIEUgr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 16:36:47 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D961CE
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 13:36:39 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58cbdf3eecaso28099567b3.0
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 13:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1693946198; x=1694550998; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vcSETnIdd8s4NxZiPJYoH/3BgpiFJSRMsCaTDhpiLk8=;
        b=x+0gj8QHcjSNLvExASG27Ym1S2OcULGXCUMeO47WiGGyWorzgo/wJ3xQHwREcCTGTe
         4YxOffz1tli3xdpjlSCFPGo0YbFnjuSXddYe+mCWITusIjq2fbcX/Vz/CC7VH7OPI2an
         EkyFSikCVFdXAbu47JPd01CwcBLCy85ooalJu91y4ITF9aDmvdCcF68PDs5dk8WBzx5J
         q9Nyzl7baoU9tqZhk49YsO8cSHWFb1M3oHmiqJkzgnvn1h5zKX4A1BWyGBK01G++G07a
         q3SMlNElKzkOcdArqUI40xNWJU59McZep02y82i+vBAdufziXRWarRJGc7xqDOcUJCD0
         bzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693946198; x=1694550998;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcSETnIdd8s4NxZiPJYoH/3BgpiFJSRMsCaTDhpiLk8=;
        b=bOYr64266v3pZ5sS0TddiPfBXfU/1rSpB+nGNOURddmllJJ4NlEbiJdVjkGCl7tWNj
         kGVRNQUYgv9hHu0a+tLJ2JR4PSB9ZxdCEcYZ2VxgVAi7mTaFDFy2YtKKxV+ktkmyUw9l
         2WMr2Hgnz5dsDnw50kjk2wCTRU/zAFC+ih6gi555yS/tcdQ/FqMPAXrrz1Ay//QQIBzy
         f5p16JUt1QKqEtV8lkL8c+n/fSVuspuleatfPaPgzwBYeZFvHyUE3y8FPj0OfyWVzUfg
         gcObnf0N0EqCi7EZaU6fpErXKMVqxKKKb+v9vZ+FQYbo0x+tzxeqkYOtCPVZ0MwtN3db
         X0hA==
X-Gm-Message-State: AOJu0YyWZK4NuSznsfMhLlHNPkJqO5om34ED3zPKvvz8nKtRy9xpoxlF
        XYtoTgcC28hHIXvEa03XIs7GaWqAzXSvtJ0PlrfGEA==
X-Google-Smtp-Source: AGHT+IFH+YDmshKNxJyEjTFO3M3YL3S3mN12d/2es7EYlieXdd9aezrDv5fFjD3CLc6SxzstRmbPLQ==
X-Received: by 2002:a81:a1d6:0:b0:583:c917:7ff0 with SMTP id y205-20020a81a1d6000000b00583c9177ff0mr13391413ywg.51.1693946198363;
        Tue, 05 Sep 2023 13:36:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z198-20020a0dd7cf000000b005925d7b62e0sm3343712ywd.24.2023.09.05.13.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:36:38 -0700 (PDT)
Date:   Tue, 5 Sep 2023 16:36:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/8] repack: refactor pack snapshot-ing logic
Message-ID: <cover.1693946195.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series refactors some of the 'git repack' internals to keep track
of existing packs in a set of string lists stored in a single structure,
instead of passing around multiple string lists to different functions
throughout the various paths.

The result is that the interface around pack deletion, marking packs as
redundant, and handling the set of pre-existing packs (both kept and
non-kept) is significantly cleaner without introducing any functional
changes.

I didn't mean to produce so much churn when I started writing these
patches, which began as a simple effort to rename a couple of variables
for more consistency.

Thanks in advance for your review!

Taylor Blau (8):
  builtin/repack.c: extract structure to store existing packs
  builtin/repack.c: extract marking packs for deletion
  builtin/repack.c: extract redundant pack cleanup for --geometric
  builtin/repack.c: extract redundant pack cleanup for existing packs
  builtin/repack.c: extract `has_existing_non_kept_packs()`
  builtin/repack.c: store existing cruft packs separately
  builtin/repack.c: drop `DELETE_PACK` macro
  builtin/repack.c: extract common cruft pack loop

 builtin/repack.c | 288 ++++++++++++++++++++++++++++-------------------
 1 file changed, 174 insertions(+), 114 deletions(-)

-- 
2.42.0.119.gca7d13e7bf
