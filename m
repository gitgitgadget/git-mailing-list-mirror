From: Junio C Hamano <gitster@pobox.com>
Subject: Re: random server hacks on top of git
Date: Mon, 18 Mar 2013 11:24:52 -0700
Message-ID: <7v7gl4o9aj.fsf@alter.siamese.dyndns.org>
References: <20130318121243.GC14789@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 18 19:25:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHekN-00073D-Qe
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 19:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab3CRSY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 14:24:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56916 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420Ab3CRSYz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 14:24:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2268BC18;
	Mon, 18 Mar 2013 14:24:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CmIMUhWpgS+911VXEZRCtC3RT+w=; b=uqIDf6
	mk5hT5DtFhtT6tMR6emB84J89of2brbQrubvSSJifr2QN4ZGPKQN9tgvcZtUMT5L
	+uBFWwLR8SCH5/GazvLfstvvfv5Jcqah7aEhTfRjSY8xq5ZsG0duzCuC8Ou153Yf
	MKhvTNdgf4xXQ8geMaysNNDdw3K6PTCQqR8Ww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uOzMCfRjlS4JziBsH9Ow9Yq/3yF87uVs
	Uh9ajk9eY2pKn/aSMu9cwbdnzupGWRj3pPYGqGsLCNUwKqwpd+ZU9wpIkctC63s3
	522JOSnpmUCXt6sGcsAcDnkMPypCpdoQw2kBB/KCMgrmWXpbiGf82Z+9png3rUCO
	qsfPVBCo/to=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B76FBBC15;
	Mon, 18 Mar 2013 14:24:54 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 335FFBC13; Mon, 18 Mar 2013
 14:24:54 -0400 (EDT)
In-Reply-To: <20130318121243.GC14789@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 18 Mar 2013 08:12:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2142D5B8-8FF9-11E2-97F3-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218434>

Jeff King <peff@peff.net> writes:

>   - blame-tree; re-rolled from my submission last year to build on top
>
>   - diff --max-depth; this is a requirement to do blame-tree efficiently

Both look mildly interesting, especially after the magic pathspec
settles the latter may be a good addition.

>   - share ref selection code between "git branch", "git tag", and "git
>     for-each-ref".

Nice.

>    - receive.maxsize; index-pack will happily spool data to disk

Again nice.

>    - receive.advertisealternates; basically turn off ".have"
>      advertisement.

I think this is a sane thing to do, especially with some hints on
the most common reference tree everybody is expected to know about.

>     - receive.hiderefs; this is going to become redundant with Junio's
>       implementation

Yup.

>     - an audit reflog; we keep a reflog for all refs at the root of the
>       repository. It differs from a regular reflog in that:
>
>         1. It never expires.
>
>         2. It is not part of reachability analysis.
>
>         3. It includes the refname for each entry, so you can see
>            deletions.

Interesting.

>     - ignore some fsck warnings under transfer.fsckobjects; some of them
>       are annoyingly common when people pull old history from an
>       existing project and try to push it back up.

Depending on the implementation, this may be very much valuable.
