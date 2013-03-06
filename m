From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] tests: make sure rename pretty print works
Date: Wed, 06 Mar 2013 14:03:41 -0800
Message-ID: <7v7glkp4n6.fsf@alter.siamese.dyndns.org>
References: <1362235092-16914-1-git-send-email-apelisse@gmail.com>
 <1362605772-14639-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 23:04:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDMRX-0005ep-2J
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 23:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390Ab3CFWDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 17:03:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34986 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754335Ab3CFWDo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 17:03:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06790AA74;
	Wed,  6 Mar 2013 17:03:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XHb2LcftkYdRvIvg6iaeL0f4fWY=; b=fBS8AO
	bYqJdUHn5zyaGm0zxiBIXEZo2gRuGQCMQ9HjSvsklAFJT37gdvBKRnf1ZdTRe/+N
	sSjKbXkljH42bv4zPrsh9zuw2qLVQ8HyPEfm15Oip5eqfbcSYgyS1AYhRZ/7u2Vq
	OYOD1s7SVvdeafCJ49ajBXi8T8SDZbsUF0SRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mhemh7KuPmFpZHHwP/TJUnzNxcns55v0
	6uWXIq1+oOdV7Im/GzcI57P/Z1kmn03T4yhpdcqdJcY1trMnFM7Kj/yIiDbc+13n
	A2B2/mVKZ6vdqOBXVPsT5pUpGSoZKy9nFHt45z0zT1OdGRsaylxgBfSy6HkVBHqK
	RpqL6xmjL9E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE488AA73;
	Wed,  6 Mar 2013 17:03:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 281B2AA6F; Wed,  6 Mar 2013
 17:03:43 -0500 (EST)
In-Reply-To: <1362605772-14639-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Wed, 6 Mar 2013 22:36:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5C50110-86A9-11E2-8E75-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217557>

Antoine Pelisse <apelisse@gmail.com> writes:

> Add basic use cases and corner cases tests for
> "git diff -M --summary/stat".
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
> list of fixes:
>  - Test using diff instead of show
>  (that is more consistent with commit message).
>  - add extra spaces around paths
>  - Use better commit messages
>  - Moved to existing t4001
>
>  t/t4001-diff-rename.sh |   54 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)

Nice.

Will queue, but we may want to make these tests more independent
from each other later.  For example, if the first test fails before
its "git mv a/b/c c/b/a", the set-up of the second test to further
move it to c/d/e will fail, which is probably not very desirable.

Thanks.

> +test_expect_success 'rename pretty print with nothing in common' '
> +	mkdir -p a/b/ &&
> +	: >a/b/c &&
> +	git add a/b/c &&
> +	git commit -m "create a/b/c" &&
> +	mkdir -p c/b/ &&
> +	git mv a/b/c c/b/a &&
> +	git commit -m "a/b/c -> c/b/a" &&
> +	git diff -M --summary HEAD^ HEAD >output &&
> +	test_i18ngrep " a/b/c => c/b/a " output &&
> +	git diff -M --stat HEAD^ HEAD >output &&
> +	test_i18ngrep " a/b/c => c/b/a " output
> +'
> +
> +test_expect_success 'rename pretty print with common prefix' '
> +	mkdir -p c/d &&
> +	git mv c/b/a c/d/e &&
> +	git commit -m "c/b/a -> c/d/e" &&
> +	git diff -M --summary HEAD^ HEAD >output &&
> +	test_i18ngrep " c/{b/a => d/e} " output &&
> +	git diff -M --stat HEAD^ HEAD >output &&
> +	test_i18ngrep " c/{b/a => d/e} " output
> +'
> +
> +test_expect_success 'rename pretty print with common suffix' '
> +	mkdir d &&
> +	git mv c/d/e d/e &&
> +	git commit -m "c/d/e -> d/e" &&
> +	git diff -M --summary HEAD^ HEAD >output &&
> +	test_i18ngrep " {c/d => d}/e " output &&
> +	git diff -M --stat HEAD^ HEAD >output &&
> +	test_i18ngrep " {c/d => d}/e " output
> +'
> +
> +test_expect_success 'rename pretty print with common prefix and suffix' '
> +	mkdir d/f &&
> +	git mv d/e d/f/e &&
> +	git commit -m "d/e -> d/f/e" &&
> +	git diff -M --summary HEAD^ HEAD >output &&
> +	test_i18ngrep " d/{ => f}/e " output &&
> +	git diff -M --stat HEAD^ HEAD >output &&
> +	test_i18ngrep " d/{ => f}/e " output
> +'
> +
> +test_expect_success 'rename pretty print common prefix and suffix overlap' '
> +	mkdir d/f/f &&
> +	git mv d/f/e d/f/f/e &&
> +	git commit -m "d/f/e d/f/f/e" &&
> +	git diff -M --summary HEAD^ HEAD >output &&
> +	test_i18ngrep " d/f/{ => f}/e " output &&
> +	git diff -M --stat HEAD^ HEAD >output &&
> +	test_i18ngrep " d/f/{ => f}/e " output
> +'
> +
>  test_done
> --
> 1.7.9.5
