Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B005C54918
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568118; cv=none; b=SUPCyKlovg4RUY3iw9hofvpOgrGIt8+VFUjP/yFzAinE8s65oCDJKcKhzZf0vR5jji9/XviZXcUhVx3Z0dGz98LcHhVu6mL/MIi+JjpQwPwXpvruDGvO53aIUJedTW9Hj90wtmxkZ6++6IA65OTWMC2Ve9/xE/e52TMmheOMP68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568118; c=relaxed/simple;
	bh=9p6OpnwM+ky3B1A+X0ZD/FfMSPxVRt5je3IfaakkYO0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kak7GUugpEF5TPpxA0tpx7g4+Mf4IAfvL95W060i0xoK3RiS7RdXa5MxR3qyvEe+K5Vrp0+nA3WmHwXA/FkCn/0VLslCWS2EaPqyAGFj7VfZfiSyGhdc2DAjSfOpm5vtPj7CFZAjQCJFnQB2nU16wc1tzozlaxuZdkT6anzMxvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nO/TXWML; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nO/TXWML"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 34BDF35DCA;
	Tue, 13 Aug 2024 12:55:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9p6OpnwM+ky3B1A+X0ZD/FfMSPxVRt5je3Ifaa
	kkYO0=; b=nO/TXWMLqUxLriGIZEq0Z4tM5JQHeqqSgTqqBuqfNXgSXX+EnIgqez
	XtUUYe2z1HkvdyolRX9MrOpZEvk1UDcJVYKMSL8bQUJf0RHokhZJnzlkInrwU3Jl
	gf0oT/kRL/J/PSOfqZu+gk2y9EO9Oe7syxW9vrNJ4adDU//LOqGqg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C06635DC9;
	Tue, 13 Aug 2024 12:55:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4E48E35DC8;
	Tue, 13 Aug 2024 12:55:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  James Liu <james@jamesliu.io>,  karthik nayak
 <karthik.188@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 18/22] builtin/format-patch: fix various trivial
 memory leaks
In-Reply-To: <c048b54a2c493658b2dd256b301491a79cfa99a1.1723540931.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 13 Aug 2024 11:32:02 +0200")
References: <cover.1722933642.git.ps@pks.im> <cover.1723540931.git.ps@pks.im>
	<c048b54a2c493658b2dd256b301491a79cfa99a1.1723540931.git.ps@pks.im>
Date: Tue, 13 Aug 2024 09:55:10 -0700
Message-ID: <xmqqed6s747l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CE53572A-5994-11EF-8941-BF444491E1BC-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> There are various memory leaks hit by git-format-patch(1). Basically all
> of them are trivial, except that un-setting `diffopt.no_free` requires
> us to unset the `diffopt.file` because we manually close it already.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/log.c           | 12 +++++++++---
>  t/t4014-format-patch.sh |  1 +
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index a73a767606..ff997a0d0e 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1833,6 +1833,7 @@ static struct commit *get_base_commit(const struct format_config *cfg,
>  			}
>  
>  			rev[i] = merge_base->item;
> +			free_commit_list(merge_base);
>  		}
>  
>  		if (rev_nr % 2)

This is correct, but isn't merge_base leaking when there are
multiple and we are not dying on failure?  Perhaps something along
this line?

			struct commit_list *merge_base = NULL;
			if (repo_get_merge_bases(the_repository,
						 rev[2 * i],
						 rev[2 * i + 1], &merge_base) < 0 ||
			    !merge_base || merge_base->next) {
				if (die_on_failure) {
					die(_("failed to find exact merge base"));
				} else {
                 +               	free_commit_list(merge_base);
					free(rev);
					return NULL;
				}
			}

> @@ -2548,12 +2550,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  			else
>  				print_signature(signature, rev.diffopt.file);
>  		}
> -		if (output_directory)
> +		if (output_directory) {
>  			fclose(rev.diffopt.file);
> +			rev.diffopt.file = NULL;

Is this a leakfix, or just a general code hygiene improvement?

> +		}
>  	}
>  	stop_progress(&progress);
>  	free(list);
> -	free(branch_name);
>  	if (ignore_if_in_upstream)
>  		free_patch_ids(&ids);

Good eyes. branch_name can be set and then "goto done" can jump this
one over, so it makes sense to move it below and make it part of the
centralized clean-up.  list is not leaking in the current code, and
there is no "goto done" or "return" after it gets allocated before
this point, so it can stay here.  On the other hand, it appears to
me that everything below stop_progress() we see above can be moved
below the "done:" label, except for that ids may still be left
uninitialized without getting populated by get_patch_ids() when
ignore-if-in-upstream is asked but head and upstream are the same
when we jump to the "done:" label, so it needs a bit more work _if_
we wanted to go that route.  I think the postimage of this patch,
i.e.  freeing the "list" and "ids" here before the "done:" label, is
a good place to stop.

Thanks.
