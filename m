X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [GIT PATCH] Makefile missing git-runstatus in PROGRAMS list
Date: Wed, 15 Nov 2006 11:04:39 -0800
Message-ID: <7vodr8mszc.fsf@assigned-by-dhcp.cox.net>
References: <FE74AC4E0A23124DA52B99F17F44159701A11D6D@PA-EXCH03.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 19:05:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <FE74AC4E0A23124DA52B99F17F44159701A11D6D@PA-EXCH03.vmware.com>
	(Bhavesh Davda's message of "Wed, 15 Nov 2006 10:42:27 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31469>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkQ4x-0005Zz-3f for gcvg-git@gmane.org; Wed, 15 Nov
 2006 20:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030893AbWKOTEw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 14:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030895AbWKOTEw
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 14:04:52 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:20722 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1030893AbWKOTEv
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 14:04:51 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115190450.TSGA7157.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 14:04:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id n74w1V00R1kojtg0000000; Wed, 15 Nov 2006
 14:04:56 -0500
To: "Bhavesh Davda" <bhavesh@vmware.com>
Sender: git-owner@vger.kernel.org

"Bhavesh Davda" <bhavesh@vmware.com> writes:

> Indeed! I had "export CDPATH=.:$HOME" in my $HOME/.bash_profile.
>
> "export -n CDPATH", and now "make install" works, setting up those hard links
> too.
>
> If this is a common gotcha in building and installing git, maybe you should
> add it near the top of the INSTALL instructions.
>
> I haven't run into this issue with other projects. Is there something that
> can be changed in git's Makefile so it works even if CDPATH is set and
> exported in people's environments?

I think we already had this discussed twice on this list.

The problem is not just Makefile, but any command implemented as
shell scripts, if it needs to "cd" inside, is bitten by exported
CDPATH not just because it gives unwanted output to stdout
(which is already stupid -- CDPATH is purely convenience for
interactive session) but also because it would take the process
to unexpected places.

You can solve it by three ways.  (1) unset CDPATH at the
beginning of every shell script; (2) write all internal "cd" in
such a way that CDPATH would not try to interfere with it; (3)
teach users to fix their broken environment.

We do (1) for our shell scripts with git-sh-setup which almost
all other script sources, along with a comment for (3) at that
place.  As you say we should probably add the same to INSTALL
instructions.
