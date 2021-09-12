Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848C7C433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6714460555
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbhILW2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 18:28:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53822 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbhILW2D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 18:28:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B999914E14C;
        Sun, 12 Sep 2021 18:26:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ph5GXdPJh/g6
        8+xczGZvaO/7Gm2mPqDyTLKuNHrPQ0o=; b=qVggRmzjIseNA68HtCGGtOB7YUW0
        BJEzPAjOk9JHR23Fc8TvI32QvUh+tLdPff7kS4rowc+Z6WVBXTP4CQuMUdoy5DRQ
        PP/JqXjWzw7MCKKWyYcfAUVOu30DrJXa8FfSZVnQRbOKlHX9MmmjXe7aX6UkG4RK
        uCMCN9TP2zoeWDM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B272B14E148;
        Sun, 12 Sep 2021 18:26:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EFCA514E147;
        Sun, 12 Sep 2021 18:26:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/6] parse-options: stop supporting "" in the
 usagestr array
References: <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
        <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com>
        <patch-v3-3.6-e23a8231f38-20210911T190239Z-avarab@gmail.com>
Date:   Sun, 12 Sep 2021 15:26:44 -0700
In-Reply-To: <patch-v3-3.6-e23a8231f38-20210911T190239Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 11 Sep
 2021 21:09:02
        +0200")
Message-ID: <xmqqpmtdjuqj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 83853548-1418-11EC-A693-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index ad4746d899a..2910874ece5 100755
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -10,8 +10,6 @@ test_description=3D'our own option parser'
>  cat >expect <<\EOF
>  usage: test-tool parse-options <options>
> =20
> -    A helper function for the parse-options API.
> -
>      --yes                 get a boolean
>      -D, --no-doubt        begins with 'no-'
>      -B, --no-fear         be brave

Isn't this, and a lot more importantly the next one ...

> diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt=
.sh
> index b29563fc997..6badc650d64 100755
> --- a/t/t1502-rev-parse-parseopt.sh
> +++ b/t/t1502-rev-parse-parseopt.sh
> @@ -6,8 +6,6 @@ test_description=3D'test git rev-parse --parseopt'
>  test_expect_success 'setup optionspec' '
>  	sed -e "s/^|//" >optionspec <<\EOF
>  |some-command [options] <args>...
> -|
> -|some-command does foo and bar!
>  |--
>  |h,help    show the help
>  |

... coalmine canaries that tell us that end-user's scripts using the
"git rev-parse --parseopt" in the documented way will be broken?

I'd rather not have to sorry about breaking end-user scripts this
way.  Unlike a very small number of in-tree parse_options() call in
C programs, we have unbounded of them.

