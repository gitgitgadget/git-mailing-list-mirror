Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031B51A08AF
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727119965; cv=none; b=CocSqixsF4GmaIHzW711u/Cu3smxseUVLXFg1vAeSsLmRdjBOqTKmOOof+n4NFuFGj3/TdIUvGszfU5kv8VEYtwHK5r2R2ITKsreqHbym61UNr4scnoCK+SbU4UFlKxF2hWeHegFsMh+9vvBJlpHQpAyN+B66/ecYHKVrcEcsas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727119965; c=relaxed/simple;
	bh=8aFjwCkWP5Pt/ETqFpx0wRCyxsuWr9lyEeA7ViywRMQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IHuMPAN65vnAVgW/BFIu6ZnzB9u8i1UVGu11xDpD/3zIIz8RPvWTKmHphzX6Jnnf21ty42yQjXrB6ocHOvrHz1VNud2twsu0dDMZaDfPf4lwO5Wgc3BOzyBo27TgS92UI04a8fiTEFcutZrPRiyJQbZkN4Ih05VeDemQAqpudxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DVDosxp/; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DVDosxp/"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A5A81299B3;
	Mon, 23 Sep 2024 15:32:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8aFjwCkWP5Pt/ETqFpx0wRCyxsuWr9lyEeA7Vi
	ywRMQ=; b=DVDosxp/2eDl8Q91vgmcf/d37kUxTWGM7v38aoe/zP/an+FlKLoaiK
	RTDQULN200kZO7DUnOf5Z8uaHPCi0r8MeK3/fCozdzgq4pkheXGTWERltL1lIopd
	aOAqUFt3IoKSpDh7WZr1e9FPBoyCOfEtVQHL9bu0rXiVBCBQwSxqc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DE4F299B2;
	Mon, 23 Sep 2024 15:32:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F98D299B1;
	Mon, 23 Sep 2024 15:32:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Nicolas Guichard via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Nicolas Guichard <nicolas@guichard.eu>
Subject: Re: [PATCH 1/2] sequencer.c: extract load_branch_decorations
In-Reply-To: <7f3d5e5da356f93ebef300ef73bfd6c312013e09.1726943880.git.gitgitgadget@gmail.com>
	(Nicolas Guichard via GitGitGadget's message of "Sat, 21 Sep 2024
	18:37:59 +0000")
References: <pull.1784.git.git.1726943880.gitgitgadget@gmail.com>
	<7f3d5e5da356f93ebef300ef73bfd6c312013e09.1726943880.git.gitgitgadget@gmail.com>
Date: Mon, 23 Sep 2024 12:32:40 -0700
Message-ID: <xmqq7cb217zb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 99BF9DFC-79E2-11EF-95F6-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Nicolas Guichard via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Nicolas Guichard <nicolas@guichard.eu>
>
> Extract load_branch_decorations from todo_list_add_update_ref_commands so
> it can be re-used in make_script_with_merges.
>
> Signed-off-by: Nicolas Guichard <nicolas@guichard.eu>
> ---
>  sequencer.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)

This intends no behaviour change, and it indeed does not make any
behaviour change.  Good.

> diff --git a/sequencer.c b/sequencer.c
> index 8d01cd50ac9..e5eb6f8cd76 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5810,6 +5810,20 @@ static const char *label_oid(struct object_id *oid, const char *label,
>  	return string_entry->string;
>  }
>  
> +static void load_branch_decorations(void)
> +{
> +	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
> +	static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
> +	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
> +	struct decoration_filter decoration_filter = {
> +		.include_ref_pattern = &decorate_refs_include,
> +		.exclude_ref_pattern = &decorate_refs_exclude,
> +		.exclude_ref_config_pattern = &decorate_refs_exclude_config,
> +	};
> +	string_list_append(&decorate_refs_include, "refs/heads/");
> +	load_ref_decorations(&decoration_filter, 0);
> +}

The load_ref_decorations() function can be called only once per
process, so it does not matter whatever garbage your second and
later invocations throw at it.

But if this function is ever called N times, you'll add N copies of
"refs/heads/" in the _include list, and because the variable is
static, it is not reported as a leak.

It may have been OK back when this implementation was inside
todo_list_add_update_ref_commands(), which was called by
complete_action() only once before the process exited.

But now you made it a "reusable" function, we should clean up after
ourselves, perhaps by dropping "static" from these three string_list
instances and clearing them after calling load_ref_decorations().
