Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE39C4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 16:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiKXQCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 11:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKXQCj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 11:02:39 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE5D1DDF6
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 08:02:38 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id v7so1628743wmn.0
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 08:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DxST/V3Oc7/0xgJShWOGeeCJBr33Hzl12zXtpGVCiQE=;
        b=V2mJnyDczfoD/03Z1cbm1Fb8HTBbHUXsIgtq26ECXow69TzUi99ZkCHiWJzWGknXNn
         DihwthadOLK8pNjoOJ24A/7ZFikDhVvjtGRZopPcdiD21cahPjrEkQ0cPMSqevSeznK0
         ybinI2rLvnA3GNNTCcFN+IsPDl5z4hADJHozV5lJIhGp53/SNDBa+aLy0GC7S3d6rn0L
         1uEjCwgFijdwJi3H/WtgyarQlqhtaoff+edh3d2FEUehynXlvbI+jvIJtTGeJLHK6MGq
         qPHqfYACb6XZurzJzp/6EVuq4YoDPyw78j76nib+qRqU/ekjjEBjf4YsbOkzqRCaqg9a
         uxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxST/V3Oc7/0xgJShWOGeeCJBr33Hzl12zXtpGVCiQE=;
        b=Oi5lT24di8z90EU91HEwtEBZeCL/KsN0bGXZa0IPNvMCQW/9mx2AVbH/+egjBigItW
         zi3zaB/kxw4KqA4kLyunmgKKtNwRlNnFIUjwr4Brw2FbKssoPLQ0RuznJV11mqv/B3Ab
         2eTyYIQ2b0z2XPHt0+V6PG9q+gS7trOwdxbGj32mRmuwxONQG/4k2kK9QynB61LI/tOw
         U+tuOdHfwl1DlfBg4grdp/rzT7ObXQzv7xDNADLi4TFVWHLa2QhJlB+U2AJn8Yp1lXSt
         8Qo1/oSf5u75RbPEeV5bF368zoN4iAxXI2WL5A2Ra0/D8bIh4JV6JobCPGepbGX9TSwa
         9iqw==
X-Gm-Message-State: ANoB5pnucQLF+chE2iG2VqJ0ze3FVsWyDiz/IybhF+CVb+VJPB+db+3x
        fqDxHxFhUzYC5MLB/XCZLfM=
X-Google-Smtp-Source: AA0mqf65u18+hJX8QqcKUGIeBNTEJWhirvSSiGJ/B1FxN/pAEhpUpy8P49/9zMacvk3SnONEIE4jOQ==
X-Received: by 2002:a05:600c:1d24:b0:3cf:6fd0:8168 with SMTP id l36-20020a05600c1d2400b003cf6fd08168mr10519157wms.206.1669305757152;
        Thu, 24 Nov 2022 08:02:37 -0800 (PST)
Received: from gmgdl ([149.38.4.46])
        by smtp.gmail.com with ESMTPSA id az26-20020a05600c601a00b003d01b84e9b2sm2306978wmb.27.2022.11.24.08.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 08:02:36 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oyEeH-000E0v-3A;
        Thu, 24 Nov 2022 17:00:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Zack Weinberg <zack@owlfolio.org>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: [bug] git log --invert-grep --grep=[sufficiently complicated
 regex] prints nothing
Date:   Thu, 24 Nov 2022 16:53:28 +0100
References: <71fcf215-101e-4398-bffa-4ed7e286d9c8@app.fastmail.com>
 <909b0770-2ac2-1a87-498b-0537a94e94ac@dunelm.org.uk>
 <cfbd647e-0e66-4417-8c94-c8cac905a78a@app.fastmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <cfbd647e-0e66-4417-8c94-c8cac905a78a@app.fastmail.com>
Message-ID: <221124.861qpspckm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 24 2022, Zack Weinberg wrote:

> On Thu, Nov 24, 2022, at 5:31 AM, Phillip Wood wrote:
> [...]
>> I'm afraid I'm not 
>> familiar with the --follow code so I've no idea how to fix this.
>
> I'm honestly unsure what the right behavior _should_ be, now.  I
> expected --grep to be applied very late in the process, after the
> set of commits touching the specified file had already been computed
> (including all of its previous names, because of --follow) but the
> documentation is ambiguous.

This doesn't help with your case, but I remember there being some
similar confusions and/or expectations mismatches reported in the
patch. E.g. "--since" here:
https://lore.kernel.org/git/220401.86pmm1nmvh.gmgdl@evledraar.gmail.com/

I couldn't find a reference quickly, but I seem to recall (but perhaps
I'm imagining it) that we had a report/discussion semi-recently about:

	git log --reverse --follow -- path

Which has a similar edge case, e.g. try on git.git:

	git log --reverse --follow -- object-name.c

That's also "correct" if you look at it from the POV of how we implement
it, i.e. we'll traverse, and the rename to object-name.c is the first
time we encounter the name from the POV of the walking logic.

Hrm, but shouldn't we show all commits *after* the rename then? Anyway,
I haven't thought about it this time around, just wanted to provide some
rabbit-hole references in case you're interested.

In terms of optimization it's *very* useful that we take these
shortcuts, but as your (and some of these) examples show it can yield
the wrong or unexpected result in some cases, and in those cases we
usually have no non-brute-force way of getting the "right" (or
"desired") result other (brute force being: parse "git log -p"
yourself).

So it would be nice in general if we had some ability to say what
filters apply at what stage in the walk, but I suspect that would
require a rather large UX overhaul...
