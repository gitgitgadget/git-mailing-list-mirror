From: Petr Baudis <pasky@ucw.cz>
Subject: "True" git merge in git-pasky
Date: Tue, 19 Apr 2005 05:51:07 +0200
Message-ID: <20050419035107.GB5554@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 19 05:47:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNjhr-0005mJ-DN
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 05:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVDSDvT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 23:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVDSDvT
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 23:51:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47285 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261217AbVDSDvJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 23:51:09 -0400
Received: (qmail 21940 invoked by uid 2001); 19 Apr 2005 03:51:07 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  so I've implemented "true" git merge in git-pasky, using core git's
merging capabilities. It seems to even work. :-)

  I tested it briefly, and even did one non-conflicting and one
conflicting merge with Linus with this, but I'd like to hear your
comments and possibly more testing before releasing it.

  To get the lastest git-pasky, get the tarball at

	http://pasky.or.cz/~pasky/dev/git

unpack, build, install, do

	git pull

rebuild and reinstall.


  The semantics is trivial (and it might get changed so that you would
do git update instead of git pull at most of places). If you don't have
a given GIT repository ready yet, do

	git init rsync://example.com/repo

in a new directory. It is by default tracking, therefore if you do

	git pull

anytime later, git merge will be automatically invoked. If you want to
prevent this, do

	git track

which will untrack your tree; the remote branch you were tracking is
called "origin", shall you want to pull/merge it later. You might want
to also merge with someone else. Do

	git addremote elsewhere rsync://example.org/another
	git pull elsewhere
	git merge elsewhere

(Note that merge won't pull automatically; you must do that on your own
if you want to pull.)


If the merge didn't succeed and you have conflicts, don't panic. The
merge told you about the conflicts, you can also do

	git diff

to see the changes, you'll probably spot the conflict markers. Resolve
the conflicts and then simply do

	git commit

to commit the pending merge.


Now you decided to do a little bit of parallel development and stick
your patches not ready for 2.6.12 to a separate tree. That's fine, do

	git fork experimental ~/linux-2.6.experimental

and get some coffee. (It takes about 8 minutes here, but I think git
isn't at fault - it is probably all spent in

	read-tree $(tree-id)
	checkout-cache -a
	update-cache --refresh

and you pretty much need to call that.)

Then, do some work there, syncing with your main tree periodically:

	git merge master

(that's how your first init'd branch is called). You decide to make it
more fun for Linus and push your experimental stuff into your master
tree. Fine, cd there and do

	git merge experimental

and there you go!


Have fun,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
