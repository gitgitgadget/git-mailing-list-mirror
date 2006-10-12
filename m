From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cg-commit does not run pre-commit hook?
Date: Thu, 12 Oct 2006 10:20:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610121011110.3952@g5.osdl.org>
References: <20061012155444.27391353BDE@atlas.denx.de>
 <Pine.LNX.4.64.0610120957460.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 19:24:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY4Ff-0005Kt-UA
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 19:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWJLRVS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 13:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWJLRVS
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 13:21:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17342 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751210AbWJLRVR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Oct 2006 13:21:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9CHKwaX001082
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Oct 2006 10:20:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9CHKvWX002739;
	Thu, 12 Oct 2006 10:20:58 -0700
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <Pine.LNX.4.64.0610120957460.3952@g5.osdl.org>
X-Spam-Status: No, hits=-0.467 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28791>



On Thu, 12 Oct 2006, Linus Torvalds wrote:
> 
> Why? That's just stupid.

Btw, let me explain that strong statement, because it _is_ a strong 
statement, but it's true.

The problem with trying to generate a changelog entry at commit time is 
that it is fundamentally a broken concept in a distributed environment.

What happens at a merge event? Sure, you can have special merge magic to 
try to sort out the mess, but it _is_ a mess. You can make things "work", 
but you can never actually make the result really make _sense_. The 
changelog is fundamentally a serialization of something that wasn't 
serial.

Now, the same serialization problem obviously exists when you 
auto-generate the changelog file when doing a release tar-ball or 
something like that, but at that point you basically "fix" it in time, so 
at that point the changelog actually makes sense.

It also turns out that in many situations, you can sort the result in 
other ways: the shortlog format, for example, is often superior to the 
default "git log" ordering, just because sorting things by person tends to 
actually result in a better view of what changed (it tells you something 
new: clumping by author not onyl tends to clump similar commits together 
and thus tell more of a "story", but it also has the added advantage of 
telling people who does what).

Generating things after-the-fact would also allow ordering things by what 
files (or subdirectories) they touch, although we've never done such a 
script. I do that quite often privately by just restricting the log to 
certain subsystems, though, and it's a damn useful thing to have. I would 
not be surprised at all if it might make sense to actually do a "tar-ball" 
changelog that way for certain projects - especially if they have clearly 
separated sub-components.

[ Btw, this whole "do things by pathname" has been so successful, that 
  I've come to realize that I would probably never accept an SCM that 
  doesn't allow something like that. Being able to do

	gitk some/random/set of/directories and/files

  is just _incredibly_ useful. Maybe others don't do it as much as I do, 
  but as a top-level maintainer, being able to look at history from the 
  viewpoint of just a random subset of the tree is incredibly powerful.

  I very strongly suspect that doing logs that way is often a good idea 
  too. ]

		Linus
