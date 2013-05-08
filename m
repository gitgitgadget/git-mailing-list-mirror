From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/11] tests: at-combinations: improve nonsense()
Date: Tue, 07 May 2013 22:55:52 -0700
Message-ID: <7v8v3qgglz.fsf@alter.siamese.dyndns.org>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
	<1367963711-8722-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 07:56:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZxMF-0001uF-0y
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 07:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139Ab3EHFz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 01:55:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54047 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081Ab3EHFzy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 01:55:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A87414888;
	Wed,  8 May 2013 05:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=n56zyJ+cnCDZa9A9p88uYDGtTb0=; b=J6UXSID3IAwYVsNVTBr1
	lLmDZpYn0M0hLybVarx9SN8aJ2JiNSwne/5fiE1aWbLnD71BjQvstqNdHT38AG0z
	5aMXKoQM0KoLbCz0vsAaV7pp7x/dZ8ae8zm/IYtu7CWDuJFg9LEP3g9PcdlycS+U
	W3LdThpY3dQnuChPkhNGQco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=StJwTf5m/f2xMZKYQUkz1GccPJY/St06vks+dSNuhhJXMy
	Hs6BMfA4vY33MSllbVs8n/8RcE6aX/tBF9pgz3qLYogdo6a21fvF19j62W5Ukqn+
	Sc2TRGEtAI9GX1nNhnPqYYxXkQ1tf9U+I1dnD26LjzqUpx7Xx7cWupXH37284=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4167C14886;
	Wed,  8 May 2013 05:55:54 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A23B814885;
	Wed,  8 May 2013 05:55:53 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1B975A4-B7A3-11E2-AFF3-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223641>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> In some circumstances 'git log' might fail, but not because the @
> parsing failed. For example: 'git rev-parse' might succeed and return a
> bad object, and then 'git log' would fail.
>
> The layer we want to test is revision parsing, so let's test that
> directly.

Hmph, but

	git rev-parse Makefile

would happily succeed if there happens to be Makefile in the
directory.

Are we expecting that they are always object names?  If that is the
case, perhaps

	git rev-parse --verify "$1"

would express the intention better.

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t1508-at-combinations.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
> index bd2d2fe..2ea735e 100755
> --- a/t/t1508-at-combinations.sh
> +++ b/t/t1508-at-combinations.sh
> @@ -17,7 +17,7 @@ test_expect_${4:-success} "$1 = $3" "
>  }
>  nonsense() {
>  test_expect_${2:-success} "$1 is nonsensical" "
> -	test_must_fail git log -1 '$1'
> +	test_must_fail git rev-parse '$1'
>  "
>  }
>  fail() {
