Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7890C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 22:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 989F660F55
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 22:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhHPW0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 18:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbhHPW0k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 18:26:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24959C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 15:26:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c63-20020a25e5420000b0290580b26e708aso18230387ybh.12
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 15:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=w7PuSp+0F2wvxkU2w3zAXFuCgNQD7YJTPC2rTr40lbg=;
        b=p2THiYdxCq1zx/j/iWcPVE6rWzW6v2bAXVRs4NUXJ9Eg4Y8dJeKOQDc7Wv7996ocTJ
         GiCnnziAbjkwb99U5r80F7cr4tFUA1BddOpTYEI2oLfEvQitZ51Kkr9/9PBLIO1RvYxU
         CYiBythc+TGwI0Y8XgiLF1FoqKQQRqtB582tIeD7Hqot1upHQ+wYoVD7qtZ0nXRl6i+y
         Mydq5xiqQw2L7kzgm1HIPAkNVDmJP3ZOEzNTMegpd3xfK/BpGGRG5Fy+HWBZyr45SOSv
         LPdZnA09/ZRQ1a/IMLXaL21aCAhegh5PWCpDgCZ6ppLpv8ElRYqd+mAT147HH5TEdGn+
         Lz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w7PuSp+0F2wvxkU2w3zAXFuCgNQD7YJTPC2rTr40lbg=;
        b=KTAPV4WnbsTKd7V1GC/KCZl7ZT03OOnHxRDs2RtlLL9EL1ynwIaeCBCN/qgoUz2U/p
         Avc/rjsQ8bY0M5kITiSTkYciTJFroJH5laje58JxfN9QBDa+6nssjnTlUdqDaorHjW/m
         kqKY5O+NGJ+A2WSNWWq9WwFAUQ7oSW5E9uo5jI+jJtymQ6cZnwnwORCIwGWj+EnjrAsJ
         77vKDBwi1Tuspw0g6uEuiUjFQlEFDatC+sfimQvoYtEKa75eWnXTsC9TK5ovm0Um7sLP
         vanp9aXxWLfgooZstcrMCzzVx7/olYDW456O+iI2n99UlRVj6GX29MMK/tJcqR2zdRq5
         +6Cg==
X-Gm-Message-State: AOAM532BHZ9xALQyoh2idDrcp2DSvQZHK234kwIIDLlpJUPijRN1fXSy
        CRVnuwKxD7xF1XmWiRtyR7c2Bue3py794H8aKXZE
X-Google-Smtp-Source: ABdhPJwPsFNdYg2rbE7BEX1BJFvpCSRPiP72bZgH3Czx8Zqxe22OkTlb8XXvpPENn8UO4gB4HmQLqSOaQU52eKfEOGwK
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:ba0f:: with SMTP id
 t15mr373409ybg.15.1629152767377; Mon, 16 Aug 2021 15:26:07 -0700 (PDT)
Date:   Mon, 16 Aug 2021 15:26:04 -0700
In-Reply-To: <87eeb6yr0m.fsf@evledraar.gmail.com>
Message-Id: <20210816222604.3503037-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87eeb6yr0m.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: Re: [PATCH] transport: no warning if no server wait-for-done
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Tangentally related (the alternative was to start a thread on some
> 2018-era patch of yours): Is it intentional that when you supply a
> gibberish OID or a nonexisting one as an explicit negotiation tip we
> don't even warn about it?
> 
> Looking at the history of fetch-pack.c I suspect not. It goes back to
> ec06283844a (fetch-pack: introduce negotiator API, 2018-06-14), i.e. the
> "o && o->type == OBJ_COMMIT" check, now "if (c)" (as in could we look up
> a commit) on "master". That in turn seems to go back as far as
> 9534f40bc42 (Be careful when dereferencing tags., 2005-11-02).

This sounds unintentional, yes. Other than replying to an old email, you
could also write a top-level patch :-)
