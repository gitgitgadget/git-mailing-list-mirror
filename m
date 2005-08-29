From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cogito/git usage question
Date: Mon, 29 Aug 2005 08:19:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508290804570.3243@g5.osdl.org>
References: <4312E74D.5020203@eircom.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 17:22:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9lQE-0004oM-EM
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 17:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVH2PTW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 11:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVH2PTW
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 11:19:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17567 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751238AbVH2PTV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 11:19:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7TFJHjA031689
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 Aug 2005 08:19:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7TFJGkH007319;
	Mon, 29 Aug 2005 08:19:17 -0700
To: "Bryan O'Donoghue" <typedef@eircom.net>
In-Reply-To: <4312E74D.5020203@eircom.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7903>



On Mon, 29 Aug 2005, Bryan O'Donoghue wrote:
> 
> cg-tag-ls lists every version from 2.6.11 to the current 2.6.13
> inclusive. cg-tag-ls also lists kernel version 2.6.13-rc6. What I'm
> wondering is how exactly I set copy of the tree to that version, so that
> I can apply the -mm patchset ?

You need to start a new branch at the right point in time, and check it
out. Let's call it "bryan-mm", and then it looks something like this:

	git checkout -b bryan-mm v2.6.13-rc6

(mental footnote: pronounce it as "git checkout new branch 'bryan-mm' at
v2.6.13-rc3").

[ You can also do the exact same thing by

	git branch bryan-mm v2.6.13-rc6
	git checkout bryan-mm

  and it's entirely a matter of taste whether you usually want to create 
  the branches first, and switch to them later, or create-and-switch in 
  one go ]

So then you can apply any -mm patches to that tree.

If you want to merge the result (ie you want to have _both_ the -mm 
patches _and_ the changes from the final 2.6.13 release), you might want 
to create yet another branch so that you can easily switch between the 
different states, and then do a "resolve":

	git checkout -b bryan-mm-merged
	git resolve HEAD v2.6.13 "Merge 2.6.13-rc7-mm1 and final 2.6.13"

which will hopefully have no conflicts, and commit the end result. If it 
did have conflicts, you'll have to fix it up by hand (all the normal 
markers from CVS: "<<<<" one side "=====" other side ">>>>>"), and then 
commit it by hand with "git commit --all".

[ Notice how in this second "git checkout -b" we only gave the new branch 
  name, not where to start. That's because we just wanted to start from 
  the same point where we already were in in the original bryan-mm branch ]

Finally, use "gitk --all" to get a better mental visualization for what
the hell you just did. I keep repeating that command, because just
doing the commands may not give you the same understanding of what 
actually happened, but "gitk --all" is really good for visualizing what's 
up (less so when the branches aren't close to each other, but still..)

And then you can switch between the different branches with just a simple

	git checkout <branch>

and off you go.

			Linus
