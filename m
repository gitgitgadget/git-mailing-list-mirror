From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] bug in unpack_trees
Date: Wed, 5 Mar 2008 07:56:11 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0803050750400.12253@woody.linux-foundation.org>
References: <20080304115940.GA5260@sigill.intra.peff.net> <alpine.LFD.1.00.0803041325370.12253@woody.linux-foundation.org> <alpine.LNX.1.00.0803050130190.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	John Goerzen <jgoerzen@complete.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 16:59:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWw0N-0000JR-K1
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 16:58:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705AbYCEP53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 10:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754727AbYCEP53
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 10:57:29 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43643 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753566AbYCEP52 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 10:57:28 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m25FuVbS021003
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Mar 2008 07:56:32 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m25FuBUn007581;
	Wed, 5 Mar 2008 07:56:13 -0800
In-Reply-To: <alpine.LNX.1.00.0803050130190.19665@iabervon.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.032 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76235>



On Wed, 5 Mar 2008, Daniel Barkalow wrote:
> 
> The thing that's hopeless isn't including the index; it's including the 
> index that's simultaneously being regenerated.

Yeah. I was thinking about just putting the result in a new index. It's 
*usually* what the user wants anyway. The whole complexity with updating 
the old index is really nasty.

There are other complexities there, but the index one is the worst.

When doing a stupid try at using "traverse_trees()" (which in itself was 
not that easy - traverse_trees() is a fundamentally simpler walker and 
_different_ enough to not match well), one of the bigger issues is that 
traverse_trees() wants to do the directories in a separate phase from the 
files (becasue they sort differently), and that coupled with the fact that 
we do a kind of "read-modify-write" on the index makes it all really ugly.

I'm still working on it, but it's nastier than I was hoping for. Maybe you 
can come up with a better solution.

		Linus
