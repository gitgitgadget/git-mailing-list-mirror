From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] symbolic ref: refuse non-ref targets in HEAD
Date: Thu, 29 Jan 2009 03:01:45 -0500
Message-ID: <20090129080145.GA777@coredump.intra.peff.net>
References: <20090129045205.GA31183@coredump.intra.peff.net> <7vljsuh7kf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 09:03:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSRrm-0003k6-7g
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 09:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756056AbZA2IBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 03:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756052AbZA2IBs
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 03:01:48 -0500
Received: from peff.net ([208.65.91.99]:42655 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbZA2IBr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 03:01:47 -0500
Received: (qmail 29764 invoked by uid 107); 29 Jan 2009 08:01:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 29 Jan 2009 03:01:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2009 03:01:45 -0500
Content-Disposition: inline
In-Reply-To: <7vljsuh7kf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107642>

On Wed, Jan 28, 2009 at 11:53:20PM -0800, Junio C Hamano wrote:

> I generally do not like adding artificial limitation to plumbing like this
> patch does, because the end user making silly mistake using plumbing is a
> sign that there was something lacking in the Porcelain.

Nor do I. I only propose it in this case because

  1. We cannot possibly be hurting somebody's workflow, since it
     produces nonsensical results currently.

  2. The damage it does is so annoying to recover from.

I have no problem with symbolic-ref eventually learning to handle these
situations in some more sane manner; in the meantime, I think it makes
sense to prevent nasty breakage. And I don't think we're closing any
doors for the future; the behavior will switch from "you aren't allowed
to do this" to "does something sensible".

> But for this particular case, I do not think any future usage of
> symbolic-ref plubming will get inconvenienced with the change.  I would
> even suggest making the check tighter to insist on refs/heads/ (not just
> refs/) and tighten validate_headref() in path.c to match.

Reasonable. Updated series to follow.

> > Please beware that running the test script on the current "master" will
> > actually hose your git repo (test 3 kills the trash directory's
> > .git/HEAD, which means test 4 thinks your parent .git/ is its current
> > repo). Maybe it makes sense to do a precautionary reset in between.
> 
> In addition, perhaps it may make sense to use test_create_repo to go one
> level deeper before starting to play around, so that trash directory's
> repository will prevent you from going any further up.

That sort of helps, but only by luck. Each test kills off one layer of
repo. So the first one kills the test_create_repo, and the second one
kills the trash directory. Adding another test would kill off the main
repo. :) So you have to do something per-test. I'll do that in the
re-roll.

-Peff
