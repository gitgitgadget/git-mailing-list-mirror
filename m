From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH, take 2] Add example xinetd(8) configuration to Documentation/everyday.txt
Date: Sun, 04 Jun 2006 18:24:29 -0700
Message-ID: <7vbqt875te.fsf@assigned-by-dhcp.cox.net>
References: <ldv@altlinux.org>
	<200606050054.k550sFCC018490@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 03:24:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn3pc-0000ys-4w
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 03:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWFEBYb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 21:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWFEBYb
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 21:24:31 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:31714 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932368AbWFEBYb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 21:24:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060605012430.PJKP5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Jun 2006 21:24:30 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200606050054.k550sFCC018490@laptop11.inf.utfsm.cl> (Horst von
	Brand's message of "Sun, 04 Jun 2006 20:54:15 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21302>

I do not know if the above address again bounces for me, but you
will see that on the list I presume...

> [Really dumb question: How do you separate comments, like this, from the
>  commit itself? Here done with dashes.]

There are two ways often used on this list.

(1) Traditional, "really automatable and nicer to the
    maintainer" style.

	From xxx
        Subject: [PATCH] Add example xinetd(8) config...

        Commit log comes here, without the cover letter
        material.

        Signed-off-by: A U Thor <author@example.com>
	---
	 * Cover letter material comes here, before the usual
           diffstat and patch

         Documentation/everyday.txt |   23 +++++++++++++++++++++++
         1 files changed, 23 insertions(+), 0 deletions(-)

        diff --git a/Documentation/everyday.txt b/Documenta...
	index 2ad2d61..ffba543 100644

    Two points to observe:

     - Subject: should be changed to match the first line of the
       commit log message you would want to see, as needed.

     - cover letter material comes after the "---\n" line.

    When the cover letter material is short, this is often
    preferred, since I can just run "git am" on the whole thing
    and everything after the first "^---", including your cover
    letter material, is omitted from the log message.  It is,
    however, like top-posting and becomes harder to follow if
    the cover letter material gets long, in which case I
    personally prefer style (2) (but do not send style (2) to
    Linus).

(2) e-mail style, but NEVER use "---" (or longer) marker between
    cover letter and the commit log.

	From xxx
        Subject: Re: some earlier discussion topic

	Longer discussion, rambling, quotes, and cover letter
	material.

	-- >8 -- cut here -- >8 --
        [PATCH] Add example xinetd(8) config...

        Commit log comes here.

        Signed-off-by: A U Thor <author@example.com>
	---
         Documentation/everyday.txt |   23 +++++++++++++++++++++++
         1 files changed, 23 insertions(+), 0 deletions(-)

        diff --git a/Documentation/everyday.txt b/Documenta...
	index 2ad2d61..ffba543 100644

    When the cover letter material is long, this is easier to
    read, because it avoids the problems associated with
    top-posting.  However, when I apply this with "git am", I
    would need to go interactive and remove everything before
    the scissors line by hand.

Usual patch application toolchain (either git-applymbox or
git-am) first splits your message at the first "^---" or "^diff
-", and uses the part before that line to form the commit log
message (together with what you have on the "Subject:" line).
The rest is fed to git-apply.  What this means is that you do
not have to use the scissors logo (the tool does not know about
it), but it is _absolutely_ necessary not to use anything that
would usually signal the tool of the commit log message in place
of the scissors.  If you have the cover letter first and then
"---" or "-----" followed by the commit message after that, the
commit log message will be taken from the "discussion, rambling,
quotes, and cover letter material" part and the real commit log
you wanted to have will not be seen at all, which needs to be
hand fixed.
