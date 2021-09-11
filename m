Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBEAC433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 00:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8719B61208
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 00:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhIKA1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 20:27:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50286 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbhIKA1I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 20:27:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E3E9614B072;
        Fri, 10 Sep 2021 20:25:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=w1dBXgY63+V9
        AMDyU4UDdtffcnlGO9m5kh1ry4M9mJI=; b=bbVN/ftDeHBGXzp1JKK7jkOehg9v
        7ONSB7KN0sJg/ST4SMmPu+I7LsC2Nts0elIsLO3LwXFwBltllo7TXG/UuAULOB3G
        76iQzmWuwM45ltpcdfZRYT+vEK9ZDmgGBl6PRiORdSlwOk89yi3/XDcYLnljkgh1
        XDNjEQzQ9sh63SQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DCCBF14B071;
        Fri, 10 Sep 2021 20:25:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3018E14B068;
        Fri, 10 Sep 2021 20:25:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/6] built-ins: "properly" align continued usage output
References: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
        <patch-v2-4.6-4547cc968b1-20210910T153147Z-avarab@gmail.com>
Date:   Fri, 10 Sep 2021 17:25:52 -0700
In-Reply-To: <patch-v2-4.6-4547cc968b1-20210910T153147Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 10 Sep
 2021 17:38:34
        +0200")
Message-ID: <xmqqfsucot4f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D35D01C8-1296-11EC-9B02-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Let's "fix" various "git <cmd> -h" output by "properly" aligning the
> output in cases where we continue usage output after a "\n". The "fix"
> and "properly" scare quotes are because this actually makes things

The "A" and "B" *in* scare quotes?

> The issue is that we should have whitespace corresponding to the
> length of the command name here, e.g. in the case of "git ls-remote"
> it should be 14 characters, or the length of ""git ls-remote
> ". Instead we had 21 characters in builtin/ls-remote.c, those extra 7
> characters are the length of "usage: " (and also " or:"). So in the C
> locale the resulting output aligns nicely:
>
>     $ git ls-remote -h
>     usage: git ls-remote [--heads] [--tags] [--refs] [--upload-pack=3D<=
exec>]
>                          [-q | --quiet] [--exit-code] [--get-url]
>                          [--symref] [<repository> [<refs>...]]

Isn't this aiming for a wrong end goal?  With an overly long
subcommand name, we'd end up with overly deep indentation of the
subsequent lines (hence too narrow a space to fit the options).

Rather, wouldn't it be better to aim for a consistent and wide
enough indentation, like say two tabs, everywhere, no matter how
long the subcommand name is?

Thanks.

