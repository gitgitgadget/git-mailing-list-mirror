From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 08:31:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610180820210.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> 
 <200610170119.09066.jnareb@gmail.com> <45346290.6050300@utoronto.ca> 
 <200610171120.09747.jnareb@gmail.com>  <1161078035.9020.73.camel@localhost.localdomain>
  <4534AB8B.8030505@op5.se> <1161147348.3423.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 18 17:32:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaDOC-0000fb-So
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 17:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161116AbWJRPbY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 11:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161173AbWJRPbY
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 11:31:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52901 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161116AbWJRPbX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 11:31:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9IFVAaX027663
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Oct 2006 08:31:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9IFV6Lr006335;
	Wed, 18 Oct 2006 08:31:09 -0700
To: Robert Collins <robertc@robertcollins.net>
In-Reply-To: <1161147348.3423.24.camel@localhost.localdomain>
X-Spam-Status: No, hits=-0.469 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29238>



On Wed, 18 Oct 2006, Robert Collins wrote:
> 
> More commonly though, like git users have 'origin' and 'master'
> branches, bzr users tend to have a branch that is the 'origin' (for bzr
> itself this is usually called bzr.dev), as well as N other branches for
> their own work, which is probably why we haven't seen the need to have a
> ui command to spit out the revnos for an arbitrary branch.

You mis-understand.

git doesn't have a "ui command to spit out the revnos for an arbitrary 
branch" either.

Normally, you'd just use the branch-name. Nobody ever uses the SHA1's 
directly.

What git does (and does very well) is to be _scriptable_. It was designed 
that way. I'm a UNIX guy. I think piping is very powerful. And when you 
script things, your scripts pass SHA1's around internally.

So for example, to repack a git archive, you'd normally do

	git repack -a -d

and you don't have any "UI" with SHA1 numbers. But internally, this used 
to be

	git-rev-list --all --objects |
		git-pack-objects 

where "git-rev-list" is the one that lists all object names (which are the 
SHA1 numbers), and "git-pack-objects" is the one that takes a list of 
objects and packs them. 

(These days, since our internal C libraries have become so much better, 
the object traversal is done internally to packing, so we don't actually 
use the pipe any more for repacking an archive, but that's just an 
implementation detail)

You seem to think that we use SHA1 names as _humans_. We don't. The SHA1 
names are used internally, and humans just use the branch names.

The only case you'd (as a human) use the SHA1 name is when you want to 
pass it on to another person that may have a different archive (ie you 
mail somebody a revision that is problematic). It would obviously be 
totally unworkable to say "it's the grand-parent of my current HEAD 
commit", since that's a local description. So instead, you'd say "it's 
commit 9550e59c4587f637d9aa34689e32eea460e6f50c".

So I think people (totally incorrectly) think that git users use a lot of 
SHA1 names, just because they see the git users on the kernel mailing list 
sending each others SHA1 names. But that's because you see only the case 
where you _want_ to communicate a stable revision name to another side. 
Sending a number like 1.57.8.312 to describe what commit broke would be a 
_bug_, because a person who has a differently shaped tree wouldn't even 
_have_ that revision.

But normally? You'd be hard-pressed to find anything but the branch (and 
tag) names on a command line.

See?

			Linus
