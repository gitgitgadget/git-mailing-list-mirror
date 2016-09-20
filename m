Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F909209A9
	for <e@80x24.org>; Tue, 20 Sep 2016 19:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbcITTQG (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 15:16:06 -0400
Received: from mta02.prd.rdg.aluminati.org ([94.76.243.215]:40367 "EHLO
        mta02.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751594AbcITTQF (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Sep 2016 15:16:05 -0400
Received: from mta02.prd.rdg.aluminati.org (localhost [127.0.0.1])
        by mta.aluminati.local (Postfix) with ESMTP id 7A3CA2331C;
        Tue, 20 Sep 2016 20:16:03 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by mta02.prd.rdg.aluminati.org (Postfix) with ESMTP id 7283833CA;
        Tue, 20 Sep 2016 20:16:03 +0100 (BST)
X-Quarantine-ID: <chqvApYG8WmK>
X-Virus-Scanned: Debian amavisd-new at mta02.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
        by localhost (mta02.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id chqvApYG8WmK; Tue, 20 Sep 2016 20:16:00 +0100 (BST)
Received: from john.keeping.me.uk (unknown [10.2.0.9])
        by mta02.prd.rdg.aluminati.org (Postfix) with ESMTPSA id B738633CD;
        Tue, 20 Sep 2016 20:15:57 +0100 (BST)
Date:   Tue, 20 Sep 2016 20:15:55 +0100
From:   John Keeping <john@keeping.me.uk>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Jonas Thiel <jonas.lierschied@gmx.de>, git@vger.kernel.org
Subject: Re: Re: Homebrew and Git
Message-ID: <20160920191555.GB1673@john.keeping.me.uk>
References: <trinity-9c8f1bd1-d6be-48f3-8575-03be09bd1243-1474213828361@3capp-gmx-bs53>
 <20160920110228.GA64315@book.hvoigt.net>
 <20160920110700.GB64315@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160920110700.GB64315@book.hvoigt.net>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2016 at 01:07:00PM +0200, Heiko Voigt wrote:
> On Tue, Sep 20, 2016 at 01:02:28PM +0200, Heiko Voigt wrote:
> > Hi,
> > 
> > On Sun, Sep 18, 2016 at 05:50:28PM +0200, Jonas Thiel wrote:
> > > A while ago I have described my problem with Homebrew at the following
> > > GitHub channel
> > > (https://github.com/Homebrew/homebrew-core/issues/2970). In the
> > > meanwhile, I believe that I my problem with Homebrew is based on an
> > > issues with my Git. I have found the attached Git Crash reports on my
> > > Mac and because I am not familiar with reading/analysing Crash
> > > Reports, it would be great if someone could give me some feedback on
> > > it.
> > >  
> > > If you have any question, please do not hesitate to contact me.
> > 
> > From your crash reports I see that git is apparently crashing in a
> > strchr() call from within ident_default_email() which is a function that
> > tries to assemble a name and email to put into your commits.
> 
> BTW, here is the callstack inlined from the crashreport:
> 
> bsystem_platform.dylib      	0x00007fff840db41c _platform_strchr$VARIANT$Haswell + 28
> 1   git                           	0x000000010ba1d3f4 ident_default_email + 801
> 2   git                           	0x000000010ba1d68f fmt_ident + 66
> 3   git                           	0x000000010ba4b495 files_log_ref_write + 175
> 4   git                           	0x000000010ba4b0a6 commit_ref_update + 106
> 5   git                           	0x000000010ba4c3a8 ref_transaction_commit + 468
> 6   git                           	0x000000010b994dd8 s_update_ref + 271
> 7   git                           	0x000000010b994556 fetch_refs + 1969
> 8   git                           	0x000000010b9935f2 fetch_one + 1913
> 9   git                           	0x000000010b992bc4 cmd_fetch + 549
> 10  git                           	0x000000010b9666c4 handle_builtin + 478
> 11  git                           	0x000000010b96602f main + 376
> 12  libdyld.dylib                 	0x00007fff834ef5ad start + 1
> 
> Maybe someone else has an idea what might be causing this...

The only strchr I can see that could be called here is in
canonical_name(), where it's called with addrinfo::ai_canonname.

Searching for OS X and ai_canonname, leads me straight back to this
list, although 7 years ago!  I think ident.c needs a fix similar to
commit 3e8a00a (daemon.c: fix segfault on OS X, 2009-04-27); from the
commit message there:

	On OS X (and maybe other unices), getaddrinfo(3) returns NULL
	in the ai_canonname field if it's called with an IP address for
	the hostname.
