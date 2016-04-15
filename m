From: Jan Durovec <jan.durovec@gmail.com>
Subject: [PATCH] Adding list of p4 jobs to git commit message
Date: Fri, 15 Apr 2016 19:51:10 +0000
Message-ID: <010201541b7a24b8-83b0f526-2f01-40e3-afc8-d81549af70d4-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 21:51:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar9lu-0000B5-C0
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 21:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbcDOTvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 15:51:13 -0400
Received: from a6-246.smtp-out.eu-west-1.amazonses.com ([54.240.6.246]:48667
	"EHLO a6-246.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751040AbcDOTvM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2016 15:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1460749870;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=/PSt/CDFttaO7gYRBtlBG3gsy/pT9OW9uJmzSdU9biI=;
	b=ICKH2qbpDFWFbXkeAkSbYvlLCIdgOcMIA74d2cWpNTBRdTcwrXucSvd4d+V2nAvG
	des5XP3SGmt1HD1zrDYwDZFDxOCkHo5KZRP7o54Xv1gREg5mcpoVxRemXiMOBEa//IX
	rSwRiR/J/DdVVnsm1R+7yB19oJUkwTRV8/AC9qCg=
X-SES-Outgoing: 2016.04.15-54.240.6.246
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291648>

---
 git-p4.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 527d44b..a81795f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2320,6 +2320,15 @@ def extractFilesFromCommit(self, commit):
             fnum = fnum + 1
         return files
 
+    def extractJobsFromCommit(self, commit):
+        jobs = []
+        jnum = 0
+        while commit.has_key("job%s" % jnum):
+            job = commit["job%s" % jnum]
+            jobs.append(job)
+            jnum = jnum + 1
+        return jobs
+
     def stripRepoPath(self, path, prefixes):
         """When streaming files, this is called to map a p4 depot path
            to where it should go in git.  The prefixes are either
@@ -2665,6 +2674,7 @@ def hasBranchPrefix(self, path):
     def commit(self, details, files, branch, parent = ""):
         epoch = details["time"]
         author = details["user"]
+        jobs = self.extractJobsFromCommit(details)
 
         if self.verbose:
             print('commit into {0}'.format(branch))
@@ -2696,6 +2706,8 @@ def commit(self, details, files, branch, parent = ""):
                              (','.join(self.branchPrefixes), details["change"]))
         if len(details['options']) > 0:
             self.gitStream.write(": options = %s" % details['options'])
+        if len(jobs) > 0:
+            self.gitStream.write(": jobs = %s" % (','.join(jobs)))
         self.gitStream.write("]\nEOT\n\n")
 
         if len(parent) > 0:

--
https://github.com/git/git/pull/225
