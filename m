From: Brad Roberts <braddr@puremagic.com>
Subject: Re: fork optional branch point normazilation
Date: Sun, 17 Apr 2005 05:40:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0504170530080.2625-100000@bellevue.puremagic.com>
References: <20050417122534.GD1487@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 14:38:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN920-0007oG-RM
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 14:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVDQMlQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 08:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVDQMlQ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 08:41:16 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:57324 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261314AbVDQMlD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 08:41:03 -0400
Received: from bellevue.puremagic.com (localhost [127.0.0.1])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3HCexUr005130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 17 Apr 2005 05:41:00 -0700
Received: from localhost (braddr@localhost)
	by bellevue.puremagic.com (8.13.3/8.13.3/Submit) with ESMTP id j3HCexah005126;
	Sun, 17 Apr 2005 05:40:59 -0700
X-Authentication-Warning: bellevue.puremagic.com: braddr owned process doing -bs
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050417122534.GD1487@pasky.ji.cz>
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> >
> > Index: gitfork.sh
> > ===================================================================
> > --- 51b1bddbbc05e50d5bbf1f9662e503c2e85d5e96/gitfork.sh  (mode:100755 sha1:e5692ea9bdbc39b028fe1e1205381da632541bab)
> > +++ c291316b28eff4042c80850cd93445345a606835/gitfork.sh  (mode:100755 sha1:386148ae9a99739d06a09742ff4157d0f7e4e223)
> > @@ -37,6 +37,7 @@
> >  [ -e "$destdir" ] && die "$destdir already exists"
> >
> >  [ "$head" ] || head=$(commit-id)
> > +head=$(gitXnormid.sh -c $head)
> >
> >  git lntree "$destdir"
> >  echo $head >.git/heads/$name
>
> commit-id always returns the normalized commit ID.
>
> --
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
>

This feels better to me.  Diffed against my previus commit.  The problem
was that commit-id wasn't called if a branch point was specified nor was
that value checked for validity.

Index: gitfork.sh
===================================================================
--- c9ccaa172ccab8e56f2fe621ee24896bfddacf26/gitfork.sh  (mode:100755 sha1:386148ae9a99739d06a09742ff4157d0f7e4e223)
+++ f9e06a309f63ac6858d019b51f2172283378d2ef/gitfork.sh  (mode:100755 sha1:dbb508b8431368fc95cc9516eada52f5bf0f8bc1)
@@ -16,7 +16,7 @@

 name=$1
 destdir=$2
-head=$3
+head=$(gitXnormid.sh -c $3)

 die () {
        echo gitfork.sh: $@ >&2
@@ -36,9 +36,6 @@

 [ -e "$destdir" ] && die "$destdir already exists"

-[ "$head" ] || head=$(commit-id)
-head=$(gitXnormid.sh -c $head)
-
 git lntree "$destdir"
 echo $head >.git/heads/$name
 ln -s heads/$name "$destdir/.git/HEAD"

