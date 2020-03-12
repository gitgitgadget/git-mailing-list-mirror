Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349F5C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 23:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080EE206B1
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 23:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQ9PtRAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgCLXao (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 19:30:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39896 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgCLXan (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 19:30:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id w65so4037759pfb.6
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 16:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/UE1mImM77zCfJpPWTFCkav5q7cC5gf8jIv2UOdu1bU=;
        b=QQ9PtRAS2u8maL7liXfsPbnQVnJ7RFa9s+97mb5cBS96Yu3/I6XY6DssO0aHOn9D5T
         AWYrb/wSnFxxlfzHSFpWNQ7IiNHLYMnU/t57iIYDYG0WzvEHulwf9QktkHpDYm/M8sTe
         +CGSMg6rqm/YMZ2c5AxqNd3jT05k77SrkY0hdQinSBbomJXHmz9yB+jYVPvuZox1Ms9+
         rI7+q/UsEkeifzrFQ1usvT/KMLogLJqvhTw14vxfVFqhwO1VBJ5hV79PZPIeT4xrOJ8R
         vVbtKebt5zBfCswlLU46XlN68HcmIMyH6vnhGNdnASSPa3UVdqpmfwh5rUTcXTYf4Bft
         nrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/UE1mImM77zCfJpPWTFCkav5q7cC5gf8jIv2UOdu1bU=;
        b=mQ1k14Y5b+QvhY9d/AjZ/bWwYYkzkT1YoqDDvxNdxp7fsRqV49Kh27Zn0Cu4cKBEsy
         0BXHD3HvsnWB9JZr2z5cUGNmOWpn5TdkZip5UWuf2WTjm1bLqlfow043f5QQ87fSELwL
         gAui3aqofx2fHW9XUAz/aJwbLUm5stS3N2B54hmJT5Dbok1Ho6n1QyxPwunvTyro+FsU
         z4bmM9nQaiwm5hfMcaMzo8AayXcjFC0CIjcEu5/ciVCfB+GNTcJVczigURWokGwa3EHl
         fF+jMtvkdRIRkvCrZsI4vXLZ4CV2eshTrMmZHp/VeEujUe7YyhXwtaQ5CVcnsaGyMfkG
         fslg==
X-Gm-Message-State: ANhLgQ2SiDh4VmLO6cZHi/zh1wfPSWC0jE97iPSxG5UAxV/NEnQep0a7
        E5+ZeL+ZjapJzlVNlAuQ1Cg=
X-Google-Smtp-Source: ADFU+vvMJcn9ZRAMYUDPPemvIBuqyRIAoG2DpOL795OjveFKuGobcZXF0paCakRNYNC9ctE+Dvk9nw==
X-Received: by 2002:a63:3f81:: with SMTP id m123mr10418782pga.335.1584055842638;
        Thu, 12 Mar 2020 16:30:42 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id 4sm58921560pfn.90.2020.03.12.16.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 16:30:41 -0700 (PDT)
Date:   Thu, 12 Mar 2020 16:30:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 20/20] rebase: rename the two primary rebase backends
Message-ID: <20200312233040.GG120942@google.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
 <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
 <ad8339aebf28ec84c22ed59cef06614d204adb55.1581802602.git.gitgitgadget@gmail.com>
 <20200312151318.GM212281@google.com>
 <CABPp-BHyNvxQZ5q=9WXXESTPmxFe4fAiE5roGeV2H+XJ_cpDmg@mail.gmail.com>
 <xmqqftedfkvy.fsf@gitster.c.googlers.com>
 <CABPp-BGvqUEDoj6_mUAsSVeS8+h5ruCFcMTENtf5LY2XWKVj-g@mail.gmail.com>
 <20200312203718.GA870787@coredump.intra.peff.net>
 <xmqqo8t1e01r.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo8t1e01r.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

>           So let's scrap the "am is taken as a synonym for apply".
> It would not help the old version taken from 'next' grok a new
> configuration file that uses "apply" anyway ;-)

Agreed.  For 2.26.0, I'm happy with either

- what we currently have, where it defaults to 'merge', or
- the more conservative approach where it supports 'merge' but defaults
  to 'apply'

Accepting multiple values for forward compatibility is an optional
cherry on top: I would like us to eventually get there, but I don't
mind if it doesn't make 2.26.0, and it's probably better to give a
change like that some cooking time.  (Although I won't complain if it
does make 2.26.0. ;-))

[...]
> We may want to think of a way to strongly encourage those who are in
> charge of choosing and maintaining the versions of Git that is used
> in their organization, whose operation depends on the healthy future
> versions of Git, to run 'next' or at least 'master', to stay ahead
> of the released versions.  Some education and advocacy is needed?

It's possible we should write up some best practices somewhere in
Documentation/ about how to make running "next" go smoothly:

- have a responsive infrastructure team.  Pay attention to changes
  landing upstream and have the infra team test before the rest of
  your user population :)

- if you have a large user population, use gradual rollouts so that a
  subset of users can find problematic changes before they affect
  everyone

- fast rollbacks

- telemetry to catch regressions (in latency, for example) when people
  are too shy to report them

We can also advertise places, such as Debian experimental, that people
can get snapshots without maintaining them themselves.

Thanks,
Jonathan
