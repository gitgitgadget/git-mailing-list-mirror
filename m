X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] change the unpack limit threshold to a saner value
Date: Wed, 06 Dec 2006 14:24:39 -0800
Message-ID: <7vejrcy860.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612061420410.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 22:24:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612061420410.2630@xanadu.home> (Nicolas Pitre's
	message of "Wed, 06 Dec 2006 16:08:56 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33531>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs5C0-0002j5-Lm for gcvg-git@gmane.org; Wed, 06 Dec
 2006 23:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937739AbWLFWYl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 17:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937740AbWLFWYl
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 17:24:41 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:64019 "EHLO
 fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937739AbWLFWYk (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 17:24:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061206222440.WVLJ2628.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Wed, 6
 Dec 2006 17:24:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vaQq1V00N1kojtg0000000; Wed, 06 Dec 2006
 17:24:50 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> Let's assume the average object size is x. Given n objects, the needed 
> storage size is n*(x + b), where b is the average wasted block size on 
> disk.
> ...
> This is why I think the current default treshold should be 3 instead of 
> the insane value of 5000.  But since it feels a bit odd to go from 5000 
> to 3 I setled on 10.

I see you are optimizing for disk footprint, and this will
result in tons of tiny packs left between "repack -a".

I have not benched it yet, but the runtime pack handling code
was written assuming we have only a handful of big packs; I
suspect this change would affect the performance at runtime in
quite a bad way.

