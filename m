Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFE6A1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 18:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbdL0SJ0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 13:09:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59027 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751781AbdL0SJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 13:09:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 456E6B6658;
        Wed, 27 Dec 2017 13:09:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=i9uO5rL0XMt9
        nDhd0U9x7+VJQR8=; b=q4zkoauG5h+i7P06h/WquGdJxJ4IXOsJFHvBZug9g//z
        nbHY8ABKUHMEp0BiaPZkeFFRR7iqCrsmLAMwpb5BeL1grOvSw7mU0AiWkckvaF6k
        EhHjitWgkUKf2aP57XZgOMGRh3IxoLQwnBfohV2j1WNxoHYdpfxFfaKwkiLF1WU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bElLzl
        pFCXkgIw+X0xGIdbDaElXiwvsFowXWUGVyIhglHeip5sHX6tvjBav8deH16AK64K
        eDB4wfUVfJCo2m20C8dxFlo3XgpxUR+5o4HX5mprIpvtLyKJflpu6Jje2ah+41sA
        LUWzGbzDVKPBOvaV2n8wq7XDvvdiD64nG9mLk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34310B6657;
        Wed, 27 Dec 2017 13:09:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E19AB6656;
        Wed, 27 Dec 2017 13:09:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH] status: add a failing test showing a core.untrackedCache bug
References: <20171222140032.21180-1-avarab@gmail.com>
Date:   Wed, 27 Dec 2017 10:09:23 -0800
In-Reply-To: <20171222140032.21180-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 22 Dec 2017 14:00:32 +0000")
Message-ID: <xmqqlghoniuk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 11EBEA9E-EB31-11E7-83DF-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +status_is_clean() {
> +	>../status.expect &&
> +	git status --porcelain >../status.actual &&
> +	test_cmp ../status.expect ../status.actual
> +}
> +
>  test_lazy_prereq UNTRACKED_CACHE '
>  	{ git update-index --test-untracked-cache; ret=3D$?; } &&
>  	test $ret -ne 1
> @@ -683,4 +689,43 @@ test_expect_success 'untracked cache survives a co=
mmit' '
>  	test_cmp ../before ../after
>  '
> =20
> +test_expect_success 'teardown worktree' '
> +    cd ..
> +'

Funny indentation.

> +test_expect_success 'setup worktree for symlink test' '
> +	git init worktree-symlink &&
> +	cd worktree-symlink &&
> +	git config core.untrackedCache true &&
> +	mkdir one two &&
> +	touch one/file two/file &&
> +	git add one/file two/file &&
> +	git commit -m"first commit" &&
> +	git rm -rf one &&
> +	ln -s two one &&
> +	git add one &&
> +	git commit -m"second commit"
> +'

This needs SYMLINKS prereq, which in turn means it cannot be tested
on certain platforms.  I thought Duy's answer was that this does not
need to involve a symbolic link at all?  If so, perhaps we can have
another test that does not need symlink?

Thanks.
