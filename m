From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 1/5] git-p4 stream: remove unused function
Date: Sat, 25 Jul 2009 10:23:57 -0400
Message-ID: <20090725142357.GB3841@arf.padd.com>
References: <1247301071-9541-1-git-send-email-luke@diamand.org> <20090725142329.GA3841@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 16:33:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUiJH-0007D8-Cr
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 16:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbZGYOdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 10:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbZGYOdF
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 10:33:05 -0400
Received: from marge.padd.com ([99.188.165.110]:39107 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbZGYOdE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 10:33:04 -0400
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Jul 2009 10:33:03 EDT
Received: from arf.padd.com (pool-71-111-229-253.rlghnc.dsl-w.verizon.net [71.111.229.253])
	by marge.padd.com (Postfix) with ESMTPSA id C8C8A121A6BF;
	Sat, 25 Jul 2009 07:24:00 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id CB5863E40FE; Sat, 25 Jul 2009 10:23:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20090725142329.GA3841@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124011>

This functionality was replaced.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |   58 --------------------------------------------
 1 files changed, 0 insertions(+), 58 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index f415ad0..70fa403 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -950,64 +950,6 @@ class P4Sync(Command):
 
         return branches
 
-    ## Should move this out, doesn't use SELF.
-    def readP4Files(self, files):
-        filesForCommit = []
-        filesToRead = []
-
-        for f in files:
-            includeFile = True
-            for val in self.clientSpecDirs:
-                if f['path'].startswith(val[0]):
-                    if val[1] <= 0:
-                        includeFile = False
-                    break
-
-            if includeFile:
-                filesForCommit.append(f)
-                if f['action'] not in ('delete', 'purge'):
-                    filesToRead.append(f)
-
-        filedata = []
-        if len(filesToRead) > 0:
-            filedata = p4CmdList('-x - print',
-                                 stdin='\n'.join(['%s#%s' % (f['path'], f['rev'])
-                                                  for f in filesToRead]),
-                                 stdin_mode='w+')
-
-            if "p4ExitCode" in filedata[0]:
-                die("Problems executing p4. Error: [%d]."
-                    % (filedata[0]['p4ExitCode']));
-
-        j = 0;
-        contents = {}
-        while j < len(filedata):
-            stat = filedata[j]
-            j += 1
-            text = ''
-            while j < len(filedata) and filedata[j]['code'] in ('text', 'unicode', 'binary'):
-                text += filedata[j]['data']
-                del filedata[j]['data']
-                j += 1
-
-            if not stat.has_key('depotFile'):
-                sys.stderr.write("p4 print fails with: %s\n" % repr(stat))
-                continue
-
-            if stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
-                text = re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text)
-            elif stat['type'] in ('text+k', 'ktext', 'kxtext', 'unicode+k', 'binary+k'):
-                text = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$\n]*\$',r'$\1$', text)
-
-            contents[stat['depotFile']] = text
-
-        for f in filesForCommit:
-            path = f['path']
-            if contents.has_key(path):
-                f['data'] = contents[path]
-
-        return filesForCommit
-
     # output one file from the P4 stream
     # - helper for streamP4Files
 
-- 
1.6.2.5
