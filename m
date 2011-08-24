From: Jeff King <peff@peff.net>
Subject: Re: git for game development?
Date: Tue, 23 Aug 2011 21:24:18 -0400
Message-ID: <20110824012418.GA19091@sigill.intra.peff.net>
References: <416D1A48-9916-4E44-A200-3A13C39C4D70@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Lawrence Brett <lcbrett@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 03:24:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qw2Ch-0008AU-EX
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 03:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755893Ab1HXBYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 21:24:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49645
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515Ab1HXBYV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 21:24:21 -0400
Received: (qmail 29655 invoked by uid 107); 24 Aug 2011 01:25:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 23 Aug 2011 21:25:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Aug 2011 21:24:18 -0400
Content-Disposition: inline
In-Reply-To: <416D1A48-9916-4E44-A200-3A13C39C4D70@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179984>

On Tue, Aug 23, 2011 at 04:06:47PM -0700, Lawrence Brett wrote:

> I am very interested in using git for game development.  I will be working
> with a lot of binaries (textures, 3d assets, etc.) in addition to source
> files.  I'd like to be able to version these files, but I understand that
> big binaries aren't git's forte.  I've found several possible workarounds
> (git submodules, git-media, git-annex), but the one that seems most
> promising is bup.  I started a thread on the bup mailing list to ask about
> the best way to use bup with git for my purposes.  One of the respondents
> suggested forking git itself to include bup functionality, thereby extending
> git to handle binaries efficiently.
> 
> My question for this group is:  would there be interest in incorporating
> this sort of functionality into git core?  I would certainly find it
> compelling as a user, but have no idea how it would fit into the bigger
> picture.

Something bup-like in git-core might eventually be good. But IIRC, bup
introduces new object types, which mixes the abstract view of the data
format (i.e., commits, trees, and blobs indexed by sha1) with the
implementation details (e.g., now we have both loose objects in their
own files as well as delta-compressed objects in packfiles).

That means that bup-git clients and non-bup git clients don't interact
very well. Where non-bup is either a client that doesn't understand the
bup objects, or one that chooses not to use bup-like encoding for
particular blobs.

I don't remember all of the details of bup, but if it's possible to
implement something similar at a lower level (i.e., at the layer of
packfiles or object storage), then it can be a purely local thing, and
the compatibility issues can go away.

-Peff

PS I also agree with Junio's comment that we are not at the "planning a
solution" stage with big files, but rather at the "trying it and getting
experience on what works and what doesn't" stage.
