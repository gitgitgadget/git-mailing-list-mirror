From: Michal Marek <mmarek@suse.cz>
Subject: [PATCH] request-pull: do not paginate output of git commands
Date: Tue, 30 Jun 2009 13:33:26 +0200
Message-ID: <1246361606-20457-1-git-send-email-mmarek@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 30 13:44:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward2.uio.no ([129.240.10.71])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLbkD-0008C3-Af
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 13:43:25 +0200
Received: from exim by mail-out2.uio.no with local-bsmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLban-0003Pf-Q6
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 13:33:41 +0200
Received: from mail-mx2.uio.no ([129.240.10.30])
	by mail-out2.uio.no with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLban-0003Pc-P5
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 13:33:41 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx2.uio.no with esmtp  (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLbam-0007bA-Td
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 13:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbZF3Lda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 07:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbZF3Ld3
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 07:33:29 -0400
Received: from cantor.suse.de ([195.135.220.2]:57680 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523AbZF3Ld3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 07:33:29 -0400
Received: from relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 26A919295B
	for <git@vger.kernel.org>; Tue, 30 Jun 2009 13:33:32 +0200 (CEST)
Received: by sepie.suse.cz (Postfix, from userid 10020)
	id E7AA67664A; Tue, 30 Jun 2009 13:33:31 +0200 (CEST)
X-Mailer: git-send-email 1.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3, uiobl=NO, uiouri=_URIID_)
X-UiO-Scanned: 6E53C7333350505D0F47DC12E3FB8F4E228AE066
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 96 total 2547353 max/h 849 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122508>

git request-pull called inside a terminal prints part of the output to
the terminal and other parts are piped through the pager. Fix this.

Signed-off-by: Michal Marek <mmarek@suse.cz>
---
 git-request-pull.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index a2cf5b8..b3aaded 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -34,7 +34,7 @@ branch=$(git ls-remote "$url" \
 	}")
 if [ -z "$branch" ]; then
 	echo "warn: No branch of $url is at:" >&2
-	git log --max-count=1 --pretty='format:warn:   %h: %s' $headrev >&2
+	git --no-pager log --max-count=1 --pretty='tformat:warn:   %h: %s' $headrev >&2
 	echo "warn: Are you sure you pushed $head there?" >&2
 	echo >&2
 	echo >&2
@@ -45,13 +45,13 @@ fi
 PAGER=
 export PAGER
 echo "The following changes since commit $baserev:"
-git shortlog --max-count=1 $baserev | sed -e 's/^\(.\)/  \1/'
+git --no-pager shortlog --max-count=1 $baserev | sed -e 's/^\(.\)/  \1/'
 
 echo "are available in the git repository at:"
 echo
 echo "  $url $branch"
 echo
 
-git shortlog ^$baserev $headrev
-git diff -M --stat --summary $merge_base $headrev
+git --no-pager shortlog ^$baserev $headrev
+git --no-pager diff -M --stat --summary $merge_base $headrev
 exit $status
-- 
1.6.3
