From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bisect do not work when good reversion is newer than bad
 reversion
Date: Wed, 19 Nov 2008 05:00:35 -0800
Message-ID: <7vljvfswek.fsf@gitster.siamese.dyndns.org>
References: <6077B97E85E7374DAE87B42B5AA997970D0B12@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Cai, Crane" <Crane.Cai@amd.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 14:02:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2mh9-0003Yv-2K
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 14:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbYKSNA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 08:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752924AbYKSNAz
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 08:00:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52205 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbYKSNAz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 08:00:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E470F170B3;
	Wed, 19 Nov 2008 08:00:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8EBEC170A8; Wed,
 19 Nov 2008 08:00:37 -0500 (EST)
In-Reply-To: <6077B97E85E7374DAE87B42B5AA997970D0B12@sshaexmb1.amd.com>
 (Crane Cai's message of "Wed, 19 Nov 2008 13:20:13 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 19440BB8-B63A-11DD-BE33-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101336>

"Cai, Crane" <Crane.Cai@amd.com> writes:

> Hi Junio,
>
> Sorry to disturb you. Here the requirement I met can not find answer
> from website. That's why I directly ask you.
>
> I need to use "git bisect" to find what patch can fix a problem.
> I found v2.6.25 has this problem.
> And v2.6.26 does NOT has this problem.
>
> Then I use bisect as this:
>
> #git bisect start
> #git bisect good v2.6.26
> #git bisect bad v2.6.25
>
> No reversion cut via these steps. Do you know whether git command can
> achieve this requirement or not?

You can use "git bisect" to find a single change that fixed the issue
(_provided if_ such a single change exists).  There is a small mental
trick you need to exercise.

First, realize that bisect is about "it used to be like this, but later it
turned into that.  Where did that single transition from this to that
happened"?  Usually, "this" is "had this particular bug and was broken"
and "that" is "that bug was fixed and things work smoothly".  In your
case, however, "this" is "broken" and "that" is "fixed".  IOW, the
question you ask "bisect" is "it used to be broken but later it was fixed;
where did that exactly happen?".

The mental trick is to swap "good" and "bad" in order to adjust to your
use, because you are using bisect in a reverse way from the usual.  Usual
case uses "good" mark "this" while "bad" is used to mark "that" in the
sentence "it used to be like this, but later it turned into that".

So what you would do is...

	(1) First of all, write on a piece of paper:

	    good - the version _STILL_ has the bug.
            bad  - the version does not have the bug _ANYMORE_

	(2) Start with "git bisect v2.6.25 v2.6.26";

        (3) As you test each revision, look at the memo you made.  Say
            "good" if it still has the bug you are interested in; say
            "bad" if it does not have the bug anymore..

    cf. http://thread.gmane.org/gmane.comp.version-control.git/86063

By the way, I usually drop requests-for-help on the floor unless it is
CC'ed to the mailing list, because my time spent on writing the response
like this message will be wasted and wouldn't help the git community at
all.  I simply do not have enough time to give unpaid support for
individuals.  I am making exception this time only because I am waiting
for something and I happen to have nothing else to do while doing so.

Please send this kind of request-for-help to <git@vger.kernel.org>, the
main mailing list, to which anybody can send messages without subscribing.
