From: Jeff King <peff@peff.net>
Subject: Re: Possible vulnerability to SHA-1 collisions
Date: Tue, 27 Nov 2012 19:27:14 -0500
Message-ID: <20121128002714.GA23224@sigill.intra.peff.net>
References: <50B0AB9C.2040802@caltech.edu>
 <CAJo=hJsZdduMdSbN+3Ei-7vx3_Q7tO88LywWj5Vw3Ngs0QgsZg@mail.gmail.com>
 <20121127230753.GA22730@sigill.intra.peff.net>
 <20121127233016.GC3937@pug.qqx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Michael Hirshleifer <111mth@caltech.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 01:27:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdVUx-0008GI-CW
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 01:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851Ab2K1A1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 19:27:17 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58767 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752359Ab2K1A1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 19:27:16 -0500
Received: (qmail 30799 invoked by uid 107); 28 Nov 2012 00:28:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Nov 2012 19:28:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Nov 2012 19:27:14 -0500
Content-Disposition: inline
In-Reply-To: <20121127233016.GC3937@pug.qqx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210643>

On Tue, Nov 27, 2012 at 06:30:17PM -0500, Aaron Schrab wrote:

> At 18:07 -0500 27 Nov 2012, Jeff King <peff@peff.net> wrote:
> >PS I also think the OP's "sockpuppet creates innocuous bugfix" above is
> >  easier said than done. We do not have SHA-1 collisions yet, but if
> >  the md5 attacks are any indication, the innocuous file will not be
> >  completely clean; it will need to have some embedded binary goo that
> >  is mutated randomly during the collision process (which is why the
> >  md5 attacks were demonstrated with postscript files which _rendered_
> >  to look good, but contained a chunk of random bytes in a spot ignored
> >  by the postscript interpreter).
> 
> I don't think that really saves us though.  Many formats have parts
> of the file which will be ignored, such as comments in source code.

Agreed, it does not save us unconditionally. It just makes it harder to
execute the attack. Would you take a patch from a stranger that had a
kilobyte of binary garbage in a comment?

A more likely avenue would be a true binary file where nobody is
expected to read the diff.

> With the suggested type of attack, there isn't a requirement about
> which version of the file is modified.  So the attacker should be
> able to generate a version of a file with an innocuous change, get
> the SHA-1 for that, then add garbage comments to their malicious
> version of the file to try to get the same SHA-1.

That's not how birthday collision attacks usually work, though. You do
not get to just mutate the malicious side and leave the innocuous side
untouched. You are mutating both sides over and over and hoping to find
a matching sha1 from the "good" and "evil" sides.

Of course, I have not been keeping up too closely with the efforts to
break sha-1. Maybe there is something more nefarious about the current
attacks. I am just going off my recollection of the md5 collision
attacks.

-Peff
