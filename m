Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9BC6F06E
	for <git@vger.kernel.org>; Tue, 28 May 2024 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716932511; cv=none; b=cKXXOuOMfRkTdAbcO4/fmKOREr/Mv+cb1yy8OxNx/kwxjNFevOs8URdk8J3DmKZFhJZlA5yfkHGHg0a7mZ3BrJmQjO9VKIYP92X4tQuL/y+aSyiCwAsMxN3uiOLsUgtFlUzwhtL3tK7FoFuGkg79JiUbXPXSiNsgO3PWaWPaqfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716932511; c=relaxed/simple;
	bh=0kXp+ZeT2miFCemxVOChvhqFKxJ4OfXZ3NugejYFZyE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HS6pSwVZ7dQGH/SkCNNiyD//UN1MaGOCzMJ3Nn45JNfdQzxSxxtCKrI0PMeipfBQ8q/riZFmFC4qHbMtUihoaSHo3n4tdbRc4Nc93i/xAMxBCB9Bum5yH4qYke7r7imMr5IlipHrC4Cll25v0IkkY1umezyh/Q8JqN+0Tbly80M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IZQjc4u3; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IZQjc4u3"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 048F11CAE4;
	Tue, 28 May 2024 17:41:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0kXp+ZeT2miFCemxVOChvhqFKxJ4OfXZ3Nugej
	YFZyE=; b=IZQjc4u3aFC71w5sNVLLORWJFCt8RkKATtK6U6TTPH3KL18cH0Zh7d
	7vqNTWbiFij/qJMSzszs0gcTmoimmGL9Grb1SNeAM62E/Hl/uIMmf5cLMpeNl0VY
	TVCE+baHSlFOcgVgC8aT0tk925c3zwItkrMwFWHt3wTNDPKy2sKIA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F05361CAE3;
	Tue, 28 May 2024 17:41:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 621401CAE2;
	Tue, 28 May 2024 17:41:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Philip Peterson <philip.c.peterson@gmail.com>
Subject: Re: [PATCH 1/2] add-patch: do not use the_repository
In-Reply-To: <c0bb37db12ea8724431fe4294d591cd8cef73e66.1716877921.git.gitgitgadget@gmail.com>
	(Philip Peterson via GitGitGadget's message of "Tue, 28 May 2024
	06:32:00 +0000")
References: <pull.1728.git.git.1716877921.gitgitgadget@gmail.com>
	<c0bb37db12ea8724431fe4294d591cd8cef73e66.1716877921.git.gitgitgadget@gmail.com>
Date: Tue, 28 May 2024 14:41:47 -0700
Message-ID: <xmqqwmnd397o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 162E5EF0-1D3B-11EF-875F-25B3960A682E-77302942!pb-smtp2.pobox.com

"Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
> +static int parse_diff(struct repository *r, struct add_p_state *s, const struct pathspec *ps)

Given that add_p_state has add_i_state in it, which in turn as a
pointer to the repository, which is initialized like so:



        int run_add_p(struct repository *r, enum add_p_mode mode,
                      const char *revision, const struct pathspec *ps)
        {
                struct add_p_state s = {
                        { r }, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
                };
                size_t i, binary_count = 0;

                init_add_i_state(&s.s, r);

this patch looks wrong.  Adding a separate repository pointer to the
function means you are saying that this function should be able to
operate one repository in 'r' that may be DIFFERENT from the
repository add_p_state was initialized for.  I do not think you are
achieving that with this patch (and I do not think such a feature
makes much sense, either).

Instead just leave everything the same as before, and rewrite things
that depend on the_repository (either by explicitly referring to it,
or by implicitly using it, like empty_tree_oid_hex() which hardcodes
the use of the_hash_algo which is the_repository->hash_algo) to refer
to the repository the add_p_state was initialized for.
