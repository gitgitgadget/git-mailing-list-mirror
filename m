Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9086B2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 18:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbdKUSf6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 13:35:58 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:43663 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbdKUSf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 13:35:57 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:36922 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eHDOn-0001sa-0s; Tue, 21 Nov 2017 13:35:57 -0500
Date:   Tue, 21 Nov 2017 13:34:34 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] notes: fix erroneous "git notes prune [-n | -v]"
 message
In-Reply-To: <20171121175846.GB27041@aiede.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.21.1711211328070.4528@localhost.localdomain>
References: <alpine.LFD.2.21.1711211156110.10397@DESKTOP-1GPMCEJ> <20171121175846.GB27041@aiede.mtv.corp.google.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 21 Nov 2017, Jonathan Nieder wrote:

> Hi,
>
> Robert P. J. Day wrote:
>
> > It seems clear that the man page SYNPOSIS and the usage message
> > referring to:
> >
> >   git notes prune [-n | -v]
> >
> > is incorrect, as "-n" (dry run) and "-v" (verbose) are not
> > alternatives, so fix both places to refer to:
> >
> >   git notes prune [-n] [-v | -q]
> >
> > to match the rest of the man page.
> >
> > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> > ---
>
> Hm.  What does "git notes prune -q" do?
>
> The docs describe what --dry-run and --verbose do for "git notes prune"
> but its description of --quiet seems to be specific to "git notes
> merge".  Should the usage summary be
>
>  git notes [--ref=<notes-ref>] prune [-n] [-v]
>
> instead?  That would also be consistent with "git notes prune -h":
>
>   $ git notes prune -h
>   usage: git notes prune [<options>]
>
>       -n, --dry-run         do not remove, show only
>       -v, --verbose         report pruned notes

  you're right ... i'm just getting familiar with the whole
parse-options.h stuff, and confused OPT__VERBOSE with OPT__VERBOSITY:

  #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
  #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
  #define OPT__VERBOSITY(var) \
        { OPTION_CALLBACK, 'v', "verbose", (var), NULL, N_("be more verbose"), \
          PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }, \
        { OPTION_CALLBACK, 'q', "quiet", (var), NULL, N_("be more quiet"), \
          PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }

so it should simply be corrected to:

  git notes prune [-n] [-v]

sound about right?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
