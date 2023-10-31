Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A151101E4
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uA1jxkq7"
Received: from pb-smtp21.pobox.com (unknown [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FC4EA
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 23:05:51 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6108F180D5;
	Tue, 31 Oct 2023 02:01:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jB26+OTUQy31uxwaGg437Q55csEpBiZP2z4yGQ
	gmHVw=; b=uA1jxkq75S+CgYZawyuOV4ehkLKFcVzdM2ZTR6OZoxSbi+hvsFXtv7
	sZVPUA2uyhazYFb014qQclKFkRf4oqBh7NzxEHWcSLm4LrZVxCPK+6U0QQPStyP+
	Qa4XseCaW5zEDtPRPwgnYY95t5MjPqaWYeTVlRVUt0VSph0BT+D2A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 59401180D4;
	Tue, 31 Oct 2023 02:01:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 72C02180D3;
	Tue, 31 Oct 2023 02:01:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Dragan
 Simic <dsimic@manjaro.org>
Subject: Re: [RFC PATCH 1/3] strbuf: make add_lines() public
In-Reply-To: <xmqqy1fj8y5m.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	31 Oct 2023 08:53:57 +0900")
References: <db6702ba-11a7-44c1-af2a-95b080aaeb77@gmail.com>
	<cover.1698696798.git.jonathantanmy@google.com>
	<d96633a2919ac619ccf29e87abc6f25314a8bfb1.1698696798.git.jonathantanmy@google.com>
	<xmqqy1fj8y5m.fsf@gitster.g>
Date: Tue, 31 Oct 2023 15:01:40 +0900
Message-ID: <xmqq1qdb49ff.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F6E0B0D0-77B2-11EE-AA52-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> Subsequent patches will require the ability to add different prefixes
>> to different lines (depending on their contents), so make this
>> functionality available from outside strbuf.c.
>
> I do not think it is a good idea to force almost everybody to repeat
> themselves.  As we can see here, all but just a single caller of
> strbuf_add_lines() with this patch pass the same prefix for both
> parameters.  If we need to make the current strbuf.c:add_lines()
> also available to some specific callers, that is fine, but let's
> keep the simpler version that almost everybody uses as-is, and give
> the more complex and featureful one that is used only by selected
> callers a longer and more cumbersome name.
>
> Thanks.

Another practical downside of this patch is that it breaks other
in-flight topics that adds new users of strbuf_add_lines(), and that
breakage is totally unnecessary.


