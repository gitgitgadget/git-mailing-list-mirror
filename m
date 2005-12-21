From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to set up a shared repository
Date: Wed, 21 Dec 2005 12:56:58 -0800
Message-ID: <7vy82e5ftx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512211919040.16640@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 21:57:24 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpB1P-0000Hl-UI
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 21:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVLUU5N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 15:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVLUU5N
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 15:57:13 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:56803 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751194AbVLUU5M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 15:57:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221205600.ZSOQ20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 15:56:00 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512211919040.16640@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 21 Dec 2005 19:27:19 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13897>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> A. Setting up the umask
>
> 1. Separate repository box
>
> If you are lucky enough that you can afford a separate machine for the 
> shared repository: Good. Just make sure that the umask is set group 
> friendly, either by ensuring that (assuming the login shell is bash) 
> $HOME/.bash_profile contains the line
>
> 	umask 0002

I suspect a bash started from ssh noninteractive session does
not read .bash_profile --- you may want to check.

> 2. Some server accessible by ssh
>
> 	git-repo-config core.umask 0002

Not yet ;-)

> B. Making sure the index is not corrupted by a push
>
> 1. No checkout!
>
> You can use the shared repository just like you use CVS: no working 
> directory. To disallow a checkout, just do
>
> 	touch .git/index
> 	chmod a-rwx .git/index
>
> Every attempt to modify the index (which is invalid), will now result in 
> an error.

Arrrgh....what a hack.  But it is a good hack.

> 2. Ensure index and working directory consistency (no locking)
>
> If you want to be able to work on the project in the shared repository, 

I am very tempted to end this sentence with "please don't" ;-).

> create hooks, as follows:

Your update hook looks sane if too strict.  I do not think of
any reason to push and fast forward a branch that is not pointed
at by .git/HEAD.  Not that I encourage pushing into a non-naked
repository where an uncontrolled random development happens,
though.

> Note that I did not check if a push locks another push.

Although it does protect against stomping on each other by
read/do-work/re-read-and-swap cycle, push does not lock. If you
want to run a build from the post-update hook you need to
serialize the build yourself.
