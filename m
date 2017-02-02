Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E152A20A78
	for <e@80x24.org>; Thu,  2 Feb 2017 02:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750847AbdBBCdz (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 21:33:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:48140 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750737AbdBBCdz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 21:33:55 -0500
Received: (qmail 1057 invoked by uid 109); 2 Feb 2017 02:33:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Feb 2017 02:33:55 +0000
Received: (qmail 16308 invoked by uid 111); 2 Feb 2017 02:33:56 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Feb 2017 21:33:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2017 03:33:51 +0100
Date:   Thu, 2 Feb 2017 03:33:51 +0100
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: git-scm.com status report
Message-ID: <20170202023349.7fopb3a6pc6dkcmd@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We (the Git project) got control of the git-scm.com domain this year. We
have never really had an "official" website, but I think a lot of people
consider this to be one.

This is an overview of the current state, as well as some possible
issues and future work.

## What's on the site

We have the domains git-scm.com and git-scm.org (the latter we've had
for a while). They both point to the same website, which has general
information about Git, including:

  - a general overview of Git

  - links to the latest releases (both source and some binary
    installers)

  - HTML-rendered copies of the manpages (both for the current version
    and historical versions)

  - an HTML rendering of the contents of the Pro Git book, along with
    translations. The book content is licensed cc-by-nc-sa and developed
    openly.

  - various external links to books, tutorials, GUI tools, etc

## How is it developed and hosted

The site is a Ruby on Rails app. The git repository is
https://github.com/git/git-scm.com. Modifications are generally done by
pull requests there. I have admin access on the repository.

The deployed site is hosted on Heroku. It's part of GitHub's
meta-account, and they pay the bills. I have access to it, and am the
only person who deploys updates. Other technical staff at GitHub have
access, too, because of the account setup, but don't generally
participate in maintenance.

It uses three 1GB Heroku dynos for scaling, which is $150/mo. It also
uses some Heroku addons which add up to another $80/mo.

## Who's the maintainer

These days, it's pretty much me, with a lot of help from Jean-Noël Avila
on issues with the Pro Git import and formatting code.

Long ago, the site content and code was done by Scott Chacon, with
graphic design help from Jason Long.  Scott maintained the site with
help from Bryan Turner for many years. But over time, they both seemed
to get less active, and I haven't seen a peep from either on the site's
GitHub repo in the past year. I've started trying to respond to issues
and pull requests to keep things healthy.

The site is mostly in maintenance mode, but things do need addressing.
People show up with new additions, fixes for typos, broken links and
other formatting problems, etc. There are a lot of long-standing
Asciidoc formatting problems both for the manpages and the imported Pro
Git content.

## What next

We can probably continue in maintenance mode like this for a while.
We've fixed a lot of of the long-standing formatting issues over the
past year, so maintaining seems to have subsided in the past few months
to mostly just merging or rejecting the occasional PR.

Still, if anybody is interested in helping with this work, I'd love to
have more eyes on it. I can give people access to the GitHub repo.
Unfortunately, I can't do so for the Heroku deploy, and part of the
maintenance burden is that the site is finicky and often needs manual
intervention (e.g., a fix to formatting requires rebuilding the
manpages, which needs a job run manually on Heroku).

It's possible that the content or visual design of the site could be
improved in various ways. I don't have any strong desires myself, but
maybe others do. If people start doing larger work, though, we have a
real lack of reviewers, and I have very little expertise with Rails or
with visual design. So anybody who wants to do this should be prepared to
take maintenance ownership.

At some point, GitHub may boot us off of the shared Heroku account,
because my impression is that it's somewhat of an administrative
headache. I don't think the Git project could afford the $230/mo hosting
fees; that's basically all the money we make. On the other hand, we
haven't actively solicited funds to any great degree, and it's possible
we could get GitHub or some other entity to just sponsor us with site
fees (I've heard zero complaints from GitHub about the money; it's
mostly just that the site is an oddball among their other assets).

With the caveat that I know very little about web hosting, $230/mo
sounds like an awful lot for what is essentially a static web site.
The site does see a lot of hits, but most of the content is a few basic
web pages, and copies of other static content that is updated
only occasionally (manpage content, lists of downloads, etc).  The biggest
dynamic component is the site search, I think.

I do wonder if there's room for improvement either:

  - by measuring and optimizing the Heroku deploy. I have no idea about
    scaling Rails or Heroku apps. Do we really need three expensive
    dynos, or a $50/mo database plan? I'm not even sure what to measure,
    or how. There are some analytics on the site, but I don't have
    access to them (I could probably dig around for access if there was
    somebody who actually knew how to do something productive with
    them).

  - by moving to a simpler model. I wonder if we could build the site
    once and then deploy a more static variant of it to a cheaper
    hosting platform. I'm not really sure what our options would be, how
    much work it would take to do the conversion, and if we'd lose any
    functionality.

If anybody is interested in tackling a project like this, let me know,
and I can try to provide access to whatever parts are needed.

-Peff
