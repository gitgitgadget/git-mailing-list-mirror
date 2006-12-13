X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] git-add --interactive (wip)
Date: Wed, 13 Dec 2006 04:15:58 +0100
Message-ID: <200612130415.59038.Josef.Weidendorfer@gmx.de>
References: <360959.72234.qm@web31809.mail.mud.yahoo.com> <200612111147.44964.Josef.Weidendorfer@gmx.de> <7vwt4wpytm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 03:23:06 +0000 (UTC)
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 22:22:45 EST
X-Authenticated: #352111
User-Agent: KMail/1.9.5
In-Reply-To: <7vwt4wpytm.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34181>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuKhz-0004aQ-3S for gcvg-git@gmane.org; Wed, 13 Dec
 2006 04:23:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932543AbWLMDWq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 22:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWLMDWq
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 22:22:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:36494 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932543AbWLMDWp
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 22:22:45 -0500
Received: (qmail invoked by alias); 13 Dec 2006 03:16:02 -0000
Received: from p5496A4D6.dip0.t-ipconnect.de (EHLO noname) [84.150.164.214]
 by mail.gmx.net (mp038) with SMTP; 13 Dec 2006 04:16:02 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Tuesday 12 December 2006 22:51, Junio C Hamano wrote:
> I've updated my "git add --interactive" in 'pu' and it now knows
> how to split a hunk into smaller pieces and recounting the diff
> offsets before applying

Nice.
Yes, this seems to be a missing piece in this hunk-wise staging.

> To make it easier, one possibility might be to add a subcommand
> to "git add --interactive" that lets you edit what is currently
> staged in the index by opening a temporary copy in your favorite
> editor, and stage the result of your edit in the index.

Yes. Sounds interesting.
Another would be to open the editor with the diff of this hunk.

> But I 
> feel quite uneasy to introduce ways to update the index with
> something _wildly_ different from what you ever had in your
> working tree as a whole.

Hmm... yes.
Is this not a general problem with staging, of course to
a lesser degree if you work at file granularity, because
the probability of dependence of changes in multiple files,
which could lead to a wrong commit, is less.

> I think it is wrong to commit partially, purely from the index,
> when you are building a series that has complex changes that
> come during the series but go away at the end.  The user should
> be able to verify all the steps in the middle in such a complex
> series, but it is not easy if you have it only in the index.

What you really want is to test the commit afterwards. If
you did it wrong, you always can do "git reset --mixed HEAD^"
or "git commit --amend".

However, testing a commit with a dirty working tree is not
possible. For this to work, you would want that
"git-checkout --store" can store away a dirty working state when
going to another revision, e.g. store it into a temporary ref
"<current branch>.dirtywork".
You would need a "git-checkout --restore" which would restore
the dirty state of the branch you are switching too.

Then, to check the commit of staged things, it should be enough
to do "git-checkout --store", check the commit, and do a
"git-checkout --restore" afterwards to get the dirty state back.

> You could do
> 
> 	$ git checkout-index --prefix=testarea/ -f -q -u -a
> 
> and run your tests there, but that takes a discipline, and is
> cumbersome to do.

IMHO that is too tricky for the average git user.

> So in short, I think per-hunk update-index is a cute hack and
> may be useful in a narrow simple cases, but it would not be so
> useful in the real life.

No. It currently is starting to get useful. With the ability
to temporarily store away a dirty state of the working directory,
it really could become very good.
 
> > Just as a sidenote: after deciding to not apply hunks, you
> > lose them in this WIP, as you will find nothing in "unstaged" mode
> > afterwards :-(
> 
> I do not understand this part.  You can 'revert' to match the
> index to HEAD and run 'patch' to pick what you want again.

Hmmm...
I lost my changes in the working directory; there was nothing to
pick again any more.
Perhaps I did something wrong.

