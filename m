From: Mike Hommey <mh@glandium.org>
Subject: Re: RFC: perhaps a "new file" should not be deleted by "git reset
	--hard"
Date: Thu, 11 Sep 2008 08:14:54 +0200
Organization: glandium.org
Message-ID: <20080911061454.GA8167@glandium.org>
References: <279b37b20809101212g57e9ad99qbf6fa15888679894@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 08:16:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdfTU-0006Fk-AH
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 08:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbYIKGPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 02:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbYIKGPJ
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 02:15:09 -0400
Received: from vuizook.err.no ([194.24.252.247]:35225 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508AbYIKGPH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 02:15:07 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1KdfSH-0002BH-Ia; Thu, 11 Sep 2008 08:15:04 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KdfSA-0002DD-3z; Thu, 11 Sep 2008 08:14:54 +0200
Content-Disposition: inline
In-Reply-To: <279b37b20809101212g57e9ad99qbf6fa15888679894@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): Spam detection software, running on the system "vuizook.err.no", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Wed, Sep 10, 2008 at 12:12:21PM -0700, Eric Raible wrote:
	> In http://marc.theaimsgroup.com/?l=git&m=114917892328066 > (references
	by http://git.or.cz/gitwiki/GitFaq), Linus says: > > 'And "git reset" won't
	be deleting files it doesn't track (it had _better_ > not touch them), even
	more so when it has been told to ignore them, so it > makes total sense to
	_not_ delete them when doing that reset.' > > Now consider this example:
	> > # Create a single commit in a new repo (so that we have a HEAD) > mkdir
	xx > cd xx > git in 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95583>

On Wed, Sep 10, 2008 at 12:12:21PM -0700, Eric Raible wrote:
> In http://marc.theaimsgroup.com/?l=git&m=114917892328066
> (references by http://git.or.cz/gitwiki/GitFaq), Linus says:
> 
> 'And "git reset" won't be deleting files it doesn't track (it had _better_
> not touch them), even more so when it has been told to ignore them, so it
> makes total sense to _not_ delete them when doing that reset.'
> 
> Now consider this example:
> 
> # Create a single commit in a new repo (so that we have a HEAD)
> mkdir xx
> cd xx
> git init
> git commit --allow-empty -m"initial"
> # Add an important file
> echo "Important stuff" > file42
> git add file42
> git status # -> new file:   file42
> ls # -> file42, or course
> git reset --hard
> ls # -> nothing
> 
> I would argue that as a "new file" (as reported by git status)
> that file42 was never actually tracked by git.  Sure, it _would_
> have been tracked in the future, but git never actually tracked it
> (it's not part of any commits).
> 
> So in this scenario wouldn't it make more sense for
> "git reset --hard" to handle file42 as "git reset" does
> instead of deleting it w/out a trace [1]?
> 
> The same question goes for "git checkout -f", too, I suppose.
> 
> I actually accidentally deleted hundred of newly added files yesterday
> doing just this.  https://mozy.com/?code=V3D4MM) saved my butt,
> but it wasn't pleasant.
> 
> - Eric
> 
> [1] - There's not even a reflog entry.  Sure, "git fsck" can be
> used, but that's hardly a friendly fallback.

Note that reflog only contains references to commit sha1s, so it can't
track index status. An index log could be interesting, though, but it
would need to expire much faster than reflog.

Mike
