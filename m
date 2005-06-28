From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: CAREFUL! No more delta object support!
Date: Tue, 28 Jun 2005 10:46:04 -0400
Message-ID: <20050628144604.GA15792@delft.aura.cs.cmu.edu>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org> <20050627235857.GA21533@64m.dyndns.org> <Pine.LNX.4.58.0506272016420.19755@ppc970.osdl.org> <7vekamvmxj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 16:42:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnHHj-0003hZ-Oe
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 16:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVF1OsX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 10:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVF1Oqs
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 10:46:48 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:58327 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261990AbVF1OqS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 10:46:18 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DnHLg-0005Kc-00; Tue, 28 Jun 2005 10:46:04 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vekamvmxj.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 28, 2005 at 02:40:56AM -0700, Junio C Hamano wrote:
> I am now dreaming if we someday would enhance the mechanism with
> append-only updates to the *.pack files with complete rewrite of
> the *.idx files, and get rid of files under .git/objects totally.

Stop dreaming, please.

The current separate objects setup might not be space efficient, but it
has many other advantages.

- Objects are only written only once, and from then on are only read.
  This works well on filesystems that provide session semantics, as
  opposed to unix semantics. And the resulting objects are perfectly
  cacheable since they are only invalidated if someone ever decides to
  pack the repository.

- The hierarchy and the way the objects directories are updated works
  very well in combination with AFS style directory acls. What surprised
  me was that subdirectories in refs/heads work perfectly with all the
  core git tools, branchnames simply become 'user/branch'.

- Objects that differ in content have different naming, as a result
  multiple developers can safely commit into a shared repository without
  requiring locks. This is also why it is safe to pull from another
  repository without clobbering your own history. Imagine if you
  appended some local changes to a packed archive and the next rsync
  wipes your local commits.

I've been trying to keep an up to date document on how (and why) I use
git on Coda. It started pretty much the identical to jgarzik's HOWTO.
But it ended up a lot more complicated, to a point where I needed my own
scripts for just about every action. Until I discovered that the
alternate objects pool would work well in my environment.

    http://www.coda.cs.cmu.edu/git.html

Jan
