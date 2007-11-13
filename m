From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Strange "beagle" interaction..
Date: Tue, 13 Nov 2007 13:30:45 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711131326310.2786@woody.linux-foundation.org>
References: <alpine.LFD.0.9999.0711131241050.2786@woody.linux-foundation.org> <20071113210354.GD22590@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 22:32:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3N3-0000rb-Sw
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127AbXKMVb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759233AbXKMVb6
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:31:58 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60289 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755127AbXKMVb5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Nov 2007 16:31:57 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lADLUkbc009097
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 13 Nov 2007 13:30:47 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lADLUj4N004978;
	Tue, 13 Nov 2007 13:30:46 -0800
In-Reply-To: <20071113210354.GD22590@fieldses.org>
X-Spam-Status: No, hits=-2.736 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64872>



On Tue, 13 Nov 2007, J. Bruce Fields wrote:
> 
> Last I ran across this, I believe I found it was adding extended
> attributes to the file.

Yeah, I just straced it and found the same thing. It's saving fingerprints 
and mtimes to files in the extended attributes.

> Yeah, I just turned off beagle.  It looked to me like it was doing
> something wrongheaded.

Gaah. The problem is, setting xattrs does actually change ctime. Which 
means that if we want to make git play nice with beagle, I guess we have 
to just remove the comparison of ctime.

Oh, well. Git doesn't *require* it, but I like the notion of checking the 
inode really really carefully. But it looks like it may not be an option, 
because of file indexers hiding stuff behind our backs.

Or we could just tell people not to run beagle on their git trees, but I 
suspect some people will actually *want* to. Even if it flushes their disk 
caches.

		Linus
