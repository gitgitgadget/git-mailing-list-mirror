From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] blame: respect "core.ignorecase"
Date: Mon, 10 Sep 2012 17:41:52 -0400
Message-ID: <20120910214152.GA2139@sigill.intra.peff.net>
References: <1347210113-27435-1-git-send-email-ralf.thielow@gmail.com>
 <7v7gs3q9rp.fsf@alter.siamese.dyndns.org>
 <20120910161325.GB9435@sigill.intra.peff.net>
 <7vvcflmxis.fsf@alter.siamese.dyndns.org>
 <20120910203442.GA968@sigill.intra.peff.net>
 <7vtxv5lfsv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 23:42:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBBk3-0007TR-Jd
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 23:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138Ab2IJVl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 17:41:56 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40141 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755750Ab2IJVlz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 17:41:55 -0400
Received: (qmail 2070 invoked by uid 107); 10 Sep 2012 21:42:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Sep 2012 17:42:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2012 17:41:52 -0400
Content-Disposition: inline
In-Reply-To: <7vtxv5lfsv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205195>

On Mon, Sep 10, 2012 at 02:38:08PM -0700, Junio C Hamano wrote:

> > Thanks, that helped. I got excited when I saw the "icase" in the
> > comments and thought it might already be implemented. But it looks like
> > it is still to be done. :)
> 
> Yeah, some are tongue-in-cheek (e.g. I do not know what "recursive
> pathspec" even means), but "noglob" probably is an urgent need from
> correctness point of view for people who are writing Porcelain and
> want to interact with a history that records funny filenames.
> Currently you can "git <cmd> 'foo\*'" to match a path that is
> exactly 'foo*' (because it matches) but you also have to hope there
> is no other paths that happens to match that pattern.  A script that
> grabs paths out of ls-files output and then tries to use them as
> pathspec would want to have a way to say "This is literal. Do not
> honor globs in it".

I agree that the automatic globbing is currently a problem (although one
that comes up quite infrequently; I guess people use sane pathnames).
But I would think for that particular use case, you would not want to do
a per-glob prefix for that, but would rather use a command-line switch.
IOW, would you rather do:

  git ls-files |
  while read fn; do
    echo ":(noglob)$fn"
  done |
  xargs git log --stdin --

or:

  git ls-files |
  xargs git log --stdin --no-glob-pathspec --

?

-Peff
