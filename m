From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 0/3]: add git push --current and remote.*.pushHeadOnly
Date: Tue, 14 Jul 2009 01:07:39 +0200
Message-ID: <1247526462-17584-1-git-send-email-bonzini@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 14 01:08:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQUcy-0000nt-G2
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 01:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbZGMXHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 19:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753773AbZGMXHq
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 19:07:46 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:39441 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808AbZGMXHq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 19:07:46 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MQUcb-0007Sq-0r
	for git@vger.kernel.org; Mon, 13 Jul 2009 19:07:45 -0400
X-Mailer: git-send-email 1.6.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123209>

This second series is gets rid of the most annoying part
(IMHO) of push.default = tracking, i.e. the fact that its
behavior cannot be achieved using git's ordinary tools.
While autosetuppush is enough to set the refspecs correctly,
push.tracking does not push _all_ tracked branches, but
only the current one (because it implicitly adds only
one refspec, while autosetuppush places them all in the
configuration).

What I introduce here is "git push --current" and a companion
remote.*.pushHeadOnly option to make it the default.  The
difference between "git push HEAD" and "git push --current"
is that the latter will still walk the remote.*.push refspecs,
but honor only the one matching HEAD.

Together with autosetuppush, this more or less achieves the
same result as push.tracking, at least for newly created
remotes.  A subsequent series will handle the transition.

Patch 1 is the meat of the implementation.  Patch 2 touches
one detail about how to handle "git push --current" when
the remote does not have a corresponding push refspec.
Patch 3 adds remote.*.pushHeadOnly.

Paolo Bonzini (3):
 push: add --current
 change default push refspec when --current is given
 push: add remote.*.pushHeadOnly configuration

 Documentation/config.txt   |    6 ++++
 Documentation/git-push.txt |   15 +++++++++-
 builtin-push.c             |   15 ++++++++--
 http-push.c                |   27 ++++++++++++++----
 remote.c                   |   42 ++++++++++++++++++++++++-----
 remote.h                   |    3 ++
 t/t5516-fetch-push.sh      |   64 ++++++++++++++++++++++++++++++++++++++++++++
 transport.c                |   22 ++++++++++++++-
 transport.h                |    1 +
 9 files changed, 177 insertions(+), 18 deletions(-)
