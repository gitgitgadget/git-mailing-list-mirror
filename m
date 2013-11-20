From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7507-*.sh: Fix test #8 (could not run '"$FAKE_EDITOR"')
Date: Wed, 20 Nov 2013 12:42:27 -0500
Message-ID: <20131120174226.GA16453@sigill.intra.peff.net>
References: <528CE716.8060307@ramsay1.demon.co.uk>
 <xmqqsiur6l9k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, Jens.Lehmann@web.de,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 20 18:42:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjBnN-0000Q5-C9
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 18:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001Ab3KTRm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 12:42:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:42710 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753942Ab3KTRm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 12:42:28 -0500
Received: (qmail 24056 invoked by uid 102); 20 Nov 2013 17:42:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Nov 2013 11:42:28 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Nov 2013 12:42:27 -0500
Content-Disposition: inline
In-Reply-To: <xmqqsiur6l9k.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238089>

On Wed, Nov 20, 2013 at 09:22:31AM -0800, Junio C Hamano wrote:

> > commit 61b6a633 ("commit -v: strip diffs and submodule shortlogs
> > from the commit message", 19-11-2013) in 'pu' fails the new test
> > it added to t7507.
> >
> > I didn't spend too long looking at the problem, so take this patch
> > as nothing more than a quick suggestion for a possible solution! :-P
> > [The err file contained something like: "There was a problem with the
> > editor '"$FAKE_EDITOR"'"].
> >
> > Having said that, this fixes it for me ...
> 
> Well spotted.  test_must_fail being a shell function, not a command,
> we shouldn't have used the "VAR=val cmd" one-shot environment
> assignment for portability.

Yeah, I noticed that, too upon reading Ramsay's patch. But I thought the
usual symptom there was that the variable is not properly unset after
the function returns? In other words, it might affect later tests, but
the failure that Ramsay sees is in _this_ test, so it must be a separate
issue.

The test_set_editor helper does some magic to help with quoting, but
that should not be an issue in this case (since we are using "cat"). We
are using test_set_editor elsewhere in the script, which would have set
EDITOR previously. But I would think that GIT_EDITOR, which we are using
here, would supersede that. However, the error message he shows
indicates that git is using EDITOR (as FAKE_EDITOR is part of that quote
magic).

Am I misremembering the issues with one-shot variables and functions?

Puzzled...

-Peff
