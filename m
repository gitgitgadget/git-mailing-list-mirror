Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oa3Qn/v1"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43393115
	for <git@vger.kernel.org>; Sun, 19 Nov 2023 15:15:30 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DDC7C1D275B;
	Sun, 19 Nov 2023 18:15:26 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7ErZ1CLCnca6yZmUT1s68ZwR4D0xcPgJRnGeEe
	iT1cw=; b=Oa3Qn/v1/grsjpDsaDHe65razz5xi39wHXMS6boePpoa6Zw8e7hEI0
	0Y/gZSgf/DU8Dp65GycKdL/9gr2ldaSyXm2k53SF2LYtP6k7zzGvl94IamMdhYLz
	LMpkzk7DJtf/3zY79tytVtax8sCEzT6I39DLdmE2/vL4swJQdc5IU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A538F1D2758;
	Sun, 19 Nov 2023 18:15:26 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 127E01D2756;
	Sun, 19 Nov 2023 18:15:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Fix a typo in `each_file_in_pack_dir_fn()`'s declaration
In-Reply-To: <pull.1614.git.1700226915859.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Fri, 17 Nov 2023 13:15:15
	+0000")
References: <pull.1614.git.1700226915859.gitgitgadget@gmail.com>
Date: Mon, 20 Nov 2023 08:15:24 +0900
Message-ID: <xmqqfs11pc6r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 85AD9C00-8731-11EE-9794-25B3960A682E-77302942!pb-smtp2.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Subject: Re: [PATCH] Fix a typo in `each_file_in_pack_dir_fn()`'s declaration

Let's have "packfile.[ch]: " before the title to tell what area the
helper function is about.

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> One parameter is called `file_pach`. On the face of it, this looks as if
> it was supposed to talk about a `path` instead of a `pach`.
>
> However, looking at the way this callback is called, it gets fed the
> `d_name` from a directory entry, which provides just the file name, not
> the full path. Therefore, let's fix this by calling the parameter
> `file_name` instead.
>  ...
>  typedef void each_file_in_pack_dir_fn(const char *full_path, size_t full_path_len,
> -				      const char *file_pach, void *data);
> +				      const char *file_name, void *data);

Very good observation.  We form a pathname to a file in a
"objects/pack/" subdirectory by concatenating this parameter after
the full_path/full_path_len parameter, which has the path to that
subdirectory, so "file_name" definitely is a much better name.

The "full_path" that does not say full path to what directory may
have room for improvement ("leading_path" or even "packdir"), but
that's OK.

Thanks for spotting.

>  void for_each_file_in_pack_dir(const char *objdir,
>  			       each_file_in_pack_dir_fn fn,
>  			       void *data);
>
> base-commit: cfb8a6e9a93adbe81efca66e6110c9b4d2e57169
