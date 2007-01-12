From: Junio C Hamano <junkio@cox.net>
Subject: Re: 1.5.0.rc1.g4494: Can't use a bare GIT_DIR to add
Date: Fri, 12 Jan 2007 13:33:33 -0800
Message-ID: <7vps9kq6aa.fsf@assigned-by-dhcp.cox.net>
References: <junkio@cox.net>
	<200701122015.l0CKFB8j022355@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 22:33:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5U1q-0005oz-9P
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 22:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbXALVdf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 16:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbXALVdf
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 16:33:35 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:59163 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161006AbXALVdf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 16:33:35 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112213334.BNRS97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 16:33:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AMYi1W00X1kojtg0000000; Fri, 12 Jan 2007 16:32:43 -0500
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
In-Reply-To: <200701122015.l0CKFB8j022355@laptop13.inf.utfsm.cl> (Horst H. von
	Brand's message of "Fri, 12 Jan 2007 17:15:11 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36714>

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:

> Junio C Hamano <junkio@cox.net> wrote:
> ...
>> This _is_ a regression, as we are checking something we did not
>> check before and refusing to work in cases where we did.  But I
>> am not sure if reverting to lift the safety (for that matter,
>> introducing the third "depends" alternative) is better than the
>> latest behaviour.
>
> It grates me somewhat that there isn't a clean way of saying "My .git stuff
> is over there". No big deal, really.
>
> And it is not a "depends", AFAICS: GIT_DIR says where to stash stuff, users
> had better know what they are doing in that case... so perhaps allow
> anything if GIT_DIR is set?

One problem I have with that is that doing so would make it
harder to prevent pushing into the current branch of a
repository with working tree from happening later.

In the "sequence of tarballs" example, I wonder why you cannot
do something like:

	git init-db
	for tarball
        do
        	tar xf $tarball
                # if it extracts in a wrong directory, move them
                # up first ...
                git add .
                git commit -a
		git rm -r .
	done
