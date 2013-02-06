From: Jeff King <peff@peff.net>
Subject: Re: importing two different trees into a fresh git repo
Date: Wed, 6 Feb 2013 04:07:32 -0500
Message-ID: <20130206090731.GA6452@sigill.intra.peff.net>
References: <CAPKkNb6+ojb+uvBW+AkhGrhjR85LrJEbmR0KmvaKYb2Cj5Aa4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Constantine A. Murenin" <mureninc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 10:08:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U30z4-0006V8-P8
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 10:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261Ab3BFJHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 04:07:39 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35600 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716Ab3BFJHf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 04:07:35 -0500
Received: (qmail 3325 invoked by uid 107); 6 Feb 2013 09:09:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Feb 2013 04:09:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2013 04:07:32 -0500
Content-Disposition: inline
In-Reply-To: <CAPKkNb6+ojb+uvBW+AkhGrhjR85LrJEbmR0KmvaKYb2Cj5Aa4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215566>

On Tue, Feb 05, 2013 at 01:46:09PM -0800, Constantine A. Murenin wrote:

> I've encountered two problems so far:
> 
> 0. After initialising the repository, I was unable to `git checkout
> --orphan Debian-6.0.4-nginx-1.0.12` -- presumably it doesn't work when
> the repo is empty?  This sounds like a bug or an artefact of
> implementation.  I presume this can be worked around by committing
> into master instead, and then doing `git checkout -b
> Debian-6.0.4-nginx-1.0.12`, and then force-fixing the master somehow
> later on.

What version of git are you using? Using both "-b" and "--orphan" from a
non-existing branch used to be broken, but was fixed by abe1998 (git
checkout -b: allow switching out of an unborn branch, 2012-01-30), which
first appeared in git v1.7.9.2.

> 1. After making a mistake on my first commit (my first commit into
> OpenBSD-5.2-nginx-1.2.2 orphan branch ended up including a directory
> from master by mistake), I am now unable to rebase and "fixup" the
> changes -- `git rebase --interactive HEAD~2` doesn't work, which, from
> one perspective, makes perfect sense (indeed there's no prior
> revision), but, from another, it's not immediately obvious how to
> quickly work around it.

You cannot ask to rebase onto HEAD~2 because it does not exist (I'm assuming
from your description that HEAD~1 is the root of your repository). But
you can use the "--root" flag to ask git to rebase all the way down to
the roots, like:

  git rebase -i --root

However, note that older versions of git do not support using "--root"
with "-i". The first usable version is v1.7.12.

-Peff
