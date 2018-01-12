Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FF111F406
	for <e@80x24.org>; Fri, 12 Jan 2018 20:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964956AbeALU2i (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 15:28:38 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36899 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964847AbeALU2i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 15:28:38 -0500
Received: by mail-pf0-f171.google.com with SMTP id p1so5209968pfh.4
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 12:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ta/yjby62WzKpO98ezWzxVJT/vvcJceYoP2VqgW9e2Q=;
        b=qLYo1OvtoLjaGfl2SDLTlJ4ie3h45ZP1ZZDrnC7v3s0GFpdgAHmYrqVDahN2bsY1OM
         hyYVUB4gEAhaKkUKARK2MNPR8pYY7AKH6b8RDX8TTiQJsS7uzMgLi0OSEgc14sl4+JhO
         2t+I8yDmI1otemcJvOeCJ7tfnA8jGjq6E7UVgI1r7yc+7cAfs6bLgJjNPhxuhz98jJGg
         4qEsjfzvBLduQwHLPJPsPQ2xgNNpHUICQDP0ZwhExz0XYtfpbGWz7G4/cndThshYcFZ1
         8M5nHBvdlEbFzVUtfaIfbWXOvPrBKrv479khvs1P+BSDknLwKJtt8rCo++W9KQw+UAQO
         9aAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ta/yjby62WzKpO98ezWzxVJT/vvcJceYoP2VqgW9e2Q=;
        b=aY5OVcmrxQxB8WvE7WiWDXh2kH3kNuH+rYJ5etnLviIt+rXJQBCx8cGK5/Cq+TPr78
         2FT7haYR9NymowhJIKy0ba/ckupQe0iW5NFXiFFH08X/3uS2uUvnngbtO7tDRJB5lL1d
         Qu4fXwZ+RU15PzbHxDlqcSmZnqVE08uSqhRmp3i14WfEfgsTImQNO0qugATsDsZQA4l/
         Bd3gNY587DAX3MyY7Y70ioM/nLyz3NpxBgEYwjmj+FOaQYjlw8Q29eRf7sWQSoE+h6C/
         zt1oudXIoR8mqCkrSfoyZtlw/QgHr2I+KpiaJf9hv9Hu5rS8IOpriEnbsAHkOWd9foJI
         gT9A==
X-Gm-Message-State: AKwxytfzIZ6XI7sY7/lnQC76Q7EDTcSG6bJl1iO7MYosKQsSpJHxDuK4
        bH4pU34xx7KootpX/h3opziwYw==
X-Google-Smtp-Source: ACJfBosnuiV5dFehE5S6mggI1CdPwlChPK0I1ZkDCR0Vt4BhD42YdZaddtW1nud3qdy81w7DyjlqCw==
X-Received: by 10.84.248.131 with SMTP id q3mr7956748pll.5.1515788917313;
        Fri, 12 Jan 2018 12:28:37 -0800 (PST)
Received: from google.com ([2620:0:100e:422:1ce8:f9b2:923:333c])
        by smtp.gmail.com with ESMTPSA id 28sm26796470pfn.34.2018.01.12.12.28.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 Jan 2018 12:28:36 -0800 (PST)
Date:   Fri, 12 Jan 2018 12:28:35 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 4/4] trace.c: be smart about what env to print in
 trace_run_command()
Message-ID: <20180112202835.GA108169@google.com>
References: <20180111094712.2551-1-pclouds@gmail.com>
 <20180112095607.18293-1-pclouds@gmail.com>
 <20180112095607.18293-5-pclouds@gmail.com>
 <20180112133355.GE27499@sigill.intra.peff.net>
 <xmqqpo6fvstf.fsf@gitster.mtv.corp.google.com>
 <20180112184546.GA15514@sigill.intra.peff.net>
 <xmqqlgh2x4tr.fsf@gitster.mtv.corp.google.com>
 <20180112192314.GA19004@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180112192314.GA19004@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/12, Jeff King wrote:
> On Fri, Jan 12, 2018 at 11:19:44AM -0800, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > The actual prep_childenv() code looks like it would always do
> > > last-one-wins, so we should treat FOO as unset in that final case. But
> > > that only kicks in on non-Windows.
> > >
> > > On Windows we feed cmd->env straight to mingw_spawnvpe().  That ends up
> > > in make_environment_block(), which looks like it does something similar.
> > >
> > > It's too bad the prep code is not shared, since then we could probably
> > > just ask _it_ which deltas it applied.
> > 
> > Yeah, but that function does a lot more than computing delta.  
> > 
> > It's primary point, which comes from ae25394b ("run-command: prepare
> > child environment before forking", 2017-04-19), is to create a full
> > copy of the environment, not just a series of putenv/unsetenv that
> > describes what gets changed, and that is done to avoid any
> > allocation after fork before exec in the child process.
> > 
> > I guess prep_childenv() could take an extra and optional string-list
> > to report what "deltas" it applied to the tracing machinery.  I am
> > not sure if that is worth it, though.
> 
> Yes, that's exactly what I meant. I think if it covered all platforms it
> might be worth it (not so much for code de-duping, but because then we
> would know our display logic always matched what we exec'd). But unless
> somebody wants to refactor all of the Windows spawn code, it's
> definitely not a good idea.

And not having access to a windows box I didn't want to try and refactor
the windows-only code when I introduced prep_childenv() :)

-- 
Brandon Williams
