Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406B4241E5
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706303939; cv=none; b=FewjpsmKD4ZZb3eGJEaHNAkeRTsOerUwOBvV8nir4T9tn6G1ipu6KyqpwAJv7z+2XzvFoJEW7FY9N5gdNK/ELDKYjrCa0vK/SFMdYiXdyWjYtKsYaPQwCom4Oim/a+QAIz3TDtIM/4QIQLVBAjOFOS7gEY2DApt1/ubY/Gl9Gck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706303939; c=relaxed/simple;
	bh=nhwWizJ+XugkSHBeRSMl2VcGdlAiX69nS2+Xv7tqAWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BqAlwRez3+/UCh0mim9w8DrGT8rPId1oqNJHj9Sg3bEbsqUh/prAhHAazdM9A4zYQhiqmckKc+7aF+64K+zueX8HD5xkjNXwuA3ecFL3fSC7kgvJUY7gOHrEjgkqV6HSNLjSwJ+uqwFzcYpITUUJxW3Gw2rQiexSFb4+tENKuR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sbZliVCH; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sbZliVCH"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5ACE81CF8A2;
	Fri, 26 Jan 2024 16:18:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nhwWizJ+XugkSHBeRSMl2VcGdlAiX69nS2+Xv7
	tqAWo=; b=sbZliVCHOEozBnbpz7rFzajKfy33WcAqvw50wbgUoX1qIQy5tCCR19
	3Fw6ijTbmZGdOxKPGWovGBFjB2Ins0WjTNvlK6xSG1n59r0ok+q2dB672+YKk7LP
	OHmnGEFR/2N/dIRcw8kYDXvAZXyZliYdULo4jvLTIVTLL0+FYqgXQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 52DBE1CF8A1;
	Fri, 26 Jan 2024 16:18:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD7931CF8A0;
	Fri, 26 Jan 2024 16:18:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>,
    Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 0/2] index-pack: fsck honor checks
In-Reply-To: <pull.1658.v3.git.git.1706302749.gitgitgadget@gmail.com> (John
	Cai via GitGitGadget's message of "Fri, 26 Jan 2024 20:59:07 +0000")
References: <pull.1658.v2.git.git.1706289180.gitgitgadget@gmail.com>
	<pull.1658.v3.git.git.1706302749.gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 13:18:49 -0800
Message-ID: <xmqqfryjn686.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 803DDC28-BC90-11EE-BC7B-25B3960A682E-77302942!pb-smtp2.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  1:  b3b3e8bd0bf ! 1:  cdf7fc7fe8a index-pack: test and document --strict=<msg>
>      @@ Metadata
>       Author: John Cai <johncai86@gmail.com>
>       
>        ## Commit message ##
>      -    index-pack: test and document --strict=<msg>
>      +    index-pack: test and document --strict=<msg-id>=<severity>...

Ah, I missed this one.  Nice spotting.

>           5d477a334a (fsck (receive-pack): allow demoting errors to warnings,
>           2015-06-22) allowed a list of fsck msg to downgrade to be passed to
>      @@ Commit message
>           directly, (nor use index-pack for that matter) it is still useful to
>           document and test this feature.
>       
>      +    Reviewed-by: Christian Couder <christian.couder@gmail.com>
>           Signed-off-by: John Cai <johncai86@gmail.com>

I haven't seen Christian involved (by getting Cc'ed these patches,
sending out review comments, or giving his Reviewed-by:) during
these three rounds of this topic.  I'll wait until I hear from him
before queuing this, just to be safe.

>      ++	Die, if the pack contains broken objects or links. An optional
>      ++	comma-separated list of `<msg-id>=<severity>` can be passed to change
>      ++	the severity of some possible issues, e.g.,
>      ++	 `--strict="missingEmail=ignore,badTagName=error"`. See the entry for the
>      ++	`fsck.<msg-id>` configuration options in linkgit:git-fsck[1] for more
>      ++	information on the possible values of `<msg-id>` and `<severity>`.

This is much better than the tentative text I tweaked.  Nice.

>      ++--fsck-objects[=<msg-id>=<severity>...]::
>      ++	Die if the pack contains broken objects. If the pack contains a tree
>      ++	pointing to a .gitmodules blob that does not exist, prints the hash of
>      ++	that blob (for the caller to check) after the hash that goes into the
>      ++	name of the pack/idx file (see "Notes").

Not a new problem bit I have to wonder what happens if the pack
contains many trees that point at different blobs for ".gitmodules"
path and many of these blobs are not included in the packfile?  Will
the caller receive all of these blob object names so that they can
be verified?  The reference to the "Notes" only refer to the fact
that usually a single hash value that is used in constructing the
name of the packfile "pack-<Hashvalue>.pack" is emitted to the
standard output, which is not wrong per se, but does not help
readers very much wrt to understanding this.

[jc: dragging JTan into the thread, as this comes from his 5476e1ef
(fetch-pack: print and use dangling .gitmodules, 2021-02-22)].

>        +
>      ++Unlike `--strict` however, don't choke on broken links. An optional

You'd need a comma on both sides of "however" used like this, I
think.  

In any case, I thought your original construction to have this
"unlike" immediately after "die on broken objects" was far easier to
follow.

Thanks.
