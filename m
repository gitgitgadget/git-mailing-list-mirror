From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Mon, 4 Feb 2008 12:06:16 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802041203510.3034@hp.linux-foundation.org>
References: <20080202122135.GA5783@code-monkey.de> <20080203030054.GA18654@coredump.intra.peff.net> <20080203043310.GA5984@coredump.intra.peff.net> <alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org> <7vr6fsk08w.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 21:09:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM7b9-0005G5-9P
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 21:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547AbYBDUGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 15:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756536AbYBDUGs
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 15:06:48 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42280 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756502AbYBDUGr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2008 15:06:47 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m14K6H3D024521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Feb 2008 12:06:21 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m14K6Gr3014890;
	Mon, 4 Feb 2008 12:06:16 -0800
In-Reply-To: <alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.215 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72554>



On Mon, 4 Feb 2008, Linus Torvalds wrote:
> 
> Not really tested at all, not really thought through. And that recursion 
> avoidance could be smarter.

.. and by "could be smarter", I obviously mean "really *really* should be 
smarter". Because this is O(2**n) in the number of merges, which is not 
acceptable even if the constant is really small.

So I really don't mean that we should do it this way. The right thing to 
do would be to add a new object flag for that "connected to UNINTERESTING" 
property, and setting it as we traverse the graph in that 
"commit_is_connected()" logic. That should get rid of the exponential 
behaviour.

			Linus
