From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: git-svn rebase can change branches during merge?
Date: Mon, 16 Mar 2009 23:36:41 +0100
Message-ID: <20090316233641.248f2e81@perceptron>
References: <683a886f0903161349k172679a6t24cc4e393aea8f2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kevin Williams <kevwil@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 23:38:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjLRr-0008OJ-NI
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 23:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755984AbZCPWgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 18:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754101AbZCPWgr
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 18:36:47 -0400
Received: from zoidberg.org ([88.198.6.61]:59703 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476AbZCPWgq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 18:36:46 -0400
Received: from perceptron (xdsl-78-34-174-68.netcologne.de [::ffff:78.34.174.68])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Mon, 16 Mar 2009 23:36:43 +0100
  id 0040452E.49BED47B.00003DD1
In-Reply-To: <683a886f0903161349k172679a6t24cc4e393aea8f2d@mail.gmail.com>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113400>

Hi Kevin,

> I've outlined steps where I can reproduce this bug here:
> http://gist.github.com/80058
> 
> When using "git svn rebase" and there is a conflict between a local
> (git) change and an upstream (svn) change, the local git repository is
> left in a ghost-branch. It shouldn't change branches during a rebase,
> should it? I also seem to be unable to recover from the merge
> conflict, but that may be just due to the noob at the keyboard (me).

rebase doesn't actually switch to another branch here, but it does
detach HEAD. To get back to a state you can work from, it's a simple
case of following the instructions rebase outputs:

1) edit conflicted files to fix the conflicts.
2) stage new versions of files (e.g. git add file.txt)
3) git rebase --continue

Here's what happens:

jast@perceptron 1% cat test.txt
<<<<<<< HEAD:test.txt
git svn rebase blows up here
=======
hello from svn
hello from git
>>>>>>> add to txt file from git:test.txt
jast@perceptron % git branch
* (no branch)
  master
jast@perceptron % vim test.txt
[...]
jast@perceptron % git add test.txt
jast@perceptron % git rebase --continue
Applying: add to txt file from git
jast@perceptron % git branch
* master
jast@perceptron %

Make sense?
-Jan
