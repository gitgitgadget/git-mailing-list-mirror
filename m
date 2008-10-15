From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH] rebase-i-p: squashing and limiting todo
Date: Wed, 15 Oct 2008 02:44:33 -0500
Message-ID: <cover.1224055978.git.stephen@exigencecorp.com>
Cc: git@vger.kernel.org, Stephen Haberman <stephen@exigencecorp.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 15 09:46:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq14z-00012V-3G
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 09:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbYJOHop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 03:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbYJOHop
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 03:44:45 -0400
Received: from smtp162.sat.emailsrvr.com ([66.216.121.162]:49863 "EHLO
	smtp162.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbYJOHoo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 03:44:44 -0400
Received: from relay6.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay6.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 1ABCC1E06A9;
	Wed, 15 Oct 2008 03:44:44 -0400 (EDT)
Received: by relay6.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id B80411E0660;
	Wed, 15 Oct 2008 03:44:43 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98247>

This is v3, rebased on top of sp/maint with sp/master and sh/maint-rebase3.

So, it should apply cleanly to that. Junio's feedback aside, the only change
from v2 is that maint-rebase3's dropped commit check needs to be done before
Johannes's recent addition of:

    test -s "$TODO" || echo noop >> "$TODO"

Because now the todo may temporarily have picks in it while probing for parents
that could later be removed by the dropped/cherry-picked commit check.

Previously todo never had temporary entries, so it didn't matter when the
dropped commit check was done.

(Apologies for not seeing Junio's what's cooking first and using his
maint/master instead of Shawn's. Let me know if I need to redo this and I will
get even more practice at rebasing.)

(Gah, resending with the list cc'd this time. Dammit, sorry about that.)

Thanks,
Stephen

Stephen Haberman (7):
  rebase-i-p: test to exclude commits from todo based on its parents
  rebase-i-p: use HEAD for updating the ref instead of mapping OLDHEAD
  rebase-i-p: delay saving current-commit to REWRITTEN if squashing
  rebase-i-p: fix 'no squashing merges' tripping up non-merges
  rebase-i-p: only list commits that require rewriting in todo
  rebase-i-p: do not include non-first-parent commits touching UPSTREAM
  rebase-i-p: if todo was reordered use HEAD as the rewritten parent

 git-rebase--interactive.sh               |  131 ++++++++++++++++++-----------
 t/t3411-rebase-preserve-around-merges.sh |  136 ++++++++++++++++++++++++++++++
 2 files changed, 218 insertions(+), 49 deletions(-)
 create mode 100644 t/t3411-rebase-preserve-around-merges.sh
