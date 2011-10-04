From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] request-pull: List the hash that results from merging onto baserev
Date: Mon, 03 Oct 2011 21:47:06 -0400
Message-ID: <m28vp1msth.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 03:47:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAu6K-0004X8-Bo
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 03:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910Ab1JDBrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 21:47:11 -0400
Received: from void.printf.net ([89.145.121.20]:36119 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652Ab1JDBrK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 21:47:10 -0400
Received: from 173-166-109-241-newengland.hfc.comcastbusiness.net ([173.166.109.241] helo=bob.laptop.org)
	by void.printf.net with esmtp (Exim 4.69)
	(envelope-from <cjb@laptop.org>)
	id 1RAu6A-0001KU-34
	for git@vger.kernel.org; Tue, 04 Oct 2011 02:47:10 +0100
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182723>

This patch modifies the request-pull message to contain both the base
hash and the top commit hash that results when the new commits are
merged onto that base.

The motivation for doing this is to turn cryptographically signing a
pull request into an operation that enables detection of commits having
been maliciously altered before being downloaded.  Before this patch, a
pull request contained only a list of commit names and a diffstat; this
is not sufficient to detect subsequent alteration of the changed files.

After this patch, the person merging may choose to rewind to $baserev,
apply the received commits, and check that the resulting hash matches.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 git-request-pull.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index fc080cc..9a686a5 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -73,6 +73,9 @@ are available in the git repository at:' $baserev &&
 echo "  $url $branch" &&
 echo &&
 
+echo "(Applying these commits produces hash $headrev)" &&
+echo &&
+
 git shortlog ^$baserev $headrev &&
 git diff -M --stat --summary $patch $merge_base..$headrev || exit
 exit $status
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
