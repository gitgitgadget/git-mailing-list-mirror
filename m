Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636C7C32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 00:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3512F22464
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 00:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAOQZFhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbgAPADP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 19:03:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33683 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731331AbgAPADP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 19:03:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so8975535pgk.0
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 16:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9aLObcfxqgctX6yRH3nz4+3YgAI6X4+rIUSWTDKW5xQ=;
        b=PAOQZFhEuytKmkC8FctVndXh50vm8x5duQnuDrTae/HDYNvNeTf99rYIoPPHWhDsEU
         HfS7M8XZ3CrG1OHd0xK3hdrtCop3rvmLGtu5y2ooUD4KruntqDcYKEfKvLmIzedJqNUL
         8zoCh1HVsbRpyr5lKmDXqJWFmdcYWmw+JefJN3LdG75XuWrlJR3FF0F7EkrPgBmCS3LW
         HmCFT1Fl4/iw2Qia4anipCpfrr273DwdAhGtK+l5V3i0cxBbDMmbKc+x9Ygs8jg/wdnA
         xkfY1AL2sZGWolAp/4w/KV51Frv4mkW3zc+vLrgpOHEusnHiFCErbW1zlYhRkBnh6yqA
         drGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9aLObcfxqgctX6yRH3nz4+3YgAI6X4+rIUSWTDKW5xQ=;
        b=a0zPm4INpmsmkn7B0UvyYqlcJmabqbjowoTh1YhgtE4Ic0eVVMeM3Vq1pnTgeJUJZ+
         jMMtzE/ga83X3GjVQnS+GdO2JWP4mmSHTS2jtpK9/eEHrSBUMAmjSiv9KES2xlDaSt8t
         3/VpicTSZGE3BA2zuSOML1f3WRj5gEQKUXnoX/zWUupowKnbMLxfhsq1IsgpGCfVpVQY
         9Lo90i4qBCQalzXzX3+6St673ZpzcTiGuxItkVTK0oGn6Wazuld+uYGdnf6QfVv64/kH
         0YthLAx6grsdiTDepouCXwaOgAg2IgE+xCTt8vgl0RBlzpc6tpPtMsaoxzVMVxQV4Cj7
         Jjhw==
X-Gm-Message-State: APjAAAWtuySPFBBdTAVKnW9XsqF/DtRDwTey5x0cp3vPLHkr87+33CeX
        Dy9NpW4k7+iLOh9mKW40EuP5QKnK
X-Google-Smtp-Source: APXvYqxs5w+5OqF/LSjXCx5B8fRHJHF2t+uttibnfueZdnrqUAm3e8RrjfrH4TuEgUcbAubkZBjRpw==
X-Received: by 2002:a63:a350:: with SMTP id v16mr34420047pgn.87.1579132994312;
        Wed, 15 Jan 2020 16:03:14 -0800 (PST)
Received: from google.com (240.242.82.34.bc.googleusercontent.com. [34.82.242.240])
        by smtp.gmail.com with ESMTPSA id z30sm23842888pfq.154.2020.01.15.16.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 16:03:13 -0800 (PST)
Date:   Thu, 16 Jan 2020 00:03:12 +0000
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Kevin.Willford@microsoft.com, newren@gmail.com
Subject: Re: [PATCH] clean: demonstrate a bug with pathspecs
Message-ID: <20200116000312.GD146834@google.com>
References: <pull.526.git.1579119946211.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.526.git.1579119946211.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Derrick Stolee wrote:

> b9660c1 (dir: fix checks on common prefix directory, 2019-12-19)
> modified the way pathspecs are handled when handling a directory
> during "git clean -f <path>". While this improved the behavior
> for known test breakages, it also regressed in how the clean
> command handles cleaning a specified file.
>
> Add a test case that demonstrates this behavior. This test passes
> before b9660c1 then fails after.

Can this commit message say a little more about the nature of the
bug?  For example, what kind of workflow does this come up in for
end users?

[...]
>     While integrating v2.25.0 into the microsoft/git fork, one of our VFS
>     for Git functional tests started failing.

This is also useful information to put in the commit message: e.g.
"Noticed via VFS for Git's functional test <test name>".  It provides
useful context when looking at such a patch later.

[...]
>                                      Elijah is CC'd in case he still has
>     context on this area.

Thanks and hope that helps,
Jonathan
