From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Big repo not shrinking on repack or gc?
Date: Wed, 14 Jan 2015 14:07:31 +0100
Message-ID: <20150114130731.GD13247@inner.h.apk.li>
References: <20150114115130.GA5677@inner.h.apk.li> <20150114124936.GC30383@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 14:07:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBNfm-00035S-I4
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 14:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbbANNHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 08:07:36 -0500
Received: from continuum.iocl.org ([217.140.74.2]:55651 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbbANNHf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 08:07:35 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id t0ED7VU08695;
	Wed, 14 Jan 2015 14:07:31 +0100
Content-Disposition: inline
In-Reply-To: <20150114124936.GC30383@peff.net>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262385>

On Wed, 14 Jan 2015 07:49:36 +0000, Jeff King wrote:
> On Wed, Jan 14, 2015 at 12:51:30PM +0100, Andreas Krey wrote:
> 
> > I have a repo here that is 130G, but when I clone --mirror it, the result
> > is only 25G big.  Because of the --mirror I don't think that I missed
> > any refs that keep objects only in the source repo.
> 
> Perhaps some objects are mentioned by reflogs, but not by the refs? They
> would not be transferred as part of a clone. Try:
> 
>   git rev-list --objects --all | cut -d' ' -f1 | sort >reachable
>   git rev-list --objects --reflog | cut -d' ' -f1 | sort >reflogs

Actually, the output of 'git rev-list --objects --reflog' is empty, and
there isn't even a reflog (or similar) directory. (This is a bare repo
inside atlass. stash.)

...
> > I already tried 'git repack -fad' and 'git gc' to shrink the original repo,
> 
> You don't need the "-f" here. Just "git repack -ad" should be enough
> (and the "-f" probably makes it _way_ slower).

Right, the -f is an old workaround for old jgits in another repo.

Apparently, part of the trick is --prune=all or similar on 'git gc',
to get rid of the loose objects faster. That got a copy of the repo
down to around 70G - still way to go.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
