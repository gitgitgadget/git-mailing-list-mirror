From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] NO_PERL support
Date: Fri, 03 Apr 2009 13:20:11 -0700
Message-ID: <7vocvd8p6s.fsf@gitster.siamese.dyndns.org>
References: <20090403T065545Z@curie.orbis-terrarum.net>
 <7vljqhaemm.fsf@gitster.siamese.dyndns.org>
 <20090403171514.GA11112@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 03 22:21:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpptk-0002xK-4o
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 22:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759483AbZDCUUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 16:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759316AbZDCUUX
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 16:20:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55703 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759249AbZDCUUW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 16:20:22 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C3293C333;
	Fri,  3 Apr 2009 16:20:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 18A36C332; Fri, 
 3 Apr 2009 16:20:13 -0400 (EDT)
In-Reply-To: <20090403171514.GA11112@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 3 Apr 2009 13:15:14 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D91F1BDC-208C-11DE-BD23-781813508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115559>

Jeff King <peff@peff.net> writes:

> Do we want to also skip those? Do we want to place the burden on
> authors of the test suite to always check for NO_PERL whenever they use
> perl?
>
> The other option would be saying "we support building with NO_PERL, but
> not running the test suite".
>
> Thoughts?

Yes, no, and probably not.

Let me clarify the last "probably not" first, because it will be the
reason behind the first "Yes".

Saying "We support building but not testing" is like saying "we don't
support it", and honestly, we'd be better off leaving this patch out of
tree if that is what we are going to do.  Even though I am not personally
very enthused about NO_PERL, the Makefile patch itself does not look too
bad, and if we can finish this with very limited injury to the overall
codebase, I wouldn't mind carrying the option in-tree.

        Side note: by the way, what did you or Robin's patch do to
        Documentation/cmd-list.perl and other bits of build infrastructure
        that rely on Perl?

To solve the second "no" cleanly, I am wondering if we can do something
clever by defining $PERL to be used in t/t*.sh scripts.  They should be
using configured PERL_PATH for running the tests _anyway_, even though I
see many hits from "git grep -e perl t/" right now.

But even if there isn't a room for doing something clever there, I think
the test prerequisite framework J6t did recently should be usable without
cluttering the test suite too much.  That forces test authors to be aware
of NO_PERL, which is slightly yucky, but if it cannot be helped, I think
we can survive.  We do the same for UTF8 and SYMLINKS already.
