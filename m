Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48A3C1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 18:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844AbcG1Sje (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 14:39:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753876AbcG1Sjd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 14:39:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9423B2E98E;
	Thu, 28 Jul 2016 14:39:31 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v8yzN9Faa7D07aB2rnSihShiGrc=; b=HsgnEd
	6NOakMUlC5GognXRk2zY8QMQSfLXS86GmkkjM1gD13RzWjZR9NiU11dIdXkpRHaj
	vZp2ehZFnKm/o52Z8Y1lUmyMrITzvtX+M3HihomfE/2kyhVfbeYcaxvjBEFpz26T
	6MXFMRCv6G+oLnM84itNIg8GvyfpWrOxezP8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HYVq99Sqky/iX+CZVQ5LJJBZu/AobNGY
	+0jhVg5FcltNPIWYPMttcxI70dNBlcob+uBOex7LshxhtaxOKXcqJ/scwx7A58Ub
	vo/Wp4Fx68SbnIqkHin0BvkYDYcD1bt6iUOYIykhh9Ajm9ETqvAFCN9BRJDGTbgN
	eXTTFyE50fw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 896942E98D;
	Thu, 28 Jul 2016 14:39:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3F042E98C;
	Thu, 28 Jul 2016 14:39:30 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, jrnieder@gmail.com
Subject: Re: [PATCH 1/2] t7406: correct depth test in shallow test
References: <20160728172641.8376-1-sbeller@google.com>
	<20160728172641.8376-2-sbeller@google.com>
Date:	Thu, 28 Jul 2016 11:39:28 -0700
In-Reply-To: <20160728172641.8376-2-sbeller@google.com> (Stefan Beller's
	message of "Thu, 28 Jul 2016 10:26:40 -0700")
Message-ID: <xmqqeg6dsj33.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F194550-54F2-11E6-8572-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> We used to ask for 3 changes and tested for having 1, so the test
> seems broken.

I am not sure what to think of "seems broken".

Asking for 3 and having 1 is broken in what way?  Should we be
expecting for 3 because we asked for that many?  Should we expect
less than three even though we asked for three because the upstream
side does not even have that many?  If the current test that asks
for 3 and gets only 1 is not failing, why should we expect that
asking for 2 would get 2?  In other words, why is it sane that
asking for fewer number of commits gives us more?

Also most of the lines in this subshell seem to be breaking
&&-chain.



> Correct the test by using test_line_count that exists in the test suite.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t7406-submodule-update.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 88e9750..bd261ac 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -846,9 +846,10 @@ test_expect_success 'submodule update clone shallow submodule' '
>  	(cd super3 &&
>  	 sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
>  	 mv -f .gitmodules.tmp .gitmodules &&
> -	 git submodule update --init --depth=3
> +	 git submodule update --init --depth=2
>  	 (cd submodule &&
> -	  test 1 = $(git log --oneline | wc -l)
> +	  git log --oneline >lines
> +	  test_line_count = 2 lines
>  	 )
>  )
>  '
