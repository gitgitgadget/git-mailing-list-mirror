Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B09B379
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HWGXdACQ"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978F6D7D
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 17:39:56 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DA82629C71;
	Fri, 20 Oct 2023 20:39:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WQxhwWfAd1ABNjHrZd+gnS8KXghKJk+lOqN0us
	I3Dvs=; b=HWGXdACQGWTwcy9y+hMw4YT0PkIU70iCJg0bjNIHCW42Z+kFxYzdYj
	vIM4eFVIGUpYbgsGBYIIyP3ISHPtoef4yO1y7HvLrRo9dsXP2oRSEd3wT4U74wcP
	D+iMbhRme6dmTGukE6sPisKrGwymnytlCe3Gxd6UVtTMzHyUgsbck=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C6EDA29C70;
	Fri, 20 Oct 2023 20:39:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5822329C6F;
	Fri, 20 Oct 2023 20:39:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Stopak <jacob@initialcommit.io>,
    Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] bugreport: include +i in outfile suffix as needed
In-Reply-To: <20231016214045.146862-2-jacob@initialcommit.io> (Jacob Stopak's
	message of "Mon, 16 Oct 2023 14:40:45 -0700")
References: <20231015034238.100675-2-jacob@initialcommit.io>
	<20231016214045.146862-1-jacob@initialcommit.io>
	<20231016214045.146862-2-jacob@initialcommit.io>
Date: Fri, 20 Oct 2023 17:39:49 -0700
Message-ID: <xmqqo7gsolka.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 586DB57A-6FAA-11EE-A7D6-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jacob Stopak <jacob@initialcommit.io> writes:

>  int cmd_bugreport(int argc, const char **argv, const char *prefix)
>  {
>  	struct strbuf buffer = STRBUF_INIT;
>  	struct strbuf report_path = STRBUF_INIT;
>  	int report = -1;
>  	time_t now = time(NULL);
> -	struct tm tm;
>  	enum diagnose_mode diagnose = DIAGNOSE_NONE;
>  	char *option_output = NULL;
> -	char *option_suffix = "%Y-%m-%d-%H%M";
> +	char *option_suffix = "";
> +	int option_suffix_is_from_user = 0;
>  	const char *user_relative_path = NULL;
>  	char *prefixed_filename;
> -	size_t output_path_len;
>  	int ret;
> +	int i = 0;

OK, I think between me and you, we stared at this piece of code long
enough to make ourselves numb.  The original "at most one report per
a minute" default came from the very original in 238b439d
(bugreport: add tool to generate debugging info, 2020-04-16) and
that is what we are changing, so let me summon its author as an area
expert for a pair of fresh eyes to see if they can offer any new
insights.

Thanks.

https://lore.kernel.org/git/20231016214045.146862-1-jacob@initialcommit.io/
