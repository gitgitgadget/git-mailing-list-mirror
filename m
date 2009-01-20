From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH,v4] git-checkout(1): mention fate of extraneous files
Date: Mon, 19 Jan 2009 19:35:35 -0800
Message-ID: <7vy6x6odiw.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901200040550.3586@pacific.mpi-cbg.de>
 <878wp6voar.fsf_-_@jidanni.org>
 <alpine.DEB.1.00.0901200110410.3586@pacific.mpi-cbg.de>
 <200901191854.58029.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	jidanni@jidanni.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 04:37:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP7QN-0000QL-6H
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 04:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094AbZATDfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 22:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbZATDfq
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 22:35:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695AbZATDfp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 22:35:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F3EB31CD6F;
	Mon, 19 Jan 2009 22:35:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E356D1CD70; Mon,
 19 Jan 2009 22:35:37 -0500 (EST)
In-Reply-To: <200901191854.58029.bss@iguanasuicide.net> (Boyd Stephen Smith,
 Jr.'s message of "Mon, 19 Jan 2009 18:54:53 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6AFAB4CC-E6A3-11DD-9DF9-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106429>

"Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:

> I think some users will expect to get a clean checkout when simply 
> doing "git checkout <branch>".  It would be nice for the documentation 
> mention that is not the case, and reference the tool that helps get the 
> tree into that state.  Just my opinion, though.
>
> It seems natural to me for this to be mentioned in the 'git checkout' 
> documentation.  Perhaps there's a better place?

I think this is probably on the other side of the borderline.

First I was about to agree with you, but the more I think about it, I do
not think it is natural at all to expect "checkout" to behave as if you
did "rm -fr" everything and then "tar xf" over the void.  What other SCM
implements branch switching that way, and what workflow would such a
behaviour help?

We need to draw a line somewhere to avoid cluttering the documentation too
much, and I do not think this is something even a person with CVS
braindamage would get confused about, which is where I think is a
reasonable place to draw that line.

Having said all that, I share a desire to help people who do not have any
prior experience nor knowledge to form a reasonable expectation out of the
system.

For example, a person who does not have a clue on what version control
system is about may think that the contents recorded in a branch is like a
tarball, a version control system is not about helping you make changes
but its _sole_ purpose is to extract one such tarball after another on
demand to let you travel in time.  Running an equivalent of "git clean"
automatically upon checkout may feel as if it is a valid a convenience
feature to deal with files that was in one tarball but not in the new one.
It is not completely implausible that such a person may be confused upon
learning that "checkout" leaves untracked paths intact.  If you start from
a flawed understanding of what problem the system helps you to solve, you
end up with flawed expectations.

It would not help him if you only taught that checkout leaves untracked
paths intact.  You have instead to teach him why you may have, and you
would want to keep, untracked paths in the work tree (i.e. they are build
products and notes you take while developing, iow, files that are
essential during your work, but does not belong to the end product, and
you would want to keep them around even while switching branches because
you may be growing both branches at the same time), and that it is one of
the prime design concern to _any_ command in git not to lose them without
being told.  When a user lacks such a basic understanding of the system,
what it was designed for and what it was designed to do, the user's
expectation will never match what many parts of the system do.  The user
will stay confused.

I've always thought such basic concepts should be covered by the tutorial
and the users are expected to read them before reading about individual
commands, but that approach may not work in practice.  Perhaps a separate
section "Basic Understanding" at the end of each manual page of the
command to cover minimum necessary basics to understand the command might
help.  The section may quote from the tutorial, or written afresh.

But I think that such a basic description should be in a separate section
so that it does not clutter the main text for people who understand the
basics.  Also I fear there will be quite a lot of repetition (e.g. you may
have to repeat that untracked files are unintersting and that is why the
command does not say anything about them in manual pages for "diff",
"grep", "checkout", etc.).  Once it is understood, the user does not need
it to be repeated, but if we want to let the user freely start reading
from anywhere, the repetition cannot be avoided.
