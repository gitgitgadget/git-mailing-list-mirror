Return-Path: <SRS0=HVLo=IF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5633AC433DB
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 20:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E14856516B
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 20:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhCGUoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Mar 2021 15:44:02 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52659 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhCGUne (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Mar 2021 15:43:34 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B656712FB1A;
        Sun,  7 Mar 2021 15:43:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UaJOzgr0yhU/
        LdHoVP6V6Si6EnI=; b=SfE7KtmQYeJeKu7ASsZ12aqMqVY+LBOFtI+fhLguCy/n
        XSmr72elyyihLX+6ezdNNjosliiQZlSPR82OiZPMsrm+txpcOmHa784CssjKJ8ck
        inzRcUpxhJUxlQVdt+0MAd9DsluwsNQJV5Nbe4U/FsllJwQWJnf8UZLLl+VZshg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DixzGZ
        Yyx2wvC7rJPVFoFFa2NbMIYoKJCOFhkNkP4Zd6HHXS8bQxC9NNHfQg2XhF2yQnkC
        jzgIEOdmNXy4SGSZv7wJnQOM78S0RtdEIgyXXrEktFbL17QPkOz86pEmXQnVlg1O
        XA7Q6m6U1FZ+FnXYVF85f0Xj6fJpY6q6tZpCY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFF9712FB19;
        Sun,  7 Mar 2021 15:43:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EFECB12FB18;
        Sun,  7 Mar 2021 15:43:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] mktag tests: fix broken "&&" chain
References: <20210211015353.28680-2-avarab@gmail.com>
        <20210307132905.14212-1-avarab@gmail.com>
Date:   Sun, 07 Mar 2021 12:43:30 -0800
In-Reply-To: <20210307132905.14212-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 7 Mar 2021 14:29:05 +0100")
Message-ID: <xmqqy2ey7kzx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C789544A-7F85-11EB-9E94-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove a stray "xb" I inadvertently introduced in 780aa0a21e0 (tests:
> remove last uses of GIT_TEST_GETTEXT_POISON=3Dfalse, 2021-02-11). This
> would have been a failed attempt to type "C-x C-b" that snuck into the
> code.
>
> The chainlint check did not catch this one, but I don't know where to
> start patching the wall-of-sed that is chainlint.sed to fix that.

I do not think the chainlint check is designed to deal with helper
functions, but I wonder why nobody noticed a runtime failure.  Is
this an unused/dead codepath?


> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t3800-mktag.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
> index 60a666da595..6275c98523f 100755
> --- a/t/t3800-mktag.sh
> +++ b/t/t3800-mktag.sh
> @@ -17,7 +17,7 @@ check_verify_failure () {
>  		grep '$2' message &&
>  		if test '$3' !=3D '--no-strict'
>  		then
> -			test_must_fail git mktag --no-strict <tag.sig 2>message.no-strict &=
&xb
> +			test_must_fail git mktag --no-strict <tag.sig 2>message.no-strict &=
&
>  			grep '$2' message.no-strict
>  		fi
>  	"
