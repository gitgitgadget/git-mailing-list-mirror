Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAA5200A6
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710006967; cv=none; b=TBuwLgLMNAXnNdSIQsbtmseQbFmyxSUlUBlHm4FfGJ885srg5FkuoljW3miZEyPyMLCtMBXhTC0hT7vuwU2fVfPhcwvVL7gXvsHhjKrcoajadyDRrJfNeTZa8tM8ZrrRRuE8NHFQMkKLgp5hkGcj89m7DJRXILsy2PJwEYN50tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710006967; c=relaxed/simple;
	bh=FTDYYKrtQBzjgdgV3/TNyRuse4leyIRhbBvtOOqpxoA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IrKx+/2h3g4Jmqmf+qRUvKoP3wmMAvCOhEOv8XOlDooBylgVihiydvrthywGWxbiC/6X22I8qSCV5mmJq5zjfisLCTSxUr0rIpPoMgC4grbEVZ1/AaXuq2qLNyJ3dR5X79ipB1W6gPSt3WwrJXgSvuZyNzHeM0iMrNLcdDHdgDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dSny286Z; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dSny286Z"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EE3561A69C;
	Sat,  9 Mar 2024 12:56:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FTDYYKrtQBzjgdgV3/TNyRuse4leyIRhbBvtOO
	qpxoA=; b=dSny286ZmHEuVUQfB4CZ17Ruxhr2sRDRAWHYdFmG4hQetbuedY+IAN
	PLeunY8qFQyJHTQCEVyRVwusYNPgWUp+vZpXMkPFhUnlmdu+5iuJMXr17BhDUVBq
	I8fqh/fgYek5QCeLrSAU7mFDKZfgYGh895ybK1r1CwjopGYD8hMck=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DE1A61A69B;
	Sat,  9 Mar 2024 12:56:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 86B101A699;
	Sat,  9 Mar 2024 12:56:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Dirk Gouders
 <dirk@gouders.net>,  Jeff King <peff@peff.net>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] merge-ort/merge-recursive: do report errors in
 `merge_submodule()`
In-Reply-To: <50fe1a26515c06afec5ac7fb723727e1365a14fc.1709993397.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Sat, 09 Mar 2024
	14:09:57 +0000")
References: <pull.1686.git.1709993397.gitgitgadget@gmail.com>
	<50fe1a26515c06afec5ac7fb723727e1365a14fc.1709993397.git.gitgitgadget@gmail.com>
Date: Sat, 09 Mar 2024 09:56:00 -0800
Message-ID: <xmqqwmqbcmrz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4B2D6F74-DE3E-11EE-95E5-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 24876ebf68b (commit-reach(repo_in_merge_bases_many): report missing
> commits, 2024-02-28), I taught `merge_submodule()` to handle errors
> reported by `repo_in_merge_bases_many()`.
>
> However, those errors were not passed through to the callers. That was
> unintentional, and this commit remedies that.
>
> Note that `find_first_merges()` can now also return -1 (because it
> passes through that return value from `repo_in_merge_bases()`), and this
> commit also adds the forgotten handling for that scenario.

Good clean-up.  But this "oops, we did not check for errors" makes
me wonder if we are better off adopting "by default we assume an
error, until we are sure we are good" pattern, i.e.

        func()
        {
                int ret = -1; /* assume worst */

                do stuff;
                if (...) {
                        error(_("this is bad"));
                        goto cleanup;
                }
                do stuff;
                if (...) {
                        error(_("this is bad, too"));
                        goto cleanup;
                }

                /* ok we are happy */
                ret = 0;

        cleanup:
                release resources;
                return ret;
        }

The patch to both functions do make it appear that they are good
candidates for application of the pattern to me.

Thanks.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  merge-ort.c       | 5 +++++
>  merge-recursive.c | 8 ++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 033c4348e2d..5d36c04f509 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -1819,6 +1819,7 @@ static int merge_submodule(struct merge_options *opt,
>  			 _("Failed to merge submodule %s "
>  			   "(repository corrupt)"),
>  			 path);
> +		ret = -1;
>  		goto cleanup;
>  	}
>  	if (ret2 > 0)
> @@ -1829,6 +1830,7 @@ static int merge_submodule(struct merge_options *opt,
>  			 _("Failed to merge submodule %s "
>  			   "(repository corrupt)"),
>  			 path);
> +		ret = -1;
>  		goto cleanup;
>  	}
>  	if (!ret2) {
> @@ -1848,6 +1850,7 @@ static int merge_submodule(struct merge_options *opt,
>  			 _("Failed to merge submodule %s "
>  			   "(repository corrupt)"),
>  			 path);
> +		ret = -1;
>  		goto cleanup;
>  	}
>  	if (ret2 > 0) {
> @@ -1866,6 +1869,7 @@ static int merge_submodule(struct merge_options *opt,
>  			 _("Failed to merge submodule %s "
>  			   "(repository corrupt)"),
>  			 path);
> +		ret = -1;
>  		goto cleanup;
>  	}
>  	if (ret2 > 0) {
> @@ -1899,6 +1903,7 @@ static int merge_submodule(struct merge_options *opt,
>  			 _("Failed to merge submodule %s "
>  			   "(repository corrupt)"),
>  			 path);
> +		ret = -1;
>  		break;
>  	case 0:
>  		path_msg(opt, CONFLICT_SUBMODULE_FAILED_TO_MERGE, 0,
> diff --git a/merge-recursive.c b/merge-recursive.c
> index f3132a9ecae..fc772c2b113 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1246,12 +1246,14 @@ static int merge_submodule(struct merge_options *opt,
>  	ret2 = repo_in_merge_bases(&subrepo, commit_base, commit_a);
>  	if (ret2 < 0) {
>  		output(opt, 1, _("Failed to merge submodule %s (repository corrupt)"), path);
> +		ret = -1;
>  		goto cleanup;
>  	}
>  	if (ret2 > 0)
>  		ret2 = repo_in_merge_bases(&subrepo, commit_base, commit_b);
>  	if (ret2 < 0) {
>  		output(opt, 1, _("Failed to merge submodule %s (repository corrupt)"), path);
> +		ret = -1;
>  		goto cleanup;
>  	}
>  	if (!ret2) {
> @@ -1263,6 +1265,7 @@ static int merge_submodule(struct merge_options *opt,
>  	ret2 = repo_in_merge_bases(&subrepo, commit_a, commit_b);
>  	if (ret2 < 0) {
>  		output(opt, 1, _("Failed to merge submodule %s (repository corrupt)"), path);
> +		ret = -1;
>  		goto cleanup;
>  	}
>  	if (ret2) {
> @@ -1281,6 +1284,7 @@ static int merge_submodule(struct merge_options *opt,
>  	ret2 = repo_in_merge_bases(&subrepo, commit_b, commit_a);
>  	if (ret2 < 0) {
>  		output(opt, 1, _("Failed to merge submodule %s (repository corrupt)"), path);
> +		ret = -1;
>  		goto cleanup;
>  	}
>  	if (ret2) {
> @@ -1312,6 +1316,10 @@ static int merge_submodule(struct merge_options *opt,
>  	parent_count = find_first_merges(&subrepo, &merges, path,
>  					 commit_a, commit_b);
>  	switch (parent_count) {
> +	case -1:
> +		output(opt, 1,_("Failed to merge submodule %s (repository corrupt)"), path);
> +		ret = -1;
> +		break;
>  	case 0:
>  		output(opt, 1, _("Failed to merge submodule %s (merge following commits not found)"), path);
>  		break;
