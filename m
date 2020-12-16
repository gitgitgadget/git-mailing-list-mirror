Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF09C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F9722DA9
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgLPAbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 19:31:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50786 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgLPAbm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 19:31:42 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 267669ECEC;
        Tue, 15 Dec 2020 19:30:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YkcolAAcPmnn
        iIfUOV5fhYLdSbs=; b=d6Krt62XAlIPKgBofEOf1bV/y9JVy+mQtN5N5YXKoE16
        OsMVhfjSAgQkZ/bY+EejsHvDKzo++UPp0YUubIEF73p9pHpWT6wyYNP3/VBRwFqS
        FYbskwjHrm4iZc9ypSw0FR9M+G16eVs7G3uxOADZI792FwgwCSU9CW6T7OaDXNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=in4L1e
        qQH+pQsArSADitp+6DPfHaBSmajizLDy02i5kxWrZVKEuPudQHUaur1yEQUwnwwi
        XQqaKQnqb+iIbSVDJGzshS65f7HBgnPqZxOG/eTawR+OVzDaImO/HBmviZLdPgU3
        n1SimF0SpHnhOJbcx+cwfte7YCEJFCyivYTzU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EADC9ECEA;
        Tue, 15 Dec 2020 19:30:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9157B9ECE9;
        Tue, 15 Dec 2020 19:30:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] style: do not "break" in switch() after "return"
In-Reply-To: <20201215235027.10401-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 16 Dec 2020 00:50:27 +0100")
References: <xmqq7dpkdup6.fsf@gitster.c.googlers.com>
        <20201215235027.10401-3-avarab@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Tue, 15 Dec 2020 16:30:57 -0800
Message-ID: <xmqqtusm618e.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F715E3D0-3F35-11EB-8BB8-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove this unreachable code. It was found by SunCC, it's found by a
> non-fatal warning emitted by SunCC. It's one of the things it's more
> vehement about than GCC & Clang.

This is a borderline Meh to me.

I am even tempted to suggest that, unless all other case arms
return, iow, if there is even a single arm that breaks, it may even
be more future-proof to end any and all case arms that do not
fall-thru to consistently end with break.

If there is some way to fix the compiler, that may be preferrable,
but as I said, this is borderline Meh and I do not care too deeply
either way.

Thanks.

> These return/break cases are just unnecessary however, and as seen
> here the surrounding code just did a plain "return" without a "break"
> already.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  apply.c               | 2 --
>  builtin/fast-export.c | 1 -
>  2 files changed, 3 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index 4a4e9a0158c..668b16e9893 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3948,10 +3948,8 @@ static int check_patch(struct apply_state *state=
, struct patch *patch)
>  			break; /* happy */
>  		case EXISTS_IN_INDEX:
>  			return error(_("%s: already exists in index"), new_name);
> -			break;
>  		case EXISTS_IN_INDEX_AS_ITA:
>  			return error(_("%s: does not match index"), new_name);
> -			break;
>  		case EXISTS_IN_WORKTREE:
>  			return error(_("%s: already exists in working directory"),
>  				     new_name);
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index d2e33f50052..0a60356b06e 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -923,7 +923,6 @@ static struct commit *get_commit(struct rev_cmdline=
_entry *e, char *full_name)
>  		if (!tag)
>  			die("Tag %s points nowhere?", e->name);
>  		return (struct commit *)tag;
> -		break;
>  	}
>  	default:
>  		return NULL;
