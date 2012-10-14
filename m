From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 05/20] cvsserver: remove unused functions _headrev and gethistory
Date: Sat, 13 Oct 2012 23:42:18 -0600
Message-ID: <1350193353-19210-6-git-send-email-mmogilvi_git@miniinfo.net>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 07:55:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNHAr-0004bu-MH
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000Ab2JNFz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 01:55:28 -0400
Received: from qmta15.emeryville.ca.mail.comcast.net ([76.96.27.228]:45878
	"EHLO qmta15.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751688Ab2JNFz0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:55:26 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Oct 2012 01:55:26 EDT
Received: from omta01.emeryville.ca.mail.comcast.net ([76.96.30.11])
	by qmta15.emeryville.ca.mail.comcast.net with comcast
	id Atkd1k0010EPchoAFtoLnA; Sun, 14 Oct 2012 05:48:20 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta01.emeryville.ca.mail.comcast.net with comcast
	id AtjK1k0062wKXRC8MtjKSQ; Sun, 14 Oct 2012 05:43:20 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 2E60D1E9601C; Sat, 13 Oct 2012 23:43:19 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207626>

Remove:
   - _headrev() - It uses similar functionality from getmeta() and gethead().
   - gethistory() - It uses similar functions gethistorydense() and getlog().

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 git-cvsserver.perl | 36 ++++--------------------------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index cc39b6b..8b2accb 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -3440,19 +3440,6 @@ sub insert_head
     $insert_head->execute($name, $revision, $filehash, $commithash, $modified, $author, $mode);
 }
 
-sub _headrev
-{
-    my $self = shift;
-    my $filename = shift;
-    my $tablename = $self->tablename("head");
-
-    my $db_query = $self->{dbh}->prepare_cached("SELECT filehash, revision, mode FROM $tablename WHERE name=?",{},1);
-    $db_query->execute($filename);
-    my ( $hash, $revision, $mode ) = $db_query->fetchrow_array;
-
-    return ( $hash, $revision, $mode );
-}
-
 sub _get_prop
 {
     my $self = shift;
@@ -3512,6 +3499,8 @@ sub gethead
 
 =head2 getlog
 
+See also gethistorydense().
+
 =cut
 
 sub getlog
@@ -3597,25 +3586,6 @@ sub commitmessage
     return $message;
 }
 
-=head2 gethistory
-
-This function takes a filename (with path) argument and returns an arrayofarrays
-containing revision,filehash,commithash ordered by revision descending
-
-=cut
-sub gethistory
-{
-    my $self = shift;
-    my $filename = shift;
-    my $tablename = $self->tablename("revision");
-
-    my $db_query;
-    $db_query = $self->{dbh}->prepare_cached("SELECT revision, filehash, commithash FROM $tablename WHERE name=? ORDER BY revision DESC",{},1);
-    $db_query->execute($filename);
-
-    return $db_query->fetchall_arrayref;
-}
-
 =head2 gethistorydense
 
 This function takes a filename (with path) argument and returns an arrayofarrays
@@ -3625,6 +3595,8 @@ This version of gethistory skips deleted entries -- so it is useful for annotate
 The 'dense' part is a reference to a '--dense' option available for git-rev-list
 and other git tools that depend on it.
 
+See also getlog().
+
 =cut
 sub gethistorydense
 {
-- 
1.7.10.2.484.gcd07cc5
