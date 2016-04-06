From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/6] t7030-verify-tag: Adds validation for multiple tags
Date: Wed, 06 Apr 2016 09:45:25 -0700
Message-ID: <xmqqk2kay9cq.fsf@gitster.mtv.corp.google.com>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
	<1459872449-7537-3-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: santiago@nyu.edu
X-From: git-owner@vger.kernel.org Wed Apr 06 18:45:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anqaS-0006xH-KL
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 18:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbcDFQpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 12:45:30 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751722AbcDFQp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 12:45:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 188E45282E;
	Wed,  6 Apr 2016 12:45:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tnOoOYrS6VaXUbpTceADp3PS/Bw=; b=JKmfD5
	bHD2/VOGKs3Ez6vYxGmmgl9v64aLjdg4oJGy+BkqVDyH2kvskyHIORP//H/nySWe
	L3xMSNXV+ypF9cuEI+nK+XmIxAG6Gq2lZfdNlLTu1MGhAporDOWb5jad6OK/Zxwu
	O0AT1KTKkBHvx5yxNENluykYEysaJ+JVUFOMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eso3mvusOuuVWrBbZ+2L8p7OvxAYDPr1
	ig5BKfVO/9ryugnugZ8jEOOJB9beL1gzdII5649TcHwiDSlX6JH7+SQ0JYVtLhKf
	OetL6Nm6T4Kyb6/992xbRKTl5ideUNdQ59GZC5IJcSZAIV6b7/bB1iOYk1qVwaiq
	gMw6e4pgadE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 049CB5282D;
	Wed,  6 Apr 2016 12:45:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 493A65282C;
	Wed,  6 Apr 2016 12:45:27 -0400 (EDT)
In-Reply-To: <1459872449-7537-3-git-send-email-santiago@nyu.edu>
	(santiago@nyu.edu's message of "Tue, 5 Apr 2016 12:07:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F74C8D16-FC16-11E5-9AD1-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290851>

santiago@nyu.edu writes:

> From: Santiago Torres <santiago@nyu.edu>
>
> The verify-tag command supports multiple tag names as an argument.

That makes it sound as if this is a valid input

	$ git verify-tag "one two three four"

but that is not what you meant.

> However, existing tests only test for invocation with a single tag, so
> we add a test invoking with multiple tags.

I'd rephrase the above like so:

    t7030: test verifying multiple tags

    The verify-tag command accepts multiple tag names to verify, but
    existing tests only test for invocation with a single tag.

    Add a test invoking it with multiple tags.

I had the same (minor) problem with Eric on the patch text itself.

>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
>  t/t7030-verify-tag.sh | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
> index 4608e71..c01621a 100755
> --- a/t/t7030-verify-tag.sh
> +++ b/t/t7030-verify-tag.sh
> @@ -112,4 +112,16 @@ test_expect_success GPG 'verify signatures with --raw' '
>  	)
>  '
>  
> +test_expect_success GPG 'verify multiple tags' '
> +	tags="fourth-signed sixth-signed seventh-signed" &&
> +	for i in $tags; do
> +		git verify-tag -v --raw $i || return 1
> +	done >expect.stdout 2>expect.stderr.1 &&
> +	grep "^.GNUPG" <expect.stderr.1 >expect.stderr &&
> +	git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
> +	grep "^.GNUPG" <actual.stderr.1 >actual.stderr &&
> +	test_cmp expect.stdout actual.stdout &&
> +	test_cmp expect.stderr actual.stderr
> +'
> +
>  test_done
