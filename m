Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839BAC433E0
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 21:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 454D82226A
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 21:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbhAPVsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 16:48:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61648 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbhAPVsx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 16:48:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B066AFCCC;
        Sat, 16 Jan 2021 16:48:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=71xwMPNgJ/lT
        RkzUZ8d7n5GyKSQ=; b=eQQb4z9yC5LYy2zYQiKqJ4sye7zIFkRiVaUKGMDRqOyj
        uczUogZsRbcNiSCUa3v+HbUBFP0NXJrdcZ3P0R62AZqZlR2HbrFayd3t7w52sRgK
        wV+cWnJ/WJssWSMvtHIn3+rD36OwrcI2HFisaR7c+vXE6I08Q5T9l3u1FXVD/Bw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pBrEew
        cIt0nm0vyWXnzOM2t2/EAW0B2sDcGoPVndi4VDB5lAtgKAWcDORybUIommvyipUF
        beTNQQeLLgHWXbzmYqQaeVkV5laePA/c7/6uLx7n6jQYUmyGCpELSA3o5cU+0/2Q
        IPtIhJTj289IKQIuUpfPUtlstxvFvd/mlQlUU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93802AFCCB;
        Sat, 16 Jan 2021 16:48:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0422BAFCCA;
        Sat, 16 Jan 2021 16:48:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 08/11] upload-pack tests: avoid a non-zero "grep"
 exit status
References: <20210114233515.31298-1-avarab@gmail.com>
        <20210116153554.12604-9-avarab@gmail.com>
Date:   Sat, 16 Jan 2021 13:48:09 -0800
In-Reply-To: <20210116153554.12604-9-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 16 Jan 2021 16:35:51 +0100")
Message-ID: <xmqqzh18o8o6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 865FAD4C-5844-11EB-9BE8-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Continue changing a test that 763b47bafa (t5703: stop losing return
> codes of git commands, 2019-11-27) already refactored. A follow-up
> commit will add support for testing under bash's "set -o pipefail",
> under that mode this test will fail because sometimes there's no
> commits in the "objs" output.
>
> It's easier to just fix this than to exempt these tests under a
> soon-to-be added "set -o pipefail" test mode. So let's do that.

Hmph, if you do not like the fact that grep indicates hits vs no
hits via its exit codes and you are purely interested in its text
munging utility, why not use a more appropriate tool than grep piped
to cut?  Running the same grep twice just to work around its exit
code looks doubly suboptimal.

	sed -n -e 's/\([0-9a-f][0-9a-f]*\) commit .*/\1/p' objs |
	sort >actual_commits

perhaps?

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t5703-upload-pack-ref-in-want.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-r=
ef-in-want.sh
> index eab966985b..420cf2bbde 100755
> --- a/t/t5703-upload-pack-ref-in-want.sh
> +++ b/t/t5703-upload-pack-ref-in-want.sh
> @@ -16,7 +16,11 @@ get_actual_commits () {
>  	test-tool pkt-line unpack-sideband <out >o.pack &&
>  	git index-pack o.pack &&
>  	git verify-pack -v o.idx >objs &&
> -	grep commit objs | cut -d" " -f1 | sort >actual_commits
> +	>actual_commits &&
> +	if grep -q commit objs
> +	then
> +		grep commit objs | cut -d" " -f1 | sort >actual_commits
> +	fi
>  }
> =20
>  check_output () {
