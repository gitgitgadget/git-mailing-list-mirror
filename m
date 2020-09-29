Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62500C4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 18:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C5820C09
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 18:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cazfQdIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgI2SFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 14:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgI2SFN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 14:05:13 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F94C061755
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 11:05:13 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id s12so4380150pfu.11
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 11:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=om3u9O0L27m8ZtkoP4cgv/joCT9EwHMRw056BbCenso=;
        b=cazfQdIF5Fgr1PcIQRIYD7fooWlFTEoeBeyjGGvHtpd5866JXJqlePXJgSE85KOaYQ
         8gIk8hfERk+JOM/4B8cuESRud1tn66tSWRVp4pW3AnH/+lk5tLgNVmZ+4qaU7DKfXzQc
         yo7JMoak9A5dd8efxJfhj9Pb1biJQPGd7TgehalD+zNvtV1I1Y0f6RE9AhqP/eS9zj74
         4f2XeyZLqpbIf1dAm4sQROduf4qxwO+50Mb037hFjPiPiQoNxDmGxQv9IPXiI6COCxrO
         1f0+0rnBO7VvcAyDAPfBuLYdzgJoLyQDgdZKLXWXExSNUtBoM0xRkvSgm3vhVWjLm6rE
         FEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=om3u9O0L27m8ZtkoP4cgv/joCT9EwHMRw056BbCenso=;
        b=cu3P0VDr/DjMbiFV75g7Jcfj9yyQV3WP/F/gtt4aryzv1ucivkOnorMl5zg3RppD9S
         7MKSUf8nEIU/8KjoOE7E+d6c7xCb/S6vWpkZO8m1MHspZPHGqXC6KIxxy5cl2KYvSYVf
         1dCjee64bgrO55cI9rKnxirCnu/OSOxSJORxzxpSjcPiO3ZBAYNaXyJ2EDc+qM3YOoSm
         5jVwd9JSYGTWbXHFBBUBx279nmhjzVic3ldIo4JQqx0uTXQ7GKKkYy9EPYkTZGc40iyC
         RIEoQ/4yYiQI3dCiu7vgPgj0rMcVqEKxS6xoi5Y5Dc2RUTuJUQVRy1Z9igzR23g730+9
         MUEQ==
X-Gm-Message-State: AOAM533APpxsSnvrMOTkiuMQHU5IfD1Ym6+sxUhSGiaqSr2AZKhsaThT
        dxB2tzoD/zCuKlZqxNEjVJCJJgoGdwN3S/94nlU9
X-Google-Smtp-Source: ABdhPJyIxTcEv6pGp6SeXZkTTVYCofQ3N/V4CU9LGLgaRFZyAn6dc7AdTQFs7dvAbhxS/nwiaI+nFTv36lLB7Acwx4ut
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:3355:: with SMTP id
 lm21mr5124873pjb.125.1601402713197; Tue, 29 Sep 2020 11:05:13 -0700 (PDT)
Date:   Tue, 29 Sep 2020 11:05:08 -0700
In-Reply-To: <20200929155350.49066-1-andrew@adoakley.name>
Message-Id: <20200929180508.118066-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200929155350.49066-1-andrew@adoakley.name>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: Re: [PATCH 0/7] Submodules and partial clones
From:   Jonathan Tan <jonathantanmy@google.com>
To:     andrew@adoakley.name
Cc:     git@vger.kernel.org, luke@diamand.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I've been investigating what is required to get submodules and partial
> clones to work well together.  The issue seems to be that the correct
> repository is not passed around, so we sometimes end up trying to fetch
> objects from the wrong place.
> 
> These patches don't make promisor_remote_get_direct handle different
> repositories because I've not found a case where that is necessary.

Anything that reads a submodule object without spawning another process
to do so (e.g. grep, which adds submodule object stores as alternates in
order to read from them) will need to be prepared to lazy-fetch objects
into those stores.

> The patches rework various cases where objects from a submodule are
> added to the object store of the main repository.  There are some
> remaining cases where add_to_alternates_memory is used to do this, but
> add_submodule_odb has been removed.
> 
> I expect there will be some remaining issues, but these changes seem to
> be enough to get the basics working.

What are the basics that work?

When I looked into this, my main difficulty lay in getting the
lazy fetch to work in another repository. Now that lazy fetches are done
using a separate process, the problem has shifted to being able to
invoke run_command() in a separate Git repository. I haven't figured out
the best way to ensure that run_command() is run with a clean set of
environment variables (so no inheriting of GIT_DIR etc.), but that
doesn't seem insurmountable.
