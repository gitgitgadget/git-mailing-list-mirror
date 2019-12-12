Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF0CC43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 00:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E852173E
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 00:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1igV7wz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfLLAso (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 19:48:44 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36073 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfLLAso (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 19:48:44 -0500
Received: by mail-pf1-f193.google.com with SMTP id x184so177725pfb.3
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 16:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dA1dUrHbtjFKD5V4yGF8PX/14Ex3j7sMjvO+4vA+zH4=;
        b=a1igV7wzAHtU55PN3gQuSLSc8lY22R/5aSi2Qr5+tw67re38PZbwb8nEreKVkvpSzg
         JQl07nRSQJKtN/TMos53IXvEgIb9l8S358Cum6LwMj3MOCWyvLvHa33ao3zUCjR5Yuwc
         busfg4851P5LQAod0Um9hp74YSHpWlFOIBjZqqZUTTXBtmQzZB4bBI0ZLbtMq1srbPYL
         2yYj5y35tFwXc2hyuD+cu8qv3zLk57qWk0vlv8i+cGxdOwkXMPo7hagJotH/coagOGTv
         QPwqi38JVSmt1JBLW0cJSJQ10SEt0S3owc9EY4ixS6h/IBP1RVrtT7B7S2AGF2iy+9tn
         wXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dA1dUrHbtjFKD5V4yGF8PX/14Ex3j7sMjvO+4vA+zH4=;
        b=ax03tHMLJR+bn8cjmpeuVCHGPbIe6RHrPaf/nFRgI4LIiWTKutVhf2pbilSCMNMUPO
         rdC+07OmUh1gffu1QDYl+r+EDElb574sT6Hu7OnJ1W2ieI16Pmqflu6SZvRQqlC+w/Ub
         QfXvkqFJ9uZ/EVcm7fyYyIdntr7uahGeakcnYXTmuuO5dfZTBEcTIhe2CF0x9/nGeWVi
         A/Z2eLCfraTLEowXCOWjuaXsfy2PID0JhkfZAlGPWnxTdVBDyIN2IbVrrz/H1dEbAM2M
         V4d7OCpQqF3t6mc/I0Pnk2SzyMTmsYB+cJSONtZQio+gBeUJ79oZC+SxSUx1Wpc/Sf7z
         ptKw==
X-Gm-Message-State: APjAAAXqAWqEL4JQ2v0BzyGcocZq3VyD3RqC2Rg2jEyLK0Pr66EdYOuX
        kaJCAHr5mpztdtilv8CMs4VKML7q
X-Google-Smtp-Source: APXvYqyUK/CXpPEuIA8PxByw1Ce0SRs2A1jvSsvR6kFkkKlF7HGmzgQfrW3g8GpSBChHok70Xe/tcQ==
X-Received: by 2002:a63:12:: with SMTP id 18mr7390609pga.294.1576111723588;
        Wed, 11 Dec 2019 16:48:43 -0800 (PST)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id d77sm4720468pfd.126.2019.12.11.16.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 16:48:42 -0800 (PST)
Date:   Wed, 11 Dec 2019 16:49:44 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH 0/2] dl/format-patch-notes-config-fixup: clean up some
 leftoverbits
Message-ID: <cover.1576111643.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series gives 'dl/format-patch-notes-config-fixup' a few polishing
touches. First of all, we document the behaviour of multiple
`format.notes` configuration variables so that end-users are aware of
the change.

Also, Eric Sunshine suggested some cleanup in the previous round, like
breaking the monolithic set_display_notes() into multiple smaller
functions and not using the return value of the function to assign to
`show_notes`.

Denton Liu (2):
  config/format.txt: clarify behavior of multiple format.notes
  notes: break set_display_notes() into smaller functions

 Documentation/config/format.txt | 18 +++++++++++++-
 builtin/log.c                   |  7 +++++-
 notes.c                         | 43 ++++++++++++++++++---------------
 notes.h                         | 19 +++++++++------
 revision.c                      |  6 ++---
 revision.h                      |  2 +-
 6 files changed, 62 insertions(+), 33 deletions(-)

-- 
2.24.0.627.geba02921db

