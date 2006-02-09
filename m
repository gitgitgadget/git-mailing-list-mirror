From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: git + ssh + key authentication feature-request
Date: Thu, 9 Feb 2006 00:14:50 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrndul2bq.2i8.mdw@metalzone.distorted.org.uk>
References: <43EA73C3.2040309@iaglans.de> <7vhd79o6m5.fsf@assigned-by-dhcp.cox.net> <43EA7D57.7040409@iaglans.de> <7v4q39o3xs.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 09 01:14:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6zSb-0004Gf-GW
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 01:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422718AbWBIAOy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 19:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422720AbWBIAOy
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 19:14:54 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:1630 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1422718AbWBIAOy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 19:14:54 -0500
Received: (qmail 7284 invoked by uid 110); 9 Feb 2006 00:14:50 -0000
To: git@vger.kernel.org
Received: (qmail 7270 invoked by uid 9); 9 Feb 2006 00:14:50 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1139444090 6954 172.29.199.2 (9 Feb 2006 00:14:50 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Thu, 9 Feb 2006 00:14:50 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15772>

Junio C Hamano <junkio@cox.net> wrote:

> So while you could make a repository "/pub/project.git" the home
> directory of _one_ UNIX user, and store her key in the file
> "/pub/project.git/.ssh/authorized_keys", that would not work
> very well for a shared repository setup if you want to be able
> to tell more than one physical users apart.

Ahh!  But you can.  The trick is to set the remote user's identity based
on the key he uses to authenticate himself.  This doesn't work if you
use password authentication.  You add items of the form
`environment="VAR=VALUE"' to the end of each authorized_keys entry, as
appropriate for whoever it is that owns the corresponding private key;
the GIT_{AUTHOR,COMMITTER}_{NAME,EMAIL} variables are ideal choices to
set here.  You could set some other variables and do some more
sophisticated checking of who's doing what, which would require souping
up git-daemon somewhat, but I don't think it's beyond the realms of
possibility.

It's important that your users can't use this SSH access to mess with
the shared user's SSH configuration itself, but, hey, that sort of
restricted access is what git-daemon is for, right?

> You _could_ tell them to use the same -l option and log-in as the same
> UNIX user with their own keys, though.  But that way you cannot tell
> which developer pushed into the repository (of course if you trust the
> commits, commit log message would say the committer ident).

I think the problem there is more that the commits themselves were
created elsewhere, where this server wasn't watching, and therefore it
pretty much has to take the committer and author information there on
trust.

-- [mdw]
