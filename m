Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507FEC433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 21:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1396E60232
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 21:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242918AbhCAVpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 16:45:30 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61519 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbhCAVmO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 16:42:14 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18838ACB31;
        Mon,  1 Mar 2021 16:41:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SrXO9m5/HH29
        2rmyORNThEA3EJ4=; b=UFsKoxrl1tLfQHZi2JSEkrQQWvNB0gb2uKOa4wgkf2Sh
        9TzsBYGzWMph7eqJSg2q9Y+NBzQPy3WB6lKuogN9xnaj01xMAcL68k22jJKHuQs/
        uzgIXlNyAPWA6tgRbXlVkDR7MEEgK8jxXUaEHNODGXoNA34wiBpfjuIbmJGG8G0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZQWNTs
        U8IIfnT6d6r80msgAcUWOBxtSn9cqnYeorcw68nn1sKE3hVbI57rLmnkApsPd3QM
        hInb/Cw4HK0BK0K2b36EiWcNkUvfhblE+iodwFpLORyZZi125a+m8Sj8gKC2YZDk
        np0XtYWTpUL0y4IBEnsQKFny042dw3VeUtEhI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F4F1ACB30;
        Mon,  1 Mar 2021 16:41:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E5CBACB2F;
        Mon,  1 Mar 2021 16:41:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 04/10] test-lib functions: add an --annotated-tag option
 to "test_commit"
References: <20200223125102.6697-1-benno@bmevers.de>
        <20210228195414.21372-5-avarab@gmail.com>
Date:   Mon, 01 Mar 2021 13:41:23 -0800
In-Reply-To: <20210228195414.21372-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 28 Feb 2021 20:54:08 +0100")
Message-ID: <xmqqr1kyo8l8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DEE400F8-7AD6-11EB-B8A0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> @@ -220,6 +225,9 @@ test_commit () {
>  		--no-tag)
>  			no_tag=3Dyes
>  			;;
> +		--annotated-tag)
> +			annotated_tag=3Dyes
> +			;;

A new option is welcome, but shouldn't we be straightening out the
variables that keep track of the options around tagging?  It's not
like it is possible to have 4 (two variables that can independently
set to 'yes') possibilities, so something along the lines of ...

         test_commit () {
        +	tag=3Dlight &&
                notick=3D &&
         ...
		while test $# !=3D 0
		do
			case "$1" in
			...
			--no-tag)
	-			no_tag=3Dyes
	+			tag=3Dnone
				;;
	+		--annotated)
	+			tag=3Dannotated
	+			;;
		...
	-	if test -z "$no_tag"
	-	then
	+	case "$tag" in
	+	none)
	+		;;
	+	light)
			git ${indir:+ -C "$indir") tag "${4:-$1}"
	+		;;
	+	annotated)
	+		git ${indir:+ -C "$indir") tag -m "$1" "${4:-$1}"
	+		;;
	+	esac
		...

after this step (meaning, we may want to start from fixing the no_tag=3Dy=
es
to tag=3Dnone before introducing this new feature).

Thanks.

> @@ -244,7 +252,15 @@ test_commit () {
>  	    $signoff -m "$1" &&
>  	if test -z "$no_tag"
>  	then
> -		git ${indir:+ -C "$indir"} tag "${4:-$1}"
> +		if test -n "$annotated_tag"
> +		then
> +			if test -z "$notick"
> +			then
> +				test_tick
> +			fi &&
> +			test_tick
> +		fi &&
> +		git ${indir:+ -C "$indir"} tag ${annotated_tag:+ -a -m "$1"} "${4:-$=
1}"
>  	fi
>  }
