Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E181C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 22:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8BB20708
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 22:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EVKOXMzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfKVWCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 17:02:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45176 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVWCs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 17:02:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id k1so3944548pgg.12
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 14:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lTrrIfxbOV2rroVpfnjcY2XImqgNzC8Hws2DTBUrUBc=;
        b=EVKOXMzIbk/DKysqph5ts3983LSm0je/IPsM5k8ex8hIQZXL4Q3skQzDY5gTwieoN6
         uI0IbyeANEQn7me4tjseyum6TQDNrFj4WzH/c/I0t2npZQ/n+k5TRFgeuqnRuSumh80V
         t5K6qggbw3U3Qm//czAnEsgIZovOIElV+7Qzqh3OCPNQrBgPLakbEaeaSxuqPe03oau2
         oNdYsTOT76HGKrp21dZ8c2h3+PvQ4IwlbrkqN4AhCwtH/ZMDBE0TN8ddhE39yBCeI1Wr
         Iblgcr4+xU/juk7cL8TZIdG13m3DIUzB5Wcj1B3wzXxzElRBbpDen1UKY6eEMEaqnqRw
         Cajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lTrrIfxbOV2rroVpfnjcY2XImqgNzC8Hws2DTBUrUBc=;
        b=m2KiA1rXn6Eh/Bgat8pYHp1fgsFj1xD66K5eIIjU5EKDAxOTMuWDyIQKyT24OlKAvK
         yaQnsk6oLbXojQWpRcTPiKqrXOwIsVeRDrnJoWGf3EvvKktWZeXQCmMM1PTWtNwBAtet
         Kw4S2DGlhaeDkEfh1D2z1vio2V0IRY5huOj4eo45FuJav6a6vfLdjnto6E2lX1Lg5LZz
         6EP0VRHt0VXw1QDbK1mL+uKxYfC6O29gxPzi1x/7xi/ZYH6bPxZMbXPBkQ6ESiCI7JBN
         fBeIdSVlXy31tkf9e2rT+4439e8iL9YygxxrkJrgjBz3K3Jxnmdmu/XXv+JS1Z8CrkCe
         vQEw==
X-Gm-Message-State: APjAAAWFt9iZXCPTDAfxY+CPeh2NGYHNmg/ns+NhB6q5bDRIE92RLEiT
        x+5lDNmp1A4tDLmwIg16siM9T3VbaOA=
X-Google-Smtp-Source: APXvYqwOWT+zBQtq2bGjYj5cPDNNyXgDP5NqdVMHSDpPGvKMeWoHdNF4aYQJ+q94P7uuGCtGau0dFw==
X-Received: by 2002:a63:ed58:: with SMTP id m24mr18612983pgk.111.1574460167583;
        Fri, 22 Nov 2019 14:02:47 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id d8sm8310017pfo.47.2019.11.22.14.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 14:02:47 -0800 (PST)
Date:   Fri, 22 Nov 2019 14:02:41 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] grep: provide pathspecs/patterns via file or stdin
Message-ID: <20191122220241.GA56020@google.com>
References: <20191122011646.218346-1-emilyshaffer@google.com>
 <20191122021419.GA52557@generichostname>
 <xmqqwobs7i6u.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwobs7i6u.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 22, 2019 at 11:34:17AM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > The reason I ask is because (correct me if I'm wrong) a lot of other git
> > commands (like add, reset and checkout) don't seem to accept pathspecs
> > via stdin and could suffer the same problem. xargs seems like a more
> > general way of solving the problem of long command lines.
> 
> You contributors who are potentially throwing your own topics into
> the cauldron, please be paying a bit more attention to other topics
> already cooking in the pot.  I think am/pathspec-from-file wants to
> go in the general direction.

Thanks for pointing it out. It is certainly easy to miss the big picture
when you spend your time looking at a bug queue instead of a review
queue; we who stand in different places see different things more
clearly. I appreciate the reminder to look around a little more.

am/pathspec-from-file does solve this issue in the way that we discussed
internally, so I'm excited to base a solution for this issue on that
branch instead.

In this situation - where it is not a related fixup for a branch in
next, but the topic does rely on that branch - should I send a series
which is based on 'next'? How do I make the dependency clear to you via
emailed patch?

 - Emily
