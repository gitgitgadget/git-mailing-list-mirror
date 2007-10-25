From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH 6/7] walk PATH to generate list of commands for "help
	-a"
Date: Wed, 24 Oct 2007 22:07:36 -0700
Message-ID: <20071025050736.GG759@srparish.net>
References: <1193283437-1706-1-git-send-email-srp@srparish.net> <1193283437-1706-2-git-send-email-srp@srparish.net> <1193283437-1706-3-git-send-email-srp@srparish.net> <1193283437-1706-4-git-send-email-srp@srparish.net> <1193283437-1706-5-git-send-email-srp@srparish.net> <1193283437-1706-6-git-send-email-srp@srparish.net> <7vve8v24al.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 07:07:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikuwi-0005en-Ks
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 07:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbXJYFHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 01:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbXJYFHi
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 01:07:38 -0400
Received: from smtp-gw5.mailanyone.net ([208.70.128.56]:43326 "EHLO
	smtp-gw5.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbXJYFHh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 01:07:37 -0400
Received: from mailanyone.net
	by smtp-gw5.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP quinn@srparish.net)
	id 1IkuwR-0001Ep-EU; Thu, 25 Oct 2007 00:07:36 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Wed, 24 Oct 2007 22:07:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vve8v24al.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62274>

On Wed, Oct 24, 2007 at 09:42:42PM -0700, Junio C Hamano wrote:

> Scott R Parish <srp@srparish.net> writes:
> 
> > Signed-off-by: Scott R Parish <srp@srparish.net>
> 
> Rationale?

Well, the ultimate reason that i've been working on all of this is
i'd like to push git as a viable development tool where i work. To
give an effective idea, lets say that shared tools get placed on
nfs servers, which can be mounted to different paths depending on
which nfs server is up or down or which system is the nfs client.

I have no control over each users PATH nor things like MANPATH or
GIT_EXEC_PATH and have no way of compiling in a path ahead of time,
but i would like to provide the easiest user experiance possible,
meaning that whether they have git in their PATH, or whether they
are using an absolute or relative path to it, it just works, hopefully
including "git help" and "git help -a".

Should i be putting all that in my commit messages?

> There are two cases execv_git_cmd() runs "git-that" from a non
> standard place, if we take your [PATCH 4/7].
> 
>  - If there is a directory that contains a location that used to
>    hold an old installation of git-* commands (some of which may
>    have been removed in the latest git) and if the user has that
>    directory on PATH, we would run obsolete git subcommand from
>    there.

I could see that as being problematic. I suppose there are ways
around that (have "git" pass to "git-cmd" an argument of what version
it is) but none that i really like.

>  - If the user has a custom command "git-that" in $HOME/bin/
>    that is outside GIT_EXEC_PATH, the new subcommand "that" can
>    be used as if it is part of the official git.  This is an
>    improvement [PATCH 4/7] would bring in.  We allow this
>    already for scripts anyway, and the patch is merely making
>    the behaviour of the execv_git_cmd() consistent with it.
> 
> It may be nicer if the user can somehow tell from the output if
> each of the command is from the standard set (i.e. on
> GIT_EXEC_PATH or built-in), or from a non standard place (either
> custom command as intended, or an unintended obsolete leftover).

What if git marked commands that weren't found in the location where
it thinks that it is running from?

sRp

-- 
Scott Parish
http://srparish.net/
