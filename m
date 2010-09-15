From: David Brown <davidb@codeaurora.org>
Subject: Re: Coping with the pull-before-you-push model
Date: Wed, 15 Sep 2010 14:59:54 -0700
Message-ID: <20100915215954.GA20880@huya.qualcomm.com>
References: <4C8866F9.1040705@workspacewhiz.com>
 <AANLkTikY55ZJvSTqyFKLqwABqnJZuODz3yrc7CFvQf0K@mail.gmail.com>
 <4C88F2A9.2080306@workspacewhiz.com>
 <AANLkTikdV3W1d7uNokKRRiT4FeznL1uM=Y9SQLDqgAic@mail.gmail.com>
 <20100910141527.GA6936@sigill.intra.peff.net>
 <4C8EFE62.7080908@workspacewhiz.com>
 <20100914052451.GA15839@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 16 00:00:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow01L-0000et-2Y
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 00:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455Ab0IOV74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 17:59:56 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:13856 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393Ab0IOV7z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 17:59:55 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6107"; a="54482989"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 15 Sep 2010 14:59:55 -0700
Received: from huya.qualcomm.com (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 2119910004C5;
	Wed, 15 Sep 2010 14:59:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100914052451.GA15839@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156260>

On Tue, Sep 14, 2010 at 01:24:51AM -0400, Jeff King wrote:

> I seem to recall from one of Shawn's presentations on Gerrit Code Review
> that it does something like this, too, but I can't seem to find any docs
> about it in my brief search:
> 
>   http://code.google.com/p/gerrit/
> 
> It may be that Gerrit doesn't handle building itself, but that the
> Android project is running something alongside it. Shawn may be able to
> say more.
> 
> Basically, what we are talking about is continuous integration, with the
> slight twist that instead of developers pushing commits to a mainline
> branch which is built and tested, we would build and test their commits
> and then merge them to the mainline branch.

Gerrit doesn't do the build and test, but it isn't all that difficult
to hook into.  It also allows the results of the build and test to
record their state so that the developer can track what is happening.

The nice part about it, compared to other CI systems I've seen is that
it catches the problems before they are merged into master, rather
than after.

Internally, we actually do multiple levels of a CI-type thing.  Every
time a developer uploads a change, one machine performs a sanity build
on it (with multiple configurations).  These results are visible in
Gerrit, and it keeps people from putting too much effort into
reviewing code that doesn't even compile.

Once the code has gotten through two levels of code review, a more
throughough build and test system pulls the whole project (from
numerous git repos) builds and runs tests.  This takes long enough
that it doesn't do individual changes, so failures take work to track
down, but it does generally assure that the result of each 'git merge'
somewhat works.

The only real annoying part I've found with the gerrit model is that
the tree is filled with lots of merge comments (generally a merge for
every real commit).  The other option is to let Gerrit rebase, which
then gets annoying when a developer has pulled changes from other
developers.

It also has a nice link to a 'git pull' command to pull down an
individual change.

David
