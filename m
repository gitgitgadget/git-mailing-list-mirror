From: Junio C Hamano <junkio@cox.net>
Subject: Re: git reset --hard not removing some files
Date: Sun, 04 Jun 2006 02:31:21 -0700
Message-ID: <7vfyilclna.fsf@assigned-by-dhcp.cox.net>
References: <20060601160052.GK14325@admingilde.org>
	<Pine.LNX.4.64.0606010918060.5498@g5.osdl.org>
	<7vhd33d2q2.fsf@assigned-by-dhcp.cox.net>
	<20060604091601.GN14325@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 11:31:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmoxC-0001OL-BL
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 11:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWFDJbX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 05:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWFDJbX
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 05:31:23 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:58832 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751153AbWFDJbX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 05:31:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060604093122.OLEN19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Jun 2006 05:31:22 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060604091601.GN14325@admingilde.org> (Martin Waitz's message
	of "Sun, 4 Jun 2006 11:16:02 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21255>

Martin Waitz <tali@admingilde.org> writes:

> hoi :)
>
> On Fri, Jun 02, 2006 at 07:57:57AM -0700, Junio C Hamano wrote:
>> I would agree in the reproduction recipe Martin gave there is no
>> problem but feature, but at the same time I suspect the recent
>> "reset --hard simplification" has introduced a true regression.
>
> This may have been the bug that bit me.
> Thanks for finding it although I was not able to reproduce it myself!

I found this somewhat the hard way myself.  I have:

        [pull]
                twohead = resolve

in my .git/config -- IOW, I usually do not use recursive
strategy myself.  When a merge with resolve strategy fails (and
with recent trend to busyboxify git commands, many merges
between my topics and "next" and/or "master" do), I relied on
"reset --hard" followed by the same merge of the topic using
"pull -s recursive" to recover things, but it didn't.  When
pulling a branch with builtin-*.c names into another branch with
older names, regressed "reset --hard" left builtin-*.c files
behind, and then the next merge attempt complained by saying my
untracked working tree files would be overwritten X-<.
