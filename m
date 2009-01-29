From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] symbolic ref: refuse non-ref targets in HEAD
Date: Wed, 28 Jan 2009 23:53:20 -0800
Message-ID: <7vljsuh7kf.fsf@gitster.siamese.dyndns.org>
References: <20090129045205.GA31183@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 29 08:54:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSRjg-0001y0-8F
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 08:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbZA2Hx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 02:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbZA2Hx1
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 02:53:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbZA2Hx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 02:53:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C769B2A053;
	Thu, 29 Jan 2009 02:53:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0A59F2A03B; Thu,
 29 Jan 2009 02:53:21 -0500 (EST)
In-Reply-To: <20090129045205.GA31183@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 28 Jan 2009 23:52:05 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E80BB730-EDD9-11DD-8D61-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107640>

Jeff King <peff@peff.net> writes:

> I know that using symbolic-ref manually is rare, but both I and the
> original poster have been bitten by this (and figuring out what is going
> on and fixing it is quite painful). But most importantly, I don't think
> this can possibly hurt anyone trying to use this legitimately, since the
> exact thing it is protecting against corrupts your repo. :)

I generally do not like adding artificial limitation to plumbing like this
patch does, because the end user making silly mistake using plumbing is a
sign that there was something lacking in the Porcelain.

But for this particular case, I do not think any future usage of
symbolic-ref plubming will get inconvenienced with the change.  I would
even suggest making the check tighter to insist on refs/heads/ (not just
refs/) and tighten validate_headref() in path.c to match.

> Please beware that running the test script on the current "master" will
> actually hose your git repo (test 3 kills the trash directory's
> .git/HEAD, which means test 4 thinks your parent .git/ is its current
> repo). Maybe it makes sense to do a precautionary reset in between.

In addition, perhaps it may make sense to use test_create_repo to go one
level deeper before starting to play around, so that trash directory's
repository will prevent you from going any further up.
