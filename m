From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Friendly refspecs
Date: Tue, 22 Apr 2008 22:52:06 -0700
Message-ID: <7v1w4xuni1.fsf@gitster.siamese.dyndns.org>
References: <20080409222500.GB19248@mithlond>
 <20080409225112.GB12103@sigill.intra.peff.net>
 <20080413093102.GC12107@mithlond.arda.local>
 <20080416034823.GA11727@sigill.intra.peff.net>
 <alpine.LNX.1.00.0804161126280.19665@iabervon.org>
 <7vod89pnxx.fsf@gitster.siamese.dyndns.org>
 <20080422105658.GA11238@sigill.intra.peff.net>
 <7v63u9zva9.fsf@gitster.siamese.dyndns.org>
 <20080422200550.GB29313@sigill.intra.peff.net>
 <7vd4ohy5ym.fsf@gitster.siamese.dyndns.org>
 <20080423042433.GA3291@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Apr 23 07:53:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoXuq-0004cm-6S
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 07:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760043AbYDWFwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 01:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761996AbYDWFwZ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 01:52:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38267 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761897AbYDWFwX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 01:52:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E84751AC9;
	Wed, 23 Apr 2008 01:52:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CF4A11AC0; Wed, 23 Apr 2008 01:52:13 -0400 (EDT)
In-Reply-To: <20080423042433.GA3291@mithlond.arda.local> (Teemu Likonen's
 message of "Wed, 23 Apr 2008 07:24:33 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80188>

Teemu Likonen <tlikonen@iki.fi> writes:

> Junio C Hamano wrote (2008-04-22 13:45 -0700):
>
>> I thought the original poster's example was
>> 
>> 	git push $there $commit:branch2
>> 
>> where $commit happened to be "branch1".  Would we dwim
>> 
>> 	git push $there branch1~4:this_is_known_ok
>> 
>> to refs/heads/?
>
> I guess this is what I meant. My original question was about
> inconsistent user interface: "git push $there branch1" creates branch1
> on the remote side (if it does not exist) but "git push $there
> branch1:branch2" gives an error if branch2 does not exist
> (branch1:refs/heads/branch2 is required).
>
> The case has become much more complicated since, so I just speak aloud
> my hope that need for refs/ paths in common situations would be reduced
> to minimum.

I think everybody involved in this discussion understands _that_.  The
issue is that you would not have said "branch2" in real life, but used
some word that is _not_ "branch" to name the thing, and there is no way
for git to guess correctly if you meant to create a branch or a
light-weight tag.

There is no inconsistency.  "push $branch1" has a special case logic to
favor "the same name".  You invoked "src:dst" syntax that is general
purpose which does not dwim.

Historically we did not favor one way or another for the general purpose
syntax.  I think Jeff's proposed heuristics to favor branch if a branch
tip is pushed and tag if a tag is pushed makes sense.
