From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 10:34:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602141026570.3691@g5.osdl.org>
References: <43F20532.5000609@iaglans.de> <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>
 <87k6bxvmj6.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Nicolas Vilz 'niv'" <niv@iaglans.de>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 19:35:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F950w-0005KO-G3
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 19:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbWBNSe5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 13:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbWBNSe4
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 13:34:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62419 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030374AbWBNSez (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 13:34:55 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1EIYaDZ023651
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 14 Feb 2006 10:34:36 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1EIYZPm020738;
	Tue, 14 Feb 2006 10:34:36 -0800
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87k6bxvmj6.wl%cworth@cworth.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16153>



On Tue, 14 Feb 2006, Carl Worth wrote:
> 
> I don't know if it's the original poster's question or not, but an
> operation I don't see in the above is "put the working files into the
> state of a given revision".

What a strange thing to ask for.

But you can do it several ways:

 - just use "git reset" to move around in history, possibly on a temporary 
   branch.

 - use "git checkout <rev> <filename>" to checkout a particular filename 
   of a particular version (it's a special case of "git checkout", which 
   is useful, but I personally think it's a bit confusing, so I wouldn't 
   mention it unless you asked)

 - use the core internal git functions, in particular

	git-read-tree -m -u <oldtree> <newtree>

   will switch from "oldtree" to "newtree" and update (-u) the working 
   tree.

> 2) Ensure that bogus-branch exists somewhere (don't care where), then
>    move it:
> 
> 	# Create the branch (if it doesn't exist)
> 	git checkout -b bogus-branch >& /dev/null
> 	# Switch to it (which doesn't happen above if it already existed)
> 	git checkout bogus-branch
> 	# Move the branch to the revision of interest
> 	git reset --hard <revision>

This is actually what I'd suggest you always do.

Why?

It's actually as efficient as anything else, and there's much less room 
for confusion. When you want to go back, you can just do a simple

	git checkout -f master

and there's no room for confusion. You've not lost sight of any old state, 
and your HEAD never differs from your checked-out copy, so all the normal 
commands work the way you'd expect them to.

		Linus
