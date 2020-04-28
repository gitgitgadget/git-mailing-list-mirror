Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08145C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 18:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B125B208E0
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 18:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgD1SIj convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 28 Apr 2020 14:08:39 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:45666 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgD1SIj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 14:08:39 -0400
Received: by mail-io1-f44.google.com with SMTP id i19so24162208ioh.12
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 11:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FD6Rsm1kQQULyz4K2xch874TX65ygL9Dz0FacGbt7kI=;
        b=evLR1hlCmFqi8zUDiM9xnyFSPnkiZ+mSFgwamipWMez6hmmb+qNE5ddFD4Uj0oM/Tv
         l/IjNUcg177saEdC9hda7WyQldqu7mJihDV1YpJ66fN3o3BTp360bflm1ybcog+YtT6z
         4GI0JHGyF7oBE9tt5l9xG8ule5zndQlceN0WorwN3MFRhwjsMf4o+oqH4NpTGRyydR0B
         51h8z+El5moQhbHrDQVmFIKZIxl2cNXNL7xqC1TEjwOSPAEdpKWD3YZ8uGVZ2GZdjG8Q
         IBLvWKfAi+sXojM0J5pdBaFq0aOQ8VFEzqFpvS5DL670g7mWYzHxvnRbI4vAygAe2CsY
         Cu5g==
X-Gm-Message-State: AGi0PubecvYsLWLJOoRWbhzAkwY9WjStDCG5kG0M93UuGuQGQCbljnhG
        AsFX+0pv2W69zrOoDoB7fj+tvGmZbPt4clj3nmH7Vw==
X-Google-Smtp-Source: APiQypKTsXdmM2uaDcgH+yHCK40axJlggPBvftbo0mvvwzwlY9JlNmkaOgsLJxF1OgzjSnJQbHKKIt1FboaAD5qDLLI=
X-Received: by 2002:a6b:660a:: with SMTP id a10mr27441338ioc.15.1588097318877;
 Tue, 28 Apr 2020 11:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAPyFy2AKSVQJtSY0RNgJDJ5k1P=-gjNXVjDgPh+CdghhZtJXDw@mail.gmail.com>
 <F0FBE3B6-0DF5-40A4-B1A3-18EF65D48FF3@icloud.com> <CAPyFy2Ar+OncJtgZZyAzxs0PkXy5rSU6ALS+MimK8x5TzWjLug@mail.gmail.com>
 <DB65AE2F-12DE-43B7-8B20-4E173794CAF2@icloud.com>
In-Reply-To: <DB65AE2F-12DE-43B7-8B20-4E173794CAF2@icloud.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Tue, 28 Apr 2020 14:08:26 -0400
Message-ID: <CAPyFy2CqAQWSxzVkfNqk5k=Tq_N82_62Z-rTawen9TtmdW9Ytg@mail.gmail.com>
Subject: Re: git-subtree split misbehaviour with a commit having empty ls-tree
 for the specified subdir
To:     Tom Clarkson <tqclarkson@icloud.com>
Cc:     git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 22 Dec 2019 at 08:50, Tom Clarkson <tqclarkson@icloud.com> wrote:
>
> If you want to try out my update, it’s at  https://github.com/gitgitgadget/git/pull/493. The commands I ended up with were
>
> git subtree ignore --clear-cache --prefix=contrib/elftoolchain 4d43158
> git subtree use --prefix=contrib/elftoolchain 9e78763
> git subtree split --prefix=contrib/elftoolchain 53f2672ff78be42389cf41a8258f6e9ce36808fb
>
> On my machine, ignore takes about 2 minutes to flag 200k commits as irrelevant. The split takes around 15 to go through the remaining 50k.

What's the next step with this patch set? Is there anything I can do to help?
