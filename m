From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Storing state in $GIT_DIR
Date: Thu, 25 Aug 2005 22:31:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508252219520.3317@g5.osdl.org>
References: <46a038f905082420323b025e3b@mail.gmail.com>
 <Pine.LNX.4.58.0508251053000.3317@g5.osdl.org> <46a038f905082518306e9d7d2a@mail.gmail.com>
 <Pine.LNX.4.58.0508252051400.3317@g5.osdl.org> <46a038f90508252115415acc04@mail.gmail.com>
 <7v3boxl3o1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0508260101390.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 08:18:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8WpD-0008P5-Es
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 07:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbVHZFbt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 01:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbVHZFbt
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 01:31:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58344 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965052AbVHZFbs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 01:31:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7Q5VajA009269
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 25 Aug 2005 22:31:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7Q5VZ0O024361;
	Thu, 25 Aug 2005 22:31:35 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508260101390.23242@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7792>



On Fri, 26 Aug 2005, Daniel Barkalow wrote:
> 
> I don't think this buys you anything, because then the tag needs to be
> accessible from something, which is the same problem you were trying to
> solve for the commit.

Yes. 

We had an earlier discussion somewhat along these lines, where a 
"collection" object might be useful. The "tree" object is that, of course, 
but the tree object really is very strictly structured (and has to be that 
way). There might be a valid case for an object that can point to an 
arbitrary collection of other objects, and have a free-form tail to it.

Of course, such an object would inevitably look very much like a 
generalized "tag" object, so one possibility might be to just allow a tag 
to have multiple object pointers.

We could easily generalize the tag format: just make it be something like

 - 1 or more lines of "object <sha1>"
 - make the "type " line optional (it used to have an implementation 
   reason: the internal interfaces always used to want to know the type 
   up-front, but we've moved away from that).
 - a single "tag" line to start the free-form section, and to name the 
   collection some way.

That kind of extension shouldn't be too hard, and might make tags much 
more generally usable (ie you could say "I sign these <n> official 
releases" or something).

			Linus
