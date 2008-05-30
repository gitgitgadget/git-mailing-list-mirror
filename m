From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merging strategy for extending Git.pm
Date: Fri, 30 May 2008 16:20:31 -0700
Message-ID: <7vabi7gz0g.fsf@gitster.siamese.dyndns.org>
References: <1212122585-7350-1-git-send-email-LeWiemann@gmail.com>
 <483FA6B3.4070607@gmail.com> <20080530095938.GE18781@machine.or.cz>
 <48401A09.6060301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 31 01:21:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Duf-0001eI-5W
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 01:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbYE3XUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 19:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753587AbYE3XUk
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 19:20:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089AbYE3XUj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 19:20:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7874F3957;
	Fri, 30 May 2008 19:20:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 75E173956; Fri, 30 May 2008 19:20:34 -0400 (EDT)
In-Reply-To: <48401A09.6060301@gmail.com> (Lea Wiemann's message of "Fri, 30
 May 2008 17:15:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0386912E-2E9F-11DD-897C-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83357>

Lea Wiemann <lewiemann@gmail.com> writes:

> 1. I'm working full-time on this, so I might produce patches that
> loosely depend on one another at a peak rate of 2-3 per day.  (I can
> do other project-related stuff while my patches are waiting for
> review, but only so much of course.)  Do you have any experience with
> working with full-time developers on Git?  Do you see problems with my
> potentially high patch frequency?

As long as experienced people on the list review patches, I do not see a
problem.

    There seems to be a misconception (not you particularly but some parts
    of the list audience in general) that a review cycle of a patch sent
    to the list is a dialog between the submitter and me.  It is _NOT_.
    If it has rooms for improvements, other people would help you polish
    it, which happens often.  However, if it is very well done, I'd also
    like other people to say so after reviewing more often.

> 2. I'll be changing my own API.  In other words, the API is really
> unstable while I work on this (with the only user of the API being
> Gitweb, which I'll update as I go).  Is that OK for the pu branch?

It does not _have_ to even land on 'pu'.  Sending the patches to the list,
asking interesting parties to look at them, _and_ having people actually
review them is more valuable part.

If your series will become big, I do not mind (re)merging it from time to
time in 'pu' to give it a wider exposure.  If you want to go this route,
you would have a publicly fetchable repository of your own to house your
changes (repo.or.cz?).

I do not even mind merging the branch to 'next' if the series is 'next'
worthy, but that places heavier responsibility on your part to keep the
history of that branch clean.

> 3. I try to be careful with my commits, but it might still cause more
> work for whoever reviews my patches, compared to reviewing larger
> chunks.  (That's because some of the stuff I write might end up being
> deleted or rewritten later.)

One thing you could do, when sending out [PATCH v$n] for the value of $n
greater than 1, is to mention what the improvements are since the previous
round in the message (typically after the three-dash separator).  This
helps reviewers who have already seen your previous iteration.  The full
rationale of the change needs to be kept in the proposed commit log
message.

For example, your first patch may look like this:

	Subject: [PATCH] Git.pm: Add rev_parse() sub

	This adds a rev_parse() sub to return the 40-byte object name
        from given "extended SHA-1" expression.

	Signed-off-by: A U Thor <au.thor@example.com>
	---
         <<diffstat and patch>>


Then after Pasky and others suggest improvements, your second message will
appear on the list:

	Subject: [PATCH v2] Git.pm: Add parse_rev()

	This adds 'parse_rev()' sub to return the 40-byte object name from
        given "extended SHA-1" expression.  It returns undef if the given
        string is malformed.

	Signed-off-by: A U Thor <au.thor@example.com>
	---

         Changes relative to v1 are:
         
         * Fixed indentation;
         * Use -q to squelch non-fatal errors so that they do not leak
           to the STDERR;
         * Improved in-code documentation.

	 <<diffstat and patch>>

Some people also sends an interdiff between v$n-1 and v$n as a separate
message, and it helps reviewing when the change is big.
