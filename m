Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF7F1B26D
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vMAefKmF"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F053D6E
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 13:11:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 230D527C0F;
	Mon, 23 Oct 2023 16:11:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IMHcqRvtR2cw8ywszi6GJ/KwU/vaJ5LIeiHKv1
	f9RCE=; b=vMAefKmFlMzayY8PQzGSbHtYFhxOWLmBjEzMbxj9B+28UqiDwP0pEU
	78T+NgR/owFSY6ayNzCbrxwc/HUUEgmncQOv7+b3DcAZO6M9VDpAMYpCZrzZIVAB
	RExlQWVEGapAUHB5U15g0Q/GhAboR12/Iwj/nv06rtOBB6WYJ+N3E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A7E127C0E;
	Mon, 23 Oct 2023 16:11:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9E46427C0D;
	Mon, 23 Oct 2023 16:11:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org,
  jonathantanmy@google.com,  calvinwan@google.com,  glencbz@gmail.com
Subject: Re: [PATCH v3 3/5] config: report config parse errors using cb
In-Reply-To: <ZTbJqzWDyqkhc6L9@nand.local> (Taylor Blau's message of "Mon, 23
	Oct 2023 15:29:47 -0400")
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
	<cover.1695330852.git.steadmon@google.com>
	<a888045c04d27864edf5751ea8641fdba596779c.1695330852.git.steadmon@google.com>
	<ZTbJqzWDyqkhc6L9@nand.local>
Date: Mon, 23 Oct 2023 13:11:52 -0700
Message-ID: <xmqqv8axm73r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 689A941C-71E0-11EE-BEB7-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

>> +	struct config_parse_options opts = CP_OPTS_INIT(CONFIG_ERROR_ERROR);
>
> I'm nit-picking, but I find this parameterized initializer macro to be a
> little unusual w.r.t our usual conventions.
>
> In terms of "usual conventions," I'm thinking about STRING_LIST_INIT_DUP
> versus STRING_LIST_INIT_NODUP (as opposed to something like
> STRING_LIST_INIT(DUP) or STRING_LIST_INIT(NODUP)).

FWIW, I have always felt that the way STRING_LIST_INIT* was done was
quite ugly.  The new pattern does look superiour, as long as (1) it
does not involve voodoo like token pasting, and (2) the parameters
passed does not grow.  The latter is especially important as there
is no equivalent to designated initializers in C preprocessor macros.

Thanks.
