From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH 00/11] Sequencer Foundations
Date: Mon, 11 Apr 2011 02:34:26 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1104110146550.14365@iabervon.org>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com> <201104110518.04413.chriscool@tuxfamily.org> <alpine.LNX.2.00.1104110031530.14365@iabervon.org> <20110411053819.GA6502@elie>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 08:34:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Ahm-0005xs-4B
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 08:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395Ab1DKGe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 02:34:28 -0400
Received: from iabervon.org ([66.92.72.58]:50683 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917Ab1DKGe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 02:34:28 -0400
Received: (qmail 27671 invoked by uid 1000); 11 Apr 2011 06:34:26 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Apr 2011 06:34:26 -0000
In-Reply-To: <20110411053819.GA6502@elie>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171308>

On Mon, 11 Apr 2011, Jonathan Nieder wrote:

> Hi,
> 
> Daniel Barkalow wrote:
> 
> > But it's annoying that, in order 
> > to finish a conflicted "git cherry-pick <branch>", you currently need to 
> > go back and find the instruction that says to commit it yourself, with the 
> > option "-c <sha1>" to retain authorship and message.
> 
> You might like v1.7.5-rc0~88^2 (Teach commit about CHERRY_PICK_HEAD,
> 2011-02-19).

Ah, so I'm actually proposing that we not revert that series, as far as 
having cherry-pick-specific state is concerned. :) On the other hand, I'd 
like to have the logic for using that state be in the cherry-pick 
implementation, rather than having commit.c need to understand merge and 
cherry-pick (and revert, and applying a patch from email, and...). Which 
is to say, there should be a core state file that ends up with 
"cherry-pick" in it, and revert.c has registered that it handles that, and 
commit.c should call the registered function to use the saved state. 

Also, git-rebase should be able to take advantage of the fact that other 
code knows how to start a cherry-pick, find that it has a conflict, tell 
the user, and use saved information to finish it.

> > And if you want to 
> > abort it, you need to remember "git reset --hard HEAD" (and maybe you also 
> > want "git rerere clear").
> 
> Hm, I had assumed reset --hard (or "git reset --merge HEAD") would
> take care of the "rerere clear" but it seems that indeed it doesn't.

In fact, Ram's series makes sure to call both, which is how I knew.

	-Daniel
*This .sig left intentionally blank*
