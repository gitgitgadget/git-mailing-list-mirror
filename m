Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986E413D2E3
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709163805; cv=none; b=XZ1queUwx3sSKolKJ9957mu/HkMXlmEl5d0PpBPusNLKj3DQ4Lnz3bXZIIzMDNieB2YBCR6jQHASjBOSDd9zsGtWsv4AT6vIDOawKrsUZBiAcLjSW+mLQ2O/cmZv8JurQsNEhJXwYJGOfqc323ZfYyZSICqQLVsj6TmhTUO5J2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709163805; c=relaxed/simple;
	bh=S0oGJSdQHZRdTDeoAEGq0bZ+y5SF5vQMuy1Y8lTubRU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EvzLS3i5JWt3xJgqrbaaHbUAgfat61yqROUD9FMfyaxUCHeqgPXhSyu6FvAPgiPv3Ye2CDA/KqwFWGU1aOcpx+Y3emh6arPx4NjqGWQo9N+4hXYGfZRM66biNiPaJohyS35CFOC/AXkuKsWrbfJoq3vNDHktkvshwDq8X/S2hxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jGRi3/S3; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jGRi3/S3"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E52FA2F055;
	Wed, 28 Feb 2024 18:43:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=S0oGJSdQHZRdTDeoAEGq0bZ+y5SF5vQMuy1Y8l
	TubRU=; b=jGRi3/S3YTjjslrq1/RJmCxYaT/ROmp3Xpc+4nQkbYr3jwoXx9lMMD
	MHAss067yG2wOZuKViDrdqe6ZXM9XyoeNfAvi8Xzk4aBwNJfWFh+KAdHFkX5ULIe
	FbVeGZsB0OUf5MR0SWrh1i2VDXhSxp/UNLIsKneAeQkLrN762RjKQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DCAA62F054;
	Wed, 28 Feb 2024 18:43:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 868F52F050;
	Wed, 28 Feb 2024 18:43:18 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] upload-pack: only accept packfile-uris if we
 advertised it
In-Reply-To: <20240228225050.GA1159078@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 28 Feb 2024 17:50:50 -0500")
References: <20240228224625.GA1158651@coredump.intra.peff.net>
	<20240228225050.GA1159078@coredump.intra.peff.net>
Date: Wed, 28 Feb 2024 15:43:16 -0800
Message-ID: <xmqq5xy8jgtn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 26450422-D693-11EE-9C47-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> I suspect in the long term that we may have other ways to trigger this
> feature than the static blobpackfileuri config (e.g., a hook that knows
> about site-specific packfiles "somehow"). So we may need to update the
> test later for that, but presumably in the vanilla config we'll continue
> to skip advertising it.

Sounds quite sensible.  Thanks for a series that is very pleasant to
read.

>
>  t/t5702-protocol-v2.sh | 18 ++++++++++++++++++
>  upload-pack.c          | 16 +++++++---------
>  2 files changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 6ef4971845..902e42c1c0 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -778,6 +778,24 @@ test_expect_success 'archive with custom path does not request v2' '
>  	! grep ^GIT_PROTOCOL env.trace
>  '
>  
> +test_expect_success 'reject client packfile-uris if not advertised' '
> +	{
> +		packetize command=fetch &&
> +		printf 0001 &&
> +		packetize packfile-uris https &&
> +		packetize done &&
> +		printf 0000
> +	} >input &&
> +	test_must_fail env GIT_PROTOCOL=version=2 \
> +		git upload-pack client <input &&
> +	test_must_fail env GIT_PROTOCOL=version=2 \
> +		git -c uploadpack.blobpackfileuri \
> +		upload-pack client <input &&
> +	GIT_PROTOCOL=version=2 \
> +		git -c uploadpack.blobpackfileuri=anything \
> +		upload-pack client <input
> +'
> +
>  # Test protocol v2 with 'http://' transport
>  #
>  . "$TEST_DIRECTORY"/lib-httpd.sh
> diff --git a/upload-pack.c b/upload-pack.c
> index 491ef51daa..66f4de9d87 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -113,6 +113,7 @@ struct upload_pack_data {
>  	unsigned done : 1;					/* v2 only */
>  	unsigned allow_ref_in_want : 1;				/* v2 only */
>  	unsigned allow_sideband_all : 1;			/* v2 only */
> +	unsigned allow_packfile_uris : 1;			/* v2 only */
>  	unsigned advertise_sid : 1;
>  	unsigned sent_capabilities : 1;
>  };
> @@ -1362,6 +1363,9 @@ static int upload_pack_config(const char *var, const char *value,
>  		data->allow_ref_in_want = git_config_bool(var, value);
>  	} else if (!strcmp("uploadpack.allowsidebandall", var)) {
>  		data->allow_sideband_all = git_config_bool(var, value);
> +	} else if (!strcmp("uploadpack.blobpackfileuri", var)) {
> +		if (value)
> +			data->allow_packfile_uris = 1;
>  	} else if (!strcmp("core.precomposeunicode", var)) {
>  		precomposed_unicode = git_config_bool(var, value);
>  	} else if (!strcmp("transfer.advertisesid", var)) {
> @@ -1647,7 +1651,8 @@ static void process_args(struct packet_reader *request,
>  			continue;
>  		}
>  
> -		if (skip_prefix(arg, "packfile-uris ", &p)) {
> +		if (data->allow_packfile_uris &&
> +		    skip_prefix(arg, "packfile-uris ", &p)) {
>  			string_list_split(&data->uri_protocols, p, ',', -1);
>  			continue;
>  		}
> @@ -1847,8 +1852,6 @@ int upload_pack_advertise(struct repository *r,
>  	get_upload_pack_config(r, &data);
>  
>  	if (value) {
> -		char *str = NULL;
> -
>  		strbuf_addstr(value, "shallow wait-for-done");
>  
>  		if (data.allow_filter)
> @@ -1860,13 +1863,8 @@ int upload_pack_advertise(struct repository *r,
>  		if (data.allow_sideband_all)
>  			strbuf_addstr(value, " sideband-all");
>  
> -		if (!repo_config_get_string(r,
> -					    "uploadpack.blobpackfileuri",
> -					    &str) &&
> -		    str) {
> +		if (data.allow_packfile_uris)
>  			strbuf_addstr(value, " packfile-uris");
> -			free(str);
> -		}
>  	}
>  
>  	upload_pack_data_clear(&data);
