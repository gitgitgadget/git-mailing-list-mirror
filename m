From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] add test for git-config --remove-section
Date: Thu, 1 Mar 2007 23:41:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703012338370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <es66vt$jej$1@sea.gmane.org> <81b0412b0703011351ldd903a8od2e4f76aded31519@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 23:41:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMtxa-0001iH-N0
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 23:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbXCAWlL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 17:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbXCAWlL
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 17:41:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:55687 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161071AbXCAWlK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 17:41:10 -0500
Received: (qmail invoked by alias); 01 Mar 2007 22:41:08 -0000
X-Provags-ID: V01U2FsdGVkX1+RRUVfM0ORNeqR4Anl7IYOnb0O1zfLaw3D1qmEzj
	iaBwb66PB7ekdj
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <81b0412b0703011351ldd903a8od2e4f76aded31519@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41140>


This adds a simple test if a section is properly removed, even if the 
section header is repeated in the config.

Not-yet-Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Waits-for-ack-by: Paolo Bonzini <bonzini@gnu.org>

---
	On Thu, 1 Mar 2007, Alex Riesen wrote:

	> On 3/1/07, Paolo Bonzini <bonzini@gnu.org> wrote:
	> > As per the subject.  The existing --rename-section option is
	> > undocumented, while --remove-section is added by this patch 
	> > based on the code I had written for the "git branch" patch.
	> 
	> You desperately need tests for this code.

	Something like this? Totally untested (of course)...

 t/t1300-repo-config.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)


diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 3753e9f..6b15a3e 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -391,6 +391,22 @@ EOF
 
 test_expect_success "rename succeeded" "diff -u expect .git/config"
 
+test_expect_success "remove section" "git config --remove-section branch.zwei"
+
+cat > expect << EOF
+# Hallo
+	#Bello
+[branch "zwei"]
+	x = 1
+[branch "zwei"]
+	y = 1
+[branch "drei"]
+weird
+EOF
+
+test_expect_success "section was removed properly" \
+	"diff -u expect .git/config"
+
 test_expect_success numbers '
 
 	git-config kilo.gram 1k &&
