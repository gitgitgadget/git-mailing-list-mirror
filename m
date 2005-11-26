From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/4] Repository format version check series.
Date: Fri, 25 Nov 2005 17:15:02 -0800
Message-ID: <7voe48gqg9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 26 02:16:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efoew-0004aa-4D
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 02:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVKZBPF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 20:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbVKZBPF
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 20:15:05 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:20450 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751432AbVKZBPE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 20:15:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051126011424.XURO6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 25 Nov 2005 20:14:24 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12759>

This series is what I've been cooking for the past several days,
partly based on patch from Martin Atukunda but with hopefully
smaller impact.

[PATCH 1/4] Repository format version check.
[PATCH 2/4] Check repository format version in enter_repo().
[PATCH 3/4] init-db: check template and repository format.
[PATCH 4/4] setup_git_directory(): check repository format version.

The first in the series adds the core.repositoryformatversion
configuration item.  The current repository format version is
defined as version 0, and is the same as not having that in the
configuration file.

The second one adds a repository format version check to
enter_repo().  This function is used to verify the path given by
the user, either from the command line or over the network, is a
valid git repository by daemon, upload-pack (which runs on the
other end when you run fetch-pack or clone-pack), and
receive-pack (which runs on the other end when you run
send-pack).

The third one makes sure we do not reinitialize a repository
whose format version we do not understand, do not copy
template files from unmatching version into a new repository,
and record the repository format version in a newly created
repository.

The last bit in the series adds the same check code to
setup_git_directory().  Along with the earlier change to
git-sh-setup that uses git-var to verify the repository, this
gives the shell scripts the same repository format version
check.

I'll push this out to the "master" sometime over the weekend,
and hopefully merge it into "maint" and cut the next 1.0rc on
Wednesday.  Let's hope that will be the last 1.0rc.
