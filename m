From: Steffen Jaeckel <steffen.jaeckel@stzedn.de>
Subject: Unexpected behavior of git-subtree
Date: Mon, 29 Apr 2013 19:34:27 +0200
Organization: Steinbeis Innovationszentrum Embedded Design und Networking
Message-ID: <1003348467.20130429193427@stzedn.de>
Reply-To: Steffen Jaeckel <steffen.jaeckel@stzedn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 29 19:34:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWryC-0005ew-MU
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 19:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757585Ab3D2Re2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 13:34:28 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:18229 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757547Ab3D2Re2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 13:34:28 -0400
X-RZG-AUTH: :Jm0Bdkutd9+hmApeFfvVItwLAhvERWWdnqr6RNEtsBX+cJj9Jg197xtEQP6NGcQ=
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.7] (pd956be74.dip0.t-ipconnect.de [217.86.190.116])
	by smtp.strato.de (jored mo41) (RZmta 31.27 AUTH)
	with ESMTPA id i03fa2p3THAilp for <git@vger.kernel.org>;
	Mon, 29 Apr 2013 19:34:26 +0200 (CEST)
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222819>

Hi,

lately I used git-subtree to integrate a submodule directly into a
repository. Now I wanted to push the changes back to the original
repository of the submodule and I was a bit surprised by what
happened...


---- snip ----
sjaeckel@T7400-003 /h/projects/my_project (develop)
$ GIT_TRACE=2 git subtree push --prefix=lib/com_lib/ git@git.local:com_lib develop -b develop
trace: exec: 'git-subtree' 'push' '--prefix=lib/com_lib/' 'git@git.local:com_lib' 'develop' '-b' 'develop'
trace: run_command: 'git-subtree' 'push' '--prefix=lib/com_lib/' 'git@git.local:com_lib' 'develop' '-b' 'develop'
trace: built-in: git 'rev-parse' '--parseopt' '--' 'push' '--prefix=lib/com_lib/' 'git@git.local:com_lib' 'develop' '-b' 'develop'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '--show-cdup'
git push using:  git@git.local:com_lib develop
trace: exec: 'git-subtree' 'split' '--prefix=lib/com_lib/'
trace: run_command: 'git-subtree' 'split' '--prefix=lib/com_lib/'
trace: built-in: git 'rev-parse' '--parseopt' '--' 'split' '--prefix=lib/com_lib/'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '--show-cdup'
trace: built-in: git 'rev-parse' '--default' 'HEAD' '--revs-only'
trace: built-in: git 'rev-parse' '--no-revs' '--no-flags'
trace: built-in: git 'log' '--grep=^git-subtree-dir: lib/com_lib/*$' '--pretty=format:START %H%n%s%n%n%b%nEND%n' '8068a810709f6284b04a18ff38dbb72c36b8d9c6'
trace: built-in: git 'rev-list' '--topo-order' '--reverse' '--parents' '8068a810709f6284b04a18ff38dbb72c36b8d9c6'
trace: built-in: git 'rev-list' '--topo-order' '--reverse' '--parents' '8068a810709f6284b04a18ff38dbb72c36b8d9c6'
1/    102 (0)trace: built-in: git 'ls-tree' 'f6e1457d345029cf4d376ff3cf780cbb8c3080b4' '--' 'lib/com_lib'
..... loads of more git 'ls-tree'...
71/    102 (70)72/    102 (70)trace: built-in: git 'ls-tree' '48dc0efb9a148b1146b013554f8bf4635adf7a0d' '--' 'lib/com_lib'
trace: built-in: git 'log' '-1' '--pretty=format:%T' '6299b48765e11302aca48cc9fca88735aeab7c54' '--'
fatal: bad object 6299b48765e11302aca48cc9fca88735aeab7c54
trace: built-in: git 'push' 'git@git.local:com_lib' ':refs/heads/develop'
trace: run_command: 'ssh' 'git@git.local' 'git-receive-pack '\''com_lib'\'''
Repository name is: com_lib.git
Repository_Clean name is: com_lib
Branch name is: com_lib/develop
To git@git.local:com_lib
 - [deleted]         develop
sjaeckel@T7400-003 /h/projects/my_project (develop)
$ git version
git version 1.8.1.msysgit.1
---- /snip ----


I don't know if that's a bug or I used git-subtree's options incorrect,
but what I read from its "manpage" 'git-subtree.txt', I would expect
that this command should split out the commits of the prefix and push
that to the remote of the former submodule.

Even if it's my fault, because I used it incorrect, I think it should
not delete the remote branch.

Besides "git subtree push --prefix=lib/com_lib/ git@git.local:com_lib
develop -b develop" I also tried "git subtree push
--prefix=lib/com_lib/ git@git.local:com_lib develop" with the same
effect.

Can someone tell me if that's a bug, and/or what I did wrong?


Thanks
Steffen
