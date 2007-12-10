From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: dmalloc and leaks in git
Date: Mon, 10 Dec 2007 08:34:37 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712100828590.12046@woody.linux-foundation.org>
References: <9e4733910712081253t7cd43f87o6001f32fddc01565@mail.gmail.com> <alpine.LFD.0.9999.0712091251330.12046@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 17:35:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1lay-0004fj-R0
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 17:35:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbXLJQeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 11:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbXLJQeo
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 11:34:44 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49051 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752061AbXLJQen (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Dec 2007 11:34:43 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBAGYcf8001956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Dec 2007 08:34:39 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBAGYbOp009791;
	Mon, 10 Dec 2007 08:34:37 -0800
In-Reply-To: <alpine.LFD.0.9999.0712091251330.12046@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67732>



On Sun, 9 Dec 2007, Linus Torvalds wrote:
> 
> For example, if you use
> 
> 	valgrind --tool=massif --heap=yes ...

I tried this on my copy of the gcc thing, but I didn't do the extreme 
packing thing, so I never saw the 3.4GB usage. Massif just reported a 200M 
heap, and about half of that was "add_object_entry".

Of course, that doesn't report any mmap usage at all, so it totally 
ignores the mapping of the original pack-file itself (which will obviously 
be totally dense by the end, since we look at all objects).

It also doesn't take into account various secondary effects. For example, 
I don't think it looks at heap fragmentation issues etc, which normally 
aren't a noticeable thing, but maybe some particular allocation pattern 
can make the glibc allocator waste horrid amounts of memory or something 
like that.

			Linus
