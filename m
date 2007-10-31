From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: unmerging feature branches
Date: Wed, 31 Oct 2007 14:34:45 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710311429080.3342@woody.linux-foundation.org>
References: <20071023152445.GA10070@piper.oerlikon.madduck.net>
 <alpine.LFD.0.999.0710230922240.30120@woody.linux-foundation.org>
 <20071023171611.GA18783@piper.oerlikon.madduck.net>
 <alpine.LFD.0.999.0710231026011.30120@woody.linux-foundation.org>
 <20071031211658.GA5430@inspiron>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
To: Alejandro Martinez Ruiz <alex@flawedcode.org>
X-From: git-owner@vger.kernel.org Wed Oct 31 22:35:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InLDe-0008KP-4O
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 22:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891AbXJaVfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 17:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753310AbXJaVfH
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 17:35:07 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43575 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751219AbXJaVfF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2007 17:35:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9VLYk02000432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 31 Oct 2007 14:34:47 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9VLYj18029896;
	Wed, 31 Oct 2007 14:34:45 -0700
In-Reply-To: <20071031211658.GA5430@inspiron>
X-Spam-Status: No, hits=-2.732 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62882>



On Wed, 31 Oct 2007, Alejandro Martinez Ruiz wrote:
> 
> So how about an "undo" command or a switch for revert with a special
> meaning like "hey, this one is a nice commit, but it ain't ready yet,
> I'd like you to ignore I ever committed the thing when merging or
> rebasing again, thanks"?

There is only one undo command, and that one we've had since day 1:

	git reset --hard <state-you-want-to-go-back-to>

will happily undo anything at all (including an earlier undo, apart from 
uncommitted dirty tree state, which is gone, gone, gone after that 
"undo" and can not be retrieved).

That's the only real true "undo" with clear semantics - it actually does 
undo the whole history.

But the kind of "undo" you wish for is not really possible. It implies a 
level of semantics that the system just doesn't know or care about. It 
also implies that anything else than the shape of history would matter for 
merging, which is just anathema to everything that makes git good in the 
first place.

That said, in practice, this really seldom does come up. You can often use 
"git revert" as that kind of undo, and when you later do the merge, and 
the other side has fixed up the code, it's (a) likely going to be obvious 
in the conflicts and (b) if the fixes were to infrastructure and you had 
no conflicts, it's really easy to just revert the revert too!

			Linus
