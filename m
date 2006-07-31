From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] gitweb: use a hash to lookup the sub for an action
Date: Mon, 31 Jul 2006 23:46:25 +0200
Message-ID: <E1G7faj-0006W8-17@moooo.ath.cx>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 31 23:46:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7fap-0000NM-2b
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 23:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030476AbWGaVq2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 17:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWGaVq2
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 17:46:28 -0400
Received: from moooo.ath.cx ([85.116.203.178]:8678 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1030476AbWGaVq1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 17:46:27 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24548>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 gitweb/gitweb.cgi |   81 ++++++++++++++++-------------------------------------
 1 files changed, 25 insertions(+), 56 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index c1ee79e..75390c8 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -161,65 +161,34 @@ if (defined $searchtext) {
 }
 
 # dispatch
-if (!defined $action || $action eq "summary") {
-	git_summary();
-	exit;
-} elsif ($action eq "heads") {
-	git_heads();
-	exit;
-} elsif ($action eq "tags") {
-	git_tags();
-	exit;
-} elsif ($action eq "blob") {
-	git_blob();
-	exit;
-} elsif ($action eq "blob_plain") {
-	git_blob_plain();
-	exit;
-} elsif ($action eq "tree") {
-	git_tree();
-	exit;
-} elsif ($action eq "rss") {
-	git_rss();
-	exit;
-} elsif ($action eq "commit") {
-	git_commit();
-	exit;
-} elsif ($action eq "log") {
-	git_log();
-	exit;
-} elsif ($action eq "blobdiff") {
-	git_blobdiff();
-	exit;
-} elsif ($action eq "blobdiff_plain") {
-	git_blobdiff_plain();
-	exit;
-} elsif ($action eq "commitdiff") {
-	git_commitdiff();
-	exit;
-} elsif ($action eq "commitdiff_plain") {
-	git_commitdiff_plain();
-	exit;
-} elsif ($action eq "history") {
-	git_history();
-	exit;
-} elsif ($action eq "search") {
-	git_search();
-	exit;
-} elsif ($action eq "shortlog") {
-	git_shortlog();
-	exit;
-} elsif ($action eq "tag") {
-	git_tag();
-	exit;
-} elsif ($action eq "blame") {
-	git_blame2();
-	exit;
-} else {
+my %actions = (
+	"blame" => \&git_blame2,
+	"blobdiff" => \&git_blobdiff,
+	"blobdiff_plain" => \&git_blobdiff_plain,
+	"blob" => \&git_blob,
+	"blob_plain" => \&git_blob_plain,
+	"commitdiff" => \&git_commitdiff,
+	"commitdiff_plain" => \&git_commitdiff_plain,
+	"commit" => \&git_commit,
+	"heads" => \&git_heads,
+	"history" => \&git_history,
+	"log" => \&git_log,
+	"rss" => \&git_rss,
+	"search" => \&git_search,
+	"shortlog" => \&git_shortlog,
+	"summary" => \&git_summary,
+	"tag" => \&git_tag,
+	"tags" => \&git_tags,
+	"tree" => \&git_tree,
+);
+
+$action = 'summary' if (!defined($action));
+if (!defined($actions{$action})) {
 	undef $action;
 	die_error(undef, "Unknown action.");
-	exit;
 }
+$actions{$action}->();
+exit;
 
 ## ======================================================================
 ## validation, quoting/unquoting and escaping
-- 
1.4.2.rc2.ge0bed
