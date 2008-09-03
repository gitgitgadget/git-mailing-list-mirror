From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Wed, 03 Sep 2008 12:36:05 -0700
Message-ID: <7vljy9auoq.fsf@gitster.siamese.dyndns.org>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl>
 <200809022339.20123.johan@herland.net>
 <20080902214428.GA20355@sigill.intra.peff.net>
 <200809030945.08619.johan@herland.net>
 <20080903131507.GC12936@coredump.intra.peff.net>
 <20080903133446.GA6967@coredump.intra.peff.net>
 <alpine.LNX.1.00.0809031234560.19665@iabervon.org>
 <20080903180726.GA16454@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>,
	Pieter de Bie <pdebie@ai.rug.nl>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 21:37:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KayAO-0004Td-6l
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 21:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbYICTgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 15:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752169AbYICTgR
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 15:36:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47082 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbYICTgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 15:36:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 745955A9C1;
	Wed,  3 Sep 2008 15:36:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5EB075A9BE; Wed,  3 Sep 2008 15:36:08 -0400 (EDT)
In-Reply-To: <20080903180726.GA16454@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 3 Sep 2008 14:07:26 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9299275A-79EF-11DD-8336-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94843>

Jeff King <peff@peff.net> writes:

> On Wed, Sep 03, 2008 at 12:49:43PM -0400, Daniel Barkalow wrote:
>
>> Good point. I think I confused myself with the new branch case. On the 
>> other hand, I think the "not starting a new branch" case should go as 
>> well. If you've got a detached HEAD, and you do:
>> 
>> $ git checkout -b foo origin/master
>> 
>> we probably ought to describe the old state. The reason that starting a 
>> new branch usually shouldn't give the message is that new->commit == 
>> old.commit (assuming that the defaults have gotten filled in by this 
>> point, which they should have).
>
> Right, I was thinking it was necessary for the starting a new branch
> case, but a better test is checking whether the commits are the same.
>
> So based on what you said and thinking a bit, I came up with:
>
>     if (!opts->quiet && !old.path && new->commit != old.commit)
>
> and then I had the brilliant idea of checking what git-checkout.sh did.
> And sure enough:
>
>     elif test -z "$oldbranch" && test "$new" != "$old"
>     then
>             describe_detached_head 'Previous HEAD position was' "$old"
>     fi
>
> Patch is below.

It was a good idea to keep the scripted ones in contrib/examples so that
they are readily accessible to find out what we used to do ;-).

Thanks.  Will apply to 'maint'.
