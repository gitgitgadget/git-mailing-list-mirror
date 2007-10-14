From: Steffen Prohaska <prohaska@zib.de>
Subject: change push's refspec behavior to match rev-parse
Date: Sun, 14 Oct 2007 10:54:39 +0200
Message-ID: <11923520851713-git-send-email-prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 10:55:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgzFT-0006lW-W6
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 10:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341AbXJNIyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 04:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754269AbXJNIys
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 04:54:48 -0400
Received: from mailer.zib.de ([130.73.108.11]:58223 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753818AbXJNIyr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 04:54:47 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9E8sjAM025862
	for <git@vger.kernel.org>; Sun, 14 Oct 2007 10:54:45 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9E8sjYr021275;
	Sun, 14 Oct 2007 10:54:45 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60810>

This patch series addresses recent complaints about the behavior of push/send-pack
when expanding short refspecs. The overall idea is to change push's handling of
refspecs to match the behavior of rev-parse.


The old way of matching short refspecs in push is often unexpected as
discussed in [1]. Now "git push <ref>" resolves ref the same way as rev-parse.

[1] http://marc.info/?l=git&m=119224567631084&w=2


A related question is how to push only the current branch [2]. Now
"git push HEAD" is supported to push the current head if a matching remote
ref exists.

[2] http://marc.info/?l=git&m=119089831513994&w=2

A summary of the patch series follows below.

    Steffen

 builtin-rev-parse.c   |   27 ++++++++++++-------
 cache.h               |    2 +
 remote.c              |   23 ++++++++++------
 sha1_name.c           |   51 ++++++++++++++++++++++++++++--------
 t/t5516-fetch-push.sh |   68 ++++++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 138 insertions(+), 33 deletions(-)

 [PATCH 1/6] push, send-pack: fix test if remote branch exists for colon-less refspec

	This is a bug fix that should go to maint. All following patches modifying
        the push test script require this.

 [PATCH 2/6] add get_sha1_with_real_ref() returning full name of ref on demand

	Is required by 3/6 and 4/6

 [PATCH 3/6] rev-parse: teach "git rev-parse --symbolic" to print the full ref name

	A bit off-topic. It demonstrates the use of get_sha1_with_real_ref.

 [PATCH 4/6] push, send-pack: support pushing HEAD to real ref name

	Requires 1/6.

 [PATCH 5/6] add ref_cmp_full_short() comparing full ref name with a short name
 [PATCH 6/6] push, send-pack: use same rules as git-rev-parse to resolve refspecs

	Requires 1/6.

	Note, an updated documentation is not yet included. I like to first wait for
	comments.
