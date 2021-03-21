Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223EAC433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 02:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8B876194C
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 02:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhCUBRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 21:17:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57685 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCUBQt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 21:16:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 918021217CC;
        Sat, 20 Mar 2021 21:16:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QrZDk8bEKGmK
        lM0EfZ5SibADCs8=; b=TFJSIiYC1w9Mf/Z9kAC5kj4IUDfuMU9sfaC2mQTAWBPZ
        oivyxi5tTPMvoJsRk9x2Fuz4QQqbsiv8DuLMMmdn8IbrQ46XcwH+HDbm5r6VDRFu
        J/dJM8hgcqIXqgm2mQAAmlW28rsWm9ef48d/ZqWi7SL+ZN3NvC55pW+6x/4VdB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KwcaN+
        PasvNPn4D9Cz6X7GkPtM3js7ZWuUXZAfLv4ThhFpqvBIoalWFIp8oeQlcZceBnqY
        SrYpU0xX5yJV+YQdmrvJ/wXmAjwlEKMu0gx0MWFelUgDARIpRLTaTyn9KuL5eQhS
        hKh1ifX0RJUDy365S7McMFA0hJubbqBdP74Ho=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8ABF11217CB;
        Sat, 20 Mar 2021 21:16:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D6A151217CA;
        Sat, 20 Mar 2021 21:16:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v4 00/29] tree-walk: mostly replace "mode" with "enum
 object_type"
References: <20210316155829.31242-1-avarab@gmail.com>
        <cover.1616282533.git.avarab@gmail.com>
Date:   Sat, 20 Mar 2021 18:16:45 -0700
In-Reply-To: <cover.1616282533.git.avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 21 Mar 2021 01:00:33 +0100")
Message-ID: <xmqqtup5cnlu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1B06DF04-89E3-11EB-B26F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> A re-roll of v3 of this series[1] and on top of (and requires) my
> just-submitted v5 re-roll of the read_tree() refactoring series[2].
>
> There was a regression in 1/32 of the old series. Removing the
> canon_mode() call in diff.c didn't account for us needing to
> canonicalize "diff --no-index" modes. There were no tests for this,
> and it failed or not depending on the FS modes in the git.git checkout
> being tested. This fixes the CI smoke coming from this series.

Sorry, but quite honestly, I am not quite sure what value this
entire code churn is trying to add to the codebase.

The function signature of read_tree_fn_t callback function gets
changed from the mode bits (which is capable to express differences
between regular files, executable files and symbolic links) to "enum
object_type" (which can only say "this is a blob"), which is a
regression, no? =20

A callback can no longer do things like this, for example:

static int add_path_to_index(const struct object_id *oid,
			     struct strbuf *base, const char *path,
			     unsigned int mode, void *context)
{
	struct index_state *istate =3D (struct index_state *)context;
	struct cache_entry *ce;
	size_t len =3D base->len;

	if (S_ISDIR(mode))
		return READ_TREE_RECURSIVE;

	strbuf_addstr(base, path);

	ce =3D make_cache_entry(istate, mode, oid, base->buf, 0, 0);
	ce->ce_flags |=3D CE_SKIP_WORKTREE;
	set_index_entry(istate, istate->cache_nr++, ce);

	strbuf_setlen(base, len);
	return 0;
}

where executableness or symlinkshood is lost.

This probably is the third time I caught similar "let's lose
information passed through the call chain as nobody seems to need
it" mistakes in the iterations of this series, and that is two times
too many.  We should learn from our earlier mistakes---tweaking of
the API that happens to be still OK with the current codebase can be
either a needless churn that loses useful expressiveness from the
API, or a useful clean-up to kill dead parameter or excess
flexibility.

And these three incidents we have seen so far are the former.

Thanks.





