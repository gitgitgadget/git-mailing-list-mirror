From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: branch --set-upstream considered harmful
Date: Mon, 07 Jun 2010 10:44:22 +0200
Message-ID: <4C0CB166.9080407@drmicha.warpmail.net>
References: <AANLkTiln_xxnF-e33YA7kkfbBBcBMd40xag8JTW0eqws@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 10:45:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLXxB-00082E-LW
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 10:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647Ab0FGIo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 04:44:59 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:38901 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751567Ab0FGIo5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jun 2010 04:44:57 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 67525F7D36;
	Mon,  7 Jun 2010 04:44:46 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 07 Jun 2010 04:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=bvnU3d2kJqo9Xzez+ZmvSS0Vpd0=; b=Qh6Gs5hl79RXsQB1Iih5pzjbnLRW+ZScvEozKbgXsSH3tt+CnFgW1YdnU0eTmOXihi+Y6Bt/+T06+QStYbrwe/qKzPor6kM1E3ROVIA/Err9HA2iTuPwg9F0LRvYUA4sQhvG7Ns4JvNIXWwl0uSkWqxbOVU6ybYLtLKzWqRPH+0=
X-Sasl-enc: rFqiC1WTOxhHTxELItpJJZhY585czRgLVdV4piU4/hFF 1275900285
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A88C34E5118;
	Mon,  7 Jun 2010 04:44:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100604 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTiln_xxnF-e33YA7kkfbBBcBMd40xag8JTW0eqws@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148587>

Jay Soffian venit, vidit, dixit 06.06.2010 21:21:
> Say I have an existing branch and it doesn't have a tracking config.
> (My local users often just do "checkout -b topic" instead of "checkout
> -b topic origin/master".)
> 
> I would naively expect this to work, while on that branch:
> 
>   (topic)$ git branch --set-upstream origin/master
> 
> But, um no:
> 
>   (topic)$ git branch --set-upstream origin/master
>   Branch origin/master set up to track local branch topic.
> 
> Doh!
> 
> Well, maybe this works:
> 
>   (topic)$ git branch --set-upstream origin/master topic
>   Branch origin/master set up to track local branch topic.
> 
> Doh!^2
> 
> Well, maybe we can say "HEAD" since that seems to mean "the current
> branch" everywhere else in gitland:
> 
>   (topic)$ git branch --set-upstream HEAD origin/master
>   Branch HEAD set up to track remote branch master from origin.
> 
> (Aside, being able to create a branch named HEAD is surely a bug, right?)
> 
> Finally after exhausting all other possibilities (or finally making
> sense of --set-upstream in the man page), we realize:
> 
>   (topic)$ git branch --set-upstream topic origin/master
>   Branch topic set up to track remote branch master from origin.
> 
> Trying to make myself feel better, I realize that this works:
> 
>   (topic)$ git branch topic --set-upstream origin/master
> 
> So here's how I'm thinking about fixing it, but maybe I'm just making
> it even more confusing. What say you:
> 
>   (topic)$ git branch --set-upstream=origin/master
>   Branch topic set up to track remote branch master from origin.
> 
> --track would be similarly enhanced, which allows a little more
> flexibility in creating a branch thusly:
> 
>   $ git branch --track=origin/master topic
> 
> Which creates topic, starting from HEAD, but tracking origin/master.
> (And I'd do the same for checkout's --track option.)
> 
> I recognize that having both positional and non-positional forms of
> --track/--set-upstream  may be confusing, but I think it's less
> confusing than set-upstream's current semantics, I'm loathe to
> introduce yet another option, and I don't want to break backward
> compatibility.
> 
> Flames?

I'm sorry, but you're completely right. I created a tracking branch
config *for* a remote branch myself, and created one for the HEAD branch
before looking up the man page and wondering about the braindead
non-semantic way it works. We have that braindeadness in other places as
well, e.g. "git rebase branchname" which does not rebase "branchname" at
all (but the current branch).

Ok, you want flame? I'll give you flame: This is not going to change. We
have a "naturally grown" ui, and we don't do any changes to make it
conceptually consistent unless it does not change any existing
behaviour. [I'm exaggerating, of course, but you wanted flame, didn't you? ]

I like your --set-upstream= solution, by the way. Maybe people find it
less confusing if there's an "--upstream=upstream" long option (no
"set") and a "--set-upstream" subcommand. You know we have subcommands
as options as well as arguments:

branch --set-upstream
config --get etc.
remote add etc.
noted edit etc.
svn init etc.
submodule add etc.

Speaking of consistency :|

Michael
