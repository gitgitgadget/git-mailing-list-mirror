From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFD] builtin-revert.c: release index lock when
 cherry-picking an empty commit
Date: Sun, 22 Mar 2009 14:58:35 -0700
Message-ID: <7veiwpdxtg.fsf@gitster.siamese.dyndns.org>
References: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com>
 <20090308144240.GA30794@coredump.intra.peff.net>
 <7v8wnflrws.fsf@gitster.siamese.dyndns.org>
 <20090310181730.GD26351@sigill.intra.peff.net>
 <AA6A171F-70CE-4CB3-9AE1-27CD69C3202C@pobox.com>
 <20090311003022.GA22273@coredump.intra.peff.net>
 <e2b179460903110408i4ab3c9cg3c863b89a2f57cba@mail.gmail.com>
 <20090322094139.GA10599@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 22 23:00:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlVie-0002AY-H4
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 23:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789AbZCVV6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 17:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755320AbZCVV6p
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 17:58:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305AbZCVV6p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 17:58:45 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0CF4789C4;
	Sun, 22 Mar 2009 17:58:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5C1F589C0; Sun,
 22 Mar 2009 17:58:37 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9B5FBDF6-172C-11DE-A69D-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114182>

Jeff King <peff@peff.net> writes:

> [this is a follow-up on the "eval 'false\n\n'" returns 0 issue on
> FreeBSD]

Thanks for keeping track of this one.

> Thanks for looking this up, Mike. It sounds like FreeBSD is probably the
> only problematic one. I confirmed that the problem still exists in
> FreeBSD 7.1, and I've mailed the git ports maintainer off-list to
> make him aware of the issue. So we'll see what happens.
>
> Junio, do you want to put anything in the release notes warning people
> who build from source that this is a potential issue? Do you want
> something in the Makefile detecting that the shell is broken?

A sentence or two in INSTALL will not hurt.

I would not worry too much about the test scripts, but I would worry more
about getting phantom bug reports for our shell script Porcelains that get
hit by this.  Earlier I mentioned bisect is the only heavy user, but the
issue is more severe with filter-branch that is designed to eval end user
scripts (calls to 'eval "$filter_frotz"' check the exit status and die on
failure---with trailing blank lines the failure the filter reports will
not get caught).
