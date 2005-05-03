From: Pavel Roskin <proski@gnu.org>
Subject: commit-id fails after cg-init
Date: Tue, 03 May 2005 16:03:05 -0400
Message-ID: <1115150585.28520.11.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue May 03 21:58:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT3X1-0002UJ-HM
	for gcvg-git@gmane.org; Tue, 03 May 2005 21:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVECUEa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 16:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVECUEa
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 16:04:30 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:39565
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261672AbVECUE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 16:04:26 -0400
Received: by localhost.localdomain (Postfix, from userid 500)
	id F3D49EFF3E; Tue,  3 May 2005 16:03:05 -0400 (EDT)
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

I tried to start a new project using cogito (current snapshot) and I was
immediately greeted by a bug (or a buglet if you want).  Let's do this
in a clean directory:

$ cg-init 
defaulting to local storage area
$ cg-diff 
cat: .git/refs/tags/: Is a directory
cat: .git/refs/heads/: Is a directory
Invalid id: 
usage: git-cat-file [-t | tagname] <sha1>
usage: git-cat-file [-t | tagname] <sha1>
Invalid id: 
usage: diff-cache [-r] [-z] [-p] [--cached] <tree sha1>
mkdir: cannot create directory `/tmp/gitdiff.k4FHLY/': File exists
$

Not nice.  Trivial debugging shows that it's commit-id that fails:

$ sh -x commit-id 
+ SHA1='[A-Za-z0-9]{40}'
+ SHA1ONLY='^[A-Za-z0-9]{40}$'
+ id=
+ '[' '!' '' ']'
++ cat .git/HEAD
+ id=
+ echo
+ egrep -vq '^[A-Za-z0-9]{40}$'
+ '[' -r .git/refs/tags/ ']'
++ cat .git/refs/tags/
cat: .git/refs/tags/: Is a directory
...

$ ls -al .git/HEAD 
lrwxrwxrwx  1 proski proski 17 2005-05-03 15:50 .git/HEAD -> refs/heads/master
$ cat .git/refs/heads/master
$

So, cg-init created an empty .git/refs/heads/master and made .git/HEAD a
symlink to it.  Now, commit-id reads that file and gets confused.

If anybody has an idea what to put to .git/refs/heads/master please
speak up so that cg-init could be fixed.

-- 
Regards,
Pavel Roskin

