From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 8 Feb 2008 19:49:02 +0100
Organization: glandium.org
Message-ID: <20080208184902.GA19404@glandium.org>
References: <200802081828.43849.kendy@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jan Holesovsky <kendy@suse.cz>
X-From: git-owner@vger.kernel.org Fri Feb 08 19:49:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNYI6-00054R-OJ
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 19:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758504AbYBHStI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 13:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758570AbYBHStH
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 13:49:07 -0500
Received: from vuizook.err.no ([85.19.215.103]:52762 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757961AbYBHStF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 13:49:05 -0500
Received: from aputeaux-153-1-42-109.w82-124.abo.wanadoo.fr ([82.124.6.109] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JNYIN-0003lF-Bi; Fri, 08 Feb 2008 19:50:01 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JNYHX-0005em-0F; Fri, 08 Feb 2008 19:49:03 +0100
Content-Disposition: inline
In-Reply-To: <200802081828.43849.kendy@suse.cz>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73123>

On Fri, Feb 08, 2008 at 06:28:43PM +0100, Jan Holesovsky wrote:
> Hi,
> 
> This is my attempt to implement the 'lazy clone' I've read about a bit in the
> git mailing list archive, but did not see implemented anywhere - the clone
> that fetches a minimal amount of data with the possibility to download the
> rest later (transparently!) when necessary.  I am sorry to send it as a huge
> patch, not as a series of patches, but as I don't know if I chose a way that is
> acceptable for you [I'm new to the git code ;-)], I'd like to hear some
> feedback first, and then I'll split it into smaller pieces for easier
> integration - if OK.
> 
> Background:
> 
> Currently we are evaluating the usage of git for OpenOffice.org as one of the
> candidates (SVN is the other one), see
> 
>   http://wiki.services.openoffice.org/wiki/SCM_Migration
> 
> I've provided a git import of OOo with the entire history; the problem is that
> the pack has 2.5G, so it's not too convenient to download for casual
> developers that just want to try it.  Shallow clone is not a possibility - we
> don't get patches through mailing lists, so we need the pull/push, and also
> thanks to the OOo development cycle, we have too many living heads which
> causes the shallow clone to download about 1.5G even with --depth 1.  Lazy
> clone sounded like the right idea to me.  With this proof-of-concept
> implementation, just about 550M from the 2.5G is downloaded, which is still
> about twice as much in comparison with downloading a tarball, but bearable.
<snip>

There are 2 things, here:
- Probably, you can make your pack smaller with proper window sizing.
Try taking a look at the "Git and GCC" that crossed borders between
the gcc and the git mailing lists.
- There are tricks to do roughly what you want without modifying git.
For example, you can prepare several "shared" clones of your repo (git
clone -s) and leave in each only a few branches. Cloning from these will
only pull the needed data.

Mike
