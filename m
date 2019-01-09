Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2905B1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 02:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfAIC70 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 21:59:26 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:56551 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIC7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 21:59:25 -0500
Received: by mail-yw1-f73.google.com with SMTP id t17so3151655ywc.23
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 18:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6o19fcX2qfeKaFkbkTorxkRTCVuQo6CgaPTBewFpDE4=;
        b=FCG6AgRvdnu8RavXnI88eppC9QZfD2E3znZK65eoRpr9HrCSypWgozO2BeZJr4CjSw
         hu3//KefwkDoiscOxx2eY40sxakYbY+q1ZNZL9QU2CBZKDs/hYwdiRr0QAamxGnhpYEE
         BjC2ajwDsUFpBlAEjnN8KZ6yY7dTHKV6kykYTAqSYRNFYofPdx1soisn9O3Lm2Tws1xT
         uK5+ONBqh15w3yPSNSdi55IWI/867oeCKFk6M7z41ZOKxE2Td3mfO2xnSGmNOmEN0OCh
         vyCQz1RVnuC/SY74pMOWNH+a/nnnFZJLKP0COyT9B0ilDLibv2bHCuebSjMl75Z06rXH
         lGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6o19fcX2qfeKaFkbkTorxkRTCVuQo6CgaPTBewFpDE4=;
        b=rR37oCDT7kNRCIQITpa9Y91hE13bKkuwZJI7YtsWvl2/9gQ6R545dfOhpUEDE+0feL
         /ivc2apwMxevMohvaREGhcRltOjyseUEOfm2zBIYHYpsB6ZuWBxrqJ39G4SjSyJsdTPQ
         kp6zGwPSg9iFkIOBCuYgUpdJy+mRhSuqUH5JmZmD5tTZkdXZ0pHoln1wPR4XErypoMit
         5wPV4lvzZxVgwVHhZVl2+ae0OXge1njHPAbVeggL6q62POvTg3D7ETwAqv41JFRgSklV
         Sq/hvUytAGdxn+zGQ66HIeRfsKmpyBZdXZfvf/mTnUdzS2LZXyRJwOxqHsEQ2t1dTsqj
         P1tA==
X-Gm-Message-State: AJcUukdFKrl9XkjXrP08YJotfAAKdHtavfNHdlBFit5p7bvgxZxZCwAL
        SsL9+myfUAW2abt7t2CkhcWE8OPZqPlFr1spRa1SrHD40/MEIzrGWODLn/hFKTyvC40BhYj6agy
        2b4jOghKI+9jM9VxOu9EPscvvLgNakbrHKKxaP3C3LREaxfafQbH1D1WnLe8=
X-Google-Smtp-Source: ALg8bN47vaby4AOro9ZzSaeIWY1nMPXap6GgztmtOIOYtlzBD8XYarQb4PuLT1i80wIes2SXxWy+cSHS2Hsy
X-Received: by 2002:a25:6b42:: with SMTP id o2mr2272240ybm.19.1547002765065;
 Tue, 08 Jan 2019 18:59:25 -0800 (PST)
Date:   Tue,  8 Jan 2019 18:59:12 -0800
In-Reply-To: <20181210234030.176178-1-matvore@google.com>
Message-Id: <20190109025914.247473-1-matvore@google.com>
Mime-Version: 1.0
References: <20181210234030.176178-1-matvore@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v3 0/2] support for filtering trees and blobs based on depth
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com,
        pclouds@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This applies suggestions from Jonathan Tan and Junio. These are mostly
stylistic and readability changes, although there is also an added test case
in t/t6112-rev-list-filters-objects.sh which checks for the scenario when
filtering which would exclude a blob, but the blob is given on the command
line.

This has been rebased onto master, while the prior version was based on next.

Thank you,

Matthew DeVore (2):
  list-objects-filter: teach tree:# how to handle >0
  tree:<depth>: skip some trees even when collecting omits

 Documentation/rev-list-options.txt  |   9 +-
 list-objects-filter-options.c       |   7 +-
 list-objects-filter-options.h       |   3 +-
 list-objects-filter.c               | 122 +++++++++++++++++++++++-----
 t/t6112-rev-list-filters-objects.sh | 122 +++++++++++++++++++++++++++-
 5 files changed, 235 insertions(+), 28 deletions(-)

-- 
2.20.1.97.g81188d93c3-goog

