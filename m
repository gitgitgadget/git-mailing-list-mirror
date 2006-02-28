From: Dave Jones <davej@redhat.com>
Subject: Re: someone changed the contents of my HEAD.
Date: Tue, 28 Feb 2006 00:58:47 -0500
Message-ID: <20060228055847.GC28434@redhat.com>
References: <20060228030446.GA23490@redhat.com> <7vlkvwt5v9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 06:59:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDxsx-00025b-9P
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 06:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWB1F64 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 00:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWB1F64
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 00:58:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38794 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750925AbWB1F64 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2006 00:58:56 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id k1S5wrgM017714;
	Tue, 28 Feb 2006 00:58:53 -0500
Received: from nwo.kernelslacker.org (vpn83-121.boston.redhat.com [172.16.83.121])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k1S5wl117052;
	Tue, 28 Feb 2006 00:58:47 -0500
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.5/8.13.5) with ESMTP id k1S5wlYM001407;
	Tue, 28 Feb 2006 00:58:47 -0500
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.5/8.13.5/Submit) id k1S5wlU9001406;
	Tue, 28 Feb 2006 00:58:47 -0500
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkvwt5v9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16919>

On Mon, Feb 27, 2006 at 09:22:18PM -0800, Junio C Hamano wrote:
 > > #!/bin/sh
 > > export GIT_AUTHOR_NAME="$1"
 > > export GIT_AUTHOR_EMAIL="$2"
 > > tree=$(git-write-tree) || exit 1
 > > commit=$(git-commit-tree $tree -p HEAD) || exit 1
 > > echo $commit > .git/HEAD
 > 
 > This has been deprecated for a looong time, but perhaps I should
 > have been louder.  "git commit --author" should be fine -- I do
 > not think you do not even need such a wrapper.

I guess I wasn't paying attention :)
It's worked just fine up until a few days ago.
I can change my habits to use the preferred approach though.

 > > For my newly created repos, this isn't a problem, as I can fudge my
 > > commit-as script to write to .git/refs/heads/master instead, but
 > > my concern now is the unpulled changes in the existing repos
 > > I have on master.  Will Linus be able to pull those into his tree
 > > with git 1.2.3, or will I have to recreate those repos with the
 > > new-style .git/HEAD ?
 >
 > A .git/HEAD symlink pointing at refs/heads/master _is_ still
 > (and will be) supported, so either symlink or symref is fine.
 > Bare SHA1 object name in HEAD is not -- git would not know which
 > branch you are on, so "checkin" would not work after that.
 > 
 > Your refs/heads/master might be stale (one rev or more older
 > than what you replaced .git/HEAD with) but still should be a
 > proper ancestor.  After making sure your refs/heads/master has
 > the right commit (you may have it there already if you have been
 > updating them using "git-push"), running "git-symbolic-ref HEAD
 > refs/heads/master" would fix things.

One scary thing fell out of this.  Andrew did a pull on my trees
and found bogons in both of them.  Both agpgart and cpufreq trees
contained partial (1 file) reverts of earlier commits in my last commit
to the head of each repo.  I can't explain how that happened, and
I'm surprised my head-munging would be the reason.

I've just rebuilt those two repos as there was only 3-4 patches
in both, so it wasn't a big deal. Something to watch out for
though if anyone else has been doing something similar to how
I was doing checkins.

		Dave
