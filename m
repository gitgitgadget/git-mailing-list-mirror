From: Gerrit Pape <pape@smarden.org>
Subject: cvsimport/cvsps: incremental import
Date: Thu, 25 Jan 2007 14:09:10 +0000
Message-ID: <20070125140911.547.qmail@c78c9fae691bed.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 25 15:15:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA5O3-00047m-1w
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 15:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965273AbXAYOPc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 09:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965353AbXAYOPc
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 09:15:32 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:52215 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S965273AbXAYOPc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 09:15:32 -0500
Received: (qmail 548 invoked by uid 1000); 25 Jan 2007 14:09:11 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37723>

Hi, with the current cvsps from
 http://ydirson.free.fr/soft/git/cvsps.git
incremental cvsimports fail with

$ git-cvsimport -C git
file 'a/a; pre_rev:INITIAL; post_rev:1.1; dead:0; branch_point:0
' not found in hash
Already up-to-date.
$ 

I think something like this should fix it:

diff --git a/cache.c b/cache.c
index b3b6c33..d1f9a31 100644
--- a/cache.c
+++ b/cache.c
@@ -380,6 +380,8 @@ void get_filename(char* filename, const char* data)
     };
     /* remainder: text after last protected char */
     strcpy (filename, data);
+    special = strchr(filename, ';');
+    if (special) *special = 0;
 }
 
 static void parse_cache_revision(PatchSetMember * psm, const char * buff)

Thanks, Gerrit.
