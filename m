X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Sometimes "Failed to find remote refs" means "try git-fetch --no-tags"
Date: Tue, 14 Nov 2006 20:05:07 -0800
Message-ID: <7vvelhs6bw.fsf@assigned-by-dhcp.cox.net>
References: <f2b55d220611141953t48d81ac5q4f48183ae79ba0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 04:05:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <f2b55d220611141953t48d81ac5q4f48183ae79ba0a@mail.gmail.com>
	(Michael K. Edwards's message of "Tue, 14 Nov 2006 19:53:34 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31408>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkC1V-0005XJ-IZ for gcvg-git@gmane.org; Wed, 15 Nov
 2006 05:05:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966696AbWKOEFM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 23:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966632AbWKOEFM
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 23:05:12 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:41161 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S966693AbWKOEFL
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 23:05:11 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115040508.LQMK5575.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 23:05:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ms5E1V00H1kojtg0000000; Tue, 14 Nov 2006
 23:05:14 -0500
To: "Michael K. Edwards" <medwards.linux@gmail.com>
Sender: git-owner@vger.kernel.org

"Michael K. Edwards" <medwards.linux@gmail.com> writes:

> Down inside git-ls-remote there is a die "Failed to find remote refs".
> This struck when I tried to fetch an http repository with a missing
> info/refs file.  Using "git fetch --no-tags" succeeds because it
> doesn't have to call git-ls-remote at all.  Does git-ls-remote have
> any way of knowing who is calling it so that it can print a
> context-appropriate error message?  If not, is it worth adding some
> sort of "caller context" mechanism, perhaps at the boundary between
> porcelain and plumbing?

I think letting git-ls-remote know who called it makes sense for
better error reporting.  I am all for it.

However "fetch --no-tags" from http upstream is a band-aid to
hide that the upstream repository has stale info/refs, and I do
not think we would want to encourage the band-aid.  Rather, the
message should say "yell loudly at the repository owner" ;-).

Seriously, when people starts using packed-refs that will be in
v1.4.4 scheduled for tomorrow on the public site, I think the
best way to adjust the commit walker clients is to have them
download info/refs and start traversing from the objects listed
there, instead of downloading .git/refs/heads/$branch and
.git/refs/tags/$tag files as we currently do, so the band-aid
would become less useful.

