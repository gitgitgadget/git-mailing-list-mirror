From: Jonas Fonseca <fonseca@diku.dk>
Subject: [JGIT PATCH] Configure the maven surefire plugin to specifically
	include all tests
Date: Fri, 12 Sep 2008 10:40:30 +0200
Message-ID: <20080912084030.GA4964@diku.dk>
References: <20080911213927.GA20238@diku.dk> <200809120047.58484.robin.rosenberg.lists@dewire.com> <20080912000007.GA31931@diku.dk> <9e85b2570809111851y756fdb3en2c17c69bf5ac444e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: Imran M Yousuf <imran@smartitengineering.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 10:41:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke4Dt-00026F-R8
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 10:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbYILIki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 04:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752613AbYILIkh
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 04:40:37 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:41556 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752598AbYILIkg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 04:40:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 677E352C392;
	Fri, 12 Sep 2008 10:40:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ogIFlSwxWd6; Fri, 12 Sep 2008 10:40:31 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 0425A52C37C;
	Fri, 12 Sep 2008 10:40:31 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 6C8E26DFD0B; Fri, 12 Sep 2008 10:40:17 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id DC0611A4001; Fri, 12 Sep 2008 10:40:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e85b2570809111851y756fdb3en2c17c69bf5ac444e@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95691>

By default, the test cases named T000* were not included. With this
patch maven reports that 508 tests have been run.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 jgit-maven/jgit/pom.xml |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

 Imran M Yousuf <imran@smartitengineering.com> wrote Fri, Sep 12, 2008:
 > On Fri, Sep 12, 2008 at 6:00 AM, Jonas Fonseca <fonseca@diku.dk> wrote:
 > > When I run all the tests using maven (inside
 > > NetBeans or from the command line) it tells me:
 > >
 > >        Tests run: 428, Failures: 0, Errors: 0, Skipped: 0
 > >
 > > From the output it looks like the tests in the files named T000* are
 > > never run. However, where the breakage is (could be my setup) I don't
 > > know. Imran?
 > >
 > 
 > Hmm, I will have to check it. Will come back with some feedback after
 > checking. Usually if a class is a TestCase then it should have run.
 
 I started looking for possible bug reports at jira.codehaus.org and
 found an issue for extendeding the default path patterns used for
 including and excluding tests. Maybe something like this patch is clean
 enough, at least it increases "my coverage" to 508 tests.

diff --git a/jgit-maven/jgit/pom.xml b/jgit-maven/jgit/pom.xml
index a64f53c..a123470 100644
--- a/jgit-maven/jgit/pom.xml
+++ b/jgit-maven/jgit/pom.xml
@@ -158,6 +158,17 @@ ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
                     <encoding>UTF-8</encoding>
                 </configuration>
             </plugin>
+            <plugin>
+                <artifactId>maven-surefire-plugin</artifactId>
+                <version>2.4.2</version>
+                <configuration>
+                    <includes>
+                        <include>**/*Test.java</include>
+                        <include>**/*TestCase.java</include>
+                        <include>**/T000*.java</include>
+                    </includes>
+                </configuration>
+           </plugin>
         </plugins>
     </build>
     <dependencies>
-- 
1.6.0.1.451.gc8d31

-- 
Jonas Fonseca
