From: David Brown <git@davidb.org>
Subject: [PATCH] git-send-email: Add --suppress-cc all
Date: Mon, 24 Dec 2007 13:26:48 -0800
Message-ID: <20071224212648.GA21070@old.davidb.org>
References: <1198216860-487-1-git-send-email-git@davidb.org> <1198522902-12117-1-git-send-email-git@davidb.org> <20071224210325.GA7242@mail.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Joel Becker <Joel.Becker@oracle.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 22:27:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6upM-0008Sz-Mr
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 22:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbXLXV0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2007 16:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbXLXV0t
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Dec 2007 16:26:49 -0500
Received: from mail.davidb.org ([66.93.32.219]:54645 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbXLXV0s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2007 16:26:48 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1J6uoy-0005ve-3y; Mon, 24 Dec 2007 13:26:48 -0800
Mail-Followup-To: Joel Becker <Joel.Becker@oracle.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071224210325.GA7242@mail.oracle.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69222>

Add the 'all' option to --suppress-cc, allowing easier suppression of
everything.

Signed-off-by: David Brown <git@davidb.org>
---
On Mon, Dec 24, 2007 at 01:03:25PM -0800, Joel Becker wrote:

>+   all    - all of the above, thus only honoring '--to', '--cc', and
>             '--bcc'

I can squash this with the other patch if that would be cleaner.

Dave

  Documentation/git-send-email.txt |    2 +-
  git-send-email.perl              |   11 ++++++++++-
  2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 432f336..fdfb56e 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -125,7 +125,7 @@ The --cc option must be repeated for each user you want on the cc list.
  	avoid including the patch author, 'cc' will avoid including anyone
  	mentioned in Cc lines in the patch, 'sob' will avoid including
  	anyone mentioned in Signed-off-by lines, and 'cccmd' will avoid
-	running the --cc-cmd.
+	running the --cc-cmd.  'all' will suppress all auto cc values.
  	Default is the value of 'sendemail.suppresscc' configuration value;
  	if that is unspecified, default to 'self' if --suppress-from is
  	specified, as well as 'sob' if --no-signed-off-cc is specified.
diff --git a/git-send-email.perl b/git-send-email.perl
index cb9adf2..ef16824 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -275,7 +275,7 @@ my(%suppress_cc);
  if (@suppress_cc) {
  	foreach my $entry (@suppress_cc) {
  		die "Unknown --suppress-cc field: '$entry'\n"
-			unless $entry =~ /^(cccmd|cc|author|self|sob)$/;
+			unless $entry =~ /^(all|cccmd|cc|author|self|sob)$/;
  		$suppress_cc{$entry} = 1;
  	}
  } else {
@@ -284,6 +284,15 @@ if (@suppress_cc) {
  	$suppress_cc{'sob'} = 1 unless $signed_off_cc;
  }
  
+if ($suppress_cc{'all'}) {
+	foreach my $entry (qw (ccmd cc author self sob)) {
+		$suppress_cc{$entry} = 1;
+	}
+	delete $suppress_cc{'all'};
+}
+
+printf "Suppressions: %s\n", join(',', keys(%suppress_cc));
+
  my ($repoauthor) = $repo->ident_person('author');
  my ($repocommitter) = $repo->ident_person('committer');
  
-- 
1.5.3.7
