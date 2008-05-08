From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: GIT max file size.
Date: Thu, 8 May 2008 13:46:40 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805081334530.2940@woody.linux-foundation.org>
References: <48232B48.9010900@cc.hut.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "epankala@cc.hut.fi" <epankala@cc.hut.fi>
X-From: git-owner@vger.kernel.org Thu May 08 22:48:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuD28-0005MG-5K
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 22:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755054AbYEHUrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 16:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755022AbYEHUrT
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 16:47:19 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49826 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755011AbYEHUrS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 May 2008 16:47:18 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m48Kkg0x019591
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 May 2008 13:46:43 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m48KkeF9005019;
	Thu, 8 May 2008 13:46:41 -0700
In-Reply-To: <48232B48.9010900@cc.hut.fi>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.418 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81560>



On Thu, 8 May 2008, epankala@cc.hut.fi wrote:
> 
> I received "fatal: Out of memory, malloc failed" error when I tried to
> check in file of ~2.5G

There's two issues there.

One is that a lot of what git does is simply "whole file at a time". The 
diff machinery, and a lot of the core stuff, simply just expects to be 
able to mmap() or read the whole file in one go. So on a 32-bit 
architecture, you'll generally be limited to the size of the address 
space, not to anything else.

The other thing is then that (partly because of the above) there probably 
are places where we haven't been as careful about size-type things as we 
could have been. A lot of the code uses size_t, but I bet not everything 
does.

		Linus
