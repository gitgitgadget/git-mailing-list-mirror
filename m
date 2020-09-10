Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E8FC433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 129CD20882
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGAgC8um"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgIJTGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgIJTEA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 15:04:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B49C061573
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:03:58 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y4so9568093ljk.8
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w8WWgBWyDtSeQIPBtnjCFMLXm835ifmot/WJxPXeMr0=;
        b=aGAgC8umo9jT3HphPtybtbPmWCzkWUG2mVWO89WZsgTvff2s0CorZE1I+d97G53K5+
         RX9nZjY8s1ItnFfhiy+Mu8ex5nH1/S9EwP40QL7L7cy2Tkwt8OXm76euU137Q5oMfEgC
         FojxR8AGVsmKlCZjY8jZM73qAvqv6nqdiychYTLtZr2hl7lQzYCkmrafbA7ErF9zYExH
         uh0mh545Oeta/MJH0l14WKX8B1WK3eRdfL36OWCmQklSh79bTrE3tg1anSDjQXuYCUxO
         cYwunNRt6F4wIu2Zb3kDiM3+gS2VXml0eThGWHcidyMdTvzfXtS4T7J/SGOjcRvcJz0Q
         8y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w8WWgBWyDtSeQIPBtnjCFMLXm835ifmot/WJxPXeMr0=;
        b=onCWT1jyd5T9ub9NQCz3xlbBwYmw+QKZ+lQ04DpHnutB1N2lLJ0959kkZfiBYSf80G
         6hVgwNPIvQcl7oYLw5iwaESAFdqaAGf1xirPHdlAJGiSSFXmpLx0oUwngPIFsfYyPw/z
         W2zHm5Nh1iYPyaFa90dNit5C342F1PdZoWCBmpHroz1RSPLgOvOKjDE9BE9SNFJnwNEt
         43FEXs6rqZ66gFwDxul4bUgZAZVlfnQx2pj1XBhmuqrP0Xu+e4gzM1nUrZ3wm0WOB/L7
         WQqQDcgddpfKt4H2MCrjUT5BEprkXkWZjx4lp8TGG6OyM99sHlU0p0NMQNmwJuODXyQH
         3Nzg==
X-Gm-Message-State: AOAM530cEB7Zl2GUtouJ6cbXnzkp8vU3ZPaawWcDR3ozG3DsBzQ1EBuJ
        1yF/jM3p5FLS1BjEoCxanO4FvsSF7NE=
X-Google-Smtp-Source: ABdhPJwI/JcFlxYEdsyD7DR0Aj9XcCLaPD6Dnktt+Glpbdc/CLfeT0Dc+LjmYbYfHzQNh2NAafp5mA==
X-Received: by 2002:a2e:a554:: with SMTP id e20mr5623094ljn.458.1599764636753;
        Thu, 10 Sep 2020 12:03:56 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id v11sm1549815lfg.39.2020.09.10.12.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 12:03:56 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/8] various wt-status/worktree cleanups
Date:   Thu, 10 Sep 2020 21:03:34 +0200
Message-Id: <cover.1599762679.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio noticed that wt-status.c is a bit inconsistent about printing to
`s->fp` vs `stdout`. That's patch two. The third patch tries to
robustify some freeing of memory. While working on that one, I ended up
in the sibling file worktree.c.

This merges pretty well with `seen` (`jc/quote-path-cleanup`) (and the
tests still pass). These patches are obviously low priority, nothing
revolutionary here.

Martin Ågren (8):
  wt-status: replace sha1 mentions with oid
  wt-status: print to s->fp, not stdout
  wt-status: introduce wt_status_state_free_buffers()
  worktree: drop useless call to strbuf_reset
  worktree: update renamed variable in comment
  worktree: rename copy-pasted variable
  worktree: use skip_prefix to parse target
  worktree: simplify search for unique worktree

 wt-status.h  |  7 +++++
 ref-filter.c |  4 +--
 worktree.c   | 39 +++++++++++++--------------
 wt-status.c  | 76 ++++++++++++++++++++++++++++++----------------------
 4 files changed, 71 insertions(+), 55 deletions(-)

-- 
2.28.0.277.g9b3c35fffd

