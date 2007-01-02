From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Draft v1.5.0 release notes
Date: Mon, 01 Jan 2007 18:31:04 -0800
Message-ID: <4599C3E8.5060209@midwinter.com>
References: <7vlkkm47eg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 03:30:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1ZQU-00022L-GX
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 03:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbXABCau (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 21:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755079AbXABCau
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 21:30:50 -0500
Received: from tater.midwinter.com ([216.32.86.90]:41894 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755040AbXABCat (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 21:30:49 -0500
Received: (qmail 15567 invoked from network); 2 Jan 2007 02:30:49 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.130?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 2 Jan 2007 02:30:49 -0000
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkkm47eg.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35764>

Junio C Hamano wrote:
>  - There is a configuration variable core.legacyheaders that
>    changes the format of loose objects so that they are more
>    efficient to pack and to send out of the repository over git
>    native protocol, since v1.4.2.  However, this format cannot
>    be read by git older than that version; people fetching from
>    your repository using older clients over dumb transports
>    (e.g. http) using older versions of git will also be
>    affected.  This is not enabled by default.
>
>  - Since v1.4.3, configuration repack.usedeltabaseoffset allows
>    packfile to be created in more space efficient format, which
>    cannot be read by git older than that version.  This is not
>    enabled by default.
>   

For people in non-public development environments, where there's 
absolutely no possibility of someone hitting a repo with an old client, 
presumably these options should both be enabled. I wonder if it makes 
sense to add an option to git-init-db to create a configuration file 
with all the latest stuff enabled -- or better still, something like

git-init-db --min-version=1.4.2

that would enable all the non-backward-compatible stuff in the newly 
created repository. And then a special case "--min-version=current" to 
use all the most optimal settings for the current release, useful in 
environments like corporate LANs where the tool versions are centrally 
managed.

Likewise, something like

git-repo-config --min-version=1.5.0

could be used to set all the options in an existing repo (presumably 
this would not allow you to move backwards, just upgrade) for cases 
where clients are known to have all upgraded to at least a particular 
version.

Maybe that last purpose would be better served by a "git-upgrade" 
command that, for example, could rebuild old packfiles in the new more 
efficient format and write out the appropriate configuration. Though one 
would have to take pains to point out that running that command was NOT 
a required step when upgrading to a new git release, and would in fact 
be a bad idea for projects being accessed by older clients.

-Steve
