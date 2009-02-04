From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: do not consider diverging submodules a
 'dirty worktree'
Date: Wed, 04 Feb 2009 09:17:19 -0800
Message-ID: <7vvdrqunog.fsf@gitster.siamese.dyndns.org>
References: <cover.1233758410u.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.0902041540130.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 04 18:18:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUlOo-0005YS-W9
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 18:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbZBDRR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 12:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbZBDRR2
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 12:17:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58782 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbZBDRR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 12:17:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E61BB2A6EF;
	Wed,  4 Feb 2009 12:17:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D5AEE2A6F5; Wed, 
 4 Feb 2009 12:17:21 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B16BE488-F2DF-11DD-8D89-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108397>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> As filter-branch could not care less about submodules' actual contents,
> it does not make sense to check if the checked-out submodules are
> up-to-date before running filter-branch.  So do not do it.

Sorry, but I am confused.  Is that because even the tree-filter does not
use the actual work tree but works in the temporary area .git-rewrite, and
a diverged submodule cannot possibly matter (and index-filter works solely
on the index anyway)?

If so, why do we even check dirtiness of anything at all?

This is not a "wouldn't this better?" proposal patch, but a "why isn't the
patch like this?" question patch.

 git-filter-branch.sh |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git i/git-filter-branch.sh w/git-filter-branch.sh
index eb62f71..dda32e0 100755
--- i/git-filter-branch.sh
+++ w/git-filter-branch.sh
@@ -107,12 +107,6 @@ USAGE="[--env-filter <command>] [--tree-filter <command>] \
 OPTIONS_SPEC=
 . git-sh-setup
 
-if [ "$(is_bare_repository)" = false ]; then
-	git diff-files --quiet &&
-	git diff-index --cached --quiet HEAD -- ||
-	die "Cannot rewrite branch(es) with a dirty working directory."
-fi
-
 tempdir=.git-rewrite
 filter_env=
 filter_tree=
