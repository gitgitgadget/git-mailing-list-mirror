From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] test-lib: verbose mode for only tests matching a pattern
Date: Wed, 29 May 2013 10:53:18 -0700
Message-ID: <7vmwrdu0z5.fsf@alter.siamese.dyndns.org>
References: <cover.1368736093.git.trast@inf.ethz.ch>
	<10e5eacece7fc9657c312b5c51747d23ae9ef40b.1368736093.git.trast@inf.ethz.ch>
	<20130529050000.GB31762@sigill.intra.peff.net>
	<20130529050732.GC31762@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 29 19:53:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhkYw-0002Xz-7M
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 19:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895Ab3E2RxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 13:53:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59110 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934979Ab3E2RxV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 13:53:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7FC022ED1;
	Wed, 29 May 2013 17:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YNXuW6aDUR+LztVufaPXR/eArfA=; b=XZoRw8
	SO5cHuXy6CuK13TpVsMk27svErV53Gi9Z9ozyR/cAIWl+zHQf+izMvD0zdE4sYai
	7fsOZGZ0DZcS8LqMznRG37l2nhsdi9beTOVon9tJagtiYn9hMFOuRNh+X1NpToIF
	4OikgWRIsBW/o/2KylbqefCXV0eFJco2F+GAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l9kAkBIKV3DoEwH/NP+ZBWLGZIwwQyaP
	gp1o8zQaqCUEk5wLH/hggA8qwlDpsYZFt0c6T/5G+EFx2grcezauONu8lmN801FD
	vKB264HLz8ndsK8ozn8RewEc0clYxh6IR8jgM9Dml+QEtpr/bGNXtievzowSel7U
	bvwQHZG1iR4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAB4B22ECE;
	Wed, 29 May 2013 17:53:20 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0EB622ECC;
	Wed, 29 May 2013 17:53:19 +0000 (UTC)
In-Reply-To: <20130529050732.GC31762@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 29 May 2013 01:07:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A5F52410-C888-11E2-A66C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225853>

Jeff King <peff@peff.net> writes:

> On Wed, May 29, 2013 at 01:00:00AM -0400, Jeff King wrote:
>
>> So we see 83 and 84 non-verbose, which is good. And we see the actual
>> output from 85 (the output from a "git checkout"). But we do not see the
>> "expecting success" for it. We see it for the _next_ test, which we
>> should not see at all. So I think your toggling is happening in the
>> wrong spot, but I haven't looked further than that.
>
> I think you want something more like:
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 5251009..75351f5 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -349,6 +349,7 @@ test_expect_failure () {
>  	export test_prereq
>  	if ! test_skip "$@"
>  	then
> +		toggle_verbose
>  		say >&3 "checking known breakage: $2"
>  		if test_run_ "$2" expecting_failure
>  		then
> @@ -367,6 +368,7 @@ test_expect_success () {
>  	export test_prereq
>  	if ! test_skip "$@"
>  	then
> +		toggle_verbose
>  		say >&3 "expecting success: $2"
>  		if test_run_ "$2"
>  		then
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index b4e81bc..165e84e 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -400,7 +400,6 @@ setup_test_eval () {
>  setup_test_eval () {
>  	setup_malloc_check
>  	toggle_valgrind
> -	toggle_verbose
>  }
>  teardown_test_eval () {
>  	teardown_malloc_check
>
> However, I'm not sure the toggle is the right thing. However, the whole
> toggle thing seems weird to me, as there is a big "gap" between
> finishing test X and starting test X+1 where we inherit the verbosity
> (and valgrind) settings from X. In general we frown upon doing much at
> all outside of test_expect_*, but I would think that:
>
>   test_expect_success 'one' '...'
>   git foo
>   test_expect_success 'two' '...'
>
> when run with "--valgrind-only=1" would not run the intermediate "git
> foo" with valgrind. I would have expected the implementation to be more
> like:
>
>   maybe_turn_on_valgrind
>   maybe_turn_on_verbose
>   run_the_actual_test
>   maybe_turn_off_verbose
>   maybe_turn_off_valgrind
>
> rather than relying on the next test to return to normal.

That matches my expectation as well (I had the same thought while
reading the series).

Thanks.
