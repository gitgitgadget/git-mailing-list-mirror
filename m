Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2A23775
	for <git@vger.kernel.org>; Tue, 21 May 2024 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314842; cv=none; b=ib4pm7wL8k8lVAMs8L5J+Ch+o0+OIncF391dvpLQuHTIz56/kqzjOI5Vvny2tpiF90TrLajHJnsIZ6m2iNBEnK7OqDDFTb39zaq/zIy59+qnzOs6h7XW1Va84AaI7CHNguzEHu4keOAV5spmtUkpp0LkHZIN4CLW2r86BSfsSlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314842; c=relaxed/simple;
	bh=lSHiXjKbFkrW4vMbhvdPUDTcuVVjwBDQ63b3E2L9fmo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Co1HCdJjGu+osXen9oRV2ga1sPhd6YO8r5xTZu85MM3pyqWp1fh1WrLgiDiY0h9fS9Ggn6GYragLXoVp31vK+erMm5sRsM9LYM+Egz2ZBhZIOGmqGyedaAVFvD3B47bFaXYGMiJKPlMD2xwbevvy4S4UH4mgr7jMH9y1g2HG1+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DcWpJfbs; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DcWpJfbs"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AFF5021719;
	Tue, 21 May 2024 14:07:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lSHiXjKbFkrW4vMbhvdPUDTcuVVjwBDQ63b3E2
	L9fmo=; b=DcWpJfbsnpVceVgaQRogSIRQtWW5K+ihEsDKJbv01YczrjZsU2JHlH
	+iO+mqCvTiT5YKHHl+YG9N4UNgwZqwnQzaz3O/ZrcuuEmNTZoavkAtKSeo7VaS8U
	Yy9FEW/Omzl8xlH+5QVlqhdGtjNhwoTEBujqd2905MY0RagCQ7ITY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A6FAF21718;
	Tue, 21 May 2024 14:07:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A21F21717;
	Tue, 21 May 2024 14:07:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 0/5] Fix use of uninitialized hash algorithms
In-Reply-To: <ZkxUGzPn363PNWMF@tanuki> (Patrick Steinhardt's message of "Tue,
	21 May 2024 09:58:19 +0200")
References: <cover.1715582857.git.ps@pks.im>
	<20240520231434.1816979-1-gitster@pobox.com> <ZkxUGzPn363PNWMF@tanuki>
Date: Tue, 21 May 2024 11:07:12 -0700
Message-ID: <xmqqpltf9gz3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F39C5660-179C-11EF-8576-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I have two smallish comments, but neither of them really have to be
> addressed. Overall I very much agree with this iteration and think that
> it's the right way to go.

I've locally done the following locally but it probably does not
need to be resent to the list before merging down to 'next'.


1:  b23a93597c ! 1:  d3b2ff75fd setup: add an escape hatch for "no more default hash algorithm" change
    @@ Commit message
         default object hash, 2024-05-07), to keep end-user systems still
         broken when we have gap in our test coverage but yet give them an
         escape hatch to set the GIT_TEST_DEFAULT_HASH_ALGO environment
    -    variable to "sha1" in order to revert to the previous behaviour.
    +    variable to "sha1" in order to revert to the previous behaviour, in
    +    case we haven't done a thorough job in fixing the fallout from
    +    c8aed5e8.  After we build confidence, we should remove the escape
    +    hatch support, but we are not there yet after only fixing three
    +    commands (hash-object, apply, and patch-id) in this series.
     
         Due to the way the end-user facing GIT_DEFAULT_HASH environment
         variable is used in our test suite, we unfortunately cannot reuse it
2:  6a20370944 = 2:  abece6e970 t1517: test commands that are designed to be run outside repository
3:  fa258c5d47 = 3:  4a1c95931f builtin/patch-id: fix uninitialized hash function
4:  164d340cbe = 4:  8d058b8024 builtin/hash-object: fix uninitialized hash function
5:  bd0246eb51 ! 5:  4674ab682d apply: fix uninitialized hash function
    @@ Commit message
         Make sure we explicitly fall back to SHA-1 algorithm for backward
         compatibility.
     
    +    It is of dubious value to make this configurable to other hash
    +    algorithms, as the code does not use the_hash_algo for hashing
    +    purposes when working outside a repository (which is how
    +    the_hash_algo is left to NULL)---it is only used to learn the max
    +    length of the hash when parsing the object names on the "index"
    +    line, but failing to parse the "index" line is not a hard failure,
    +    and the program does not support operations like applying binary
    +    patches and --3way fallback that requires object access outside a
    +    repository.
    +
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## builtin/apply.c ##
    @@ builtin/apply.c: int cmd_apply(int argc, const char **argv, const char *prefix)
      	if (init_apply_state(&state, the_repository, prefix))
      		exit(128);
      
    ++	/*
    ++	 * We could to redo the "apply.c" machinery to make this
    ++	 * arbitrary fallback unnecessary, but it is dubious that it
    ++	 * is worth the effort.
    ++	 * cf. https://lore.kernel.org/git/xmqqcypfcmn4.fsf@gitster.g/
    ++	 */
     +	if (!the_hash_algo)
     +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
     +
