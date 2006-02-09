From: Junio C Hamano <junkio@cox.net>
Subject: Re: git + ssh + key authentication feature-request
Date: Wed, 08 Feb 2006 16:40:06 -0800
Message-ID: <7vacd1mkk9.fsf@assigned-by-dhcp.cox.net>
References: <43EA73C3.2040309@iaglans.de>
	<7vhd79o6m5.fsf@assigned-by-dhcp.cox.net>
	<43EA7D57.7040409@iaglans.de>
	<7v4q39o3xs.fsf@assigned-by-dhcp.cox.net>
	<slrndul2bq.2i8.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 01:40:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6zr5-0000KE-4H
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 01:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422733AbWBIAkL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 19:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422734AbWBIAkL
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 19:40:11 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:64227 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1422733AbWBIAkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 19:40:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209003901.PZNK15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Feb 2006 19:39:01 -0500
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrndul2bq.2i8.mdw@metalzone.distorted.org.uk> (Mark Wooding's
	message of "Thu, 9 Feb 2006 00:14:50 +0000 (UTC)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15775>

Mark Wooding <mdw@distorted.org.uk> writes:

> It's important that your users can't use this SSH access to mess with
> the shared user's SSH configuration itself, but, hey, that sort of
> restricted access is what git-daemon is for, right?

Correct modulo s/git-daemon/git-shell/.

> I think the problem there is more that the commits themselves were
> created elsewhere, where this server wasn't watching, and therefore it
> pretty much has to take the committer and author information there on
> trust.

That's an different issue.  Anybody could create bogus commits
all they want based on somebody else's history.  Making
refs/{heads,tags}/ pointers to point at the tip of a development
tail that contains such bogus commits is something you would
want to have control upon.

For example, Documentation/howto/update-hook-example shows
Carl's idea to implement access control using the unix user
identity (because it assumes you set up one home directory per
developer to use public key authentication to cause sshd to give
a true unix uid to an incoming connection) to make sure who can
update which head.  By updating a branch head, the developer is
asserts that the development trail that led to it is something
she feels valid.

Now, you brought up an interesting way to do this without using
unix uid.  Some sshd installations do not honour environment=
settings, but that problem aside, you could define a token, say
GIT_USER, with different value on each line in the shared
authorized_keys file so that you can distinguish incoming
developers that share the same "home directory", and change the
example hook Carl gave us to use that token instead of the unix
user identity.  I'd imagine that would work quite well.
