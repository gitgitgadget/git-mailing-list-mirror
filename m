Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA9BC433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68D2C206D4
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AoDzMiGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgJLUEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:04:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61131 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgJLUEj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 16:04:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FAF98D92E;
        Mon, 12 Oct 2020 16:04:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=u1Da9TXB7C89
        YSeGyqX2YkhXYDk=; b=AoDzMiGFPVZA4+0gsx0D9WusvC+qvHFxwFlSfJbmSO9z
        IrkcvZzNj+jErNjCsAWIFI4GTgWz1kfT+i61KqKEGvnszaaCh/kWvbpNcsuRD41y
        RcvFhOCuxBSujQPu4bBqAm2kqL64lkkQ/AktV5h1eg2p6Zm25i1zGBX0X9yuE+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=H65gfu
        WdIBYJzszT+u4sjddLGYIGDkc86CNvDV7spR/9j6okLkF3mhQJXdfelSEfkk2M5d
        O+ozdncZxo7HZ0qkliFR06dFZgQBaiRgnFKr/yVFjEzbSwMp/+5bowe2YWQ40YdM
        z/+tKC+7jrSvrfPP1rXeqZtD/D8a8Zh4OKRgE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3843A8D92D;
        Mon, 12 Oct 2020 16:04:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BCA1B8D92B;
        Mon, 12 Oct 2020 16:04:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] diff: add -I<regex> that ignores matching changes
References: <20201001120606.25773-1-michal@isc.org>
        <20201012091751.19594-1-michal@isc.org>
        <20201012091751.19594-3-michal@isc.org>
Date:   Mon, 12 Oct 2020 13:04:36 -0700
In-Reply-To: <20201012091751.19594-3-michal@isc.org> (=?utf-8?B?Ik1pY2hh?=
 =?utf-8?B?xYIgS8SZcGllxYQiJ3M=?=
        message of "Mon, 12 Oct 2020 11:17:50 +0200")
Message-ID: <xmqqk0vvnrcb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2755A51E-0CC6-11EB-92A1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Micha=C5=82 K=C4=99pie=C5=84 <michal@isc.org> writes:

> +	/* see Documentation/diff-options.txt */

This comment adds negative value.

If it were

	/* "-I<regexp>" */

the readers won't have to switch to the file only to find out that
the comment didn't tell them where in the file to look at.=20

> +	regex_t **ignore_regex;
> +	size_t ignore_regex_nr, ignore_regex_alloc;
> +
>  	const char *single_follow;
>  	const char *a_prefix, *b_prefix;
>  	const char *line_prefix;
> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index 032e3a9f41..883a0d770e 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -79,6 +79,10 @@ typedef struct s_mmbuffer {
>  typedef struct s_xpparam {
>  	unsigned long flags;
> =20
> +	/* See Documentation/diff-options.txt. */

Likewise.

> +	regex_t **ignore_regex;
> +	size_t ignore_regex_nr;
> +
>  	/* See Documentation/diff-options.txt. */
>  	char **anchors;
>  	size_t anchors_nr;
