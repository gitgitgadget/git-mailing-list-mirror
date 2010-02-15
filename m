From: Gabriel Filion <lelutin@gmail.com>
Subject: [PATCH] require_work_tree broken with NONGIT_OK
Date: Sun, 14 Feb 2010 22:51:47 -0500
Message-ID: <4B78C4D3.90407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 04:58:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngs6V-0003nf-QD
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 04:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965Ab0BOD6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 22:58:31 -0500
Received: from mail001.aei.ca ([206.123.6.130]:34815 "EHLO mail001.aei.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754877Ab0BOD6a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 22:58:30 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Feb 2010 22:58:30 EST
Received: (qmail 29110 invoked by uid 89); 15 Feb 2010 03:51:48 -0000
Received: by simscan 1.2.0 ppid: 29107, pid: 29108, t: 0.0419s
         scanners: regex: 1.2.0 attach: 1.2.0
Received: from mail002.aei.ca (HELO mail002.contact.net) (206.123.6.132)
  by mail001.aei.ca with (DHE-RSA-AES256-SHA encrypted) SMTP; 15 Feb 2010 03:51:48 -0000
Received: (qmail 14876 invoked by uid 89); 15 Feb 2010 03:51:48 -0000
Received: by simscan 1.2.0 ppid: 14869, pid: 14870, t: 0.4493s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.95.3/m:51 spam: 3.3.0
X-Spam-Checker-Version: SpamAssassin 3.3.0 (2010-01-18)
X-Spam-Level: 
X-Spam-Status: No, hits=-3.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	FREEMAIL_FROM autolearn=ham version=3.3.0
Received: from dsl-149-2.aei.ca (HELO ?192.168.2.202?) (66.36.149.2)
  by mail.aei.ca with SMTP; 15 Feb 2010 03:51:47 -0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100108 Lightning/1.0b1 Icedove/3.0
X-Enigmail-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139964>

When sourcing git-sh-setup after having set NONGIT_OK, calling the
function require_work_tree while outside of a git repository shows a
syntax error.

This is caused by the call to "git rev-parse --is-inside-work-tree"
printing a sentence when it is called outside of a git repository.
Relying on the return code is better.
---
 git-sh-setup.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index d56426d..8de2f03 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -128,7 +128,7 @@ cd_to_toplevel () {
 }
  require_work_tree () {
-	test $(git rev-parse --is-inside-work-tree) = true ||
+	test git rev-parse --is-inside-work-tree >/dev/null 2>&1 ||
 	die "fatal: $0 cannot be used without a working tree."
 }
 -- 1.6.6
