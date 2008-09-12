From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 14:24:40 +1200
Message-ID: <48C9D2E8.1000506@vilain.net>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809100841080.3384@nehalem.linux-foundation.org> <alpine.LFD.1.10.0809100844040.3384@nehalem.linux-foundation.org> <200809101823.22072.jnareb@gmail.com> <48C9A9A4.8090703@vilain.net> <alpine.LFD.1.10.0809111641110.3384@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Paolo Bonzini <bonzini@gnu.org>,
	"Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 12 04:29:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdyPT-0003go-Qv
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 04:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbYILCYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 22:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754483AbYILCYw
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 22:24:52 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:49845 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753567AbYILCYv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 22:24:51 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 6916E21C6AC; Fri, 12 Sep 2008 14:24:49 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=AWL,BAYES_00 autolearn=ham
	version=3.2.3
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 81B8B21C50D;
	Fri, 12 Sep 2008 14:24:41 +1200 (NZST)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <alpine.LFD.1.10.0809111641110.3384@nehalem.linux-foundation.org>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95679>

Linus Torvalds wrote:
> 
> On Fri, 12 Sep 2008, Sam Vilain wrote:
>>  2. make git-cherry-pick have a similar option to '-x', but instead of
>>     recording the original commit ID, record the original *patch* ID,
>>     *if* there was a merge conflict for that cherry pick.
> 
> Actually, don't make it dependent on merge conflicts. Just make it depend 
> on whether the patch ID is _different_.
> 
> It can happen even without any conflicts, just because the context 
> changed. So it really isn't about merge conflicts per se, just the fact 
> that a patch can change when it is applied in a new area with a three-way 
> diff - or because it got applied with fuzz.
> 
> You could add it as a 
> 
> 	Original-patch-id: <sha1>
> 
> or something. And then you just need to teach "git cherry/rebase" to take 
> both the original ID and the new one into account when deciding whether it 
> has already seen that patch.

Yes, right - it's the patch ID changing that's the problem for
git-cherry / rev-list --cherry-pick to be able to spot changes as the
'same'.

Someone else pointed out that git-rebase -i might want to have this as well.

I actually looked into coding this, but there was a little problem with
the way git-revert worked - it builds the commit message before the diff
is calculated.  So there would probably need to be a little trivial
refactoring first before this can be implemented.

Sam.
