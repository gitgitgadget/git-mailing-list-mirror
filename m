From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 3/4] reset: add option "--merge-safe" to "git reset"
Date: Thu, 17 Sep 2009 15:05:20 +0200
Message-ID: <4AB23410.6080508@viscovery.net>
References: <20090917040835.4048.51057.chriscool@tuxfamily.org>	 <20090917041440.4048.16353.chriscool@tuxfamily.org>	 <7vk4zykv7o.fsf@alter.siamese.dyndns.org>	 <4AB1D957.20902@viscovery.net>	 <7vr5u6jbgk.fsf@alter.siamese.dyndns.org>	 <4AB1E41F.6050304@viscovery.net> <c07716ae0909170512k3c2ec7m21e69e9acfdfd81f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 15:05:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoGg2-0003bf-Vi
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 15:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758357AbZIQNFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 09:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758211AbZIQNFX
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 09:05:23 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:19695 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757384AbZIQNFW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 09:05:22 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MoGfo-0001eS-Pm; Thu, 17 Sep 2009 15:05:20 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8438EBC81; Thu, 17 Sep 2009 15:05:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <c07716ae0909170512k3c2ec7m21e69e9acfdfd81f@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128751>

Christian Couder schrieb:
> On Thu, Sep 17, 2009 at 9:24 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Junio C Hamano schrieb:
>>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>  $ git stash
>>  $ git reset --hard $target
>>  $ git stash pop
>>
>>> I have _no_ idea what the intended use-case of --merge-safe is, and that
>>> was why I asked Christian for clarification in the previous round.  The
>>> answer was still not clear enough so I pointed out --merge-safe could be
>>> still doing a wrong thing even in _his_ use-case.
>> Reading Christian in 200909170554.49416.chriscool@tuxfamily.org, I think
>> this *is* his use-case? Christian?
> 
> Yes, I agree, it can be used instead of git stash.

It "can"? Do you say that you intend --merge-safe for something else in
addition to the above stash + reset --hard + stash pop sequence? What?

> By the way Linus, in his
> patch that added the --merge option, said that --merge could be used like
> that.

But that use-case has one important difference: You can't use stash right
before the reset:

   # work tree is dirty
   $ git pull $there $topic  # assume we have conflicts

   # investigate result ...
   # oh no, that's crap, scratch it

   $ git stash what? conflicted changes?
   $ git reset what? --hard would remove my dirty state, too

You are screwed. 'git reset --merge' comes to rescue.

I'm pretty sure you don't mean --merge-safe to provide extra safety in
*this* use-case, but that you have a very different use-case in mind.

-- Hannes
