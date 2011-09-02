From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Fri, 02 Sep 2011 09:00:55 +0200
Message-ID: <4E607F27.2000405@viscovery.net>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org> <20110902000039.GB9339@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 02 09:01:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzNkU-000180-Ga
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 09:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641Ab1IBHBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 03:01:06 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:38482 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751101Ab1IBHBD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 03:01:03 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QzNkG-0003j8-4o; Fri, 02 Sep 2011 09:00:56 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D78AF1660F;
	Fri,  2 Sep 2011 09:00:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.20) Gecko/20110804 Thunderbird/3.1.12
In-Reply-To: <20110902000039.GB9339@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180599>

Am 9/2/2011 2:00, schrieb Jeff King:
> Right now, I think of it as a local cache for whatever the remote side
> has. In other words, a way of separating the network-fetching parts of
> the workflow from the local parts.

This is also my interpretation. For this reason, I don't think a change is
necessary.

> So I consider that a downside, because it's extra work for the user[1].
> What are the upsides?
> 
> Is this about preventing workflow-related mistakes where people
> accidentally merge in rebased commits, creating annoying shadow
> histories?
> 
> Is it about preventing malicious rewinds from infecting downstream
> repositories?

All good questions to ask.

> [1] What I really don't like is that cloning git.git is no longer:
> 
>       git clone git://git.kernel.org/pub/scm/git/git.git
> 
>     which is a minimal as it can be, but becomes:
> 
>       git clone git://git.kernel.org/pub/scm/git/git.git
>       cd git
>       git config --add remote.origin.fetch +refs/heads/pu:refs/remotes/origin/pu
> 
>     It's not that my fingers are too tired to do all that typing, but
>     rather that the first set of instructions is very easy to explain,
>     and the second one is full of magic and head-scratching about why
>     git isn't handling this magic itself.

Absolutely.

>     It would be considerably nicer if the server had some way of saying
>     "I expect this branch to be rewound". Which has been discussed off
>     and on over the years, as I recall.

So, if such a feature were available, wouldn't it be nicer if the initial
clone set up the refspec like this:

  [remote "origin"]
        url = git://git.kernel.org/pub/scm/git/git.git
        fetch = +refs/heads/*:refs/remotes/origin/*
        fetch = refs/heads/maint:refs/remotes/origin/maint
        fetch = refs/heads/master:refs/remotes/origin/master

i.e., the non-wildcard refspec are about which branches are *not* expected
to be rewound rather than the other way around.

-- Hannes
