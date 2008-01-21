From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Mon, 21 Jan 2008 15:27:35 +0100
Message-ID: <2885c7896ba72adee6bc5c9e2210a8881904f601.head.git.bonzini@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 13:21:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM0KS-0006Pl-SK
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 13:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbYBDMUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 07:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754066AbYBDMUq
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 07:20:46 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:42345 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbYBDMUp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 07:20:45 -0500
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1JM0JU-0007ny-1a
	for git@vger.kernel.org; Mon, 04 Feb 2008 07:20:40 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72496>

This series of patches adds a prepare-commit-msg hook.
The prepare-commit-msg hook is run whenever a "fresh" commit message
is prepared, just before it is shown in the editor (if it is).
It can modify the commit message in-place and/or abort the commit.
I implemented Alex Riesen's suggestion to tell the hook where the
message came from, and now run the hook even if the editor is not
run.

Patches 1 and 2 are small changes.  Patch 1 changes run_hook to
accept a variable-length NULL-terminated list of arguments.  Patch 2
forces GIT_EDITOR to : if editor will not be launched; this is the
simplest way I found to tell the prepare-commit-msg hook whether
the editor will be launched.

Patch 3 is bigger; it refactors parts of git-commit to do all the
log message processing at the same time.  Currently the message
is prepared soon, but only edited after the first part of the commit
object is prepared.  This simplifies a little the code for part 4.

Part 4 actually adds the hook, including documentation and testcases.
The hook takes two parameters.  The first is the source of the commit
message (detailed more in the commit message and in the docs), which
is either an English word or a commit SHA1.  The second
parameter if the name of the file that the commit log message.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
