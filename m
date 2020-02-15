Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F78C35242
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 00:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC382187F
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 00:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="1IMyKyWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgBOAA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:00:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33808 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbgBOAA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 19:00:26 -0500
Received: by mail-pg1-f194.google.com with SMTP id j4so5733565pgi.1
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 16:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IBPGSCmNXlvQ68PnZgc/Im78FhslCoYzDrAcogXUb0Y=;
        b=1IMyKyWKTGaPqRngjH58dZ3OmQoNmfiH2UXHRm6Y2jT7ny4viASNH8z/h32pFVcDa5
         WtvbcYQFunRGnHzT3Mn/y6F8pqWcpM4Nq0uzG7tUeFvYt2FqNDDYCoEmcPVJCpQS2Vf1
         ds45TPdkLtEIDZFGfaG1qbJVvf4kod3imeGg8dvEnvZG/mDMwkYUxYB4bH3wTPPc/Hnw
         7PuuRn2k/NhnzBjHiRv64Qgns8hmcrWOGdB1c1qKVQlgastlVv6I924wb0sqcIP7LsPp
         Z9/Oh59bXO3VnI1VmMbUTsUrDUj2P/Z523xv+9CgWsb7iewjAWlVotkWpYpbDWJyleaC
         fqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IBPGSCmNXlvQ68PnZgc/Im78FhslCoYzDrAcogXUb0Y=;
        b=i1HTCEAQSMoE9PpepI0fpQBQkaLnYKL+N0N79sD8WsuRRX/Lr6Ql1ZlJnKcr62Jc7h
         ApFcsPkjlNYqFZcGA5bnV2kIRyUFnY0c1k9tbUntPWq1kn9lJ8gK5tKk5PwjeWo1LGEh
         pi9jo2VskKp3QFmAzUPHVGWb4QEaKf7tQ2IIv+NU1+LYJlBnuepe/keRIYgf8rR7Qg1H
         A5ibqiEuo3OKkqRKM7OMGX6CFd1rN1+XfkyI+dQsROSwdx56LH5SY5qZG3lKv88pVKTR
         GyWFmaNlvaEjLF/EveCptOekXC5MUbcysC2UNzeBb0hz/8OX7VR7e96Ga5gWf/amLb2k
         uxkQ==
X-Gm-Message-State: APjAAAV7bKtQipVj+Dy2lGgBvl8b0q9MkBloEuW8KMO/0w6yFkSxtn7T
        fNifvniNN+Wn+uQwGBNbUpHy1g==
X-Google-Smtp-Source: APXvYqyg1L8K5MJMB6JqInaCTAoEA/UihW87iGCPdSLUd5s0jCS2yUB2YlK+TXMvDKL4+NmRRK66Dw==
X-Received: by 2002:a62:fc93:: with SMTP id e141mr5703423pfh.262.1581724824251;
        Fri, 14 Feb 2020 16:00:24 -0800 (PST)
Received: from localhost ([2600:100f:b02c:92d4:11e2:3a54:273f:b5fe])
        by smtp.gmail.com with ESMTPSA id 28sm8250531pgl.42.2020.02.14.16.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 16:00:23 -0800 (PST)
Date:   Fri, 14 Feb 2020 16:00:22 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Parth Gala via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Parth Gala <parthpgala@gmail.com>
Subject: Re: [PATCH 2/5] object.c: lookup_unknown_object() accept 'r' as
 parameter
Message-ID: <20200215000022.GB11400@syl.local>
References: <pull.545.git.1581535151.gitgitgadget@gmail.com>
 <16dd64618ab6a086727685e9eca3850fabc46437.1581535151.git.gitgitgadget@gmail.com>
 <20200212202540.GD4364@syl.local>
 <xmqqtv3vtst5.fsf@gitster-ct.c.googlers.com>
 <20200213180030.GF45518@syl.local>
 <xmqqh7zus6hm.fsf@gitster-ct.c.googlers.com>
 <20200213185235.GA15252@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213185235.GA15252@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 13, 2020 at 01:52:35PM -0500, Jeff King wrote:
> On Thu, Feb 13, 2020 at 10:10:45AM -0800, Junio C Hamano wrote:
>
> > > Right, but my suggestion was that this advice doesn't apply to this
> > > particular instance since I don't expect that we'd ever passing
> > > something other than 'the_repository'.
> > >
> > > Specifically, I was worried that we'd get bitten by re-assigning 'r' in
> > > the middle of the function and then end up in some odd broken state.
> >
> > "git fsck" works only in a single, "the", repository, so I guess you
> > are right to be worried about unnecessary complexity here.
>
> I think the end-game for this whole repository transition would be to
> get rid of the_repository, though. I.e., I'd envision the progression
> something like this:
>
>   1. Teach all of the library code to take (and operate on) "struct
>      repository".
>
>   2. Teach static local functions like this to pass in the_repository.
>
>   3. Teach top-level commands like cmd_fsck() to pass the_repository to
>      all of those static local helpers.
>
>   4. Teach top-level commands to get a real repository pointer, either
>      from the git.c wrapper (when RUN_SETUP is used) or by calling
>      setup_git_repository() themselves.
>
>   5. Grep for the_repository and drop it everywhere.
>
> Here we're at step 2 now, but declaring "r" makes moving to step 3 just
> a little easier. And I think the existence of steps 4 and 5 implies that
> it would eventually be worth going through step 3.

Ah, the transition to step 3 justifies this, I think. I wasn't aware
that steps 3+ existed. If they didn't, I'd stand by my original advice,
but given that they do, the approach here makes more sense long-term.

> Of course I just wrote those steps down for the first time, so maybe
> nobody else shares my vision. ;)

Thanks for writing it down. I'm sure that it has been loosely discussed
over a while, but this is the first time that I've seen it all in one
place.

> -Peff

Thanks,
Taylor
