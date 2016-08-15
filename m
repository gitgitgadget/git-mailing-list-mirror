Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5DE41F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 20:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbcHOUGE (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 16:06:04 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50696 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbcHOUGE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 16:06:04 -0400
Received: from mfilter22-d.gandi.net (mfilter22-d.gandi.net [217.70.178.150])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 3369F172094;
	Mon, 15 Aug 2016 22:06:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter22-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
	by mfilter22-d.gandi.net (mfilter22-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 6F8UYeEmZQfp; Mon, 15 Aug 2016 22:05:58 +0200 (CEST)
X-Originating-IP: 192.55.48.10
Received: from x (unknown [192.55.48.10])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 6E4D11720A5;
	Mon, 15 Aug 2016 22:05:56 +0200 (CEST)
Date:	Mon, 15 Aug 2016 13:05:53 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Simon Glass <sjg@chromium.org>
Cc:	Stephen Warren <swarren@wwwdotorg.org>,
	Git List <git@vger.kernel.org>,
	lk <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
Message-ID: <20160815200553.ettprytevjjk7a6b@x>
References: <20160729064055.GB25331@x>
 <b7bd1464-1412-1feb-fe10-9ecb6018e122@wwwdotorg.org>
 <20160801183750.ivwue4mxm5ilgzqz@x>
 <CAPnjgZ2-sWuibLGK-AR2D=mM=MoOrQM9OVuJnCtVAE5GYqJXcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2-sWuibLGK-AR2D=mM=MoOrQM9OVuJnCtVAE5GYqJXcQ@mail.gmail.com>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 12:17:11PM -0600, Simon Glass wrote:
> On 1 August 2016 at 12:37, Josh Triplett <josh@joshtriplett.org> wrote:
> > On Mon, Aug 01, 2016 at 09:14:54AM -0600, Stephen Warren wrote:
> >> On 07/29/2016 12:40 AM, Josh Triplett wrote:
> >> > I'd like to announce a project I've been working on for a while:
> >> >
> >> > git-series provides a tool for managing patch series with git, tracking
> >> > the "history of history". git series tracks changes to the patch series
> >> > over time, including rebases and other non-fast-forwarding changes. git
> >> > series also tracks a cover letter for the patch series, formats the
> >> > series for email, and prepares pull requests.
> >>
> >> Just as an FYI, I wouldn't be surprised if there's some overlap, or
> >> potential for merging of tools, between this tool and the "patman" tool
> >> that's part of the U-Boot source tree:
> >>
> >> http://git.denx.de/?p=u-boot.git;a=blob;f=tools/patman/README;h=e36857dedea1d0dbafa41732aaf9bf0988d63f38;hb=HEAD
> >
> > Interesting tool; thanks for the link.
> >
> > As far as I can tell from that documentation, patman doesn't track old
> > versions of a patch series; you rebase to modify patches or change
> > patman tags (embedded in commit messages), and nothing preserves the
> > previous version.  And it tracks the cover letter and similar in one of
> > the commit messages in the series, so previous versions of that don't
> > get saved either.  If you wanted to track the history of your changes,
> > you'd have to use branch names or similar.
> 
> That's right. Normally you would keep the old branch around, or tag
> it. Of course old branches are often based on older versions the
> upstream repo, so they are not that useful for diiff, etc. But the
> normal procedure when updating a series to a new version is:
> 
> git checkout -b wibble-v2 wibble
> git rebase upstream/master

That's the workflow I used before git-series, as well.  Having to create
versioned branch names motivated creating git-series; the branch names
in the git-series documentation ("feature-v8-rebased-4.6-alice-fix") are
*reduced* versions of actual branch names used for internal projects.

> > In addition, tracking metadata in commit messages only works with a
> > patches-by-mail workflow where the messages get processed when
> > generating patches; that doesn't work for please-pull workflows.
> 
> Can you explain what a please-pull workflow looks like, and what tags
> are expected?

You push the branch somewhere, as a branch or tag, and then use git
request-pull or otherwise tell someone "please pull from here".  They
pull the *exact* commit hashes you pushed, including whatever you based
them on.  That means they get the exact commit messages you pushed.  So,
if you have any inline metadata in the commit message, that would end up
in the project history.  The Linux kernel and other projects object to
getting those kinds of bits in commit messages; I've seen many patches
rejected because they included a Gerrit Change-Id.

Tracking the history and cover letter in a separate string of "series
commits" allows the underlying patch series to contain the exact commits
you want upstream to pull, without any postprocessing required.

- Josh Triplett
