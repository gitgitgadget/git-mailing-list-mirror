From: Junio C Hamano <junkio@cox.net>
Subject: Re: Meaning of "fatal: protocol error: bad line length character"?
Date: Mon, 22 Jan 2007 14:33:12 -0800
Message-ID: <7vireyr8t3.fsf@assigned-by-dhcp.cox.net>
References: <17842.1385.366750.915767@lisa.zopyra.com>
	<7vk5zh7b7d.fsf@assigned-by-dhcp.cox.net>
	<7vfya57ast.fsf@assigned-by-dhcp.cox.net>
	<17842.29542.229557.460473@lisa.zopyra.com>
	<7vbqkt78n7.fsf@assigned-by-dhcp.cox.net>
	<7v7ivh77md.fsf@assigned-by-dhcp.cox.net>
	<17845.2402.105688.56648@lisa.zopyra.com>
	<7vy7nusv52.fsf@assigned-by-dhcp.cox.net>
	<17845.5805.290668.552757@lisa.zopyra.com>
	<17845.14245.559835.112658@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 23:33:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H97j3-0006St-Iu
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 23:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbXAVWdO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 17:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbXAVWdO
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 17:33:14 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:62326 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932085AbXAVWdN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 17:33:13 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070122223313.CQQE15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Mon, 22 Jan 2007 17:33:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ENZW1W00y1kojtg0000000; Mon, 22 Jan 2007 17:33:31 -0500
To: Bill Lear <rael@zopyra.com>
In-Reply-To: <17845.14245.559835.112658@lisa.zopyra.com> (Bill Lear's message
	of "Mon, 22 Jan 2007 16:16:05 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37465>

Bill Lear <rael@zopyra.com> writes:

> Looks like it is our developer's fault after all.  
> ...
> I do think that some augmentation of the error output is in order,
> either as previously posted, or something fancier.  It would be even
> better if this sort of thing did not trip up git, though perhaps
> I don't understand enough of how the update hook and git interact.

The updated receive-pack (was fixed with cd83c74c on Dec 30th
2006, has been in 'master', is in 1.5.0-rc2, and will be in
1.5.0) is supposed to make this a non-issue.  Is it possible for
your developer to use it?  You can have a private install of
receive-pack somewhere in /home/me/bin and tell git-push to use
it with --exec=/home/me/bin/git-receive-pack.

With the fixed receive-pack, whatever the mailer says should not
break the protocol exchange by leaking into it; instead, it
should come back and shown to stderr, just like any output to
stderr from the hook script.

The test patch I sent you should probably not be used as-is in
the production, as it dumps literally everything to your
terminal without limit, but I do agree that it helped us
diagnose the problem in this case.  Maybe limiting it to show
the first few hundred bytes would be sufficient for debugging.
