From: Junio C Hamano <junkio@cox.net>
Subject: Re: problems GIT_TRACE
Date: Mon, 10 Jul 2006 05:22:39 -0700
Message-ID: <7vwtalbqeo.fsf@assigned-by-dhcp.cox.net>
References: <E1Fzta3-00066Z-8B@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 14:22:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzumi-0000Xc-HG
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 14:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWGJMWl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 08:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWGJMWl
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 08:22:41 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:40320 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030318AbWGJMWk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 08:22:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060710122240.KCR22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Jul 2006 08:22:40 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1Fzta3-00066Z-8B@moooo.ath.cx> (Matthias Lederhofer's message
	of "Mon, 10 Jul 2006 13:05:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23614>

Matthias Lederhofer <matled@gmx.net> writes:

> I just discovered a problem with GIT_TRACE.  Some scripts redirect
> stderr to stdout and the trace messages go with it.  For example from
> git-repack:
>> name=$(git-rev-list --objects --all $rev_list 2>&1 |
>>         git-pack-objects --non-empty $pack_objects .tmp-pack) ||
>>         exit 1
> Then for example git-pack-objects complains:
>> fatal: expected sha1, got garbage:
>>  trace: built-in: git 'rev-list' '--objects' '--all'
> git-grep '2>&' shows a few other places that do this too, I'll take a
> closer look at this later.  Is there any reason to redirect stderr to
> stdout?  I think this will always fail with such a strange error
> message when something is written to stderr.

This particular one is trying to catch an error condition from
rev-list.  Shell reports the exit status from the last command
in the pipeline, and when rev-list notices a corrupt repository,
it wants to tell pack-objects to stop producing incorrect pack,
but there is no way other than sending a garbage string (as an
error message) to cause pack-object to notice there is garbage
coming in.
