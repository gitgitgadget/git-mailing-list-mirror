From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH 0/3] completion: Convention updates and DIRTYSTATE fix
Date: Wed, 11 Feb 2009 10:37:11 -0500
Message-ID: <1234366634-17900-1-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ted Pavlic <ted@tedpavlic.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Feb 11 16:39:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXHBJ-0002IF-2d
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 16:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbZBKPhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 10:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757501AbZBKPha
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 10:37:30 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:35901 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754703AbZBKPh0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 10:37:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 05A2F80D8085;
	Wed, 11 Feb 2009 10:30:55 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XIpFsdsmK8A4; Wed, 11 Feb 2009 10:30:54 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id E445280D8005;
	Wed, 11 Feb 2009 10:30:54 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.390.gba743
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109429>

Three more patches to git's bash completion script.

The first two are non-critical:
* The first patch changes two "git rev-parse" calls to "__gitdir" to
  match the convention used in the rest of the script.
* The second patch changes "[...]" to "test ..." to match git
  convention. In the one case of "[...] || [...]", a "test || test" call
  is used. Alternatively, a "test ... -o ..." call could be used, but
  that might not be as readable.

The third fixes an ugly error in the new GIT_PS1_DIRTYSTATE. In order to
determine whether the branch name needs a "*" following it, the
DIRTYSTATE implementation uses a "git diff." Because "git diff" is
illegal when not in a working tree, this command gives an ugly error
when changing directory to ".git". This patch detects this case and sets
"--work-tree=..". Is there a better fix?

Ted Pavlic (3):
  completion: For consistency, changed "git rev-parse" to __gitdir
    calls.
  completion: Change "if [...]" to "if test ..." to match git
    convention
  completion: Prevents GIT_PS1_DIRTYSTATE from breaking when CWD is
    .git

 contrib/completion/git-completion.bash |  101 +++++++++++++++-----------------
 1 files changed, 48 insertions(+), 53 deletions(-)
