Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C83C3524D
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 23:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD6E2087F
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 23:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8LuViPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgA1XE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 18:04:27 -0500
Received: from mail-yb1-f201.google.com ([209.85.219.201]:45676 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgA1XE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 18:04:26 -0500
Received: by mail-yb1-f201.google.com with SMTP id b144so11458746ybg.12
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 15:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WTaqTQCNpgd7j2DHr2C1yMS5kMrXClnOVLTxvvaG3zc=;
        b=m8LuViPZgag0h1DXCcxjW2eEkKdYHIgpGTMQAdRvl0+ZNmNv6XerrNEioz1UNQVHAz
         KdxxzOjtMMoDFTzvDtDk0mI1sR0xPVdBnOluN7aI6kv/IdFqbeUy6XzVFNQxFsg3Dyxn
         DfHcM0UbclkvduPgMq1JYrTYPBwE8+2fuJXGxcQ0fnjM22t89bM5p0CfsqnXYRpmc/L0
         xDqiDx5HT0YoSDM8YGMWqcCpKi/avA/fQtdtsjx193UZyUBIT5plMNF8A0iK+k32k9k9
         Ke8FZz5x7klxsABcbHWRjNRdSCbIEH0XYnQ2O4QsQkAM1H5sWT8W7gKYcNcng1xfo6u2
         SD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WTaqTQCNpgd7j2DHr2C1yMS5kMrXClnOVLTxvvaG3zc=;
        b=TMMHkO1TBemjOhQFHpb9Nwr0AwhU/K9dqbKPJHJTpOqRO4yTj4DFdAtZFCKItgz78O
         +jjhC79VK2ZdWBmOVG2Jj4l/a2ukzl1OxfNREfKPg5iy3lb3LqIEQ3wT1DV4mYRj5577
         FqsbfA6SNowL5ZQgfMiIphX2KIDKKFLCpW7kKW7jtcS89+NN14f8WVRsGwnALrpnv171
         uDo20Zd33cIPdhpqfTv+7DIkqs9J+jVLFpy50oGsFPGeLA8Y7ERJvGZlr62eG3I+3vCu
         lR+bZnyEmrxJjZEQk+fL2l7clRUBKbN691iL7YUWniMFpiudjeCjrQZV92Cz++yhlxVD
         YmBw==
X-Gm-Message-State: APjAAAX3Pgbu5mwrHVPf5GIy0J4MXxCcTa7MP0zw7IjLfE5d+xMCNDag
        2L+gPvg4K72JUf92tX3VY8gtLv/b0S1oc0e3nnJ6
X-Google-Smtp-Source: APXvYqyV5mGcn+VK9iuH49J1PNgahIq2JcBpRWtie76m9ND3ahBj/ekfopfFB7TTYRgFvluRDJt4vcKVDpWBQABoLxWw
X-Received: by 2002:a81:33d0:: with SMTP id z199mr18833953ywz.53.1580252665185;
 Tue, 28 Jan 2020 15:04:25 -0800 (PST)
Date:   Tue, 28 Jan 2020 15:04:21 -0800
In-Reply-To: <20200124033436.81097-1-emilyshaffer@google.com>
Message-Id: <20200128230421.49994-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: Re: [PATCH v5 00/15] add git-bugreport tool
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, stolee@gmail.com, Johannes.Schindelin@gmx.de,
        gitster@pobox.com, martin.agren@gmail.com, aaron@schrab.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Emily Shaffer <emilyshaffer@google.com>
> 
> This topic branch depends on the patch mailed in
> lore.kernel.org/git/20191211233820.185153-1-emilyshaffer@google.com in order to
> display scopes for configs gathered during "bugreport: add config values from
> safelist".
> 
> I'll summarize v4-v5. Since v4 has languished for some time, I don't
> think an interdiff is too helpful, so I won't include one. Bonus, the
> code is much simplified from some suggestions from Junio on how to
> inspect objects, so I hope it's easy to review anyways.

To everyone in the developer community interested in this set: what is
the status of this?

If this needs further review, then maybe it would be best if only
patches 1-4 were put up for submission first, with a note in the
bugreport documentation that more information may be added in future Git
versions. For me, patches 1-4 look good and I don't have enough
experience with uname (especially across libcs and OSes) to determine
what should or should not be included - if this is typical of reviewers
in the Git project, it might be better to submit patches 1-4 first, and
then send each additional diagnostic separately, so that people who know
what's going on in one area but not another can just comment on the area
they know about.

Having said that, I see that a few people have already looked at the
entire patchset and made comments, so if they are OK with it, we don't
need to split it up.
