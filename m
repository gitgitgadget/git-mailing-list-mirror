From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Helpers scripts to simplify work with submodules (git-sm-commit and git-sm-pull)
Date: Sat, 7 Nov 2009 14:05:53 +0100
Message-ID: <200911071405.53530.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Michal Sojka <sojkam1@fel.cvut.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 07 14:29:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6lLi-0000Hk-80
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 14:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbZKGNZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2009 08:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbZKGNZe
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 08:25:34 -0500
Received: from viefep16-int.chello.at ([62.179.121.36]:31524 "EHLO
	viefep16-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbZKGNZd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 08:25:33 -0500
X-Greylist: delayed 1178 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Nov 2009 08:25:33 EST
Received: from edge05.upc.biz ([192.168.13.212]) by viefep18-int.chello.at
          (InterMail vM.7.09.01.00 201-2219-108-20080618) with ESMTP
          id <20091107130556.EOBT7028.viefep18-int.chello.at@edge05.upc.biz>;
          Sat, 7 Nov 2009 14:05:56 +0100
Received: from baree.pikron.com ([62.24.72.246])
	by edge05.upc.biz with edge
	id 2D5t1d0Hr5JpFYE05D5v8c; Sat, 07 Nov 2009 14:05:56 +0100
X-SourceIP: 62.24.72.246
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132363>

Hello to all git developers and users,

we are dropping use of other SCMs for most of our projects
during time and switch to GIT. The actual one is uLan protocol
related stuff

  http://sourceforge.net/projects/ulan/develop
  git://ulan.git.sourceforge.net/gitroot/ulan/ulan

This project provided more libraries and targets support used
in other university and company projects. CVS allows to checkout
some subset/directory for use in such case. The GIT does not
support work with subtrees so we have split project into
multiple submodules, but actual GIT submodules support
makes committing and maintenance over whole tree a little painfull.

So there are hackish helper scripts which made us work simpler
and can be found usable by others as well

git-sm-pull - runs git pull (by default) or other option or shell specified 
command
for all subprojects. It is not necessary to stay in the project top directory,
when invoked. If it can be instructed to work with top lever repository even
if current working directory is inside subproject directory if option -w
is specified.

http://ulan.git.sourceforge.net/git/gitweb.cgi?p=ulan/ulan-top;a=blob;f=scripts/git-sm-pull;hb=HEAD

Usage: git-sm-pull [options] [shell command]
      -w --whole      find top repository for whole project
      -h --help       help
      -p --pull       pull in all submodules
      -P --push       push in all submodules
      -s --status     status in all submodules

git-sm-pull - runs git gui (by default) or other option or shell specified 
command
for all subproject where status reports that repository is not clean.

http://ulan.git.sourceforge.net/git/gitweb.cgi?p=ulan/ulan-top;a=blob;f=scripts/git-sm-commit;hb=HEAD

Usage: git-sm-commit [options] [shell command]
      -h --help       help
      -w --whole      find top repository for whole project
      -m --message    specify commit message on command line
      -a --all        commit all changes in tracked files
      -s --status     show status

The second stript can be used without parameters or with -w to do
select and commit changes interactively or if option -m and/or -a
are used int runs git commit. You can find quite strange trickeries
there to propagate correctly multiple word arguments through shell/bash
there so it works as expected.

  git-sm-commit                    -> invokes GUI for modified submodules
                                      and for top finally
  git-sm-commit -a -m "my change"  -> commits changes in all tracked files
                                      in all submodules with provided message
                                      and then does toplevel commit which
                                      should ensure submodules versions tying
  git-sm-commit qgit               -> runs know fancy viewer for each modified
                                      submodule and for top finally
  
The other git commands can be specified as well, so git-sm-commit
can be little misleading after script evolution from original single
purpose version, but commit preparation is it main use still.

Thanks for git and may it be that these scripts can be usable
for some other users,

                Pavel Pisa
    e-mail:     pisa@cmp.felk.cvut.cz
    www:        http://cmp.felk.cvut.cz/~pisa
    university: http://dce.felk.cvut.cz/
    company:    http://www.pikron.com/
