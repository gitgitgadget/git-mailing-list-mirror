Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4600C43334
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 18:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiFASxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 14:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiFASxF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 14:53:05 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78143147804
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 11:53:04 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 817E3186B8B;
        Wed,  1 Jun 2022 14:53:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=e85k4sWNltcO
        AbUgteZfi/PAYhy2ZuLjffZ5T5cxRn4=; b=xV580ukUOAYGBCpn7RexolDuZWRt
        4IgMIFv2ZAJTKTC7W/OnOv79SYQyr67CfrqggOYZp2l/oA+CMtfi+yK30j1G1tso
        hti/MA1qPG32594e8jVyID64kjCgkkPZWD6MFoKykAvrFTPz3O8pUsj/FwWPtakT
        OVVPGDITRfmi8fg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79ED5186B89;
        Wed,  1 Jun 2022 14:53:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 13C28186B85;
        Wed,  1 Jun 2022 14:53:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 6/6] cache-tree.c: use bug() and BUG_if_bug()
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
        <patch-v2-6.6-cbbe0276966-20220531T164806Z-avarab@gmail.com>
Date:   Wed, 01 Jun 2022 11:52:58 -0700
In-Reply-To: <patch-v2-6.6-cbbe0276966-20220531T164806Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 31 May
 2022 18:58:48
        +0200")
Message-ID: <xmqqilpkrzat.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0EEB27A0-E1DC-11EC-84DD-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change "BUG" output originally added in a97e4075a16 (Keep
> rename/rename conflicts of intermediate merges while doing recursive
> merge, 2007-03-31), and later made to say it was a "BUG" in
> 19c6a4f8369 (merge-recursive: do not return NULL only to cause
> segfault, 2010-01-21) to use the new bug() function.
>
> This gets the same job done with slightly less code, as we won't need
> to prefix lines with "BUG: ". More importantly we'll now log the full
> set of messages via trace2, before this we'd only log the one BUG()
> invocation.
>
> While we're at it let's replace "There" with "there" in the message,
> i.e. not start a message with a capital letter, per the
> CodingGuidelines.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  cache-tree.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index 6752f69d515..b91995af602 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -692,14 +692,14 @@ struct tree* write_in_core_index_as_tree(struct r=
epository *repo) {
>  	ret =3D write_index_as_tree_internal(&o, index_state, was_valid, 0, N=
ULL);
>  	if (ret =3D=3D WRITE_TREE_UNMERGED_INDEX) {
>  		int i;
> -		fprintf(stderr, "BUG: There are unmerged index entries:\n");
> +		bug("there are unmerged index entries:");
>  		for (i =3D 0; i < index_state->cache_nr; i++) {
>  			const struct cache_entry *ce =3D index_state->cache[i];
>  			if (ce_stage(ce))
> -				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
> -					(int)ce_namelen(ce), ce->name);
> +				bug("%d %.*s", ce_stage(ce),
> +				    (int)ce_namelen(ce), ce->name);
>  		}
> -		BUG("unmerged index entries when writing inmemory index");
> +		bug("unmerged index entries when writing inmemory index");
>  	}

I do not quite understand the last change here.  Shouldn't this be
either a BUG() that flushes previous bug() or BUG_if_bug() followed
by either a BUG() or an exit()?

> =20
>  	return lookup_tree(repo, &index_state->cache_tree->oid);
