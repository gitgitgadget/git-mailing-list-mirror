From: Marcin Owsiany <porridge@debian.org>
Subject: git-svn stubbornly re-creating branch "master"
Date: Sun, 29 Mar 2009 18:13:47 +0100
Message-ID: <20090329171347.GA26866@beczulka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 29 19:35:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lnyuf-0002et-BE
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 19:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbZC2Rdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 13:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbZC2Rdl
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 13:33:41 -0400
Received: from mail0.vicoop.com ([85.17.210.107]:59922 "EHLO mail.vicoop.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbZC2Rdl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 13:33:41 -0400
X-Greylist: delayed 1185 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Mar 2009 13:33:40 EDT
Received: from localhost (dsl-49-57.dsl.netsource.ie [213.79.49.57])
	(Authenticated sender: porridge@sl.owsiany.pl)
	by mail.vicoop.com (Postfix) with ESMTP id 4745E1E8EE
	for <git@vger.kernel.org>; Sun, 29 Mar 2009 19:13:50 +0200 (CEST)
Received: from mowsiany by localhost with local (Exim 4.67)
	(envelope-from <marcin@owsiany.pl>)
	id 1LnyZv-00076f-6s
	for git@vger.kernel.org; Sun, 29 Mar 2009 18:13:47 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115030>

Hello,

I created my git repository by cloning it with git-svn from an upstream SVN
repository. When I did that, a branch "master" was created. Afterwards I
renamed that branch to "upstream". However every time I "git-svn fetch", it
recreates the "master" branch, pointing it at the newest upstream commit.

Ideally, I'd like it to just forget about "master" and do the same to my
"upstream" branch. Is it possible?

If not, then is it at least possible to have it not recreate the "master"
branch? It clutters my view.


Here's a typescript (with git 1:1.5.6.3-1.1ubuntu2):

$ svnadmin create svn-repo
$ r=`pwd`/svn-repo
$ svn co file://$r svn
Checked out revision 0.
$ (cd svn && echo one >> file && svn add file && svn ci -m one file)
A         file
Adding         file
Transmitting file data .
Committed revision 1.
$ git-svn clone file://$r git
Initialized empty Git repository in /home/mowsiany/tmp/gs/git/.git/
        A       file
r1 = 66e7199fe089b1e626efb5f2f3106189d992d288 (git-svn)
Checked out HEAD:
  file:///home/mowsiany/tmp/gs/svn-repo r1
$ (cd git && git show-ref )
66e7199fe089b1e626efb5f2f3106189d992d288 refs/heads/master
66e7199fe089b1e626efb5f2f3106189d992d288 refs/remotes/git-svn
$ (cd git && git branch mystuff )
$ (cd git && git show-ref )
66e7199fe089b1e626efb5f2f3106189d992d288 refs/heads/master
66e7199fe089b1e626efb5f2f3106189d992d288 refs/heads/mystuff
66e7199fe089b1e626efb5f2f3106189d992d288 refs/remotes/git-svn
$ (cd git && git branch -m master upstream )
$ (cd git && git show-ref )
66e7199fe089b1e626efb5f2f3106189d992d288 refs/heads/mystuff
66e7199fe089b1e626efb5f2f3106189d992d288 refs/heads/upstream
66e7199fe089b1e626efb5f2f3106189d992d288 refs/remotes/git-svn
$ (cd svn && echo two >> file  && svn ci -m two file)
Sending        file
Transmitting file data .
Committed revision 2.
$ (cd git && git-svn fetch  )
        M       file
r2 = c2f8e7fd146e0e9f1223f20bf3c2105f71632c4b (git-svn)
$ (cd git && git show-ref )
c2f8e7fd146e0e9f1223f20bf3c2105f71632c4b refs/heads/master
66e7199fe089b1e626efb5f2f3106189d992d288 refs/heads/mystuff
66e7199fe089b1e626efb5f2f3106189d992d288 refs/heads/upstream
c2f8e7fd146e0e9f1223f20bf3c2105f71632c4b refs/remotes/git-svn

As you can see, "master" sprang back to life after the last command.

-- 
Marcin Owsiany <porridge@debian.org>             http://marcin.owsiany.pl/
GnuPG: 1024D/60F41216  FE67 DA2D 0ACA FC5E 3F75  D6F6 3A0D 8AA0 60F4 1216
