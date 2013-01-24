From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: cleanup sprintf usage for uppercasing hex
Date: Thu, 24 Jan 2013 01:28:10 +0000
Message-ID: <20130124012810.GA8096@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 02:28:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyBcH-0004sp-E3
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 02:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531Ab3AXB2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 20:28:12 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:60833 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241Ab3AXB2K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 20:28:10 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D50044C001;
	Thu, 24 Jan 2013 01:28:10 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214382>

We do not need to call uc() separately for sprintf("%x")
as sprintf("%X") is available.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 perl/Git/SVN.pm        | 4 ++--
 perl/Git/SVN/Editor.pm | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 59215fa..490e330 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -490,7 +490,7 @@ sub refname {
 	#
 	# Additionally, % must be escaped because it is used for escaping
 	# and we want our escaped refname to be reversible
-	$refname =~ s{([ \%~\^:\?\*\[\t])}{uc sprintf('%%%02x',ord($1))}eg;
+	$refname =~ s{([ \%~\^:\?\*\[\t])}{sprintf('%%%02X',ord($1))}eg;
 
 	# no slash-separated component can begin with a dot .
 	# /.* becomes /%2E*
@@ -2377,7 +2377,7 @@ sub map_path {
 
 sub uri_encode {
 	my ($f) = @_;
-	$f =~ s#([^a-zA-Z0-9\*!\:_\./\-])#uc sprintf("%%%02x",ord($1))#eg;
+	$f =~ s#([^a-zA-Z0-9\*!\:_\./\-])#sprintf("%%%02X",ord($1))#eg;
 	$f
 }
 
diff --git a/perl/Git/SVN/Editor.pm b/perl/Git/SVN/Editor.pm
index 3db1521..fa0d3c6 100644
--- a/perl/Git/SVN/Editor.pm
+++ b/perl/Git/SVN/Editor.pm
@@ -146,7 +146,7 @@ sub url_path {
 	my ($self, $path) = @_;
 	if ($self->{url} =~ m#^https?://#) {
 		# characters are taken from subversion/libsvn_subr/path.c
-		$path =~ s#([^~a-zA-Z0-9_./!$&'()*+,-])#uc sprintf("%%%02x",ord($1))#eg;
+		$path =~ s#([^~a-zA-Z0-9_./!$&'()*+,-])#sprintf("%%%02X",ord($1))#eg;
 	}
 	$self->{url} . '/' . $self->repo_path($path);
 }
-- 
Eric Wong
