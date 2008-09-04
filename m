From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Wed, 03 Sep 2008 22:31:19 -0700
Message-ID: <7vbpz479zs.fsf@gitster.siamese.dyndns.org>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl>
 <7vk5dujn9h.fsf@gitster.siamese.dyndns.org>
 <20080902210524.GB7757@leksak.fem-net> <200809022339.20123.johan@herland.net>
 <alpine.LFD.1.10.0809021849390.23787@xanadu.home>
 <32541b130809032150i418014bdo8a838f529e109f50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Stephan Beyer" <s-beyer@gmx.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Pieter de Bie" <pdebie@ai.rug.nl>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 07:33:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb7SS-0001Tx-BQ
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 07:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbYIDFbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 01:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbYIDFbe
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 01:31:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55538 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbYIDFbd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 01:31:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6EC6A73280;
	Thu,  4 Sep 2008 01:31:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 463097327F; Thu,  4 Sep 2008 01:31:21 -0400 (EDT)
In-Reply-To: <32541b130809032150i418014bdo8a838f529e109f50@mail.gmail.com>
 (Avery Pennarun's message of "Thu, 4 Sep 2008 00:50:18 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BB936C62-7A42-11DD-A925-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94895>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> Why do people (including me) spend so much time with a detached HEAD?
> I think it happens mainly for the following reasons:
>
> 1) Checking out a remote branch "git checkout origin/master" detaches
> my HEAD, which is kind of bad, since it's such a common thing to want
> to do.

I do not think it is bad at all.  The feature to detach HEAD was designed
for that kind of usage.  Start sightseeing, possibly futz with the code,
and even create some snapshot commits, and then:

 * if it starts to take a usable shape, say "git checkout -b my-topic",
   from there, to give your exploration a lasting home; or
   
 * if it doesn't pan out, just discard it with "git checkout -f master"
   (or whatever you wanted to switch back to).

One thing that might help for downstream people would be to be able to say
"I am making 'my-topic' branch out of a detached HEAD, but it really is
meant to be a fork of origin/master that I detached my HEAD from, so
please set up tracking for that one".

You could force people to say "git checkout -b my-topic origin/master"
from the beginning, but that is very unreasonable and unworkable.  When
you are exploring, you more often than not do not know where your quest
would lead to until spending some time.  It is quite important to be able
to delay the decision to create a local branch to keep what you did, and
(more importantly) to be able to delay deciding what to name that topic.

Perhaps "git checkout -b my-topic" from a detached HEAD should inspect the
HEAD reflog to see which remote (or local) branch you came from, and give
that to the --track logic.

> 2) git-rebase and git-am detach the HEAD while they work.  I think
> this is fine, but: you shouldn't be able to *reattach* the HEAD
> without first aborting the rebase or am operations....

PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ ' would help here.

I do not have an objection to the general idea of forbidding people from
switching branches out of detached HEAD while sequencer is in effect as a
safety measure, but I didn't think through possible negative implications.

> The remaining situations where someone is working on a detached HEAD
> (eg. checking out a particular commit, or actually implementing
> git-rebase like operations) seem to be pretty obviously *intentional*,
> and in that case, git should stay out of their way and let them do
> what they're doing.

Absolutely.  Being able to explore, without having to first decide what
you are going to work on or what to name that branch, is a wonderful
feature.  It really lowers the barrier to explore.
