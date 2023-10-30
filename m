Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D24D19450
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 23:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M7OCa4oO"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CA1101
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 16:54:02 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3DDDA1F84C;
	Mon, 30 Oct 2023 19:54:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MMYOg6NHjTM1KM5OfdOOGP9SnUAFJ/ZOjled5F
	dLVr8=; b=M7OCa4oOLyHW69QJHOiyYgVmNe8XFKiHBDAZPwBq11yLgOaWD4RPHf
	SUlzOgArwv3UUf7EyFc752T5oyYlV61NH5k7OOcyNuPC6fHbkLRNuYUsGUj9KDjX
	GDDyBeaOYZcnaeQ6+70/FvJLmLAr957cwXzdK8W6dL3OamvGXP9HU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 355B81F84B;
	Mon, 30 Oct 2023 19:54:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C7AD61F849;
	Mon, 30 Oct 2023 19:53:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Dragan
 Simic <dsimic@manjaro.org>
Subject: Re: [RFC PATCH 1/3] strbuf: make add_lines() public
In-Reply-To: <d96633a2919ac619ccf29e87abc6f25314a8bfb1.1698696798.git.jonathantanmy@google.com>
	(Jonathan Tan's message of "Mon, 30 Oct 2023 13:22:46 -0700")
References: <db6702ba-11a7-44c1-af2a-95b080aaeb77@gmail.com>
	<cover.1698696798.git.jonathantanmy@google.com>
	<d96633a2919ac619ccf29e87abc6f25314a8bfb1.1698696798.git.jonathantanmy@google.com>
Date: Tue, 31 Oct 2023 08:53:57 +0900
Message-ID: <xmqqy1fj8y5m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 97EA7D78-777F-11EE-8B92-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jonathan Tan <jonathantanmy@google.com> writes:

> Subsequent patches will require the ability to add different prefixes
> to different lines (depending on their contents), so make this
> functionality available from outside strbuf.c.

I do not think it is a good idea to force almost everybody to repeat
themselves.  As we can see here, all but just a single caller of
strbuf_add_lines() with this patch pass the same prefix for both
parameters.  If we need to make the current strbuf.c:add_lines()
also available to some specific callers, that is fine, but let's
keep the simpler version that almost everybody uses as-is, and give
the more complex and featureful one that is used only by selected
callers a longer and more cumbersome name.

Thanks.
