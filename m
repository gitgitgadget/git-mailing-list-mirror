X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitk feature request..
Date: Tue, 07 Nov 2006 14:34:59 -0800
Message-ID: <7vslgu28do.fsf@assigned-by-dhcp.cox.net>
References: <452A37FB.60507@adelaide.edu.au>
	<17745.1213.22769.420355@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 7 Nov 2006 22:35:26 +0000 (UTC)
Cc: git@vger.kernel.org,
	Pierre Marc Dumuid <pierre.dumuid@adelaide.edu.au>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <17745.1213.22769.420355@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Wed, 8 Nov 2006 09:12:13 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31096>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhZXB-0003si-3d for gcvg-git@gmane.org; Tue, 07 Nov
 2006 23:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753338AbWKGWfE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 17:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753781AbWKGWfE
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 17:35:04 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:42691 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1753338AbWKGWfB
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 17:35:01 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061107223500.SNHF18180.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Tue, 7
 Nov 2006 17:35:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id jyad1V0021kojtg0000000; Tue, 07 Nov 2006
 17:34:37 -0500
To: Paul Mackerras <paulus@samba.org>
Sender: git-owner@vger.kernel.org

Paul Mackerras <paulus@samba.org> writes:

> Good idea.  Junio, is there a canonical place under .git where gitk
> should put such things?

Well, we do not design things in advance but tend to let things
evolve, which probably is a bad habit but I am not sure how else
we can avoid overdesigning before knowing the needs.

The existing state-keeping programs seem to keep their stuff
immediately under $GIT_DIR.  Examples are:

	.git/description (gitweb)
        .git/cvs-authors (cvsimport)
        .git/gitcvs.<branch>.sqlite (cvsserver)

So, .git/gitk-<foo> (or .git/gitk/<bar>) would be in line with
others.  We _might_ want to have a standard plan to keep
Porcelains stepping on each other's toes, and probably migrating
everybody to .git/aux/{common,gitcvs,gitk,...}/<foo> would be a
sane thing to do.  description and cvs-authors could probably be
shared across Porcelains, so I do not think we mind leaving them
in the current place or throw them in .git/aux/common/

Having said that, is the gitk view supposed to be shared across
users of a single repository?

If you imagine yourself logging into kernel.org (perhaps X
forwarded over ssh to your local machine) and browsing
/pub/scm/git/git.git/, the repository itself would not be
writable by you.  Even if it were, I do not think you would want
me to reuse the view you used from there next time I did the
same on the same repository.

It might make sense to give --state=dir/ parameter to gitk and
tell it to use that directory to keep persistent data.  Also I
seem to recall you already have one file under $HOME/ to make
window geometry or something persistent.



