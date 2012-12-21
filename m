From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: [RFC/FR] Should "git checkout (-B|-b) branch
 master...branch" work?
Date: Fri, 21 Dec 2012 09:12:44 -0800
Message-ID: <7vr4mj1g8j.fsf@alter.siamese.dyndns.org>
References: <7v8v8r2y8s.fsf@alter.siamese.dyndns.org>
 <CANiSa6jP_JN+DpDgYpWA9Aky9REJvFq3aR3Yj0vF3+axWvtmsw@mail.gmail.com>
 <CANiSa6ibS7ORY=QMS3WQzXYJQQH4ZYvPO75qgLgv-oWGMSBBrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 18:13:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm69n-0002c7-5K
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 18:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694Ab2LURMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 12:12:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293Ab2LURMw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 12:12:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CD7BAABA;
	Fri, 21 Dec 2012 12:12:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fAFKHLH0J4bDIZ6BpKqJxI6vH1E=; b=ucHl9c
	jMqTkZbBtV+dNAGQNYwvOK4l0XH65H6CR7eIAsc/kKXS9qlvOBnSkdYTgE8IA6ox
	qOSoUmips9wUhVYr9rRuEFYsvlzp8U0uG+x4HQ+PdeTBdvPCzaVWu4Ha3c8N+/WR
	4p8D66nNtjUe1pZfsg3zlXqH9P1T2Q1VJf2kk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OhhA1wXpJWDaSB6/7PaoT0aBW4k6leM1
	zIzL3M/CfAEBw16Sa1EPczUbaZ73S7PInFIP11I8eht9tPyXXvEG5x6Fl1MNED2s
	UMrmtPi7+gIMWPTqF76RdyDkNQ4agtu41TzOqHdTi3v6/aOdm7ERCKRT1xHGnXlb
	uFU8gzHE6vo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08357AAB9;
	Fri, 21 Dec 2012 12:12:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 852E3AAB7; Fri, 21 Dec 2012
 12:12:50 -0500 (EST)
In-Reply-To: <CANiSa6ibS7ORY=QMS3WQzXYJQQH4ZYvPO75qgLgv-oWGMSBBrw@mail.gmail.com> (Martin
 von Zweigbergk's message of "Fri, 21 Dec 2012 08:55:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6377708-4B91-11E2-93F5-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211989>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> I keep forgetting what "git diff A..B" does.

"diff" is always about two endpoints, not the path that connects
these two endpoints (aka "range"), and when you want to "diff"
between two commits, you say "diff A B".  "A..B" happens to be
accepted as such only by accident (e.g. the old command line parser
did not have a reliable way to tell "^A B" and "A..B" apart), not by
design.

    side note: incidentally, now we have rev_cmdline_info support,
    we could start deprecating "diff A..B" syntax.

The special case "git checkout master...branch" is not about
specifying a range.  The command knows it wants a single point (not
two endpoints, nor a range), and A...B as a notation to specify a
single point is $(merge-base A B).

> I would have much preferred if
> it was possible to make the revision parser generally interpret e.g.
> "A.^.B" as "the merge base of A and B" (failing if not exactly one).

Actually, in many places where the command line parser knows it
wants a single point, and never a range, we should be able to apply
the "A...B as a notation to specify a single point" rule.  

Of course you could come up with a symbol other than "..." for that
purpose, and migrate the current "git checkout A...B" special case
to use that other symbol, but that would be more work and also you
would need to retrain existing users.
