Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB8CC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 06:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D2164F23
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 06:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhCLGvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 01:51:02 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63996 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhCLGud (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 01:50:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0769412EDA1;
        Fri, 12 Mar 2021 01:50:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YDAOg9DsSpIV
        9wY/CqNm8srj3iQ=; b=gHw6kEn4LDQLh4onNVMFFI9r8J3E0YEewDG+Zn7rhiqe
        1S6z6ePHEx+eXizxtguOlmTqtpuzHdP0PKcU1H3VHTglIAERXrfCTC5Saj9b1j6p
        6DEnkl8B899BNQvd+Iy+vA8a22vWO9Xuzxvy7ktEGhtC4IgYol9WLrSa3EJlEpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EsojjR
        6VA/HSnFlC4L8DPaBfMLS3hOI/vS8EQs1704mA0uHjl0I0+LigCwp/ZrhRpfp3ZO
        LNWQzMjj41bJ5F0grSBOzwpI9ua93tlekzOzsuMb1ANhChojpypJmxOdWaBVPPaA
        zY8i+uwX897TvGP4pfWlamnvN/B8AmZGiQrgo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F391512EDA0;
        Fri, 12 Mar 2021 01:50:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4994812ED9F;
        Fri, 12 Mar 2021 01:50:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 05/20] sparse-index: implement ensure_full_index()
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
        <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <399ddb0bad56c69ff9d9591f5e8eacf52cf50a15.1615404665.git.gitgitgadget@gmail.com>
Date:   Thu, 11 Mar 2021 22:50:28 -0800
In-Reply-To: <399ddb0bad56c69ff9d9591f5e8eacf52cf50a15.1615404665.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 10 Mar 2021
        19:30:48 +0000")
Message-ID: <xmqq1rckc1cb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3C333EA6-82FF-11EB-B8B1-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  void ensure_full_index(struct index_state *istate)
>  {
> ...
> +	int i;
> +		tree =3D lookup_tree(istate->repo, &ce->oid);
> +
> +		memset(&ps, 0, sizeof(ps));
> +		ps.recursive =3D 1;
> +		ps.has_wildcard =3D 1;
> +		ps.max_depth =3D -1;
> +
> +		read_tree_recursive(istate->repo, tree,
> +				    ce->name, strlen(ce->name),
> +				    0, &ps,
> +				    add_path_to_index, full);

=C3=86var, the assumption that led to your e68237bb (tree.h API: remove
support for starting at prefix !=3D "", 2021-03-08) closes the door
for this code rather badly.  Please work with Derrick to figure out
what the best course of action would be.

Thanks.

> +		/* free directory entries. full entries are re-used */
> +		discard_cache_entry(ce);
> +	}
> +
> +	/* Copy back into original index. */
> +	memcpy(&istate->name_hash, &full->name_hash, sizeof(full->name_hash))=
;
> +	istate->sparse_index =3D 0;
> +	free(istate->cache);
> +	istate->cache =3D full->cache;
> +	istate->cache_nr =3D full->cache_nr;
> +	istate->cache_alloc =3D full->cache_alloc;
> +
> +	free(full);
> +
> +	trace2_region_leave("index", "ensure_full_index", istate->repo);
>  }
