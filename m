From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add another fast-import example, this time for .zip
 files
Date: Mon, 30 Jun 2008 23:53:52 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806302352370.9925@racer>
References: <alpine.DEB.1.00.0806301948130.9925@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: spearce@spearce.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 00:56:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDSIf-0008CC-Jr
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932801AbYF3Wzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 18:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbYF3Wzr
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:55:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:33937 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762883AbYF3Wzq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 18:55:46 -0400
Received: (qmail invoked by alias); 30 Jun 2008 22:55:44 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp064) with SMTP; 01 Jul 2008 00:55:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/6haEBD2v6SeXXtTkireD6Fch4S5gllS48h7VVk+
	wQL9OhvlajBj7H
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0806301948130.9925@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86960>

Hi,

On Mon, 30 Jun 2008, Johannes Schindelin wrote:

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> 	I needed that today.

... and I needed that on top, which I forgot to commit, and therefore 
never sent in my first mail on this subject:

-- snipsnap --
diff --git a/contrib/fast-import/import-zip.py b/contrib/fast-import/import-zips.py
similarity index 85%
rename from contrib/fast-import/import-zip.py
rename to contrib/fast-import/import-zips.py
index 4200a66..fcf5823 100755
--- a/contrib/fast-import/import-zip.py
+++ b/contrib/fast-import/import-zips.py
@@ -40,6 +40,11 @@ for zipfile in argv[1:]:
 
 		if commit_time < info.date_time:
 			commit_time = info.date_time
+		if common_prefix == None:
+			common_prefix = name[:name.rfind('/') + 1]
+		else:
+			while not name.startswith(common_prefix):
+				common_prefix = name[:name.rfind('/') + 1]
 
 		mark[name] = ':' + str(next_mark)
 		next_mark += 1
@@ -56,7 +61,8 @@ for zipfile in argv[1:]:
 		'', 'deleteall'))
 
 	for name in mark.keys():
-		fast_import.write('M 100644 ' + mark[name] + ' ' + name + "\n")
+		fast_import.write('M 100644 ' + mark[name] + ' ' +
+			name[len(common_prefix):] + "\n")
 
 	printlines(('',  'tag ' + path.basename(zipfile), \
 		'from ' + branch_ref, 'tagger ' + committer, \
