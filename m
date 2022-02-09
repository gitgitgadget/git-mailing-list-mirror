Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51668C4321E
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 02:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344690AbiBICl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 21:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243061AbiBIB34 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 20:29:56 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB6FC061576
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 17:29:55 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id d3so671847qvb.5
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 17:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nHv3H+yRIQSeZjnIpvFNmSz4Zowa5stZjqJ41e1lU7g=;
        b=D/jIneoZtwC8K/eMSlLwKj5D5V/r0wFS7g6U9g0uz/wo4liOywOzEA1uCAdW8Fyif3
         7NcVsrpcs0eNpxOO7L+G9/TT780SAG/VBFLIILElYnGTvbvWHUB8D7ZWRZM3fGW9yhbZ
         0ZUl1+NR0qDdlQSNyN+gaA/EddSDw+jIvvTNKWVj0js3eWCW+AMjpVb9SBM7GdRZkS6H
         cNOrVZmiBxbrvIdy1O9cqdVAOZ4adC76UTrDZGUUFgfKFvEmeDFKheNwgXdqYWpQVWkq
         jRFBQB3CSdipVUI69PVhyiF16OiWL+8IQ1XJ5AXhJKeyvVPwLD4glBtS7xulSy1rI4Kt
         zy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nHv3H+yRIQSeZjnIpvFNmSz4Zowa5stZjqJ41e1lU7g=;
        b=7ZMHB15MAaxSRI3Op8oYIC/6Rlzo4CyXdfwrAky87MgQqRMywAH9ChyQxHcGUrql+h
         yBek+r8FgEte8eSUsPX002TG/9qsiMAc1UglGmJ22LrG0nkxACIB+2QJ1613kauegF+r
         7WtRePnvDIgd0guaNHo0I1/1LeNSy21eziRjYtvWSRn0ewzmzoZCl0NzRdeg1NEDLOOG
         KHlEGZ9ofsuMqIY88k5k1bZaIB25/vwIlBCz4a5TRTdT44+9S85O7C8Y1j0fbqmFlRqk
         6Fe4gUED3DU2m+v1l8NJrotgHWTwICzljreuUyMx0EMa3YFrC1Ps+1Yh6USabX5kVYCz
         GU8g==
X-Gm-Message-State: AOAM530zPhIXVrHbSz5Wk7TvJST14p/wKK94RVa7nGYorxNH6DSjrV/h
        ydPFBEDf41xJMa0xIk74SAv65HbJqDBv98EB
X-Google-Smtp-Source: ABdhPJzK7ebwjLverRwSTcSokaPme7Xy/PGFBJkb3Knn3dhGagoqAvYDNjHwqSV1PBUV5ou9HtnR/w==
X-Received: by 2002:a05:6214:dcb:: with SMTP id 11mr35550qvt.15.1644370193921;
        Tue, 08 Feb 2022 17:29:53 -0800 (PST)
Received: from abe733c6e288 ([50.234.189.46])
        by smtp.gmail.com with ESMTPSA id l202sm7754794qke.66.2022.02.08.17.29.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Feb 2022 17:29:53 -0800 (PST)
Date:   Wed, 9 Feb 2022 01:29:51 +0000
From:   Edward Thomson <ethomson@edwardthomson.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de
Subject: [PATCH 0/1] xdiff: share xdiff between git and libgit2
Message-ID: <20220209012951.GA7@abe733c6e288>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello from libgit2, where we borrowed your xdiff a few years ago and
have watched as we both hacked on it independently.  (For us, mostly it
was around tightening some things up around warnings and signed/unsigned
mismatches.)  However, we'd love to share a common xdiff implementation,
and we're happy if git is the home for that.

The next patch adds an indirection point, `git-xdiff.h`, that contains
the git-specific functionality in xdiff.  This keeps the core of xdiff
to standard functions.  Other xdiff users, like libgit2, can specify
their own compatibility functions in this header file.

I hope that this allows us to make progress on a common xdiff; we'd love
to go back to building it without warnings, but we'd like to not do that
in isolation.

Cheers-
-ed

Edward Thomson (1):
  xdiff: provide indirection to git functions

 xdiff/git-xdiff.h | 14 ++++++++++++++
 xdiff/xdiff.h     |  8 +++-----
 xdiff/xdiffi.c    | 20 ++++++++++----------
 xdiff/xinclude.h  |  2 +-
 4 files changed, 28 insertions(+), 16 deletions(-)
 create mode 100644 xdiff/git-xdiff.h

--
2.35.0

