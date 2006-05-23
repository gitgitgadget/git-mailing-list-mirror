From: Pavel Roskin <proski@gnu.org>
Subject: cogito testsuite failure - git-read-tree too careful
Date: Mon, 22 May 2006 20:28:18 -0400
Message-ID: <1148344098.26251.57.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue May 23 02:28:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiKlI-0003jp-Oe
	for gcvg-git@gmane.org; Tue, 23 May 2006 02:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWEWA2a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 20:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWEWA2a
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 20:28:30 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:52134 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751206AbWEWA2a
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 20:28:30 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FiKlA-0004EL-RO
	for git@vger.kernel.org; Mon, 22 May 2006 20:28:28 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FiKl0-0001oQ-GD; Mon, 22 May 2006 20:28:18 -0400
To: Petr Baudis <pasky@suse.cz>, git <git@vger.kernel.org>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20556>

Hello, Petr!

The testsuite for cogito fails in t9300-seek.sh for up-to-date master
branches of git and Cogito.

$ ./t9300-seek.sh -v -i
* expecting success: cg-seek cbd273f56aecaaf28b857ae74da77cbb11a4d659
Warning: uncommitted local changes, trying to bring them along
fatal: Entry 'newdir/newfile' not uptodate. Cannot merge.
cg-seek: cbd273f56aecaaf28b857ae74da77cbb11a4d659: bad commit
* FAIL 21: seeking to the first commit
        cg-seek cbd273f56aecaaf28b857ae74da77cbb11a4d659

As I understand it, "git-read-tree -m" in cg-Xlib refuses to merge if
there are local changes.  This was likely caused by commit
fcc387db9bc453dc7e07a262873481af2ee9e5c8:

read-tree -m -u: do not overwrite or remove untracked working tree
files.
    
I guess git-read-tree should be using "--reset" or something to restore
the original behavior.

The "tutorial" testsuite also fails:

Should not be doing an Octopus.
No merge strategy handled the merge.
Merging 5de8995e58b4b478dff476788c3607ed5021fc24 ->
ba8b9edd80500d60d68a6630ee415a3e710f6db2
        to a60f36f73018dc1959d8d2cbd28271f93ee5f686 ...
fatal: Untracked working tree file 'stack.h' would be overwritten by
merge.
cg-merge: git-read-tree failed (merge likely blocked by local changes)
162
?
Unexpected error 4 on line 242

In this case, we may want cg-merge to fail, because it's wrong to
overwrite local files without backing them up.

-- 
Regards,
Pavel Roskin
