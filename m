From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Thu, 12 Apr 2007 12:17:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704121203290.4061@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0704111646000.6730@woody.linux-foundation.org> 
 <Pine.LNX.4.63.0704111628240.28394@qynat.qvtvafvgr.pbz> 
 <Pine.LNX.4.64.0704111903060.4061@woody.linux-foundation.org>
 <56b7f5510704121132g3961060amb394978bb49093e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Lang <david.lang@digitalinsight.com>,
	Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 21:17:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc4nq-0000QY-5H
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 21:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbXDLTRu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 15:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbXDLTRu
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 15:17:50 -0400
Received: from smtp.osdl.org ([65.172.181.24]:55916 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbXDLTRt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 15:17:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3CJHZIs021792
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Apr 2007 12:17:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3CJHYVT008025;
	Thu, 12 Apr 2007 12:17:34 -0700
In-Reply-To: <56b7f5510704121132g3961060amb394978bb49093e6@mail.gmail.com>
X-Spam-Status: No, hits=-0.957 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44348>



On Thu, 12 Apr 2007, Dana How wrote:
> 
> These arguments all seem pretty convincing to me --
> maybe the problem is that I'm not a "*developer*" right now.
> Instead I'm part of a multi-developer *site*.

Yes.

The issues for hosting sites are very different from the issues of 
individual developers having their own git repositories, and I agree 100% 
that both alternates and shared object directories make tons of sense for 
hosting.

> Below I talk about a possible way we could use git
> without changing it (since I recognize this would be a minority usage
> pattern).

I hope it wouldn't even be a minority usage pattern. I am a firm believer 
that distributed SCM's and git in particular makes a lot more sense for 
source control hosting than CVS or SVN do. I'm really disappointed with 
things like sourceforge, and part of the problem is literally that a 
centralized SCM is really *fundamentally* wrong for a hosting entity. 

Using a distributed SCM just makes _so_ much more sense for hosting 
projects, and I've actually very much wanted to try to make sure that git 
can help people who host things. 

It's not my *own* primary use, but I think it's a very important usage 
pattern, even though it's very different froma "normal developer" private 
sandbox case.

So I think your case is really very interesting. I'd love to help figure 
out how to help you guys with git, but because it's not how I personally 
work, I can really just try to help when you actually hit a problem - 
you'll have to figure out what your usage patterns actually are on your 
own ;)

And btw, I think the shared object model really works very well, but I 
think it has to be paired with some stricter rules than people who use 
their own repos tend to have. For example, end-point developers have 
become very used to rebasing and generally rewriting history (or just 
resetting to an older state), and that's something that works find in a 
"local repository" setup, but it's also the kinds of patterns that can 
really screw you in a hosted and shared-object environment.

As to your two setups: I would suggest you go with the "hidden" shared 
version (ie people use the remote access pull/push to a server, and the 
*server* uses a shared object repository for multiple repositories), 
rather than having a user-visible globally shared object directory. Even 
with sticky bits and controlled group access etc, I think it's just safer 
to have that extra level of indirection.

(Partly because a globally visible shared object directory also implies 
that you'd use a networked filesystem, and I suspect a lot of developers 
would actually be a lot happier having their own development repositories 
on their own local disks, or at least some "group disk", rather than have 
one big and performance-critical network share. Even if you use some 
competent NetApp box and a modern network filesystem, it's just one less 
critical infrastructure piece that needs to be really beefy).

		Linus
