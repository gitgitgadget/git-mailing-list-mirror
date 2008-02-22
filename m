From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] hash: fix lookup_hash semantics
Date: Fri, 22 Feb 2008 12:42:09 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802221233410.21332@woody.linux-foundation.org>
References: <20080222194726.GA24532@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Dane Jensen <careo@fastmail.fm>,
	Pieter de Bie <pdebie@ai.rug.nl>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 21:51:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSero-0002Ph-KS
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 21:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbYBVUvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 15:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754388AbYBVUvA
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 15:51:00 -0500
Received: from smtp1.linux-foundation.org ([207.189.120.13]:48137 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750985AbYBVUu7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2008 15:50:59 -0500
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Feb 2008 15:50:59 EST
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1MKgC2r019974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Feb 2008 12:42:13 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1MKg9NX028008;
	Fri, 22 Feb 2008 12:42:10 -0800
In-Reply-To: <20080222194726.GA24532@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-5.053 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74757>



On Fri, 22 Feb 2008, Jeff King wrote:
>
> We were returning the _address of_ the stored item (or NULL)
> instead of the item itself. While this sort of indirection
> is useful for insertion (since you can lookup and then
> modify), it is unnecessary for read-only lookup.

Gaah. That code returned the pointer-to-a-pointer exactly because of the 
insert case, but then to clean it up I had split it up into that internal 
"lookup_hash_entry()" case, but left the broken semantics for 
lookup_hash().

Stupid.

Your patch is obviously correct, and should probably go into maint just so 
that no other code makes the mistake of using that broken interface.

		Linus
