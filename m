Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11863C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 10:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD024613AB
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 10:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhFAK0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 06:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhFAK0S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 06:26:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F08C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 03:24:36 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id b9so20798123ejc.13
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 03:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=8laeVzaZZ8KLauZGpZM2R9M9HSqpWlFLHLaMZwXXpKs=;
        b=rbZknzf0SfNLsF+9TzSQSmwl9PCtze7mehU8UQMLtxLVaUpBCExq3UOdYGcTRbUYdV
         Vrav5BCrXji5ZXlwCRZLTQOr/Y0PCS8XcIKyXsUBnjgV0VUicxgoS9QVd4dsBh0ndrDB
         zg6dN7dvXWMfgkCYtviQdyTdz1ubelj/SvQsTmz3xOhEValSsgMea4OdpJ+DEPEwugZj
         lowMtcJDXHMVWusoxfXojn0AZDv9d5hMhxGQfMln6hzWGvoLNQZZrgHyM4g41WdaHdHh
         RvduiQRmr8/kYRUyXCkmNfQ//SYTZtEofJBGA6Xwjxk1enDEe2oS40KvReic+TIIhIRt
         eJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8laeVzaZZ8KLauZGpZM2R9M9HSqpWlFLHLaMZwXXpKs=;
        b=B55Ve8BnPsroAxqNtP5hWh99u+XQhCZ2V3QJrkxQgateZ8RVPM6sH02o0gfwjqRoe6
         nRdT59D3ELiP3QZuam+Phuscb7nmiKIsZsd9yR6zo3RfKZd4aXVroSbL20UM7eh4buIF
         bsbk7ZtjeppY2OJiDE6zuA2jDUkWtXVDHoggn6X05RD1cY+ckR+wnuXJzzMKTm6N6ZWS
         pUympYd+AlSEC8JX3WnepFKb/pEvLMIne8Yn5caYRwwidEcGPi3mJ8ERvseyY6lgXtbt
         N4rPdh6cX/gINCkuRKnmncthA2HJQSdX/ShP/MPvINxjxEKRg3SnDr/G7EbHhu5W2NZZ
         iLuA==
X-Gm-Message-State: AOAM530lhRV/vfc98HqxM20GmVocbLFOTbJCJzgF4yn2RhQn3oI4MkVm
        argh5tzQ4jTtC1kUmLozcIX0hAVKSTKGAcLoO3FVYKmh70e5Y00P
X-Google-Smtp-Source: ABdhPJxtu0Ml90iFdg619fOfCKKhnRixvLd2bdfHlLR8667Cocr0Q5JW8C1xksUFZUwZTAz5HSSe74FGZLKJXlLm9bM=
X-Received: by 2002:a17:907:6ef:: with SMTP id yh15mr4070710ejb.151.1622543074206;
 Tue, 01 Jun 2021 03:24:34 -0700 (PDT)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 1 Jun 2021 12:24:23 +0200
Message-ID: <CAPMMpoim38J3=4pd0_fM2h=DN_PrEE_Osg2duU5Ur8WUZ5S1Pg@mail.gmail.com>
Subject: Removing Partial Clone / Filtered Clone on a repo
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I'm trying to deepen my understanding of the Partial Clone
functionality for a possible deployment at scale (with a large-ish
13GB project where we are using date-based shallow clones for the time
being), and one thing that I can't get my head around yet is how you
"unfilter" an existing filtered clone.

The gitlab intro document
(https://docs.gitlab.com/ee/topics/git/partial_clone.html#remove-partial-clone-filtering)
suggests that you need to get the full list of missing blobs, and pass
that into a fetch...:

git fetch origin $(git rev-list --objects --all --missing=print | grep
-oP '^\?\K\w+')

In my project's case, that would be millions of blob IDs! I tested
this with a path-based filter to rev-list, to see what getting 30,000
blobs might look like, and it took a looong while... I don't
understand much about the negotiation process, but I have to assume
there is a fixed per-blob cost in this scenario which is *much* higher
than in a "regular" fetch or clone.

Obviously one answer is to throw away the repo and start again with a
clean unfiltered clone... But between repo-local config, project
settings in IDEs / external tools, and unpushed local branches, this
is an awkward thing to ask people to do.

I initially thought it might be possible to add an extra remote
(without filter / promisor settings), mess with the negotiation
settings to make the new remote not know anything about what's local,
and then get a full set of refs and their blobs from that remote...
but I must have misunderstood how the negotation-tip stuff works
because I can't get that to do anything (it always "sees" my existing
refs and I just get the new remote's refs "for free" without object
transfer).

The official doc at https://git-scm.com/docs/partial-clone makes no
mention of plans or goals (or non-goals) related to this "unfiltering"
- is it something that we should expect a story to emerge around?

Thanks,
Tao Klerks
