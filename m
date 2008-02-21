From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] CE_REMOVE conversion
Date: Thu, 21 Feb 2008 08:05:42 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802210746410.7833@woody.linux-foundation.org>
References: <7v7igywvnj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 17:12:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSE2G-0004vQ-Gv
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 17:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755482AbYBUQMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 11:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758893AbYBUQMA
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 11:12:00 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40811 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755482AbYBUQL7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Feb 2008 11:11:59 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1LG5hSV011014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Feb 2008 08:05:44 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1LG5gAt029540;
	Thu, 21 Feb 2008 08:05:42 -0800
In-Reply-To: <7v7igywvnj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.238 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74625>



On Thu, 21 Feb 2008, Junio C Hamano wrote:
> 
> but I am wondering if we should instead really _remove_ entries
> from the index instead, just like the attached patch.

Absolutely. I think that your patch is "ObviouslyCorrect(tm)", and that 
code should never have used CE_REMOVE in the first place. The fact that 
the old code worked was perhaps intentional, but still very subtle and 
lucky.

The whole (and only) point of CE_REMOVE was and is to do the "-u" handling 
when resolving a merge, and keep the thing in the index in order to later 
still do work with it (ie remove it) when we have verified that the index 
is complete. But that's not what "read_cache_unmerged()" is about: it's 
very explicitly documented to just ignore the unmerged entries.

So your patch looks very good to me. Basically, the merge code absolutely 
does not want to be called with some entries already marked as CE_REMOVE 
(it's supposed to *add* those markers as part of resolving the merge, but 
it is not able to handle them in the source).

So ack, ack, ack.


			Linus
