X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-clone --use-separate-remote the default
Date: Thu, 23 Nov 2006 16:17:24 -0800
Message-ID: <7vlkm1hf57.fsf@assigned-by-dhcp.cox.net>
References: <20061123225835.30071.99265.stgit@machine.or.cz>
	<7vejrtiwqd.fsf@assigned-by-dhcp.cox.net>
	<20061123234203.GN7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 00:17:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061123234203.GN7201@pasky.or.cz> (Petr Baudis's message of
	"Fri, 24 Nov 2006 00:42:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32181>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnOl2-0002Ld-N9 for gcvg-git@gmane.org; Fri, 24 Nov
 2006 01:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757523AbWKXAR1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 19:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757524AbWKXAR0
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 19:17:26 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:4798 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1757523AbWKXAR0
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 19:17:26 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061124001725.FKMM296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Thu, 23
 Nov 2006 19:17:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qQHZ1V0071kojtg0000000; Thu, 23 Nov 2006
 19:17:33 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

>> Even though I fully agree that use-separate-remotes should be
>> the default, to the point that I think we do not even
>> need a backward compatibility option.  People who want to use
>> traditional layout for simple one-remote-branch-only project
>> would not suffer anyway because 'origin' still means origin in
>> the new layout (refs/remotes/origin/HEAD).
>
> I don't know, we still at least need to keep the functionality for
> --bare.

I agree --bare should continue to be a "snapshot mirror"; I am
not advocating for the removal of the internal implementation
detail such as $use_separate_remote variable.

However, I think having one sane behaviour is the right thing to
do for a clone that prepares a repository with a working tree
(including the one made with -n option, which only means "do not
do the check-out immediately after cloning" for such a
repository).

The traditional layout is slightly simpler for a project with
the simplest needs (that is, a single upstream repository that
has a single 'master' branch), but I do think even that is not
an advantage anymore.

With the separate-remote layout, git-fetch would still fetch and
update the "origin" (although that is now remotes/origin/master
which is pointed at by remotes/origin/HEAD) and the user can
still refer to it with "origin".  Commands "git-pull origin",
"git-pull . origin", and "git-merge origin" all will continue to
work the same way as before for such a project as in the
traditional layout, and that is why I think we do not need
backward compatibility flag in this case.
