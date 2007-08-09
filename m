From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 09 Aug 2007 15:02:36 -0700
Message-ID: <7vtzr8wemb.fsf@assigned-by-dhcp.cox.net>
References: <20070809163026.GD568@mbox.bz>
	<alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
	<7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net>
	<7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
	<20070809165218.9b76ebf7.seanlkml@sympatico.ca>
	<alpine.LFD.0.999.0708091426050.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091444550.25146@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, moe <moe-git@mbox.bz>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 00:02:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJG5b-0003sj-BD
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 00:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbXHIWCj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 18:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753218AbXHIWCj
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 18:02:39 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:62051 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940AbXHIWCi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 18:02:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070809220237.PSUJ2095.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 9 Aug 2007 18:02:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Zy2c1X00A1kojtg0000000; Thu, 09 Aug 2007 18:02:36 -0400
In-Reply-To: <alpine.LFD.0.999.0708091444550.25146@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 9 Aug 2007 14:46:41 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55480>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 9 Aug 2007, Linus Torvalds wrote:
>> 
>> So "builtin-read-tree.c" (or rather unpack-trees.c) would need the same 
>> kind of logic.
>
> The path seems to be:
>
>   cmd_read_tree ->
>     unpack_trees ->
>       unpack_trees_rec ->
>         [ recursive .. unpack_trees_rec ] ->
> 	  oneway_merge ->
> 	    keep_entry ->
> 	      add_index_entry()
>
> and here again we end up having the same insertion sort issue.

Quite honestly, I was this (shows the "thumb and index finger
almost touching" gesture) close to declare that unpack-trees is
unsalvageable, and was planning to redo the one-tree (and
perhaps two-tree) read-tree without using that mess after 1.5.3.
