X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] merge-recursive: add/add really is modify/modify with an empty base
Date: Wed, 13 Dec 2006 14:26:16 -0800
Message-ID: <7vhcvze8l3.fsf@assigned-by-dhcp.cox.net>
References: <20061207101707.GA19139@spearce.org>
	<Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vvekgog0r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612130402300.2807@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vvekgl2z2.fsf@assigned-by-dhcp.cox.net>
	<b0943d9e0612131401s6cde6d0du5e3c6d2e34bfbbb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 22:26:30 +0000 (UTC)
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <b0943d9e0612131401s6cde6d0du5e3c6d2e34bfbbb2@mail.gmail.com>
	(Catalin Marinas's message of "Wed, 13 Dec 2006 22:01:21 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34242>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GucYQ-0000fz-3I for gcvg-git@gmane.org; Wed, 13 Dec
 2006 23:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751632AbWLMW0T (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 17:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbWLMW0T
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 17:26:19 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:37222 "EHLO
 fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751626AbWLMW0S (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 17:26:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061213222617.CHJI18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Wed, 13
 Dec 2006 17:26:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id yNSU1V00h1kojtg0000000; Wed, 13 Dec 2006
 17:26:29 -0500
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> On 13/12/06, Junio C Hamano <junkio@cox.net> wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
> What is this new xdl_merge()? Is it a better replacement for diff3? In
> this situation diff3 would actually show two confict parts, each of
> them being the full file, with an empty ancestor.

The calls to xdl_merge() from merge-recursive replace
invocations to external "merge" from RCS suite.

An older merge-recursive had a bug (as you noticed and adjusted
StGIT with the commit 8d41555) in that it did not leave anything
in the working tree in add/add situation, while merge-resolve
would have left its best attempt of ancestor-less two file merge
(which is not necessarily the straight diff3 "no common section,
full copies from both" result).  The change in question corrects
that problem and merge-recursive would create a file in the
working tree just like merge-resolve would.

You were CC'ed just in case this change in behaviour might
interact with the abovementioned change in StGIT, but as you say
the change would not break StGIT, we would all be happy ;-).
