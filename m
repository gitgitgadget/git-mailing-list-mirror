From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/3] t5551: make the test for extra HTTP headers more robust
Date: Tue, 10 May 2016 10:34:11 -0700
Message-ID: <xmqq4ma5rf58.fsf@gitster.mtv.corp.google.com>
References: <cover.1462774709.git.johannes.schindelin@gmx.de>
	<cover.1462863934.git.johannes.schindelin@gmx.de>
	<ff8cbab7e62211b13835e520d402fbd89b90849e.1462863934.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 10 19:34:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0BY3-000706-Nx
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 19:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbcEJReQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 13:34:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61258 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750983AbcEJReP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 13:34:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C022519E0B;
	Tue, 10 May 2016 13:34:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RWEYc08WZ22AoA1NgWKGq6e355A=; b=F6KXtT
	Y0M+TmC7OotLylVwPjI0nak0m0yWM4ubE4ySNMWR/XIuVT/ccc+nfWVF+F7/Pav0
	kTQB5c/li0tgu4OvfGVeuBj7YUV59o3Bgv9k8LTAJnT51D3bAEbtTLUk2XT0YR8A
	aTycYaeVnhvQUbIUJhkix/7q40weGoaF+9Cu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hUA2WdZz29jeXrOOUePvCOX+gQ0m/SCe
	mhjIfpiYSgmtKi8U9wwEOG/81KoZHmuWc0hzV6OV5HlfIFSG7RTq9/ytAKYaUOGr
	kMrAIioXQ1SgTvqYS461l351bpm5Vg54LN8qvbX9XnD9Me89kwD8v/0/96nhQduH
	pa8Tl1Tkvjw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B6B6E19E0A;
	Tue, 10 May 2016 13:34:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 30EFD19E09;
	Tue, 10 May 2016 13:34:13 -0400 (EDT)
In-Reply-To: <ff8cbab7e62211b13835e520d402fbd89b90849e.1462863934.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 10 May 2016 09:08:38 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 69508E5C-16D5-11E6-A5B2-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294163>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> To test that extra HTTP headers are passed correctly, t5551 verifies that
> a fetch succeeds when two required headers are passed, and that the fetch
> does not succeed when those headers are not passed.
>
> However, this test would also succeed if the configuration required only
> one header. As Apache's configuration is notoriously tricky (this
> developer frequently requires StackOverflow's help to understand Apache's
> documentation), especially when still supporting the 2.2 line, let's just
> really make sure that the test verifies what we want it to verify.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Matches the previous one I queued with Reviewed-by: from Peff; good.

>  t/t5551-http-fetch-smart.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index e44fe72..43b257e 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -283,7 +283,8 @@ test_expect_success EXPENSIVE 'http can handle enormous ref negotiation' '
>  '
>  
>  test_expect_success 'custom http headers' '
> -	test_must_fail git fetch "$HTTPD_URL/smart_headers/repo.git" &&
> +	test_must_fail git -c http.extraheader="x-magic-two: cadabra" \
> +		fetch "$HTTPD_URL/smart_headers/repo.git" &&
>  	git -c http.extraheader="x-magic-one: abra" \
>  	    -c http.extraheader="x-magic-two: cadabra" \
>  	    fetch "$HTTPD_URL/smart_headers/repo.git"
