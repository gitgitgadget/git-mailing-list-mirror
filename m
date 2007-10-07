From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-push [--all] and tags
Date: Sun, 7 Oct 2007 09:39:53 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710070929340.23684@woody.linux-foundation.org>
References: <20071006160506.GA28238@lapse.madduck.net> <47083035.7070904@vilain.net>
 <alpine.LFD.0.999.0710061814310.23684@woody.linux-foundation.org>
 <20071007093636.GA3568@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>,
	Sam Vilain <sam@vilain.net>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Sun Oct 07 18:40:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeZAy-0005tQ-6Y
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 18:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbXJGQkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 12:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752469AbXJGQkI
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 12:40:08 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58806 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752216AbXJGQkH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Oct 2007 12:40:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l97GdsGA005074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 7 Oct 2007 09:39:55 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l97GdrUK015256;
	Sun, 7 Oct 2007 09:39:53 -0700
In-Reply-To: <20071007093636.GA3568@lapse.madduck.net>
X-Spam-Status: No, hits=-2.74 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60197>



On Sun, 7 Oct 2007, martin f krafft wrote:
> 
> So am I right if I say that all the logic should really be happening
> in send-pack and that push is really just an interface when it comes
> to selecting the refs to push, so it should basically feed through
> the options and refs, meaning that send-pack should get --tags and
> --shared as well?

I really don't have any strong personal opinions. I don't think anybody is 
ever supposed to use send-pack directly, so I don't think it really much 
matters whether send-pack is taught to do all the helper options too, or 
whether it should just get the list of refs..

But yes, I suspect it would be cleanest to just remove the "expand --tags" 
logic from builtin-push, and make the actual sending side do that.

> Or should push enumerate all refs needed and pass them directly to
> send-pack, effectively making send-pack's --all option obsolete?

I don't think this works very well - builtin-push doesn't even know what 
the remote branches _are_, so it cannot list "these branches are shared". 
So we'd always have to have that shared behaviour embedded in send-pack 
anyway, so I think the most logical thing is to also do the logic for 
--all and --tags there.

IOW, builtin-push would just be a wrapper around send-pack, doing the 
"for each remote" thing, but just passing down all/tags/shared.

		Linus
