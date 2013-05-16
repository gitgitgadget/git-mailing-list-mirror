From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] test-lib: enable MALLOC_* for the actual tests
Date: Thu, 16 May 2013 15:43:50 -0700
Message-ID: <7v61yi4kbd.fsf@alter.siamese.dyndns.org>
References: <cover.1368736093.git.trast@inf.ethz.ch>
	<043f7ee12630ae267bcde88e92a7dfacbf41e730.1368736093.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 17 00:44:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud6u9-0004ae-Di
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 00:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177Ab3EPWnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 18:43:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44504 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755170Ab3EPWnx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 18:43:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4118C1FD34;
	Thu, 16 May 2013 22:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bDPVkmor1vX39esrDj1hjZXX5r8=; b=n46Z8I
	UyrxnlFPWjsyk33VTs5kMmG7C53se6KB7JBgV1t7M6fTd3F08kwCrBRqoJXP9WDl
	FiGvSW9oBqOyKtuwkR7ZJ20PA1I9VVWL0417ocSbapJM2a48NKh8j7vt/YrrX+vw
	JW2IhtwlQ7kU+9ZYEYMlX3q9WOrp1LOT+KxWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tT/YQJHmQjk8FaDqKqK4tjQBjcNewlrL
	6CetrC6meu9+kw1tnvet+mfvTIYU4XzbE8/rk8jz2J7SXUZWG5GrhdMc+5RzGfFC
	q/0mMXN2YrxUtGDJhu/O1Loi30IwEnrLUHqJF0CYc6gyqL2qd3njCHbzhTEgds0j
	ctVM3hVy77k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 357E71FD33;
	Thu, 16 May 2013 22:43:52 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFA1D1FD32;
	Thu, 16 May 2013 22:43:51 +0000 (UTC)
In-Reply-To: <043f7ee12630ae267bcde88e92a7dfacbf41e730.1368736093.git.trast@inf.ethz.ch>
	(Thomas Rast's message of "Thu, 16 May 2013 22:50:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14B64A1E-BE7A-11E2-88EC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224623>

Thomas Rast <trast@inf.ethz.ch> writes:

> 1b3185f (MALLOC_CHECK: various clean-ups, 2012-09-14) moved around the
> MALLOC_CHECK_ and MALLOC_PERTURB_ assignments, intending to limit
> their effect to only the test runs.  However, they were actually
> enabled only during test cleanup.  Call setup/teardown_malloc_check
> also around the evaluation of the actual test snippet.

Sorry about the breakage.

> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
> ---
>  t/test-lib.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index ca6bdef..229f5f7 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -337,8 +337,10 @@ test_eval_ () {
>  test_run_ () {
>  	test_cleanup=:
>  	expecting_failure=$2
> +	setup_malloc_check
>  	test_eval_ "$1"
>  	eval_ret=$?
> +	teardown_malloc_check
>  
>  	if test -z "$immediate" || test $eval_ret = 0 || test -n "$expecting_failure"
>  	then
