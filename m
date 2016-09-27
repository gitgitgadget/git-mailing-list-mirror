Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06A4120986
	for <e@80x24.org>; Tue, 27 Sep 2016 17:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753865AbcI0RZz (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 13:25:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64573 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751064AbcI0RZy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 13:25:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F2B13FA53;
        Tue, 27 Sep 2016 13:25:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vFJ6G0AdIJ78ULE9SGtAVi7Cgsk=; b=f1atXy
        dA19xbhYAd9Dcs7UfNy2Mfn7Y8IexEHa1ctarmJgQC/750U76htmE2yelgn6LYT5
        mX+ezUybnuD7sRJUvXc7RqOg7pAc2xn+2hqXLnzW5Sz9yNl5e/YK1cfcO9OzPR1+
        5tHKTrjFtbB3kZali6yb5LTTbOk3W+KyAAZHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QapJIPp8dLe/aYd27ew5gRQn6y/SRsMP
        huJQ+I5BRLe09PMJr/vetyS4UIWkeUZdHmljUGjfNtldJUZQIHYcPkIzoYx0nEyx
        r2qtjaCkzJy6YOcraWcrp45pGyvXnUe4XydpX0FQv604Oz+89Zbph2Npgq1jieXd
        N+ltSA4TtZo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 75A103FA51;
        Tue, 27 Sep 2016 13:25:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E89FD3FA4D;
        Tue, 27 Sep 2016 13:25:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     git@vger.kernel.org, Alex <agrambot@gmail.com>
Subject: Re: [PATCH] gpg-interface: use more status letters
References: <87y42ey3z4.fsf@gmail.com>
        <06b5e0bfb898c7b3c6a866df5bda0ab4587284c6.1474986563.git.git@drmicha.warpmail.net>
Date:   Tue, 27 Sep 2016 10:25:49 -0700
In-Reply-To: <06b5e0bfb898c7b3c6a866df5bda0ab4587284c6.1474986563.git.git@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Tue, 27 Sep 2016 16:31:40 +0200")
Message-ID: <xmqqk2dxp84i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7061BD54-84D7-11E6-87F6-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> According to gpg2's doc/DETAILS:
> "For each signature only one of the codes GOODSIG, BADSIG, EXPSIG,
> EXPKEYSIG, REVKEYSIG or ERRSIG will be emitted."
>
> gpg1 ("classic") behaves the same (although doc/DETAILS
> differs).
>
> Currently, we parse gpg's status output for GOODSIG, BADSIG and trust
> information and translate that into status codes G, B, U, N for the %G?
> format specifier.
>
> git-verify-* returns success in the GOODSIG case only. This is somewhat in
> disagreement with gpg, which considers the first 5 of the 6 above as VALIDSIG,
> but we err on the very safe side.
>
> Introduce additional status codes E, X, R for ERRSIG, EXP*SIG, REVKEYSIG
> so that a user of %G? gets more information about the absence of a 'G'
> on first glance.
>
> Reported-by: Alex <agrambot@gmail.com>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

That probably was requested-by, but that's OK.

> I'd be happy to learn are more portable/safer/cooler way to make gpg forget
> that key in the added test...

We seem to set GNUPGHOME to $HOME/gnupg-home-not-used in test-lib.sh
to say "No gnupg keys for you!" for all the tests by default, which
is overriden by the signature tests like 7510.  I do not know if
that is more portable/safer/cooler than setting it to /dev/null but
imitating it might be a way for you to push the potential problem
away to other people ;-)  If it becomes an issue to set it to a
directory that does not exist with an updated future version of GPG,
this new test will share the same problem with everybody else, and
hopefully the solution would be the same ;-)

Having said that, if GNUPGHOME=/dev/null works for you, that's good
enough for now, so that people on other platforms can test it and
report.

Thanks.

> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 6e839f5..fd22742 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -190,7 +190,7 @@ test_expect_success GPG 'show bad signature with custom format' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success GPG 'show unknown signature with custom format' '
> +test_expect_success GPG 'show untrusted signature with custom format' '
>  	cat >expect <<-\EOF &&
>  	U
>  	61092E85B7227189
> @@ -200,6 +200,15 @@ test_expect_success GPG 'show unknown signature with custom format' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success GPG 'show unknown signature with custom format' '
> +	cat >expect <<-\EOF &&
> +	E
> +	61092E85B7227189
> +	EOF
> +	GNUPGHOME=/dev/null git log -1 --format="%G?%n%GK" eighth-signed-alt >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success GPG 'show lack of signature with custom format' '
>  	cat >expect <<-\EOF &&
>  	N
