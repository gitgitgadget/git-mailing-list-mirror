Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFC59202F2
	for <e@80x24.org>; Wed, 22 Nov 2017 11:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbdKVLlf (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 06:41:35 -0500
Received: from ikke.info ([178.21.113.177]:48560 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752044AbdKVLlf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 06:41:35 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 78A394400DD; Wed, 22 Nov 2017 12:41:33 +0100 (CET)
Date:   Wed, 22 Nov 2017 12:41:33 +0100
From:   Kevin Daudt <me@ikke.info>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] gitcli: tweak "man gitcli" for clarity
Message-ID: <20171122114133.GD16418@alpha.vpn.ikke.info>
References: <alpine.LFD.2.21.1711211626460.26166@localhost.localdomain>
 <20171121214552.GB16418@alpha.vpn.ikke.info>
 <alpine.LFD.2.21.1711220453290.3814@DESKTOP-1GPMCEJ>
 <xmqq3756txeg.fsf@gitster.mtv.corp.google.com>
 <alpine.LFD.2.21.1711220616230.11319@DESKTOP-1GPMCEJ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1711220616230.11319@DESKTOP-1GPMCEJ>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 06:19:23AM -0500, Robert P. J. Day wrote:
> On Wed, 22 Nov 2017, Junio C Hamano wrote:
> 
> > "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
> >
> > > git repo with a file called "Gemfile", so i created a branch called
> > > "Gemfile", and when i ran:
> > >
> > >   $ git checkout Gemfile
> > >
> > > git switched to the branch. so even with the ambiguity, git
> > > obviously has some sort of precedence order it checks. so what are
> > > the rules here?
> >
> > 31b83f36 ("Merge branch 'nd/checkout-disambiguation'", 2016-09-26)
> > should have made it clear that the "checkout" command has a
> > convenience special case.
> 
>   ok, then i'm still curious about git examples that actually fail due
> to an inability to disambiguate.
> 
> rday

Here is an example with git diff

    $ git init git-disambiguate
    $ cd git-disambiguate
    $ echo 1 >foo && git add foo && git commit -m foo
    $ git branch foo
    $ echo 2 >>foo && git add foo && git commit -m foo2
    $ echo 3 >>foo

    $ git diff foo
    fatal: ambiguous argument 'foo': both revision and filename
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'
    
    $ git diff HEAD foo
    fatal: ambiguous argument 'foo': both revision and filename
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'

    $ git diff HEAD -- foo
    diff --git a/foo b/foo
    index 1191247..01e79c3 100644
    --- a/foo
    +++ b/foo
    @@ -1,2 +1,3 @@
     1
     2
    +3

    $ git diff HEAD foo --
    diff --git a/foo b/foo
    index 1191247..d00491f 100644
    --- a/foo
    +++ b/foo
    @@ -1,2 +1 @@
     1
    -2
 
