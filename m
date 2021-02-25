Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6B9C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 02:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E0E64ED1
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 02:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbhBYCxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 21:53:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59829 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbhBYCxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 21:53:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B686AAAA20;
        Wed, 24 Feb 2021 21:52:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=475XrKFi5gJP
        p3VmP/Pl0C+JzGQ=; b=QOxvrN0QVh0cW+PQXd1YmQydYoKsOLF8GJvNC9b4HvW5
        wTb1YlNClWdRo7WQaZU/9NUchEaPP0G4+cXtB9Xzj1zmL6lWutxVSfrQJgVyct+H
        4hNRllNhXqf5DxwHXlh08KmMaEsGJtkuvzlWNruS3SUcXOiumC1cKUXCl1dx98c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZdPq+H
        OzB+wd+21r1SJBJ0ZyrwvCtsb3z2VFbQ4So66zVe8nzKLgbB5W3bHAUWHA1NxR76
        fLXybyHztIJ/jkuZaKEIBh78Og3GvQVK954Z7v+f2pCHTWurihHkWIT8XDgaKQoo
        7Tv6GfAnRSrGyLWfPnM05V8xfVbDoIVs4uT+Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AC31DAAA1F;
        Wed, 24 Feb 2021 21:52:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06846AAA1E;
        Wed, 24 Feb 2021 21:52:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v3 12/35] userdiff tests: change setup loop to
 individual test setup
References: <20210215154427.32693-1-avarab@gmail.com>
        <20210224195129.4004-13-avarab@gmail.com>
Date:   Wed, 24 Feb 2021 18:52:41 -0800
In-Reply-To: <20210224195129.4004-13-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 24 Feb 2021 20:51:06 +0100")
Message-ID: <xmqqa6rsyi2u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8772F664-7714-11EB-BE45-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +# check each individual file
> +for i in $(git -C t4018 ls-files)
> +do
> +	test_expect_success "setup hunk header: $i" "
> +		grep -v '^t4018' \"t4018/$i\" >\"t4018/$i.content\" &&
> +		sed -n -e 's/^t4018 header: //p' <\"t4018/$i\" >\"t4018/$i.header\" =
&&
> +		cp \"t4018/$i.content\" \"$i\" &&
> =20
>  		# add test file to the index
> -		git add "$i" &&
> +		git add \"$i\" &&
>  		# place modified file in the worktree
> -		sed -e "s/ChangeMe/IWasChanged/" <"t4018/$i.content" >"$i" || return=
 1
> -	done
> -'
> +		sed -e 's/ChangeMe/IWasChanged/' <\"t4018/$i.content\" >\"$i\"
> +	"

Please use '' around the second argument (i.e. test body) of the
test_expect_success, and use "" inside it.  "$i" that is used in the
loop is visible perfectly fine inside the test body when it is
eval'ed, and we won't have to count ugly backslashes that way.

> =20
> -# check each individual file
> -for i in $(git ls-files)
> -do
>  	test_expect_success "hunk header: $i" "
>  		git diff -U1 $i >diff &&
>  		sed -n -e 's/^.*@@$//p' -e 's/^.*@@ //p' <diff >ctx &&
