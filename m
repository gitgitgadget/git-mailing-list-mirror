From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 15:09:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702121505560.8424@woody.linux-foundation.org>
References: <45CFA30C.6030202@verizon.net> <20070212042425.GB18010@thunk.org>
 <Pine.LNX.4.64.0702120839490.8424@woody.linux-foundation.org>
 <7vps8f6l81.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 00:09:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGkIs-00075w-Ud
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 00:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbXBLXJO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 18:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbXBLXJO
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 18:09:14 -0500
Received: from smtp.osdl.org ([65.172.181.24]:46492 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030464AbXBLXJM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 18:09:12 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1CN94hB029608
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Feb 2007 15:09:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1CN93mu014661;
	Mon, 12 Feb 2007 15:09:03 -0800
In-Reply-To: <7vps8f6l81.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.425 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39451>



On Mon, 12 Feb 2007, Junio C Hamano wrote:
> 
> Not so fast.  What's your plan for st_size?

Umm. There's two (very distinct) uses for st_size.

The one that we actually use to validate the current index obviously must 
match the "OS returned value". It contains all the CR/LF stuff.

The one where we actually read the file and run SHA1 on the result must 
obviously be the post-conversion one.

But it shouldn't be a problem. We'll always know which one matters: the 
index case is always about pure stat information (and has no meaning 
outside of that, really - after all, it's no different from st_mode etc, 
and we actually keep it in a special binary format that is endian-safe!) 
and the "real object" case is always about the *data* we use to compare 
with.

I don't think we ever mix the two anyway.

		Linus
