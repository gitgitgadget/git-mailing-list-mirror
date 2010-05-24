From: Jeff Epler <jepler@unpythonic.net>
Subject: 'git pull --dry-run' accepted, but moves HEAD and changes working
	tree
Date: Mon, 24 May 2010 08:58:23 -0500
Message-ID: <20100524135823.GC19861@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 24 15:58:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGYAq-0007Ws-6k
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 15:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757135Ab0EXN61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 09:58:27 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:33232 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757073Ab0EXN61 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 09:58:27 -0400
Received: by unpythonic.net (Postfix, from userid 1000)
	id BE92011469D; Mon, 24 May 2010 08:58:23 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147632>

I don't recall why I initially typed it, I was surprised to discover
that 'git pull --dry-run' moves HEAD and modifies the working tree.

Here's an example:
$ git reset --hard HEAD^  # so there's something on origin to merge
HEAD is now at c26a08d fix clearing of mesa components
$ git rev-parse HEAD; git pull --dry-run; git rev-parse HEAD
c26a08d1535a02ec044efd0d1fa50205d2da03fa
Updating c26a08d..41c8ee3
Fast-forward
 docs/man/man9/hostmot2.9                |    7 +++++--
 src/hal/drivers/mesa-hostmot2/stepgen.c |    5 +++++
 2 files changed, 10 insertions(+), 2 deletions(-)
41c8ee3e19ffb13cc357375d87940cac4769e029
$ git --version
git version 1.7.1

On IRC, jast points out that 'git pull --dry-run' is not explicitly
documented, but unfortunately it is accepted and then does something
that is really counter to the user's expectations. (I assume it's
passing --dry-run to fetch, which does accept it, but that doesn't
ensure that there's nothing at all to merge)

Maybe 'git pull --dry-run' should just be forbidden, or maybe it could
tell the user whether the result of the pull would be a merge, FF, or no
change.

Jeff
