From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Fix multi-paragraph list items in OPTIONS section
Date: Mon, 20 Mar 2006 00:39:46 +0100
Message-ID: <20060319233946.GB22802@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 20 00:40:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL7VM-0002n8-76
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 00:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWCSXjx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 18:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWCSXjx
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 18:39:53 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:54679 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1750910AbWCSXjw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Mar 2006 18:39:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 8E83D770093;
	Mon, 20 Mar 2006 00:39:51 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04337-03; Mon, 20 Mar 2006 00:39:49 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id D4149770055;
	Mon, 20 Mar 2006 00:39:46 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 9EB126E0288; Mon, 20 Mar 2006 00:38:10 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id B67AA61EA3; Mon, 20 Mar 2006 00:39:46 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17736>

Asciidoc cannot handle multi-paragraph description list items without the
need for adding special control characters and reindenting all paragraphs
but the first. Workaround it in make-cg-asciidoc so that the documentation
in the script headers can use the more intuitive and readable formatting.

Affected files are cg-patch and cg-commit.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 Documentation/make-cg-asciidoc |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/Documentation/make-cg-asciidoc b/Documentation/make-cg-asciidoc
index 126d4eb..c454062 100755
--- a/Documentation/make-cg-asciidoc
+++ b/Documentation/make-cg-asciidoc
@@ -112,8 +112,31 @@ $DESCRIPTION
 
 OPTIONS
 -------
-$OPTIONS
+
+--
+__END__
+
+# Only indent the first paragraph of multi-paragraph list items.
+multipara=
+echo "$OPTIONS" | while read line; do
+	case "$line" in
+	*::)
+		multipara=
+		;;
+	"")
+		multipara=t
+		;;
+	*)
+		[ "$multipara" ] || line="	$line"
+	esac
+
+	echo "$line"
+done
+
+cat <<__END__
+
 $HELP_OPTIONS
+--
 
 $MISC
 

-- 
Jonas Fonseca
