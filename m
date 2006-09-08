From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add git-archive [take #2]
Date: Thu, 07 Sep 2006 17:37:21 -0700
Message-ID: <7v8xkvqjlq.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com>
	<7vfyf6ce29.fsf@assigned-by-dhcp.cox.net>
	<44FED12E.7010409@innova-card.com>
	<7vac5c7jty.fsf@assigned-by-dhcp.cox.net>
	<cda58cb80609062332p356bd26bw852e31211c43d1ac@mail.gmail.com>
	<7v1wqo400b.fsf@assigned-by-dhcp.cox.net>
	<44FFD00E.5040305@innova-card.com>
	<7vr6yo2isu.fsf@assigned-by-dhcp.cox.net>
	<450019C3.4030001@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 02:37:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLUN0-0003L4-8D
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 02:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbWIHAhH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 20:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbWIHAhH
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 20:37:07 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:9349 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751953AbWIHAhE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 20:37:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060908003703.NJFD21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 Sep 2006 20:37:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Kccu1V00x1kojtg0000000
	Thu, 07 Sep 2006 20:36:56 -0400
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <450019C3.4030001@innova-card.com> (Franck Bui-Huu's message of
	"Thu, 07 Sep 2006 15:08:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26668>

Franck Bui-Huu <vagabon.xyz@gmail.com> writes:

> I'm sending a new version of the patchset which allows 'git-archive'
> and 'git-upload-archive' command. I tried to take into account all
> feedbacks made by Junio and Rene, but there are still some open points.
>
>   1/ Allow 'git-upload-archive' command to enable/disable some
>      formats. This should be done by 'git-upload-archive'.

Perhaps.  I was thinking about the way how a site administrator
can configure such when upload-archive is spawned via git-daemon
(for users coming from ssh and spawn an upload-archive on their
own, it's their own process and upload-archive has no business
deciding what is allowed and what is forbidden).  Not very many
clean ways I can think of unfortunately.

>   2/ Can I remove 'git-upload-tar' command ?
>   3/ Should I kill 'git-zip-tree' command ?

We do not deprecate commands that easily.  Notice we have kept
git-resolve for a long time (we should remove it and by now it
should be safe)?

Especially tar-tree --remote and upload-archive talks different
protocols, so it is not like not removing it is making your life
more difficult.  Perhaps after next release (1.4.3 or 1.5?  I
dunno) in the new development cycle, we would start saying
"don't use tar-tree --remote, use archive --fmt=tar --remote",
and then the release after that (1.4.4 or 1.5.1?  Again I dunno)
we might remove it.  The same thing for zip-tree, although that
one has lived shorter so it might not be missed if we remove it
earlier.

In any case, don't make removal of them as part of the series
please.  Let's make sure this new toy works well first, and then
start talking about removing things that have become obsolete.

>   4/ Progress indicator support. Junio wants to mimic upload-pack for
>      that. But it will lead in a lot of duplicated code if we don't
>      try to share code. Can we copy that code anyways and clean up
>      later ?

Refactoring first is always preferred, since "later" tends to
come very late (or worse, never) for clean-up tasks than feature
enhancements.

>   5/ Should we use "struct tree_desc" based interface for tree parsing
>      ? According to Rene it doesn't worth it as soon as you actually
>      start to do something to the trees

That became a non-issue I agree.  Whichever is easier.
