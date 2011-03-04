From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [BUG] git cat-file does not terminate
Date: Fri, 4 Mar 2011 16:40:14 +0100
Message-ID: <20110304154014.GE24660@m62s10.vlinux.de>
References: <4D70E340.3050309@tweerlei.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Wruck <wruck@tweerlei.de>
X-From: git-owner@vger.kernel.org Fri Mar 04 16:40:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvX7D-0005WC-R0
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 16:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759722Ab1CDPkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 10:40:22 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:43488 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759480Ab1CDPkV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 10:40:21 -0500
Received: (qmail invoked by alias); 04 Mar 2011 15:40:17 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp062) with SMTP; 04 Mar 2011 16:40:17 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+UXtEo9PWUwo9gmmRTbCcZiMxyBBPEGxOBwD1tcK
	FXmd1ciaGnkkAu
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 63C3CD401F; Fri,  4 Mar 2011 16:40:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D70E340.3050309@tweerlei.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168442>

On Fri, Mar 04, 2011 at 02:04:00PM +0100, Robert Wruck wrote:
> Hi,
> 
> this is some strange behaviour of cat-file:
> On a certain file, `git cat-file blob <objectname>` writes an
> endless stream repeating the first 4096 byte of the original file.
> cat-file -s and cat-file -t produce correct results.
> 
> Even stranger: This only happens with cygwin-git (1.7.4.1).
> msysgit (same machine, same repository): works
> linux-git (same machine, same repository): works
> 
> Even more strange: This only happens with cygwin on a particular
> machine (recent cygwin1.dll 1.7.8) under WinXP/32bit. On another
> machine, recent cygwin, Windows7/64bit it works...
> 
> Debugging a bit, I found that the following happens:
> In xwrite (wrapper.c), write() is called with the total file size -
> in my case about 87 MB. This call returns -1 and EAGAIN but
> nevertheless writes 4096 byte to the output fd. I don't think that's
> expected behaviour...
> 
> I "fixed" it by limiting each write to 64k (thus looping in
> write_in_full) but maybe somebody knows about that cygwin behaviour?
> 
> This seems to be the cause of the dreaded "No newline found after
> blob" when running `git svn clone` under cygwin on a repository with
> large files.
> 
> You could argue that this is a cygwin bug but maybe limiting each
> write to a maximum size is a simple workaround.
> 
Maybe you could post a patch, so everyone can see the technical implications
and discuss the fix?

-Peter
