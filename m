X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Wed, 13 Dec 2006 22:29:14 -0800
Message-ID: <7vy7pb9eit.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<200612132237.10051.andyparkins@gmail.com>
	<7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612140113340.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0612132231050.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 06:29:27 +0000 (UTC)
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612132231050.18171@xanadu.home> (Nicolas Pitre's
	message of "Wed, 13 Dec 2006 22:32:52 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34282>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guk5p-0005xv-23 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 07:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752019AbWLNG3R (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 01:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbWLNG3R
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 01:29:17 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:44556 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752019AbWLNG3Q (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 01:29:16 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061214062914.VWHN25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Thu, 14
 Dec 2006 01:29:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id yWUb1V00N1kojtg0000000; Thu, 14 Dec 2006
 01:28:36 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> On Thu, 14 Dec 2006, Johannes Schindelin wrote:
>
>> I sent a patch which makes "git show" have that functionality, and 
>> frankly, I disagree "less" would be a good name for it. It uses the 
>> _pager_, which is not always "less", and besides, what it does is to show 
>> that particular blob. So obviously, I think my patch is the best approach.
>
> I think your approach is pretty sensible too.

I think so too for a few reasons.

 * cat-file is a very low level plumbing.  Giving it -p was a
   mistake made by somebody lazy long time ago back when we were
   not all that hot about "user friendliness in Porcelain-ish"
   (the option -p was not originally even meant to be the user
   level; it was merely a helper feature for verify-tag).

 * If we were to call something 'cat' and make a user-level
   command, adding the feature to 'show' is a lot more sensible
   than cat-file; the former takes more than one args already.
   People expect 'cat' to concatenate the arguments.  cat-file
   doesn't.

 * Throwing ls-tree output is the most sensible thing to do at
   'cat-file -p <tree-ish>' level, but not at the UI level (Andy
   compared ls-tree with 'svn list' today).  With 'git show', it
   would be more natural to show ls-tree --name-only by default
   for tree-ish objects, and control the verbosity level with
   command line option.

One minor issue we may need to decide is what to do when show is
given a tag object.  Personally I think the current behaviour of
dereferencing it to commit is fine (people who want to see the
tag can always do 'git-verify-tag -v').



