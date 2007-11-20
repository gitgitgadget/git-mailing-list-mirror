From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Partial checkouts / submodules
Date: Tue, 20 Nov 2007 16:59:22 +0100
Message-ID: <20071120155922.GA6271@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 20 17:51:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuWJB-0003Em-1Y
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 17:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904AbXKTQu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 11:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752439AbXKTQu1
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 11:50:27 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:57922 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527AbXKTQu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 11:50:26 -0500
X-Greylist: delayed 3062 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Nov 2007 11:50:26 EST
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.60)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1IuVVS-0002ea-Si
	for git@vger.kernel.org; Tue, 20 Nov 2007 16:59:23 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65549>

My use case it this: We have some huge projects (let's call them
supermodules) that are the only products we really release. Any change
going into any of the submodules go in solely to modify the
superproject, the submodules are not released on their own.

We cannot keep the supermodule with all its submodules in one git
repository for two reasons: Size & sharing. A 6GB+ repository is too
big to handle gracefully, and there are multiple superprojects sharing
some of the submodules. Our supermodules typically contains 50-250
submodules. Usually it is sufficient to look at just a few of these
submodules at the same time.

I looked into the current git submodules to see if they support what I
think we need, but it seems like they do not really cut it (If I'm
wrong about this, please educate me).

What I want is this: 

Somewhere the following modules all exist:

supermodule/
   submodule1
   submodule2
   submodule3
    ...
   submodule200

You pull the supermodule, and initialize random collection of
submodules, e.g. locally you have:

supermodule/
   submodule13
   submodule71
   submodule102

Now I want this to behave as if it was a partial checkout of
"supermodule" - i.e. I want _all_ operations in any of the submodules
to act as if they happened in all the submodules (as if supermodule
was a single repository containing all the submodules directly).

If I do a change in submodule13, another change in submodule71 and yet
another change in submodule102, I want to be able to commit them all
as ONE commit (obviously it will be 4 commits, 1 in each submodule and
one in the supermodule, but anyone looking at this in the context of
this supermodule should see it as one commit).

If I pull supermodule, I get updates to supermodule, submodule13,
submodule71 and submodule102, but nothing else.

If I make a branch on submodule71, the branch is made in all submodules &
the supermodule.

With this setup it should be possible to handle supermodule as a
normal module with branches for each feature/topic/bugfix, and those
features being merged into other branches in a reasonable way. Does
something like this look doable?

- Finn Arne
