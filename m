From: Junio C Hamano <gitster@pobox.com>
Subject: Re: jc/shortstatus
Date: Sat, 15 Aug 2009 01:18:28 -0700
Message-ID: <7v8whltrqj.fsf@alter.siamese.dyndns.org>
References: <7vtz0co3xe.fsf@alter.siamese.dyndns.org>
 <20090815070904.GA23389@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 15 10:22:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McEX7-0004Zj-3L
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 10:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbZHOISd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 04:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbZHOISd
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 04:18:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbZHOISb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 04:18:31 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 68EE5B0A2;
	Sat, 15 Aug 2009 04:18:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4EECB0A1; Sat, 15 Aug
 2009 04:18:29 -0400 (EDT)
In-Reply-To: <20090815070904.GA23389@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 15 Aug 2009 03\:09\:04 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 38764EFC-8974-11DE-A0F9-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125984>

Jeff King <peff@peff.net> writes:

> For the "git stat" portion still in pu, I have a few comments/questions:
>
>   1. Is "stat" a good name? I worry a little that it is _too_ similar to
>      "status", and that will cause confusion while they both exist. So
>      something like "git overview" would cause less confusion, and even
>      though it sucks to type, it will eventually replace "status" (and
>      in the meantime people can make aliases or whatever).

It is handy to have both available while asking others help debugging the
version in 'pu', and that is the only reason for the separate command.  It
could have been named 'git frotz' for all I care ;-)

I do not intend to make it another "git merge-recur"; I would actually
want to have it replace "status" before the series goes to 'next'.

I hopefully will have some time to start doing that over the weekend; the
first step would be to rename the branch to jc/1.7.0-status and get rid of
cmd_status() from builtin-commit.c.

A few points I haven't managed to think about, decide, nor test, are:

 - What should its exit code be?  Should it be consistent with the
   traditional "git status" at least when no paths are given, signallying
   failure when nothing is staged for committing, so that ancient out of
   tree scripts people may have written would not break too badly when we
   make the switch?

 - What should its default mode of output be?  Do people prefer "svn st"
   style short-format output, or should we stay verbose and explanatory?

 - Is it handling corner cases correctly?  e.g. Does it operate correctly
   when run from a subdirectory?  How should it handle submodules?  Before
   the initial commit?  Use of colors?

>   2. Does it really belong in builtin-commit.c anymore? It seems like
>      historical accident that "status" is so closely tied to commit. The
>      whole point of the new command is to _not_ be tied; I think of the
>      new command more as an extension of 'diff'. Admittedly, users don't
>      care where the source is located, but it helps the developers
>      understand the relationships between code.

It would make sense to create a separate builtin-status.c.  I haven't
looked at the dependencies yet, but it shouldn't be too bad.  We'll see.

>   3. Can you squash in the gitignore patch below? :)

Yes but hopefully it won't be necessary ;-)
