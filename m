From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Introduce <branch>@{tracked} as shortcut to the tracked
 branch
Date: Thu, 10 Sep 2009 12:59:47 +0200
Message-ID: <4AA8DC23.6050500@drmicha.warpmail.net>
References: <20090904135414.GA3728@honk.padd.com> <alpine.DEB.1.00.0909101135590.8306@pacific.mpi-cbg.de> <4AA8CA88.9060802@drmicha.warpmail.net> <200909101218.06789.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Pete Wyckoff <pw@padd.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 13:00:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlhNp-0001Gp-Ot
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 13:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285AbZIJK77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 06:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbZIJK77
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 06:59:59 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34902 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753470AbZIJK76 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2009 06:59:58 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E33FC698B8;
	Thu, 10 Sep 2009 06:59:59 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 10 Sep 2009 06:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=dwsh85bkM8wlmu6AJyLJzTmiPi4=; b=mG/uOrDn5PoY7zWLbg9zYxqdwk6UoANc/+r5j4GdUPb6vv/MjnvgEH+UGbqJtuWDI5y34cfJpPMO0HAj9zJo2lDQgv6ZWUWeGApQL3jFH47mE9PT0mKzZ5OF6aP7CtJJRR+Q1Lth1d6Fzq2oX8eP2NqhrZF94B0QndgXc0QP1H8=
X-Sasl-enc: o6dhcG+MNYejHd/ns40SfbjqhRYgWvsLp06xCZJHVDeT 1252580399
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 820745DC0;
	Thu, 10 Sep 2009 06:59:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090908 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <200909101218.06789.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128107>

Johan Herland venit, vidit, dixit 10.09.2009 12:18:
> On Thursday 10 September 2009, Michael J Gruber wrote:
>> Johannes Schindelin venit, vidit, dixit 10.09.2009 11:36:
>>> Often, it is quite interesting to inspect the branch tracked by a
>>> given branch.  This patch introduces a nice notation to get at the
>>> tracked branch: '<branch>@{tracked}' can be used to access that
>>> tracked branch.
>>>
>>> A special shortcut '@{tracked}' refers to the branch tracked by the
>>> current branch.
>>
>> Sorry, I didn't know the name of the long form was up for discussion.
>> But it should certainly coincide with the key which for-each-ref
>> uses, shouldn't it? I don't care whether tracked or upstream, but
>> for-each-ref's "upstream" has set the precedent.
> 
> ...and 'git branch --track' set an even earlier precedent...

an unfortunate one, yes. It brings us back to an old discussion. The
consensus was what's in the glossary:

       tracking branch
           A regular git branch that is used to follow changes from
another repository. A tracking branch should
           not contain direct modifications or have local commits made
to it. A tracking branch can usually be
           identified as the right-hand-side ref in a Pull: refspec.

I.e., a tracking branch is something under refs/remotes/ (usually; I'll
use that simplification).

If I checkout -b myworkonit refs/remotes/origin/theirstuff then
myworkonit *does not track* origin/theirstuff according to the glossary
(but git checkout says so, unfortunately, and the option is named
likewise); rather, it has origin/theirstuff as its upstream.

In fact, refs/remotes/origin/theirstuff tracks whatever the name is on
the left hand side of the correspondig fetch refspec.

Maybe this is a good time to either

- change the definition of "tracking branch" (to one having an upstream
which is in refs/remotes/; and call "remote upbranch" what's in
refs/remotes/) or
- rename the option and output of git checkout -b/git branch --track.

Accordingly, either tracked or something else (such as upstream) would
be appropriate for the for-each-ref key and the ref specifier.

Cheers,
Michael
