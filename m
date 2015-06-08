From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH] git-rebase--interactive.sh: add config option for custom
Date: Mon, 8 Jun 2015 00:53:09 +0000
Message-ID: <0000014dd0a821f6-a4ffca2d-d242-4e96-aeec-7a52186c5df1-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2_516384226.1433724789212"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 03:11:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1lai-0006Hr-Q5
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 03:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbbFHBK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 21:10:56 -0400
Received: from a6-246.smtp-out.eu-west-1.amazonses.com ([54.240.6.246]:52043
	"EHLO a6-246.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750769AbbFHBKy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jun 2015 21:10:54 -0400
X-Greylist: delayed 1063 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jun 2015 21:10:54 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1433724789;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Date:Feedback-ID;
	bh=xiYQ7uTeGo8Kg/rs0wDIrxSjoIFjko4QOSv+F35yH7g=;
	b=oQliUzAoA0RWRrFCBdFh0wlWf1z2EV/HC3/4RTfND672Qk5sQUb7Lx8gy7twfX8D
	lOri8QwmRAkcWFKSppatURzc2iCbQi4SK6odjFHRfIyISE8sodKdpJLLh09B0dxpqB1
	LNc4kCph5NxJWwoHAnWVVeI51mRDPODipSivezjw=
X-SES-Outgoing: 2015.06.08-54.240.6.246
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270987>

------=_Part_2_516384226.1433724789212
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

A config option 'rebase.instructionFormat' can override the
default 'oneline' format of the rebase instruction list.

Since the list is parsed using the left, right or boundary mark plus
the sha1, they are prepended to the instruction format.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 git-rebase--interactive.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index dc3133f..cc79b81 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -977,7 +977,14 @@ else
 	revisions=$onto...$orig_head
 	shortrevisions=$shorthead
 fi
-git rev-list $merges_option --pretty=oneline --reverse --left-right --topo-order \
+format=$(git config --get rebase.instructionFormat)
+if test -z "$format"
+then
+   format="%s"
+fi
+# the 'rev-list .. | sed' requires %m to parse; the instruction requires %h to parse
+format="%m%h ${format}"
+git rev-list $merges_option --pretty="${format}" --reverse --left-right --topo-order \
 	$revisions ${restrict_revision+^$restrict_revision} | \
 	sed -n "s/^>//p" |
 while read -r sha1 rest

---
https://github.com/git/git/pull/146
------=_Part_2_516384226.1433724789212--
