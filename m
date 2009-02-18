From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] check_updates(): effective removal of cache entries
 marked CE_REMOVE
Date: Wed, 18 Feb 2009 14:44:34 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902181436390.21686@localhost.localdomain>
References: <1234995483-933-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Wed Feb 18 23:56:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZvL5-0007Gw-JQ
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 23:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbZBRWyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 17:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756027AbZBRWyw
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 17:54:52 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57899 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752266AbZBRWyu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Feb 2009 17:54:50 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1IMoCWd006710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Feb 2009 14:54:36 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1IMiYLc008057;
	Wed, 18 Feb 2009 14:44:35 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1234995483-933-1-git-send-email-barvik@broadpark.no>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.457 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110590>



On Wed, 18 Feb 2009, Kjetil Barvik wrote:
> 
> To fix this, and use an O(N) algorithm instead, where N is the number
> of cache_entries, we delete/remove all entries in one loop through all
> entries.

Ack. We've had things like this before. I'm somewhat surprised that it is 
noticeable even in the "o->update" case (since I would have expected the 
cost of actually doing an unlink() to swamp the memmove overhead), but the 
patch looks obviously correct. 

Looking at the numbers, I guess it's not _really_ noticeable - it's 1.8% 
of git user-space time, which in turn is about 75% of total time, so it's 
not a huge improvement, but I'll certainly ack it anyway as being the 
right thing to do. Every little bit helps. 

			Linus
