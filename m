From: Jeff King <peff@peff.net>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Mon, 26 Sep 2011 07:05:52 -0400
Message-ID: <20110926110552.GA20796@sigill.intra.peff.net>
References: <4E7AF1AE.5030005@alum.mit.edu>
 <CAG+J_DxtCx6-RKWLKFy+V7tOtu7UnUrke7iN8gNdGiY-sC52sQ@mail.gmail.com>
 <20110922171340.GA2934@sigill.intra.peff.net>
 <CAG+J_DxdP2qHhttJOtWQTKeiDV2YbC_A_F+b9sDOZsWhWxjcjw@mail.gmail.com>
 <20110922205856.GA8563@sigill.intra.peff.net>
 <4E7C5A3B.10703@alum.mit.edu>
 <20110923193341.GA26820@sigill.intra.peff.net>
 <4E7D7329.7070800@alum.mit.edu>
 <20110924061555.GB13974@sigill.intra.peff.net>
 <4E7DB916.6010606@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 26 13:06:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R890b-00046e-22
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 13:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921Ab1IZLF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 07:05:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44472
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843Ab1IZLF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 07:05:56 -0400
Received: (qmail 10355 invoked by uid 107); 26 Sep 2011 11:10:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Sep 2011 07:10:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2011 07:05:52 -0400
Content-Disposition: inline
In-Reply-To: <4E7DB916.6010606@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182102>

On Sat, Sep 24, 2011 at 01:03:50PM +0200, Michael Haggerty wrote:

> > But once you've verified that the config looks OK and turned this option
> > on, how do you protect yourself from malicious config entering the repo
> > through a fetch?
> 
> For most software projects, the user does
> 
>     git pull
>     make
> 
> daily.  There is nothing that a nasty .gitconfig can do that can't be
> done more easily by a nasty Makefile (or anything else in the build
> process).  The moment I pull from Junio's repository and run a build
> without having personally done a full code review first, I've given
> Junio complete pownership of my account.  For projects in which I invest
> such trust, "core.useTreeConfig=true" would be a convenience that does
> not appreciably increase my risk.

True. I think it would be nice for their to be a less risky option, too,
though.  Which was part of the motivation in my earlier proposal for
specifying a ref that contains config. Then you can ignore it, track
your own local config which is derived from upstream, or do the easy but
dangerous thing of just using the remote tracking ref directly.

> There are obviously config options that should not be versioned.  These
> should not be stored in the tree.  (Perhaps they should be stored in
> another branch, as you suggested.)  But there's no need to prevent
> people from versioning *any* config options just because they shouldn't
> version *all* of them.

Do you have an example of a config option whose old value should be
respected when looking at an old version? In general, the split between
attributes and config was meant to split what is tied to a specific
version, and what should apply to all versions. We may not have followed
that in all cases, but if so, the right solution may actually be
migrating the functionality into .gitattributes.

> While we are on the topic of config settings, I have often thought that
> it would be nice for git's default settings to be set via a
> well-commented config file, installed along with git, rather than via
> values compiled into the code.  This file and Documentation/config.txt
> could be generated from a single source file as part of the build
> process.

I think that can be a nice piece of documentation, but there may be some
complications.  I seem to recall that there may be one or two options
whose builtin values cannot be replicated via config (i.e., the "unset"
state means something). But I may be misremembering.

However, I'm not sure what you mean by "rather than via values compiled
into the code".  Would you somehow generate code that sets the default
according to your master file? Would git fail to start if the file is
missing? Or if a specific config option is missing? How would you track
that?

-Peff
