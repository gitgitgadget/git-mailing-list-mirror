X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] git-fetch: do not use "*" for fetching multiple refs
Date: Wed, 06 Dec 2006 10:37:45 -0800
Message-ID: <7vejrc50qu.fsf@assigned-by-dhcp.cox.net>
References: <1165261102.20055.9.camel@ibook.zvpunry.de>
	<el1tud$n07$2@sea.gmane.org>
	<1165422865.29714.13.camel@ibook.zvpunry.de>
	<el6sni$re3$1@sea.gmane.org>
	<1165429001.993.35.camel@ibook.zvpunry.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 18:38:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <1165429001.993.35.camel@ibook.zvpunry.de> (Michael Loeffler's
	message of "Wed, 06 Dec 2006 19:16:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33504>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs1eS-0001pk-1p for gcvg-git@gmane.org; Wed, 06 Dec
 2006 19:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937083AbWLFShs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 13:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937084AbWLFShs
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 13:37:48 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:41402 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937083AbWLFShr (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 13:37:47 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061206183746.LGYS9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Wed, 6
 Dec 2006 13:37:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vWdw1V00B1kojtg0000000; Wed, 06 Dec 2006
 13:37:56 -0500
To: Michael Loeffler <zvpunry@zvpunry.de>
Sender: git-owner@vger.kernel.org

Michael Loeffler <zvpunry@zvpunry.de> writes:

>> Just a thought.
> I would prefer the following ways to do this globfetch stuff:
>
> 1.) The original refspec:
>     Pull: refs/heads/master:refs/remotes/origin/master
>
> 2.) The one with "prefix match":
>     Pull: refs/heads/:refs/remotes/origin/
>
> 3.) The one with extended regex:
>     Pull: refs/heads/(.*):refs/remotes/origin/\1

Please, don't do regex when talking about paths.  Uniformly
using fnmatch/glob is less confusing.  I do not see anything
wrong with Andy's refspec glob we already have.  Although I
agree that the second asterisk in "src/*:dst/*" has a certain
"Huh?" factor to UNIX-trained eyes, I think it is quite obvious
even to new people what it does.

Also, while I agree that (2) is logical and less typing, I would
avoid cases where foo and foo/ behave differently when "foo"
itself is a directory/tree like thing.  Doing otherwise easily
invites mistakes.

