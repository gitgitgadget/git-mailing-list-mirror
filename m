X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: linux@horizon.com
Subject: Re: Question on multi-level git repository heiarchy.
Date: 27 Oct 2006 15:26:37 -0400
Message-ID: <20061027192637.8885.qmail@science.horizon.com>
NNTP-Posting-Date: Fri, 27 Oct 2006 19:48:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30342>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdXLx-000428-U9 for gcvg-git@gmane.org; Fri, 27 Oct
 2006 21:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750916AbWJ0T0n (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 15:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbWJ0T0n
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 15:26:43 -0400
Received: from science.horizon.com ([192.35.100.1]:43064 "HELO
 science.horizon.com") by vger.kernel.org with SMTP id S1750916AbWJ0T0m (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 15:26:42 -0400
Received: (qmail 8886 invoked by uid 1000); 27 Oct 2006 15:26:37 -0400
To: greearb@candelatech.com
Sender: git-owner@vger.kernel.org

The thing to learn is that the operation you are trying to perform
is called "fetch", not "pull".  Pull = fetch + merge.

In fact, the "fetch" part of "git pull" is optional, so it's
best to think of "git pull" as the fundamental *merge* operation.
("git merge" is a helper that you probably don't want to use directly.)

There's a valid argument that this is not good terminology (especially
because "push" is the opposite of "fetch"!), but without getting
into that discussion, there are two ways to do a merge:

- The small-steps way.
  git fetch remote
  git pull . remoteorigin

- The bold, all-at-once way
  git pull remote remoteorigin

The former acutally gives a local name to the remote branch,
then merges it in in a second step.

The latter is what folks like Linus do who aren't carefully following
remote development, but just want to merge it in.  It's better for
one-off access to remote development, because it doesn't clutter your
reporistory with a remote branch name that you're not going to use again.

Generally, I always do the former, and I recommend you do too, until
you're comfortable with making such big leaps.

Just remember:
1) "git fetch" copies from the remote repository to the local one.
   This doesn't change anything locally except for branch heads that
   it's supposed to.  And even there, it's careful.
   In particular, "git fetch" will refuse to modify the current HEAD.

2) "git pull" actually does a merge.  This *does* change the current
   HEAD.  It creates a new commit on the HEAD branch unless:
   - HEAD is already up to date, or
   - HEAD can be fast-forwarded, or
   - The merge fails.

