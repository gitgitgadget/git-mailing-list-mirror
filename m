From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log -p unexpected behaviour - security risk?
Date: Sun, 21 Apr 2013 11:42:13 -0700
Message-ID: <7vli8bu3ne.fsf@alter.siamese.dyndns.org>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
	<20130420140051.GB29454@ruderich.org>
	<7vd2towdiq.fsf@alter.siamese.dyndns.org>
	<CAHQ6N+pKb-44rOM7ocYMvSDyimvAGZppX1Gc=st59aVKzJSBKw@mail.gmail.com>
	<20130421102150.GJ10429@elie.Belkin>
	<CAHQ6N+rXE42NOyQPfLiDN8jYfL8w06hEE5MFLeFNxMR4ORD0aw@mail.gmail.com>
	<20130421160939.GA29341@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>,
	Simon Ruderich <simon@ruderich.org>,
	Git List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 20:42:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTzDR-0008Nl-OI
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 20:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950Ab3DUSmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 14:42:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49925 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753934Ab3DUSmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 14:42:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B79816B6B;
	Sun, 21 Apr 2013 18:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=px8GC+omnRIRGeDyzuHtSzz20TE=; b=xIk22M60UOldbusYE7L/
	BlGytqfvb5jhJIaLoR0N4yuCVoc9cPLfnQWrTOluXF68/eyo831XBTcMtjZ7Fa2h
	TpNmhm360M32qKAlXX7dm82ykxYSQpAxgLFJtcv6OeJ47nCNepYk9gLEx7tvc5Et
	oCDc7sz7uYQOKU/pcq04pxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=oFpxV1rhFGb9buhZa/FrJ9dnfFqrO3eRF7Jaiu3PRppLJ6
	Wvf45a+kkUzw9UQRFwRU+VhzqP9XRNo728sux+I7/byav/UTAXHqIrWeQL7dvPmv
	5QsuYVSQrX+3csSh4SutAz3tBwlBX2fwM/YFPiCHjl/gRWGEhQoqV6ocy0z5Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EBAB16B6A;
	Sun, 21 Apr 2013 18:42:15 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A217316B66;
	Sun, 21 Apr 2013 18:42:14 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F77A526-AAB3-11E2-B3E1-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221961>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The thing is, I'm not convinced this is a bad default.  "Shows no diff
> at all for merges" is easy for a person to understand.  It is much
> easier to understand its limitations than -c and --cc.

Making "log -p -m" a default before -c/--cc was introduced would
have been the stupidest thing to do, as it would make the command
mostly useless.  Nobody would want to see repetitious output from a
merge that he would eventually get when the traversal drills down to
individual commits on the merged side branch.

When I added -c/--cc, I contemplated making -p imply --cc, but
decided against it primarily because it is a change in traditional
behaviour, and it is easy for users to say --cc instead of -p from
the command line.

On the other hand, "show" was a newer command and it was easy to
turn its default to --cc without having to worry too much about
existing users.

> For that
> reason, it is a much *better* default for security than --cc or -c
> (even though I believe one of the latter would be a better default for
> convenience).

Yes.  I do not fundamentally oppose to the idea of "log -p" to imply
"log --cc" when "-m" is not given ("log -p -m" is specifically
declining the combined diff simplification).  It may be a usability
improvement.

But "--cc/-c" does not have anything to do with Tapsell's "security
worries".  The only real audit he can do is with "log -m -p",
possibly with --first-parent (only if he trusts his first-parent
history).

The "recreate mechanical merge and compare recorded merge against
it" mode may highlight a malicious merger, but it will not show a
cleanly merged hunk of malicious code in the merge, so it cannot be
used with --first-parent when used as a "security audit tool".
Tapsell still needs to drill down to the merged side branch that
introduced the malicious change that merged cleanly with "-p".
