From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 3/7] Git.pm: Swap hash_object() parameters
Date: Sun, 25 Jun 2006 03:54:26 +0200
Message-ID: <20060625015426.29906.54971.stgit@machine.or.cz>
References: <20060625015421.29906.50002.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 25 03:54:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJpY-00069P-SP
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWFYBy2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWFYBy2
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:54:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:65449 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751350AbWFYBy1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 21:54:27 -0400
Received: (qmail 29939 invoked from network); 25 Jun 2006 03:54:26 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 25 Jun 2006 03:54:26 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060625015421.29906.50002.stgit@machine.or.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22571>

I'm about to introduce get_object() and it will be better for consistency
if the object type always goes first. And writing 'blob' there explicitly
is not much bother.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 perl/Git.pm |    8 ++++----
 perl/Git.xs |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 6da11a6..eea6c07 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -570,13 +570,13 @@ sub ident_person {
 
 
 
-=item hash_object ( FILENAME [, TYPE ] )
+=item hash_object ( TYPE, FILENAME )
 
-=item hash_object ( FILEHANDLE [, TYPE ] )
+=item hash_object ( TYPE, FILEHANDLE )
 
 Compute the SHA1 object id of the given C<FILENAME> (or data waiting in
-C<FILEHANDLE>) considering it is of the C<TYPE> object type (C<blob>
-(default), C<commit>, C<tree>).
+C<FILEHANDLE>) considering it is of the C<TYPE> object type (C<blob>,
+C<commit>, C<tree>).
 
 In case of C<FILEHANDLE> passed instead of file name, all the data
 available are read and hashed, and the filehandle is automatically
diff --git a/perl/Git.xs b/perl/Git.xs
index ebaac4b..2fd1c67 100644
--- a/perl/Git.xs
+++ b/perl/Git.xs
@@ -105,9 +105,9 @@ CODE:
 }
 
 char *
-xs_hash_object(file, type = "blob")
-	SV *file;
+xs_hash_object(type, file)
 	char *type;
+	SV *file;
 CODE:
 {
 	unsigned char sha1[20];
