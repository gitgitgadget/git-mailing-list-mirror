Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADAE61F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 01:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406929AbfJRBii (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 21:38:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56184 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388373AbfJRBih (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 21:38:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 380772290C;
        Thu, 17 Oct 2019 21:38:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TLOjnZqugFYp
        JQJ9fKKyD21vTv0=; b=KMDcMwN5XtY5R/vMZUSS475+rCYeMyYhqdXRgjWafUiQ
        v8kpcjoG1dUk4bWNttphGYiJVDwyvRCC1BeiCfTCCdcnx5ABA3NThKBugHS9TyBt
        0NpeN75jNlosBGlMmpWMjLcRj8g0YtFOwLp32AtdTFHel2+bj477nJNAm4CJpUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ubZAhd
        8iDVfw9fufTMRb2mpJ7UzTRYOMl1xQE5MOJ1KGdiOZZv5Myqcjq4tKScLqn6naAJ
        7FbT9+c06o722ACiuA4fzaTKYKtMWnXr8t4CR4MwZy4MhCwAvBzrit006EpW1XT3
        VYP0REKreD5bYHUHubE03/pf5Sm4I3Jlb+Kv0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F7482290B;
        Thu, 17 Oct 2019 21:38:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 91FC02290A;
        Thu, 17 Oct 2019 21:38:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/3] grep: make PCRE2 aware of custom allocator
References: <pull.402.git.1571227613.gitgitgadget@gmail.com>
        <pull.402.v2.git.1571227824.gitgitgadget@gmail.com>
        <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
Date:   Fri, 18 Oct 2019 10:38:35 +0900
In-Reply-To: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
        ("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget"'s message
 of "Wed, 16
        Oct 2019 12:10:23 +0000")
Message-ID: <xmqqsgnq6des.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 00E00964-F148-11E9-A9D2-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Carlo Marcelo Arenas Bel=C3=B3n via GitGitGadget"
<gitgitgadget@gmail.com> writes:

>  builtin/grep.c |  1 +
>  grep.c         | 34 +++++++++++++++++++++++++++++++++-
>  grep.h         |  1 +
>  3 files changed, 35 insertions(+), 1 deletion(-)

> =20
> +#if defined(USE_LIBPCRE2)
> +	if (!pcre2_global_context)
> +		pcre2_global_context =3D pcre2_general_context_create(
> +					pcre2_malloc, pcre2_free, NULL);
> +#endif

This part should use the same "#ifdef" as the other one which is a
minor nit, for consistency.  I do not care too deeply which way we
unify, but we should stick to one.

> +
>  #ifdef USE_LIBPCRE1
>  	pcre_malloc =3D malloc;
>  	pcre_free =3D free;

Other than that, all 3 patches look sensible, and they certainly got
simplified by dropping the conditional ;-).

