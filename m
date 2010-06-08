From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: Making submodules "track" branches
Date: Tue, 08 Jun 2010 16:09:31 -0700
Message-ID: <7vbpblruj8.fsf@alter.siamese.dyndns.org>
References: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com>
 <201006080912.31448.johan@herland.net> <4C0E6A8A.70608@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 09 01:10:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM7wZ-0000PD-EP
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 01:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662Ab0FHXJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 19:09:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54734 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab0FHXJn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 19:09:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 211DEBAEE3;
	Tue,  8 Jun 2010 19:09:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=vN+oNQP1InbOSUCC4UcQl7GEHug=; b=xgnwphT0OQiwN/EcrJhHRO7
	a21qTY6ct1ER9ybQZqkGxooW1Syd9UaBy87thzXSug7hzEYd2aP4i4hXhEG7mVJI
	lTpOekEIpKB7HiBtfitLwLpiVz0JC+DssnbNE+Q68hMJSCnL+DUP9zeyOx6LQ6NQ
	6XC9G70vG+JW6+CT5nss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=TuYqbiRBbZz+tjTxAWgqo/jr0xByMBPAgc2w0m4ftAKg8YW+e
	Y0QZaPYZ4Eq1NOQQtlNYDEMeu7qzZ2z78nhc346ySExYrNz+/WUkcklQx5wJEQKt
	0NME0lc3FZDQQIFdgfvcw9CZXX0AY2WxTDzy2/U4UmKkTTTfZ5BQA8yl+c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CF94ABAEE2;
	Tue,  8 Jun 2010 19:09:37 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3B5EBAEE1; Tue,  8 Jun
 2010 19:09:32 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E903275E-7352-11DF-ABB3-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148731>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Don't record a commit in the first place, following a branch is not bound
> to a special commit, so pretending to do that might do more harm than good.
> Just putting the 0-hash there might be the solution.

Ugh.  Even though I understand that in some scenarios you would want to
say "I don't care what commit is used for this submodule---just use the
tip of the branch 'fred'", I don't think you want to use 0{40} in the
superproject.  I think it would be Ok to add such a note to .gitmodules in
the superproject, but I also think we should still record which _exact_
commit was used to test and validate such a commit in the superproject
when it was made.

If you clone a superproject that contains such a submodule from an
upstream, keeping them up-to-date while working on your own change, it is
perfectly fine to choose to use whatever random commit that happens to be
at the tip of 'fred' branch in a submodule (and needless to say, that
commit might be your own commit that nobody else has, if you have been
actively working in that submodule, that you haven't published), that is
different from what the person who created the commit in the superproject
had.  But at least you would need to be able to tell that the result of a
build from such a state is different from what the superproject had.
Recording 0{40} would make the information contained in the superproject
tree meaningless.

Wouldn't it be enough to say --ignore-submodules for your day-to-day work,
without lying in the gitlink entry in the superproject tree?  An entry
"submodule.foo.branch = fred" in your .gitmodules will still tell your
local git to update the submodule worktree to work on 'fred' branch.  At
least, an arrangement like that would allow the build infrastructure to
use --no-ignore-submodules when running its equivalent of GIT-VERSION-GEN
to notice that what you are building is using something different from
what the superproject specified to use in the submodule, while not bugging
you with differences you do not care about (or you already know about and
are irrelevant to the change you are working on).
