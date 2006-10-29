X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 03:47:43 -0800
Message-ID: <7viri34a3k.fsf@assigned-by-dhcp.cox.net>
References: <200610291122.30852.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 11:47:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610291122.30852.jnareb@gmail.com> (Jakub Narebski's message
	of "Sun, 29 Oct 2006 11:22:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30427>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge98m-0005CV-MJ for gcvg-git@gmane.org; Sun, 29 Oct
 2006 12:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932293AbWJ2Lrq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 06:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWJ2Lrp
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 06:47:45 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:6329 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S932293AbWJ2Lro
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 06:47:44 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061029114743.QVVX13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Sun, 29
 Oct 2006 06:47:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gBnQ1V00H1kojtg0000000 Sun, 29 Oct 2006
 06:47:25 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Changes:
> * "gitweb diff header" which looked for example like below:
>     file:_<sha1 before>_ -> file:_<sha1 after>_
>   where 'file' is file type and '<sha1>' is full sha1 of blob, is link
>   and uses default link style is changed to
>     diff --git a/<file before> b/<file after>
>   where <file> is hidden link (i.e. underline on hover, only)
>   to appropriate version of file. If file is added, a/<file> is not
>   hyperlinked, if file is deleted, b/<file> is not hyperlinked.

I do not have time to look at the code right now, but here are 
quick comments on the output.

I personally do not mind "hidden" but it might be more obvious
to make them normal links -- the filenames in the header are not
part of long text people need to "read".  On the other hand,
it feels a bit wasteful to have these hidden links both on "diff
--git" line *and* ---/+++ lines (these three are very close to
each other).

> * there is added "extended diff header", with <path> and <hash>
>   hyperlinked (and <hash> shortened to 7 characters), and <mode>
>   explained: '<mode>' is extnded to '<mode>/<symbolic mode> (<file type>)'.

It somehow feels that deviating from what "git diff" gives makes
it very distracting; I would feel better if "/-rw-r--r-- (file)"
were not there.

Also I think arguing over 7 or 8 hexdigits is pointless; if you
are reading this from "git diff", it is probably the easiest to
match what "git diff" gave you.  One thing we _might_ want to do
in the future is to change "git diff" to use DEFAULT_ABBREV
hexdigits at the minimum but more if needed to disambiguate; I
think it currently does not do the "more if needed" part.

> * <file> hyperlinking should work also when <file> is originally
>   quoted. For now we present filename quoted. This needed changes to
>   parse_difftree_raw_line subroutine.

This feels Ok.

> * from-file/to-file two-line header lines have slightly darker color
>   than removed/added lines.

This visually feels right.

> * chunk header has now delicate line above for easier finding chunk
>   boundary, and top margin of 1px.

This visually feels right.
