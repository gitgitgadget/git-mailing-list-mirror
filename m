Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCEF1873
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yebJNOKm"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEDF10A
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 18:20:47 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D310C1CF858;
	Mon,  6 Nov 2023 21:20:46 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ybHVAdYkS+uV9k7vZljfqjqfJ3ul/tmDVMW1VK
	Jj8mQ=; b=yebJNOKmsl8T22CeU7vkrBGpW+OBNjqd9/zF6biVqx8UDI636NDlo8
	UQnH4pS2CuhVj9mxRhkmJ+3cIB0owuGWUQtxv5hqqWQCHebAruJMl0kxubg4xJMW
	dSq+2tZtd8qFPDMuDmHDxC6cdAdA6fZOoOmw+vOQcUTr5SaPqLbaI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C9F9E1CF856;
	Mon,  6 Nov 2023 21:20:46 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29C721CF853;
	Mon,  6 Nov 2023 21:20:46 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] pack-bitmap: drop --unpacked non-commit objects
 from results
In-Reply-To: <7492dc699052a392d2fb394e1dcfabebac82ded0.1699311386.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 6 Nov 2023 17:56:33 -0500")
References: <cover.1699311386.git.me@ttaylorr.com>
	<7492dc699052a392d2fb394e1dcfabebac82ded0.1699311386.git.me@ttaylorr.com>
Date: Tue, 07 Nov 2023 11:20:45 +0900
Message-ID: <xmqqfs1ib8xu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 42664C98-7D14-11EE-AE58-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

The same comment to the commit title applies here.

> .... Note that we do not have to
> inspect individual bits in the result bitmap, since we know that the
> first N (where N is the number of objects in the bitmap's pack/MIDX)
> bits correspond to objects which packed by definition.

;-)

Very nice.  Since we are omitting any object that appears in some
packfile, this produces an expected result even when some of these
objects also appear in loose form.

> +test_expect_success 'bitmap traversal with --unpacked' '
> +	git repack -adb &&
> +	test_commit unpacked &&
> +
> +	git rev-list --objects --no-object-names unpacked^.. >expect.raw &&
> +	sort expect.raw >expect &&
> +
> +	git rev-list --use-bitmap-index --objects --all --unpacked >actual.raw &&
> +	sort actual.raw >actual &&
> +
> +	test_cmp expect actual
> +'

OK.

