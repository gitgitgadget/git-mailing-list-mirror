From: Tanky Woo <wtq1990@gmail.com>
Subject: Git add -p =?utf-8?b?4oCcWW91cg==?= edited hunk does not apply. Edit =?utf-8?b?YWdhaW7igJ0=?=
Date: Tue, 14 Apr 2015 01:56:12 +0000 (UTC)
Message-ID: <loom.20150414T035141-286@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 14 04:00:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhq95-00086m-4o
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 04:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbbDNCAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 22:00:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:42215 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbbDNCAF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 22:00:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Yhq8x-000853-70
	for git@vger.kernel.org; Tue, 14 Apr 2015 04:00:03 +0200
Received: from li226-230.members.linode.com ([173.255.216.230])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 04:00:03 +0200
Received: from wtq1990 by li226-230.members.linode.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 04:00:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 173.255.216.230 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267108>

I asked this question in stackoverflow a few days ago, but get no answer.

link: http://stackoverflow.com/questions/29518944/git-add-p-your-edited-hunk-does-not-apply-
edit-again

---

An example, the original file:

test:
       make clean
       nosetests

clean:
       rm -rf htmlcov
       rm -rf build dist
       coverage erase
The file after changed:

HTMLCOV="htmlcov/"

test:
       make clean
       nosetests

clean:
       coverage erase
       rm -rf htmlcov
       rm -rf build dist

covhtml:
       make clean
       nosetests
       coverage html
       cd ${HTMLCOV} && python -m SimpleHTTPServer
This is the diff:

diff --git a/mf b/mf
index b9ca06e..6316e17 100644
--- a/mf
+++ b/mf
@@ -1,8 +1,16 @@
+HTMLCOV="htmlcov/"            # Hunk 1
+
 test:
        make clean
        nosetests

 clean:
+       coverage erase         # Hunk 2
        rm -rf htmlcov
        rm -rf build dist
-       coverage erase         # Hunk 3
+
+covhtml:
+       make clean
+       nosetests
+       coverage html
+       cd ${HTMLCOV} && python -m SimpleHTTPServer
I use git add -p, want only to add:

+       coverage erase
        rm -rf htmlcov
        rm -rf build dist
-       coverage erase
So I first use s to split hunks, and n to ignore first add,
then use y to add second hunk, the third hunk 
is:

-       coverage erase
+
+covhtml:
+       make clean
+       nosetests
+       coverage html
+       cd ${HTMLCOV} && python -m SimpleHTTPServer
So I use e to manually edit the hunk, I delete all the + lines, it seems:

# Manual hunk edit mode -- see bottom for a quick guide
@@ -6,3 +9,8 @@
        rm -rf htmlcov
        rm -rf build dist
-       coverage erase
# ---
# To remove '-' lines, make them ' ' lines (context).
# To remove '+' lines, delete them.
# Lines starting with # will be removed.
#
# ....
But when I saved, it says:

@@ -6,3 +9,8 @@
        rm -rf htmlcov
        rm -rf build dist
-       coverage erase
+
+covhtml:
+       make clean
+       nosetests
+       coverage html
+       cd ${HTMLCOV} && python -m SimpleHTTPServer
Stage this hunk [y,n,q,a,d,/,K,g,e,?]? e
error: patch failed: mf:1
error: mf: patch does not apply
Your edited hunk does not apply. Edit again (saying "no" discards!) [y/n]?
And then I change to @@ from-file-range to-file-range @@ part to:

@@ -6,3 +9,2 @@
There is still the same problem.

If I first add only the second Hunk, 
and then I run git add -p xxx again, and edit the hunk, 
there is no problem. Why?
