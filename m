From: Magnus Hagander <magnus@hagander.net>
Subject: [PATCH] Allow gitweb tab width to be set per project.
Date: Mon, 18 Oct 2010 12:41:04 +0200
Message-ID: <1287398464-22721-1-git-send-email-magnus@hagander.net>
References: <AANLkTimOxim60=gMNZu3n_AztZR7mPAOzg1NevJA2m+4@mail.gmail.com>
Cc: Magnus Hagander <magnus@hagander.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 18 12:41:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7n9e-0006tP-WE
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 12:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902Ab0JRKlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 06:41:12 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41722 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab0JRKlL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 06:41:11 -0400
Received: by ewy20 with SMTP id 20so1434761ewy.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 03:41:10 -0700 (PDT)
Received: by 10.213.114.17 with SMTP id c17mr3991434ebq.62.1287398470339;
        Mon, 18 Oct 2010 03:41:10 -0700 (PDT)
Received: from mha-laptop.hagander.net ([217.78.36.66])
        by mx.google.com with ESMTPS id x54sm12341537eeh.23.2010.10.18.03.41.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 03:41:09 -0700 (PDT)
Received: by mha-laptop.hagander.net (Postfix, from userid 1000)
	id 952C2124146; Mon, 18 Oct 2010 12:41:08 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <AANLkTimOxim60=gMNZu3n_AztZR7mPAOzg1NevJA2m+4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159250>

Allow the gitweb.tabwidth option to control how many spaces a tab
gets expanded to.

Signed-off-by: Magnus Hagander <magnus@hagander.net>
---
 gitweb/README      |    4 ++++
 gitweb/gitweb.perl |    6 +++++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index bf3664f..d2e4a1d 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -312,6 +312,10 @@ You can use the following files in repository:
    repository's owner. It is displayed in the project list and summary
    page. If it's not set, filesystem directory's owner is used
    (via GECOS field / real name field from getpwiud(3)).
+ * gitweb.tabwidth
+   You can use the gitweb.tabwidth repository configuration variable to set
+   the number of spaces that tabs should be expanded to, instead of the
+   default 8.
  * various gitweb.* config variables (in config)
    Read description of %feature hash for detailed list, and some
    descriptions.
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8d7e4c5..66c258f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1478,9 +1478,13 @@ sub unquote {
 # escape tabs (convert tabs to spaces)
 sub untabify {
 	my $line = shift;
+	# git_get_project_config caches the value for us, so it's ok
+	# to call it once for each line.
+	my $tabwidth = git_get_project_config('tabwidth', '--int');
+	$tabwidth = 8 if (!defined $tabwidth || $tabwidth <= 0);
 
 	while ((my $pos = index($line, "\t")) != -1) {
-		if (my $count = (8 - ($pos % 8))) {
+		if (my $count = ($tabwidth - ($pos % $tabwidth))) {
 			my $spaces = ' ' x $count;
 			$line =~ s/\t/$spaces/;
 		}
-- 
1.7.0.4
