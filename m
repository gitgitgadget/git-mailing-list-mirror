From: Andy Lowry <andy.work@nglowry.com>
Subject: BUG in git diff-index
Date: Thu, 31 Mar 2016 12:39:23 +0000 (UTC)
Message-ID: <loom.20160331T143733-916@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 14:45:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1albyM-0005Jc-5z
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 14:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737AbcCaMpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 08:45:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:53149 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbcCaMpH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 08:45:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1albyB-0005FZ-Ri
	for git@vger.kernel.org; Thu, 31 Mar 2016 14:45:04 +0200
Received: from ool-4574ffea.dyn.optonline.net ([69.116.255.234])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 14:45:03 +0200
Received: from andy.work by ool-4574ffea.dyn.optonline.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 14:45:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 69.116.255.234 (Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2693.2 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290379>

Following transcript illustrates what I believe to be a bug in git diff-
index. The session used a git built from latest source, located in 
/tmp/git/git.

1. New repo, create empty file A, commit changes.
2. touch A
3. git diff-index reports A has changed, and reports bogus destination 
SHA
4. This is stable behavior until next step
5. git diff correctly reports no changes
6. git diff-index now also reports nothing

My understanding is that git diff-index should care only about content 
and file mode, not modification time.

===========================================================
andy@wiki:/tmp$ git/git init xxx
warning: templates not found /home/andy/share/git-core/templates
Initialized empty Git repository in /tmp/xxx/.git/
andy@wiki:/tmp$ cd xxx
andy@wiki:/tmp/xxx$ touch A
andy@wiki:/tmp/xxx$ ../git/git add A
andy@wiki:/tmp/xxx$ ../git/git commit -m initial
[master (root-commit) 370c3ac] initial
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 A
andy@wiki:/tmp/xxx$ touch A
andy@wiki:/tmp/xxx$ ../git/git diff-index HEAD
:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 
0000000000000000000000000000000000000000 M    A
andy@wiki:/tmp/xxx$ ../git/git diff-index HEAD
:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 
0000000000000000000000000000000000000000 M    A
andy@wiki:/tmp/xxx$ ../git/git diff
andy@wiki:/tmp/xxx$ ../git/git diff-index HEAD
andy@wiki:/tmp/xxx$ 
