From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] gitweb: start to generate PATH_INFO URLs
Date: Sat, 30 Sep 2006 00:16:41 +0200
Message-ID: <20060929221641.GC2871@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Sep 30 00:16:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTQf1-00021a-3s
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 00:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWI2WQn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 18:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWI2WQn
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 18:16:43 -0400
Received: from agent.admingilde.org ([213.95.21.5]:30593 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1750745AbWI2WQm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 18:16:42 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GTQev-00020o-CE
	for git@vger.kernel.org; Sat, 30 Sep 2006 00:16:41 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28132>

Instead of providing the project as a ?p= parameter it is simply appended
to the base URI.
All other parameters are appended to that, except for ?a=summary which
is the default and can be omitted.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 gitweb/gitweb.perl |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 597d29f..e507ce9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -355,6 +355,7 @@ ## action links
 
 sub href(%) {
 	my %params = @_;
+	my $href;
 
 	my @mapping = (
 		project => "p",
@@ -373,6 +374,16 @@ sub href(%) {
 
 	$params{'project'} = $project unless exists $params{'project'};
 
+	# first encode base url and project
+	$href = "$my_uri/$params{'project'}";
+	delete $params{'project'};
+
+	# Summary just uses the project path URL
+	if ($params{'action'} eq 'summary') {
+		return $href;
+	}
+
+	# now encode the parameters explicitly
 	my @result = ();
 	for (my $i = 0; $i < @mapping; $i += 2) {
 		my ($name, $symbol) = ($mapping[$i], $mapping[$i+1]);
@@ -380,7 +391,9 @@ sub href(%) {
 			push @result, $symbol . "=" . esc_param($params{$name});
 		}
 	}
-	return "$my_uri?" . join(';', @result);
+	$href .= "?" . join(';', @result);
+
+	return $href;
 }
 
 
-- 
1.4.2.gb8b6b

-- 
Martin Waitz
