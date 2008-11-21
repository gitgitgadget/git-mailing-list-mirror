From: David Bryson <david@statichacks.org>
Subject: Re: Bad git status performance
Date: Thu, 20 Nov 2008 16:42:42 -0800
Message-ID: <20081121004242.GD6458@eratosthenes.cryptobackpack.org>
References: <4926009E.4040203@gmx.ch>
Reply-To: David Bryson <david@statichacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jean-Luc Herren <jlh@gmx.ch>
X-From: git-owner@vger.kernel.org Fri Nov 21 01:44:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3K8f-0007DG-QV
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 01:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144AbYKUAnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 19:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755190AbYKUAnf
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 19:43:35 -0500
Received: from cryptobackpack.org ([64.105.32.74]:38299 "EHLO
	mail.cryptobackpack.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634AbYKUAne (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 19:43:34 -0500
Received: by mail.cryptobackpack.org (Postfix, from userid 1000)
	id 8223E10D0247; Thu, 20 Nov 2008 16:43:33 -0800 (PST)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on
	ptolemy.cryptobackpack.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.1-gr1
Received: from eratosthenes.statichacks.org (heliosphan.cryptobackpack.org [10.6.6.6])
	by mail.cryptobackpack.org (Postfix) with ESMTP id B39A210D00CA;
	Thu, 20 Nov 2008 16:43:32 -0800 (PST)
Received: by eratosthenes.statichacks.org (Postfix, from userid 1000)
	id 5DE171F4089; Thu, 20 Nov 2008 16:42:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4926009E.4040203@gmx.ch>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101485>

Hi,

On Fri, Nov 21, 2008 at 01:28:14AM +0100 or thereabouts, Jean-Luc Herren wrote:
> Hi list!
> 
> I'm getting bad performance on 'git status' when I have staged
> many changes to big files.  For example, consider this:
> 
[snip]
> $ time git status
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #       modified:   1
> #       modified:   10
> ...
> #       modified:   98
> #       modified:   99
> #
> 
> real    0m16.291s
> user    0m16.054s
> sys     0m0.221s
> 
> The first 'git status' shows the same difference as the second,
> just the second time it's staged instead of unstaged.  Why does it
> take 16 seconds the second time when it's instant the first time?

I had similar problems with a repository that contained several tarballs
of gcc and the linux kernel(don't ask me why it was not my repository).

Some weeks ago I mentioned this on IRC, and the problem really was not
necessarily git.  The way it was explained to me(and please correct or
clairify where I am wrong) is that git asked linux for the status of
those files and being that they are so large they were swapped out of
memory.

The result is the kernel reading those large files back in to see if
they have changed at all.  My impression is that this is not a git bug
but a cache-tuning problem.

Dave
