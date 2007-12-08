From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Something is broken in repack
Date: Fri, 7 Dec 2007 16:37:16 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712071632490.12046@woody.linux-foundation.org>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>, Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 01:38:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0nhq-0003e8-TE
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 01:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbXLHAhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 19:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbXLHAhu
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 19:37:50 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:32836 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751022AbXLHAht (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Dec 2007 19:37:49 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB80bGV5018972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Dec 2007 16:37:17 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB80bGlR011520;
	Fri, 7 Dec 2007 16:37:16 -0800
In-Reply-To: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
X-Spam-Status: No, hits=-2.687 required=5 tests=AWL,BAYES_00,TW_TR
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67488>



On Fri, 7 Dec 2007, Jon Smirl wrote:
>
> Using this config:
> [pack]
>         threads = 4
>         deltacachesize = 256M

I think deltacachesize is broken.

The code in try_delta() that replaces a delta cache entry with another one 
seems very buggy wrt that whole "delta_cache_size" update. It does

	delta_cache_size -= trg_entry->delta_size;

to account for the old delta going away, but it does this *after* having 
already replaced trg_entry->delta_size with the new delta entry.

I suspect there are other issues going on too, but that's the one that I 
noticed from a quick look-through.

Nico? I think this one is yours..

		Linus
