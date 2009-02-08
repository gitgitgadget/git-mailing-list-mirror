From: Sam Vilain <sam@vilain.net>
Subject: Re: understanding merge history
Date: Mon, 09 Feb 2009 11:16:06 +1300
Message-ID: <498F59A6.4000402@vilain.net>
References: <20090127223926.GO3503@iabyn.com> <b77c1dce0901280053r28b9f02cjd7151377e6e9a30a@mail.gmail.com> <1233179416.29266.1.camel@maia.lan> <20090202171556.GG3558@iabyn.com> <1233602444.6439.3.camel@maia.lan> <20090204212808.GS3558@iabyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	perl5-porters@perl.org, git@vger.kernel.org
To: Dave Mitchell <davem@iabyn.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 23:17:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWHyD-0002qD-Ky
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 23:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245AbZBHWQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 17:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753147AbZBHWQS
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 17:16:18 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:34567 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752884AbZBHWQS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 17:16:18 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 8A05621C6D2; Mon,  9 Feb 2009 11:16:12 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id A21AE21C5C0;
	Mon,  9 Feb 2009 11:16:07 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <20090204212808.GS3558@iabyn.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109019>

Dave Mitchell wrote:
> Perhaps I was misunderstanding rerere. I assumed it would only replay
> identical resolves on the same branch, rather than being able to cope with
> slightly different resolves on a different branch.
>
> However, after playing with it just now I can't seem to get it to work in
> the initial phase of recording a resolve that has previously taken place.
>
> Given three commits A,B M, where M is a previous merge of A,B:
>
>     A-M
>      /  
>     B
>
> I tried the following:
>
> git checkout A
> git merge B		# replay the initial conflict
> git rerere clear
> git rerere		# record the initial conflict state
>
> git reset --hard M	# simulate the post-resolve state
> git rerere		# and record it
>
>
> But then
>
>     git rerere diff
> and
>     git rerere status
>
> both show nothing, so I'm assuming it didn't manage to capture anything.
>   

[cross-posted to the git list so that people will answer who use this
command a bit more than myself and to help provide the use case for
making the interface better]

I think the problem is that you want to run something like 'git checkout
M \*' or 'git read-tree M' instead of 'git reset --hard M'. ie, change
the index only and not the HEAD reference. Once this is done then 'git
commit' (this will be a dummy commit you'll throw away) or perhaps just
'git rerere' should be enough to update the rerere cache.

But perhaps someone else will have tried this before and knows how to do
it..

Sam.
