Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D5AC2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 22:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2070D24655
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 22:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgAUWgN convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 21 Jan 2020 17:36:13 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:41297 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgAUWgM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 17:36:12 -0500
Received: by mail-io1-f54.google.com with SMTP id m25so4568151ioo.8
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 14:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yHC8HNPMuSis+K7pDyTWijWCxwB1z94Ccb6y4ZxAWHA=;
        b=qWd6EWFa0xbg3zp5FuaPebTQ0HpTUxQIxxTtZgaANcpT87jz93xf82jG/pjyTPMVcR
         vXSS+NDSH4lPo5sx2iXcm1M6BRPll8IZZQ/tGG0enfLIM5eNhyHhF7Jolk2m6YNZcu9V
         I1PDk9wmX5MTvYz02wBYLbwBoHvx36xuyGTwaq0hyHZcFnEHxxDu3xLGbs0B1P7qJWm0
         aG6DXYvHOqm5n4vzVzxxEyIUumO9pyQ2Xo6Ophx8aPAYQmLXJzJBeDErH8zIgmjtJgtc
         9gJz1lg4qp/CsWHXmGN9f82YRvSTCczknqt9Ft2eQBP0lMy8Wer52GzHckzhtRrd4WQC
         wjCQ==
X-Gm-Message-State: APjAAAWuNEbVTPWR4WQyezAxiCP4WNSyK00W1vTNNZua/Fn8rX2St9dD
        f3n+ApNABvMZ4VjbXWzKNOYbFkS4c1psSkSoIFA=
X-Google-Smtp-Source: APXvYqwA6ldzRcjjYncBvcnNg7rkYzL4hUgh6EjSDf4z2dlrUqAR+V+PYENl/Ctoes/d/dZpNaRbagMAtniJval6mC4=
X-Received: by 2002:a5e:d515:: with SMTP id e21mr268562iom.100.1579646172187;
 Tue, 21 Jan 2020 14:36:12 -0800 (PST)
MIME-Version: 1.0
References: <CAPyFy2AKSVQJtSY0RNgJDJ5k1P=-gjNXVjDgPh+CdghhZtJXDw@mail.gmail.com>
 <F0FBE3B6-0DF5-40A4-B1A3-18EF65D48FF3@icloud.com> <CAPyFy2Ar+OncJtgZZyAzxs0PkXy5rSU6ALS+MimK8x5TzWjLug@mail.gmail.com>
 <905A443A-7E2B-45C2-985F-46C3E295670A@icloud.com>
In-Reply-To: <905A443A-7E2B-45C2-985F-46C3E295670A@icloud.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Tue, 21 Jan 2020 17:36:00 -0500
Message-ID: <CAPyFy2A+8mK3cBYYf4W3wg-qXR1S5wkX4kAOk2BXgG=hVefbYA@mail.gmail.com>
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

On Sun, 22 Dec 2019 at 09:01, Tom Clarkson <tqclarkson@icloud.com> wrote:
>
> If you want to try out my update, it’s at  https://github.com/gitgitgadget/git/pull/493. The commands I ended up with were
>
> git subtree ignore --clear-cache --prefix=contrib/elftoolchain 4d43158
> git subtree use --prefix=contrib/elftoolchain 9e78763
> git subtree split --prefix=contrib/elftoolchain 53f2672ff78be42389cf41a8258f6e9ce36808fb

Thanks Tom, I was finally able to get back to this, and confirm it
works as I'd expect / desire. I'll continue experimenting with the
rest of the contrib/ software in FreeBSD; please let me know if
there's anything specific you'd like me to test with your patch set.
