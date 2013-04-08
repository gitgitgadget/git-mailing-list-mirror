From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] transport-helper: check if remote helper is alive
Date: Mon, 08 Apr 2013 10:43:31 -0700
Message-ID: <7vtxngyl30.fsf@alter.siamese.dyndns.org>
References: <1365320706-13539-1-git-send-email-felipe.contreras@gmail.com>
 <1365320706-13539-3-git-send-email-felipe.contreras@gmail.com>
 <20130408005155.GA24030@sigill.intra.peff.net>
 <CAMP44s0PYARrCQxyBOiGzCAKTXqGp5yrKyfVwLjE1CyuxVSU2A@mail.gmail.com>
 <20130408023351.GA32558@sigill.intra.peff.net>
 <CAMP44s1cphJ5wojt2OeZjWJVOi5AMQJR2jN_BCkQw0B0BxpUfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 19:43:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPG6a-0000FE-FX
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935146Ab3DHRnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:43:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39669 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935135Ab3DHRne (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:43:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93E0C13636;
	Mon,  8 Apr 2013 17:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ju1HJAzEeg34I2GBElPbb+H50Ew=; b=exK/1N
	i/a402LIuDFskLiIPZWZ2p6oHMIQz2MRcgDr/fpkcEm8kUldui3eTHBH9QNQ/5BG
	Y4PTOR8gJr0BYzfYYaDK8XU0X//YdlRiZTByjpEP7a0XkbkSDfCZXTz26hbjleSW
	QpiR1Erqi6qe2Vhmwvi2Qoa0mgVD1VGQk6hl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bktAd7EG749innynt4bHDFCHd5iIF4FC
	jsb52P8pafe+Jjh8UenAxn1l2zAnezG4FyCN8Wkd3NbYnT1VgBsUww10WYz6OENJ
	+lv7+gNJ5ogfSv8viSyUnLP7tENivNaF0SwueJXaTfJcvQ27j0U+xIzB3N1n+U6g
	XIuP1GXEB+4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 887D813634;
	Mon,  8 Apr 2013 17:43:33 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9364B13631; Mon,  8 Apr
 2013 17:43:32 +0000 (UTC)
In-Reply-To: <CAMP44s1cphJ5wojt2OeZjWJVOi5AMQJR2jN_BCkQw0B0BxpUfA@mail.gmail.com> (Felipe
 Contreras's message of "Mon, 8 Apr 2013 09:38:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D4D67974-A073-11E2-BFBC-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220473>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sun, Apr 7, 2013 at 9:33 PM, Jeff King <peff@peff.net> wrote:
>> On Sun, Apr 07, 2013 at 09:03:25PM -0500, Felipe Contreras wrote:
>
>>> And you think that is desirable? User-friendly?
>>
>> No, as you probably realized if you read the rest of my email. My point
>> in bringing it up was to try to explain exactly what is going on in each
>> case. Your commit message provided zero explanation of what the current
>> problem is, nor why your fix is the right thing to do.
>
> I have explained this many times, I wonder why when the patch is close
> to be merged does this become important, and not before.

There are at least a few reasons I can think of off the top of my
head.

Reviewers have limited time allocated for each individual topic.  To
an original patch with say 3 problems, the review may only point out
issues in 2 and suggest a concrete improvement for only 1 and that
is sufficient to suggest a reroll.  That is not being unhelpful by
deliberately withholding 1 and half reviews in the initial round.

Reviewers will see the same patch with fresh eyes after 6 months and
will notice different issues. That is not being unhelpful by
deliberately withholding a crucial point in the initial round of the
review.

I would not be surprised if one ends up repeating oneself in
multiple review threads; the log message of a rerolled patch is a
better place to avoid the need for the repetition.

>>> That's a comprehensive essay, unfortunately, it's not correct. The
>>> exit status of the remote-helper is not important, it's the one of
>>> fast-import that we really care about.
>>
>> Nowhere does it say that we should not check fast-import's exit value,
>> and indeed, the patch does not replace that check at all. It comes
>> immediately after. It replaces the WNOHANG check of the helper's exit
>> code (i.e., check_command) with a synchronous check.
>
> Yeah, and in the process it's changing the design of transport-helper,
> where the pipes are closed only at the very end.

I agree that the disconnection here closes the pipes a lot earlier
than we used to.  But I am not sure what the practical consequences
of doing so are.  We know the fast-import process has successfully
read everything from the helper (we called finish_command() on it).
We expect at this point the helper is still running or successfully
exited (the other alternative, the helper died with non-zero status,
is an error check_command() patch wanted to detect).  But if we keep
helper running, who will be communicating with it via these open
pipes?  The process that is calling finish_command() on fast-import
and disconnecting from the helper won't be, as read/write to the
pipe, even if we do not disconnect from here, will result in errors
if the helper has already exited at this point.

What I am trying to get at is if "changing the design", which I
agree is a change, is an improvement, or a backward incompatible
possible breakage.
