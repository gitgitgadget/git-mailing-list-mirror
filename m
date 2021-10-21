Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EEFC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3646101C
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhJUX6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 19:58:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57932 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJUX6l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 19:58:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1C1BFEAD0;
        Thu, 21 Oct 2021 19:56:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=d1uluwzFQwrO
        L0ZTcgkZZ4gmgCiPvvTyS+647dFBvJ8=; b=CcmWvGN1iNTI/De7Av5pkR/PnETl
        ZIuNnPSUYoL5eCZpYNd07NrAZ5+T6cxtOL4mqXj7wNFBm0JJSfFpWraQIgDqTQ6N
        8txTmLqE8Vq+IyJfZxTsIp9TqMpnA2XRbQaC+mtd+Lh5qxBJjbwpURuurpXaDSzT
        BXMpmdT1cHYq2aE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8A7BFEACF;
        Thu, 21 Oct 2021 19:56:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2D89EFEACE;
        Thu, 21 Oct 2021 19:56:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/6] grep: use object_array_clear() in cmd_grep()
References: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
        <patch-2.6-727fdb27a2a-20211021T155529Z-avarab@gmail.com>
Date:   Thu, 21 Oct 2021 16:56:23 -0700
In-Reply-To: <patch-2.6-727fdb27a2a-20211021T155529Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Oct
 2021 17:57:33 +0200")
Message-ID: <xmqqr1ceexug.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7F4A78E6-32CA-11EC-AC91-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Free the "struct object_array" before exiting. This makes grep tests
> (e.g.  "t7815-grep-binary.sh") a bit happer under SANITIZE=3Dleak.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/grep.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index fd184c182a3..555b2ab6008 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1196,6 +1196,7 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
>  		run_pager(&opt, prefix);
>  	clear_pathspec(&pathspec);
>  	free_grep_patterns(&opt);
> +	object_array_clear(&list);
>  	free_repos();
>  	return !hit;
>  }

OK.
