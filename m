Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEC54402
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EKRH3brQ"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79B81BF1
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 17:20:08 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E42811CD345;
	Sun, 12 Nov 2023 20:20:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DSCiQGPTbkTDr3Zb2wXwjXb6dLCpbw6VkaQ1di
	1qqI8=; b=EKRH3brQdhKKhw5gJZbl8GxXkMZeE8rLtB17V6+kSj+fob2Zj2Z0Sb
	oNwBWd6RIYJ35RPQ47EyLTtAO1eJTMZHIOKq9qXq8jSk7LE5XjoSCseiuFlK70aa
	AL3p/zmPGnu73iPPusAYaSYmUWRHgeLGwDLaxEbUza+Om09/0J7wg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D53981CD343;
	Sun, 12 Nov 2023 20:20:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 970BE1CD341;
	Sun, 12 Nov 2023 20:20:06 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com
Subject: Re: [PATCH v4 3/4] rebase: test autosquash with and without -i
In-Reply-To: <20231111132720.78877-4-andy.koppe@gmail.com> (Andy Koppe's
	message of "Sat, 11 Nov 2023 13:27:17 +0000")
References: <20231105000808.10171-1-andy.koppe@gmail.com>
	<20231111132720.78877-1-andy.koppe@gmail.com>
	<20231111132720.78877-4-andy.koppe@gmail.com>
Date: Mon, 13 Nov 2023 10:20:04 +0900
Message-ID: <xmqqzfzila9n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C78F0560-81C2-11EE-9411-25B3960A682E-77302942!pb-smtp2.pobox.com

Andy Koppe <andy.koppe@gmail.com> writes:

> Amend t3415-rebase-autosquash.sh to test the --autosquash option and
> rebase.autoSquash config with and without -i.
>
> Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
> ---
>  t/t3415-rebase-autosquash.sh | 38 ++++++++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 10 deletions(-)
>
> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> index a364530d76..fcc40d6fe1 100755
> --- a/t/t3415-rebase-autosquash.sh
> +++ b/t/t3415-rebase-autosquash.sh
> @@ -43,7 +43,7 @@ test_auto_fixup () {
>  
>  	git tag $1 &&
>  	test_tick &&
> -	git rebase $2 -i HEAD^^^ &&
> +	git rebase $2 HEAD^^^ &&
>  	git log --oneline >actual &&
>  	if test -n "$no_squash"
>  	then
> @@ -61,15 +61,24 @@ test_auto_fixup () {
>  }
>  
>  test_expect_success 'auto fixup (option)' '
> -	test_auto_fixup final-fixup-option --autosquash
> +	test_auto_fixup fixup-option --autosquash &&
> +	test_auto_fixup fixup-option-i "--autosquash -i"
>  '

Nice.  As test_auto_fixup (and test_auto_squash we see later) clears
the slate with "git reset --hard base" before it starts its work, it
is easy to rerun them with and without "-i".
