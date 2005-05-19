From: Sebastian Kuzminsky <seb@highlab.com>
Subject: Re: manpage name conflict
Date: Thu, 19 May 2005 10:24:54 -0600
Message-ID: <E1DYnpO-0003cF-I6@highlab.com>
References: <E1DYmy8-0003YB-JW@highlab.com> <20050519155804.GB4513@pasky.ji.cz>
X-From: git-owner@vger.kernel.org Thu May 19 18:27:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYnqV-00064e-S3
	for gcvg-git@gmane.org; Thu, 19 May 2005 18:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVESQY7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 12:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVESQYl
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 12:24:41 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:51076 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261161AbVESQXv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 12:23:51 -0400
Received: from highlab.com ([24.8.179.27])
          by comcast.net (sccrmhc11) with ESMTP
          id <2005051916234801100itos3e>; Thu, 19 May 2005 16:23:48 +0000
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1DYnpO-0003cF-I6
	for git@vger.kernel.org; Thu, 19 May 2005 10:24:54 -0600
To: git@vger.kernel.org
In-reply-to: <20050519155804.GB4513@pasky.ji.cz> 
Comments: In-reply-to Petr Baudis <pasky@ucw.cz>
   message dated "Thu, 19 May 2005 17:58:05 +0200."
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@ucw.cz> wrote:
> Does this manpage actually belong to man1? What about git(7) or
> something? It's not an actual command.


Good point.


Ok, I've appended a patch (against the top of git-pb) that moves the
git manpage to man7.  It also does two other things:

    * Sort of works around the asciidoc 6.0.3 bug where the manpages all
      get called "git.1".  It just renames them to what they should have
      been called.

    * Fixes a cut-n-paste bug in git-diff-helper.txt that was making
      asciidoc choke.




> Not directly related to this problem, but just FYI - git isn't staying
> as part of Cogito forever, actually I think its time in Cogito
> distribution is running over soon (now that I've pushed all the interesting
> local changes to git-pb, consequently to git-linus).
> 
> So you will have to either bundle it manually in the distribution
> packages, or provide a separate git package for cogito to depend on
> (when the unbundling really happens).  Either way, this is git issue,
> not cogito. :-)


Right.  Hm.  It's no problem to have git be it's own separate package
with all the appropriate relationships (cogito Requires git, and git
suggests cogito).


But what is going to be the name of the git package?  Let's please
not make it "git", because that's taken by the GNU Interactive Tools.
How about "git-core" or "git-plumbing" or "linus-is-a-git"?


;)




Anyway, here's the documentation patch:


Index: Documentation/Makefile
===================================================================
--- 75b95bec390d6728b9b1b4572056af8cee34ea7d/Documentation/Makefile  (mode:100644)
+++ uncommitted/Documentation/Makefile  (mode:100644)
@@ -1,6 +1,6 @@
 DOC_SRC=$(wildcard git*.txt)
 DOC_HTML=$(patsubst %.txt,%.html,$(DOC_SRC))
-DOC_MAN=$(patsubst %.txt,%.1,$(DOC_SRC))
+DOC_MAN=$(patsubst %.txt,%.1,$(wildcard git-*.txt)) git.7

 all: $(DOC_HTML) $(DOC_MAN)

@@ -13,13 +13,15 @@
        touch $@

 clean:
-       rm -f *.xml *.html *.1
+       rm -f *.xml *.html *.1 *.7

 %.html : %.txt
        asciidoc -b css-embedded -d manpage $<

-%.1 : %.xml
+%.1 %.7 : %.xml
        xmlto man $<
+       # FIXME: this next line works around an output filename bug in asciidoc 6.0.3
+       [ "$@" = "git.7" ] || mv git.1 $@

 %.xml : %.txt
        asciidoc -b docbook -d manpage $<
Index: Documentation/git-diff-helper.txt
===================================================================
--- 75b95bec390d6728b9b1b4572056af8cee34ea7d/Documentation/git-diff-helper.txt  (mode:100644)
+++ uncommitted/Documentation/git-diff-helper.txt  (mode:100644)
@@ -1,5 +1,5 @@
 git-diff-helper(1)
-=======================
+==================
 v0.1, May 2005

 NAME
Index: Documentation/git.txt
===================================================================
--- 75b95bec390d6728b9b1b4572056af8cee34ea7d/Documentation/git.txt  (mode:100644)
+++ uncommitted/Documentation/git.txt  (mode:100644)
@@ -1,4 +1,4 @@
-git(1)
+git(7)
 ======
 v0.1, May 2005


-- 
Sebastian Kuzminsky
"Marie will know I'm headed south, so's to meet me by and by"
-Townes Van Zandt
