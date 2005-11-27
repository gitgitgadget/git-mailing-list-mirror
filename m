From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 7/9] Add the accurate changeset applyer
Date: Sat, 26 Nov 2005 21:43:33 -0800
Message-ID: <20051127054333.GA4707@mail.yhbt.net>
References: <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com> <20051124074605.GA4789@mail.yhbt.net> <20051124074739.GB4789@mail.yhbt.net> <20051124074857.GC4789@mail.yhbt.net> <20051124075027.GD4789@mail.yhbt.net> <20051124075133.GE4789@mail.yhbt.net> <20051124075243.GF4789@mail.yhbt.net> <20051124075355.GG4789@mail.yhbt.net> <20051124075504.GH4789@mail.yhbt.net> <46a038f90511262024g4eca7dc2oa42d1f72febf9e27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sun Nov 27 06:44:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgFKD-00042z-4j
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 06:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbVK0Fnf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 00:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbVK0Fnf
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 00:43:35 -0500
Received: from hand.yhbt.net ([66.150.188.102]:61580 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1750875AbVK0Fne (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 00:43:34 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id E550F2DC033; Sat, 26 Nov 2005 21:43:33 -0800 (PST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511262024g4eca7dc2oa42d1f72febf9e27@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12798>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 11/24/05, Eric Wong <normalperson@yhbt.net> wrote:
> > And make it the default.
> 
> Cheeky, but right ;-)
> 
> Would it be a good idea to read the log entry and decide what kind of
> smarts do we need to apply the changeset? If the log entry looks
> plain, use process_patchset_fast(), else invoke $TLA?

This could work.  For it to work efficiently, process_patchset_fast()
should probably be modified to work on real Arch trees and rsync with
the git one.  Basically, we can replace the bulk of the tla replay calls
with your fast changeset applier.   Once the fast mode hits a changeset
it can't handle, it can do a tla replay on a single changeset instead of
having to do a slow get/apply-delta on an out-of-date tree.

process_patchset_fast() must understand how to handle permissions
changes, though, as Arch log entries are completely useless for that.

Unfortunately, doing this right and fast probably still requires more
time than it's worth.  Let's face it, trees with 12k files are extremely
rare in the Arch world (as are trees constantly reorganized by
obsessive-compulsives :), but many trees do get a small handful of
directory renames in their lifetime.

-- 
Eric Wong
