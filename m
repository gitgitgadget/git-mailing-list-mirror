From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Working with remotes; cloning remote references
Date: Mon, 27 Oct 2008 15:54:21 -0400
Message-ID: <49061C6D.2070407@xiplink.com>
References: <48F7852F.109@xiplink.com>	 <eaa105840810161220k26eebd48q8de606597f2be055@mail.gmail.com>	 <48F7A42E.70200@xiplink.com> <eaa105840810161345r69c9f05j66bb850085f561e7@mail.gmail.com> <48F7BBAC.2090907@xiplink.com> <48F83FD0.90606@drmicha.warpmail.net> <48F8A4E8.8070008@xiplink.com> <48F8AA5E.6090908@drmicha.warpmail.net> <48F8ECA2.3040208@xiplink.com> <48FC8624.9090807@fastmail.fm> <48FCB6B8.6090708@xiplink.com> <48FDA5A0.8030506@drmicha.warpmail.net> <48FDF28A.9060606@xiplink.com> <48FF3FEE.8020209@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 27 20:55:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuYBC-0001w8-Va
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 20:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbYJ0Txz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 15:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753101AbYJ0Txy
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 15:53:54 -0400
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:50538 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbYJ0Txx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 15:53:53 -0400
Received: from relay6.relay.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay6.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id AA7257AA5A0;
	Mon, 27 Oct 2008 15:53:51 -0400 (EDT)
Received: by relay6.relay.iad.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTP id 5E8E37AA4C6;
	Mon, 27 Oct 2008 15:53:51 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <48FF3FEE.8020209@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99258>

Michael J Gruber wrote:
> 
> First you should decide whether it is worth for you.

I'm still trying to figure that out...

> Comments on the
> list tend to kick in once people see a proposed implementation. A viable
> strategy could be, mimicking git submodule behaviour in part:
> 
> - Implement "git remote export reponame" which takes an existing remote
> config from .git/config, writes it to .gitremotes and checks in (or
> better: stages for commit) the file .gitremotes [you would use this on main]
> 
> - Implement "git remote import" which reads the file .gitremotes and
> adds remote config to .git/config. [you would use this on clones]
> 
> - Change "git remote update" to take updates to .gitremotes into account
> before doing its usual routine (perhaps based on a config with default
> off, or a command line option, or better both)
> 
> Downside is that .gitremotes is tracked would show up as a file in the
> repo, but I can't come up with a better way which is as simple as the
> above. .gitremotes could be stored in a specially named branch, though.

That downside is a bit disappointing.  I might as well just make "git 
remote export" simply generate a script of "git remote add" commands 
based on the contents of .git/config, and check that script in.  Then I 
could run the script in a clone to recreate the origin's remotes.

It also seems awkward to have an export step in the origin repository. 
I don't really see a need for an export step (except as an artifact of 
the above implementation).

It seems to me that this would be more natural if our hypothetical "git 
remote import <X>" could just grab the remotes from repository <X> (or 
the origin, if <X> is unspecified).  I assume that would involve 
lower-level changes than what you described, but to me it seems like the 
more usable approach.  (But then I know nothing of Git's internals, so 
maybe this kind of change would be too much work?)

		Marc
