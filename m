X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-fetching from a big repository is slow
Date: Thu, 14 Dec 2006 16:38:50 -0800
Message-ID: <7vslfixaat.fsf@assigned-by-dhcp.cox.net>
References: <200612141340.43925.andyparkins@gmail.com>
	<200612141518.05770.andyparkins@gmail.com>
	<458171B7.1020702@xs4all.nl>
	<200612141620.17782.andyparkins@gmail.com>
	<Pine.LNX.4.63.0612141732410.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xha2osd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612150015330.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 00:39:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612150015330.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 15 Dec 2006 00:26:24 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34456>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv16F-0001Gp-KS for gcvg-git@gmane.org; Fri, 15 Dec
 2006 01:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751740AbWLOAiw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 19:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbWLOAiw
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 19:38:52 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:49889 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751740AbWLOAiv (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 19:38:51 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061215003850.RCYY97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Thu, 14
 Dec 2006 19:38:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id yof21V0081kojtg0000000; Thu, 14 Dec 2006
 19:39:02 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If I read builtin-show-ref.c correctly, it _always_ calls 
> for_each_ref(show_ref, NULL);

Ok, that settles it.  If there is a reason to have --verify, we
should really special case it.  There is no point in looping,
because verify does not do the tail match (which could cause
ambiguity) and its answer should be either "yes it is there" or
"no there is no such ref".
