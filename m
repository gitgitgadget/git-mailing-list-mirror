From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git-mergetool: show original branch names when possible
Date: Mon, 20 Aug 2007 01:28:31 -0700
Message-ID: <7vabsmtxsg.fsf@gitster.siamese.dyndns.org>
References: <20070820075318.GA12478@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 20 10:28:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN2ct-0006uB-DH
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 10:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533AbXHTI2k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 04:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755717AbXHTI2k
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 04:28:40 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:55252 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401AbXHTI2j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 04:28:39 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 96A04124B8D;
	Mon, 20 Aug 2007 04:28:57 -0400 (EDT)
In-Reply-To: <20070820075318.GA12478@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 20 Aug 2007 03:53:18 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56190>

Jeff King <peff@peff.net> writes:

> 1. Is it OK to place the extra branch name information in MERGE_HEAD
> after the SHA1?

I do not think of anything that would barf offhand (we already
do that in FETCH_HEAD), but this would definitely be carefully
audited.

> 2. It looks like doing an anonymous 'git-pull' leaves GITHEAD_* as the
> commit sha1, which means you will end up with that sha1 rather than
> 'REMOTE', which is less nice than the current behavior.

Much less nice indeed.

> It would be _really_ convenient in this case if we had a "git is in the
> middle of something" file, which has been discussed before.
> ...
> there are some operations that persist across multiple command
> invocations, and it would be nice rather than every command knowing
> about every other command's implementation patterns ("Oh, you have a
> .dotest file? You must be in the middle of...") to have a single place
> with something like:
>
>   $ cat .git/STATE
>   operation: merge
>   remote: git://git.kernel.org/pub/scm/git/git.git
>   branch: master
>   branch: octopus

It would be very nice, and I would encourage any wannabe
Porcelain writers to go wild on this.  One worry I have is if we
would need to support nested states.  "I was in the middle of
'foo' and then had to go sideways to do 'bar' which I am now in
the middle of" kind of thing.
