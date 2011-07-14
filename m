From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ref namespaces: tests
Date: Thu, 14 Jul 2011 16:13:48 -0700
Message-ID: <7v1uxs3177.fsf@alter.siamese.dyndns.org>
References: <20110714205055.GA26956@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 01:13:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhV6U-000066-Is
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 01:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507Ab1GNXNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 19:13:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49258 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932437Ab1GNXNw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 19:13:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10A6F42AA;
	Thu, 14 Jul 2011 19:13:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3Q3/xIZEa8Ik0Y8V82yXROaI4zw=; b=Mol7bW
	Gs9qPy+/UlRWgXs72X8mjgpFNCkrDOv4Vknc5xKigprlLUHhf6Zk9nGzyxyOzRxg
	gYQyyMIlMryojxWIEM6Na0FtZ5eqlIGSNtcVBUmYU/X6inPWMhuSq+gXXsGllpJB
	y9L3Ak6tA0NFXfPlS59hvLyQRTs3alUPnMx+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H56C7lI3Q4h5R/2UHRzmcmj+fvgXuxpf
	/4y9+1NcoenpFAXMZK0rMFcrUr2OqRycSOMNTW4P8tlaCnNODtLr77WyDgiEH3tP
	s1uZwNNRHBov8V4dBk90y+osk+X9EhNUHWxyRiid2/7elVYZXB0XsOVbukuGPBzO
	hAARiObjhOw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 066BF42A9;
	Thu, 14 Jul 2011 19:13:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57FFD42A8; Thu, 14 Jul 2011
 19:13:50 -0400 (EDT)
In-Reply-To: <20110714205055.GA26956@leaf> (Josh Triplett's message of "Thu,
 14 Jul 2011 13:50:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF36E9E6-AE6E-11E0-BF64-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177182>

Josh Triplett <josh@joshtriplett.org> writes:

> Test pushing, pulling, and mirroring of repositories with ref
> namespaces.
>
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> Signed-off-by: Jamey Sharp <jamey@minilop.net>

Thanks.

>  create mode 100755 t/t5502-fetch-push-namespaces.sh

Isn't 5502 used already?

> +test_expect_success setup '
> +	test_tick &&
> +	git init original &&
> +	(
> +		cd original &&
> +		i=0 &&
> +		while [ "$i" -lt 2 ]
> +		do
> +			echo "$i" > count &&

This is just style, but the test scripts prefer to spell these like this:

	while test "$i" -lt 2
	do
        	echo "$i" >count &&
                ...

to favor "test" over "[ ... ]", and omit SP between ">" redirection (or
"<" for that matter) and the filename.

> +		git remote add pushee-namespaced "ext::git --namespace=namespace %s ../pushee" &&

Nice ;-).

> +test_expect_success 'pushing into a repository using a ref namespace' '
> +	(
> +		cd original &&
> +		git push pushee-namespaced master &&
> +		git ls-remote pushee-namespaced > actual &&
> +		printf "dc65a2e0f299dcc7efddbbe01641a28ee84329ba\trefs/heads/master\n" > expected &&

Could you avoid hardcoding the exact object names here?  Your script knows
what object should appear at refs/heads/master at "pushee-namespaced" (as
you have pushed from the repository "original" you are in), so it may be
something like:

	printf "%s\trefs/heads/mater\n" $(git rev-parse master) >expect

Same comment applies for all the other hardcoded object names.

> +test_expect_success 'mirroring a repository using a ref namespace' '
> +	git clone --mirror pushee mirror &&
> +	(
> +		cd mirror &&
> +		git for-each-ref refs/ > actual &&
> +		printf "dc65a2e0f299dcc7efddbbe01641a28ee84329ba commit\trefs/namespaces/namespace/refs/heads/master\n" > expected &&
> +		printf "fbdf4310c71b916568f04753f603fb24a0544227 commit\trefs/namespaces/namespace/refs/tags/0\n" >> expected &&
> +		printf "dc65a2e0f299dcc7efddbbe01641a28ee84329ba commit\trefs/namespaces/namespace/refs/tags/1\n" >> expected &&
> +		test_cmp expected actual
> +	)
> +'

I am not sure what you are trying to test. "pushee" is pretending to be a
hosting site that uses the namespace feature to house refs pushed from
original in refs/namespaces/namespace/ so it is expected to have these
refs under there.  You didn't make any "git remote" configuration in
either mirror nor pushee, so it is natural with or without the namespace
feature that "git clone --mirror" would find them at the same place.

What hasn't been tested in the above is to see what actual refs pushee has
with (cd pushee && git for-each-ref), and you could argue that this test
is a proxy for that, but then you are assuming that "clone --mirror" is
not broken, which means it would make debugging harder when this test does
start failing---is it the basic namespace feature, or is it mirror cloning
that acquired a bug to break this test?

Also I would have expected that some configuration that affects the
central repository side (i.e. "pushee") to cause unsuspecting clients
(e.g. "original" that pushes into it) to see only a subset of refs
"pushee" has, which would be the real motivation for this feature. To show
that off, we may also need tests that house two or more namespaces hosted
in the same repository.
