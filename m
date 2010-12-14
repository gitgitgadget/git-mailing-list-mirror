From: Jeff King <peff@peff.net>
Subject: Re: Can `add --patch` display the diff in my difftool instead of
 just printing it on the command line?
Date: Tue, 14 Dec 2010 16:38:10 -0500
Message-ID: <20101214213810.GB2216@sigill.intra.peff.net>
References: <AANLkTi=_VyUAL+qjWLEcThX-zC5n0v0WB-W7hTSZn0ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 22:38:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PScZj-00047L-LW
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 22:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542Ab0LNViP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 16:38:15 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35194 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348Ab0LNViP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 16:38:15 -0500
Received: (qmail 20729 invoked by uid 111); 14 Dec 2010 21:38:13 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 14 Dec 2010 21:38:13 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Dec 2010 16:38:10 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=_VyUAL+qjWLEcThX-zC5n0v0WB-W7hTSZn0ae@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163691>

On Tue, Dec 14, 2010 at 03:17:09PM -0600, Dun Peal wrote:

> I'd like to display the diff of each modified working copy file, and
> have the option of staging (or reversing) each patch after it is
> displayed. This is exactly the same thing `add --patch` does, except I
> want the diff to be displayed in my difftool (happens to be vimdiff)
> rather than just being printed.

You can't do this with "git add -p" now, but I suspect the patch would
be relatively straightforward. See patch_update_file in
git-add--interactive.perl. You just need to replace:

  for (@{$head->{DISPLAY}}) {
    print;
  }

with code to dump the diff in @{$head->{TEXT}} either to stdin of your
display program or to a tempfile that your program operates on.
Conditional on having some config option to specify your program, of
course.

Or did you want something more integrated with vimdiff? If you want to
primarily see the diff in vim and then have mappings set up to stage or
revert changes, that is pretty straightforward to do. Just have vim dump
the relevant hunk to "git apply --cached" or "git apply -R". I would be
surprised if the vim integration packages didn't have something like
this already.

-Peff
