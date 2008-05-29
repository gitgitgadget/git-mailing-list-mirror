From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 6/5] NUL hack to create_file()
Date: Thu, 29 May 2008 13:19:23 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805291157330.19665@iabervon.org>
References: <1212020246-26480-1-git-send-email-gitster@pobox.com> <1212020246-26480-2-git-send-email-gitster@pobox.com> <1212020246-26480-3-git-send-email-gitster@pobox.com> <1212020246-26480-4-git-send-email-gitster@pobox.com> <1212020246-26480-5-git-send-email-gitster@pobox.com>
 <1212020246-26480-6-git-send-email-gitster@pobox.com> <1212020246-26480-7-git-send-email-gitster@pobox.com> <483E4E3C.90805@viscovery.net> <483E55C1.1000900@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Thu May 29 19:20:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1lnV-0005h2-EK
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 19:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbYE2RT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 13:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbYE2RTZ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 13:19:25 -0400
Received: from iabervon.org ([66.92.72.58]:39117 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751773AbYE2RTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 13:19:25 -0400
Received: (qmail 1298 invoked by uid 1000); 29 May 2008 17:19:23 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 May 2008 17:19:23 -0000
In-Reply-To: <483E55C1.1000900@trolltech.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83221>

On Thu, 29 May 2008, Marius Storm-Olsen wrote:

> Johannes Sixt said the following on 29.05.2008 08:33:
> > Junio C Hamano schrieb:
> > > This is not meant for application to the mainline.  It allows your git to
> > > refuse to create a blob whose name is "nul".
> > 
> > It's not just about "nul"; these won't work either: "aux", "prn", "con",
> > "com\d+", "lpt\d+", neither do "$one_of_these.$some_extension". And all of
> > that regardless of the case!
> > 
> > See http://msdn.microsoft.com/en-us/library/aa365247(VS.85).aspx
> > 
> > Definitely, we don't ever want to have such special-casing somewhere in git.
> 
> They _can_ be used by using the UNC notation:
>     \\?\<drive letter>:\<path>\nul
> Do you think we should special-case that, or simply fail?

Perhaps we should see if we can get an open() that always uses that 
notation for the actual system call? I doubt we want to support the 
DOS-ish meanings even if the user provides them as input sources. If it's 
not actually a problem with the underlying storage mechanism, but rather a 
flaw in the POSIX implementation for Windows, we should fix that (or do 
something in compat to work around it) instead of failing in any way to 
support it in git. Of course, people on Windows using projects with these 
filenames will probably run into problems with other tools, but at least 
git will behave properly.

On the other hand, I bet there are going to be real issues with filenames 
with backslashes in them.

	-Daniel
*This .sig left intentionally blank*
