From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: git pull on Linux/ACPI release tree
Date: Sun, 8 Jan 2006 11:41:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601081111190.3169@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "David S. Miller" <davem@davemloft.net>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 20:42:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvgQX-0000GP-Ly
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 20:42:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161141AbWAHTmD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 14:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161169AbWAHTmB
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 14:42:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19356 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161141AbWAHTl5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2006 14:41:57 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k08JfTDZ026346
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 8 Jan 2006 11:41:29 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k08JfSno000910;
	Sun, 8 Jan 2006 11:41:28 -0800
To: "Brown, Len" <len.brown@intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14329>



On Sun, 8 Jan 2006, Brown, Len wrote:
>
> Perhaps the tools should try to support what "a lot of people"
> expect, rather than making "a lot of people" do extra work
> because of the tools?
> 
> Call me old fashioned, but I believe that tools are supposed to
> make work easier, not harder.

They DO.

Len, you're doing EXTRA WORK that is pointless.

Just stop doing the automated merges. Problems solved. It really is that 
easy. Don't do what David suggests - he does it because he's apparently 
_so_ comfortable with things that he prefers to do extra work just to keep 
his trees extra clean (I actually would disagree - but git makes that 
fairly easy to do, so if you prefer to have as linear a history as 
possible, you can do it with git pretty easily).

Now, I'm only complaining about _automated_ merges. If you have a reason 
to worry about my tree having clashes with your tree, do a real merge. For 
example, in your latest pull, you had a 

	"pull linus into release branch"

merge, where you merged my v2.6.15 tree. That makes perfect sense.

What I object to is that there were _also_ two automated merges within ten 
hours or each other, with absolutely _zero_ development in your tree in 
between. Why did you do that in your development tree? By _definition_ you 
had done zero development. You just tracked the development in _my_ tree.

In case you wonder, the two commits I'm talking about are:

	add5b5ee992e40c9cd8697ea94c223628be162a7
	25da0974601fc8096461f3d3f7ca3aab8e79adfb

and neither of them have any reason to be in a development tree. You 
didn't develop them.

They are real merges, because you had a trivial patch in your tree 
(changing the acpi-devel mailing list address) that I didn't have, so when 
you pulled, your end result was thus always different from something I had 
(so you did a real "merge", even though it was totally trivial), but the 
point is that there is a difference between "the ACPI development tree" 
and "the tree that has random ACPI patches and then tracks Linus' tree as 
closely as possible".

See?

That's the most egregious example. There's two unnecessary pulls on 
December 28 and 29th too (commits 0a5296dc and c1a959d8).

You can do

	gitk 0aec63e..f9a204e1 

to see exactly what I see when I pulled from you. 11 commits, 5 of which 
are just trivial merges that are no development, just tracking _my_ tree. 
Of those, one makes sense (tracking a release).

(NOTE NOTE NOTE! It does make sense to track my tree in case you do big 
changes and you worry about clashes. Then you would want to synchronize 
those big changes with my changes, so that you can resolve any clashes 
early. So I'm not saying that tracking trees is always bad: I'm saying 
that doing so _unnecessarily_ is bad, because it adds no value, and it 
just makes the history harder to read).

Now, most people don't read the history. It gets messy enough quickly 
enough that it's hard to read anyway over time. My tree has tons of _real_ 
merges anyway, since it's by definition the one that is used for most 
synchronization, so my tree is always pretty hard to follow.

But my guess is that this probably makes it harder for _you_ to see what 
you've done too. If you didn't merge with me, then "git log" would show 
just your own changes at the top, and that's likely what you care most 
about anyway, no?

Also, if you didn't pull from me, and you decided that you needed to re-do 
your tree (let's say that you notice that one of your commits was bad 
_before_ you ask me to pull from your tree), then you'd also have an 
easier time re-creating your own development without that buggy change, 
exactly because _your_ tree wouldn't have my changed mixed up in it.

So your merges likely make git harder to use for you, not easier.

		Linus
