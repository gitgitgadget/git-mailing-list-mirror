From: Matthias Andree <matthias.andree@gmx.de>
Subject: Git-SVN on Cygwin 1.7: git svn rebase b0rks index if not run from
 top-level directory
Date: Wed, 21 Apr 2010 18:56:07 +0200
Message-ID: <4BCF2E27.1010906@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 21 18:56:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4dDl-0006wZ-PQ
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 18:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902Ab0DUQ4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 12:56:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:43736 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752692Ab0DUQ4L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 12:56:11 -0400
Received: (qmail invoked by alias); 21 Apr 2010 16:56:09 -0000
Received: from baloo.cs.uni-paderborn.de (EHLO baloo.cs.uni-paderborn.de) [131.234.21.116]
  by mail.gmx.net (mp011) with SMTP; 21 Apr 2010 18:56:09 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX19qMNY/3OZqcDARvCDafLYQ6UV9laNM+8f8vcZXbZ
	hKZRR2Cksi/wZb
Received: from [127.0.0.1]
	by baloo.cs.uni-paderborn.de with esmtp (Exim 4.70)
	(envelope-from <matthias.andree@gmx.de>)
	id L18KDK-0005QC-8W; Wed, 21 Apr 2010 18:56:08 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.1.9) Gecko/20100317 Lightning/1.0b1 Thunderbird/3.0.4
X-Enigmail-Version: 1.0.1
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52000000000000002
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145442>

Greetings,

Looking for help - I have some issues with git-svn as of git version
1.7.1.rc1.12.ga601 on Cygwin 1.7.5 w/ Windows 7 32-bit professional German, but
this has been going on for a while now, but I hadn't figured how to reproduce.

=== Symptoms ===

When I run "git svn rebase" (trace below) *from a working directory somewhere
deep in the checkout,* the index gets dirty.

git diff-index HEAD then shows a massive amount of files that were to be updated:

$ git diff-index HEAD
:100644 100644 faba562f37df8f4a308594b9b867470507229292
0000000000000000000000000000000000000000 M      .project
:100644 100644 0184158eda0e3787d5d29e1f23a6809ed3e4b54c
0000000000000000000000000000000000000000 M      README.txt
:100644 100644 d00be041aecaf00e2c3e7358911a6e5d493e9e7f
0000000000000000000000000000000000000000 M      docs/.gitignore
:100644 100644 bed116f07ba5742e6ed344553008c262656020c7
0000000000000000000000000000000000000000 M      docs/d3.3/.gitignore
[...]

This is always 100644 100644 SHA1 000...000 M filename.

=== Impact ===

- Several parts of git then show bogus local changes, for instance, gitk.

- git svn dcommit aborts because it believes the index were dirty


=== Workarounds ===

Either is sufficient:

1. cd to top-level directory before running git-svn

2. git update-index --refresh


=== Reproduce ===

1. Use a git-svn checkout that has at least one subdirectory

2. cd to that subdirectory

3. run git svn rebase. It concludes successfully, then:

4. git diff-index HEAD -> output like the one shown above.



=== Trace ===

trace: exec: 'git-svn' 'rebase'
trace: run_command: 'git-svn' 'rebase'
trace: built-in: git 'rev-parse' '--show-cdup'
trace: built-in: git 'config' '--bool' '--get' 'svn.fetchall'
trace: built-in: git 'config' '--bool' '--get' 'svn.noauthcache'
trace: built-in: git 'config' '--bool' '--get' 'svn.nocheckout'
trace: built-in: git 'config' '--get' 'svn.authorsprog'
trace: built-in: git 'config' '--bool' '--get' 'svn.dryrun'
trace: built-in: git 'config' '--bool' '--get' 'svn.followparent'
trace: built-in: git 'config' '--bool' '--get' 'svn.useSvmProps'
trace: built-in: git 'config' '--get' 'svn.authorsfile'
trace: built-in: git 'config' '--get' 'svn.repackflags'
trace: built-in: git 'config' '--bool' '--get' 'svn.localtime'
trace: built-in: git 'config' '--get' 'svn.username'
trace: built-in: git 'config' '--int' '--get' 'svn.repack'
trace: built-in: git 'config' '--get' 'svn.ignorepaths'
trace: built-in: git 'config' '--bool' '--get' 'svn.quiet'
trace: built-in: git 'config' '--bool' '--get' 'svn.verbose'
trace: built-in: git 'config' '--int' '--get' 'svn.logwindowsize'
trace: built-in: git 'config' '--get' 'svn.configdir'
trace: built-in: git 'config' '--bool' '--get' 'svn.merge'
trace: built-in: git 'config' '--bool' '--get' 'svn.addauthorfrom'
trace: built-in: git 'config' '--bool' '--get' 'svn.useSvnsyncProps'
trace: built-in: git 'config' '--bool' '--get' 'svn.noMetadata'
trace: built-in: git 'config' '--bool' '--get' 'svn.local'
trace: built-in: git 'config' '--get' 'svn.strategy'
trace: built-in: git 'config' '--bool' '--get' 'svn.uselogauthor'
trace: built-in: git 'rev-parse' '--symbolic' '--all'
trace: built-in: git 'config' '-l'
trace: built-in: git 'config' '-l'
trace: built-in: git 'update-index' '--refresh'
trace: built-in: git 'log' '--no-color' '--first-parent' '--pretty=medium' 'HEAD'
trace: built-in: git 'config' '--bool' 'svn.useSvmProps'
trace: built-in: git 'config' '-l'
trace: built-in: git 'for-each-ref' '--format=%(refname)' 'refs/'
trace: built-in: git 'for-each-ref' '--format=%(refname)' 'refs/'
trace: built-in: git 'config' '--get' 'svn-remote.svn.rewriteRoot'
trace: built-in: git 'config' '--get' 'svn-remote.svn.url'
trace: built-in: git 'config' '--get' 'svn-remote.svn.uuid'
trace: built-in: git 'rev-list' '--pretty=raw' '--no-color' '--reverse'
'thesamehashthatwasreplacedforprivacy..refs/remotes/trunk' '--'
trace: built-in: git 'config' '--get' 'svn-remote.svn.rewriteRoot'
trace: built-in: git 'config' '--get' 'svn-remote.svn.rewriteUUID'
trace: built-in: git 'diff-index' 'HEAD' '--'
trace: built-in: git 'config' '--get' 'svn-remote.svn.usesvmprops'
trace: built-in: git 'config' '--get' 'svn-remote.svn.nometadata'
trace: built-in: git 'cat-file' 'commit' 'thesamehashthatwasreplacedforprivacy'
trace: built-in: git 'config' 'svn-remote.svn.reposRoot'
'svn+ssh://scm.gforge.inria.fr/svn/PROJECT'
trace: built-in: git 'rev-list' '--pretty=raw' '--no-color' '--reverse'
'thesamehashthatwasreplacedforprivacy..refs/remotes/trunk' '--'
trace: built-in: git 'config' 'svn-remote.svn.reposRoot'
'svn+ssh://scm.gforge.inria.fr/svn/PROJECT'
trace: exec: 'git-rebase' 'refs/remotes/trunk'
trace: run_command: 'git-rebase' 'refs/remotes/trunk'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '--show-toplevel'
trace: built-in: git 'config' '--bool' 'rebase.stat'
trace: built-in: git 'update-index' '--ignore-submodules' '--refresh'
trace: built-in: git 'diff-index' '--cached' '--name-status' '-r'
'--ignore-submodules' 'HEAD' '--'
trace: built-in: git 'rev-parse' '--verify' 'refs/remotes/trunk^0'
trace: built-in: git 'rev-parse' '--verify' 'refs/remotes/trunk^0'
trace: built-in: git 'symbolic-ref' 'HEAD'
trace: built-in: git 'symbolic-ref' '-q' 'HEAD'
trace: built-in: git 'rev-parse' '--verify' 'master^0'
trace: built-in: git 'merge-base' 'thesamehashthatwasreplacedforprivacy'
'thesamehashthatwasreplacedforprivacy'
trace: built-in: git 'rev-list' '--parents'
'thesamehashthatwasreplacedforprivacy..thesamehashthatwasreplacedforprivacy'
Current branch master is up to date.



-- 
Matthias Andree
