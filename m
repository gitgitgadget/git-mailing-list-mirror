From: Junio C Hamano <junkio@cox.net>
Subject: Re: qgit idea: interface for cherry-picking
Date: Mon, 03 Jul 2006 13:03:44 -0700
Message-ID: <7vd5cmqwv3.fsf@assigned-by-dhcp.cox.net>
References: <e8954u$srh$1@sea.gmane.org>
	<e5bfff550607021433l1987c32apf4453b52fc2f3e63@mail.gmail.com>
	<e89eqj$npu$1@sea.gmane.org>
	<e5bfff550607021504l6e7fc8b8ja61f20f630c0f3f@mail.gmail.com>
	<e89iql$42a$1@sea.gmane.org>
	<e5bfff550607022245s2ef160fu5ad30a822f06117d@mail.gmail.com>
	<7vzmfrrxyp.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550607030418n6a46c0cdh1a95155e1feb4356@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 22:03:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxUe6-0008AW-1e
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 22:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWGCUDr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 16:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWGCUDr
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 16:03:47 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:50823 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750972AbWGCUDq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 16:03:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060703200345.QLOJ22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Jul 2006 16:03:45 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550607030418n6a46c0cdh1a95155e1feb4356@mail.gmail.com>
	(Marco Costalba's message of "Mon, 3 Jul 2006 13:18:46 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23197>

"Marco Costalba" <mcostalba@gmail.com> writes:

> I cannot test your patch now, so I'm just guessing, what if we have a
> series of patches?

The patch stops at each patch.  I am primarily interested in
keeping "git-am" usable from command line while making it easy
to use from other tools.

The expected use for the patch you are responding to is that
after the first application with --fail the user has an
opportunity to fix the result up but needs to create a commit by
rerunning "git-am" (or just drop that by resetting the index and
saying "git-am --skip").

> Is it possible that for two patches A and B happens that
>
> git-am A
> git-am B
> git-reset --soft HEAD^^
>
> gives a different result then
>
> git-am --fail A
> git-am --fail B

If you had a series of patches chosen inside your GUI and
squash-apply them all, two full am with soft reset to the
original state would be the easiest, if and only if both patch
applications do not fail.  If patch A does not apply for
whatever reason, you have to guide your user through the patch
adjustment process before applying B, regardless of the reason
why the patch application failed (either A did not apply
cleanly, or you gave --fail to the command).

The main question is what you would let your users do and how
you would guide them through the process, when the application
of an earlier patch in the series fails.  I think it is a
secondary implementation detail which of "git-am", "git-am
--fail" or "git-apply" to implement that process.
