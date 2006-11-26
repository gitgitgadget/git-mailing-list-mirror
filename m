X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Possible BUG with git-rev-list --all in a StGit repository
Date: Sun, 26 Nov 2006 12:16:50 -0800
Message-ID: <7v7ixit13h.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550611260827t686a5071w7f050f17f784e5d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 20:17:04 +0000 (UTC)
Cc: catalin.marinas@gmail.com,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32366>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoQQq-0007t6-Ce for gcvg-git@gmane.org; Sun, 26 Nov
 2006 21:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757958AbWKZUQw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 15:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757959AbWKZUQw
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 15:16:52 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:30619 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1757958AbWKZUQv
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 15:16:51 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061126201651.UFCM9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Sun, 26
 Nov 2006 15:16:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id rYGz1V00M1kojtg0000000; Sun, 26 Nov 2006
 15:17:00 -0500
To: "Marco Costalba" <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

"Marco Costalba" <mcostalba@gmail.com> writes:

> In a StGit repository the --all option causes a lot of spurious
> revisions, possibly stgit related.
>
> $ git branch
> * master
>  origin
>  test
>
> $ git rev-list master origin test -- src/settingsimpl.cpp | wc
>     13      13     533
>
> $ git rev-list --all -- src/settingsimpl.cpp | wc
>     26      26    1066
>
>
> The extra revisions have shortlogs of the kind of:
>
> push        a3bc76fd0bdd154149c26a3c208f0344e9cd873b
> new e7baf56544cd8b4f8601a35fad274b8de97fd558
> refresh     8fa01a56a40b04ed9c6d006c669ca9d370176728
>
>>From qgit these are easily seen from file history tab of a file
> modified by stgit patches or when filtering in main view on the same
> file.
>
> Shouldn't 'git-rev-list --all'  print  *the same output* of when the
> list  with all branches is given in command line?

Should it?  The "--all" option is about "all refs", not "all
user branches" and it has been so from the beginning.  For one
thing it has to do the reachability thing also for tags
(otherwise it cannot be used as the upstream for git-repack
pipeline).

You are looking at .git/refs/bases/ refs that StGIT uses for its
internal bookkeeping.

