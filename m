From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: do not show ambiguous tag names as "tags/foo"
Date: Mon, 25 Jan 2016 19:25:42 -0800
Message-ID: <xmqq1t95dnt5.fsf@gitster.mtv.corp.google.com>
References: <CAAB=nN=RSQuDPdg6Y2heeBXpQVdWSwFAcDDTfxE=XRSOu5gGEg@mail.gmail.com>
	<20160124071234.GA24084@sigill.intra.peff.net>
	<20160124071815.GB24084@sigill.intra.peff.net>
	<xmqqvb6iboxj.fsf@gitster.mtv.corp.google.com>
	<20160124222736.GA29115@sigill.intra.peff.net>
	<xmqqsi1m9yxh.fsf@gitster.mtv.corp.google.com>
	<20160125100141.GC24452@sigill.intra.peff.net>
	<xmqqmvrtfm0u.fsf@gitster.mtv.corp.google.com>
	<20160126023753.GA4012@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pete Harlan <pgit@tento.net>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 26 04:25:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNuGU-0000eM-4P
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 04:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932781AbcAZDZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 22:25:47 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52101 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932582AbcAZDZp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 22:25:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0FD62409EB;
	Mon, 25 Jan 2016 22:25:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I1s3q6IQQY091zCtWkePh/6G3Po=; b=GPG6r0
	HCW9VxxMpDNTJhZfYpXM7fFIGvA/W+mKJochocNuAUb+Ba9M0Bh5Ah586AT+7BIT
	3Yi4gw+aHevOyzi+jmfsH4IDtfhAqEuY4OHxHIzYoxHufEvwOl7E/oqUMHeoxvPX
	JWprmWfnbp0aBwevNbt+GYvkDNGHEdkRgNX3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n8A3viwsnx7aygh6nVatIkD3OvCTCq8G
	ncgDClhcV16UNSFoHiBvEjBDX5vx/hL0slYu6N8wc0el4HKT2AZf3g+7FpIrgQMb
	zpzRHOed8cEzDKwH1fFQulmgnkG1m/DqUsiQPN5UHA6h6hQHYXJ1vNXSKtpSTcXq
	GC/A6NoKCTE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 07DA2409EA;
	Mon, 25 Jan 2016 22:25:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7F07B409E9;
	Mon, 25 Jan 2016 22:25:43 -0500 (EST)
In-Reply-To: <20160126023753.GA4012@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 25 Jan 2016 21:37:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7B686854-C3DC-11E5-9BD2-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284775>

Jeff King <peff@peff.net> writes:

> What does this do:
>
>   git for-each-ref --format='%(refname:remove-standard-prefix)'
>
> ?
>
> Is there no standard prefix, because we are not in branch/tag? Does it
> remove well-known prefixes like "refs/heads/", "refs/tags/", etc? Does
> it remove the first two components (e.g., what happens to
> "refs/foo/bar")? If so, what happens to "refs/stash"?

I think our mails crossed.  I envisioned that the documentation
would go something like this:

remove-standard-prefix::
	When the refname begins with one of the well-known prefixes,
	the prefix is stripped from it (and when it does not start
	with any of the well-known prefixes, the refname is left
	as-is).  "refs/heads/", "refs/remotes/" and "refs/tags/" are
	the well-known prefixes that are removed (as this modifier
	is primarily meant to allow users emulate the listing modes
	of "git tag" and "git branch") but this set may change over
	time (we may teach it to remove "refs/changes/" in later
	versions of Git, for example).

> Yeah, I am definitely on board with trying to do the most minimal thing
> for the regression fix and worry about more advanced concerns later (if
> at all). It seems to me that "error out" is a pretty minimal behavior,
> though, and one that doesn't lock us into any behaviors (i.e., it is
> generally OK to take something that did not work at all before, and give
> it new useful behavior; it is not OK to change something that did
> something useful before).

The thing that worried me the most is that "strip=<n>" is a very
intuitive and nice notation that end users would want to use it
beyond emulating "git tag" literally, and one behaviour we happen to
pick, be it "error out" or "leave it intact", would have a high
chance of being not the most useful one.  If we define it to error
out, somebody somewhere will abuse it to "ensure that all branch
names are at least two levels deep" or something we do not
anticipate now and start relying on the "erroring out" behaviour,
and then complain when we later "allow it to do something more
useful" that it no longer errors out.

Having said all that, I think I can live with "strip=<n>" that
happens to pick a single behaviour that we pick with the best
knowledge we have right now.  If we fear the compatiblity wart so
seriously, we can always add a separate "strip-nofail=<n>" variant
that gives a different behaviour from "strip=<n>" that errors out.

Another useful variant might be "strip <n> levels if we can,
otherwise pretend that the ref did not even pass the filtering
criteria and do not show anything about the ref on the output", by
the way.

> So what about this:
>
>   1. Implement ":strip=<n>" and use it from git-tag.
>
>   2. Have it error out on a ref with fewer than <n> components. This
>      should be impossible to trigger via "git-tag" with the default
>      format.
>
>   3. Explicitly document that the behavior for values of <n> that are
>      not positive integers is undefined and subject to change (or
>      alternatively, we can simply error out).
>
>
> That _is_ user-visible, but it seems like "strip" is a fairly flexible
> mechanism by itself (enough that I do not mind living with it forever),
> and we haven't made any promises about the ambiguous parts.

OK.
