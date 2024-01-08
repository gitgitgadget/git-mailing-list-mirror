Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44945380D
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MU3+CxAA"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F3AEB31ABD;
	Mon,  8 Jan 2024 14:51:31 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jE7Xs46SsGaAF+j5WTpxpcemaCQvKVxjXi7npA
	WMo+A=; b=MU3+CxAAiPRThwy+UMXz1ybqc7WYSg7hbOYCI4UfQq9q37DMOv2P8Y
	szTGP3OF1YhVQ717Mf3riN39LtJXuNz5qXmwBgyzU93DHgJH7ENk3C6qeHbeFPnO
	Ah9FkCwXMpUpjaBONXxd7SFXWDt6b079aV+nvG/PrlzgXzFEN4Tbg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EBF5C31ABC;
	Mon,  8 Jan 2024 14:51:31 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9AC2131ABA;
	Mon,  8 Jan 2024 14:51:28 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Nathan Manceaux-Panot <fresh.tree3651@lemon.garden>
Cc: git@vger.kernel.org
Subject: Re: Analyzing a corrupted index file
In-Reply-To: <B38C5D82-33E3-4D10-8119-7E0D59DD3DA2@lemon.garden> (Nathan
	Manceaux-Panot's message of "Sun, 7 Jan 2024 16:22:02 +0100")
References: <B38C5D82-33E3-4D10-8119-7E0D59DD3DA2@lemon.garden>
Date: Mon, 08 Jan 2024 11:51:27 -0800
Message-ID: <xmqqh6jnk3i8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 503F0C98-AE5F-11EE-915D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Nathan Manceaux-Panot <fresh.tree3651@lemon.garden> writes:

> I have a corrupted git index file, and am trying to read it by
> hand, to understand what's wrong with it. Are there any tools
> that'll let me parse the on-disk, binary version of the index
> file, to unpack it into a human-readable data structure?

"git ls-files" with its various options is probably the closest, but
even the command is not meant for "debugging the bits".  It is more
about showing lower-level details of a working index file to help
diagnose the mismatch between end-user expectation and the reality
(e.g. the user says the conflicts were all resolved, an expert asks
to run "ls-files -u" and together they discover that there are paths
that are still unmerged).

