X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-explain
Date: Mon, 04 Dec 2006 22:09:17 -0800
Message-ID: <7v1wnekh6a.fsf@assigned-by-dhcp.cox.net>
References: <200612031701.15594.alan@chandlerfamily.org.uk>
	<Pine.LNX.4.64.0612031024480.3476@woody.osdl.org>
	<7v1wngwws6.fsf@assigned-by-dhcp.cox.net>
	<7vwt57j94c.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612042253250.2630@xanadu.home>
	<20061205035721.GA26735@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 06:09:26 +0000 (UTC)
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061205035721.GA26735@fieldses.org> (J. Bruce Fields's message
	of "Mon, 4 Dec 2006 22:57:21 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33306>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrTUY-0005zN-3x for gcvg-git@gmane.org; Tue, 05 Dec
 2006 07:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967151AbWLEGJT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 01:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967865AbWLEGJT
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 01:09:19 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:47649 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S967151AbWLEGJS (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 01:09:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205060917.DCVT9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Tue, 5
 Dec 2006 01:09:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id uu9T1V00Y1kojtg0000000; Tue, 05 Dec 2006
 01:09:28 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>, Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Mon, Dec 04, 2006 at 10:55:49PM -0500, Nicolas Pitre wrote:
>> ...
>> > [PATCH] git-explain
>> > ...
>> 
>> What about calling it git-whatsup instead?
>
> No, clearly it should be git-wtf.

Should I take these responses to mean that you two are negative
about the approach of spending extra cycles to commands that can
leave the working tree in a "in the middle of doing something"
state to help having a unified command to explain what the
situation is and suggest the user possible exits, or are you
saying that it might be a good idea but "git explain" is a bad
name?

An issue with this approach is that this can be the beginning of
hardwiring the official "right way of doing things" in the set
of tools.  Pursuing this approach would enhance the set of state
markers like "FAILED_MERGE" in the example, which means:

 - more commands would actively record what they were attempting
   to do, obviously;

 - over time "git explain" will learn about these state markers,
   and we would hardwire the "best current practice" exits from
   various states in the help messages;

 - also commands other than "git explain" would learn about the
   state markers of other commands, and change their behaviour.
   For example, "git am" might learn to refuse running while a
   merge in progress much earlier than with the current
   implementation.

The last point can easily become a double-edged sword.

Hardwiring the recommended workflow in the tools would reduce
chances of mistakes, but it could rob the flexibility from them
if we are not careful and forget to take into account some
useful combination of tools when adding such safety valves.
