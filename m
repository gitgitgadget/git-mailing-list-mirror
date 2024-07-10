Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B0B2B9DD
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720645469; cv=none; b=SbuL8vN7KR76Sj7i3tI+iZbpBaJr8IRXIRuzW2R2SlHoXd8cCvMp4gLW1CyV2nRd2Zfm6s1KmTxsP+046tB2+RFfzGplwNwTIY17cimUcM626T/oy2aCVbD5AiX1PztDErL3Z37f3+nZqag0Z87SPD+YBTLpiU/w3MYg1iaSD8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720645469; c=relaxed/simple;
	bh=o5DW3WsRVBmME7Q+FmLvPd0foD8+fky1eTt979DexSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gjx+ie7cE+oVmDWF4Pg0dHjSnCOu7e8mQpn2ySm1nniOhq1AOOyHixa3alJC5DA1dmK8H6WWYXgUbetEvdheUP7GJJLX/rxv+CQDZmHa5lQKqMFVIzXdWiizLEUinz3OFQ5vervK1ONkfkNXpfvADuMaTSDOR8rtKz4y+yzcPXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mIUJzTHE; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mIUJzTHE"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8EB113001D;
	Wed, 10 Jul 2024 17:04:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=o5DW3WsRVBmME7Q+FmLvPd0foD8+fky1eTt979
	DexSY=; b=mIUJzTHEMfe5C11Hcvd268cgqb+bIXQ5+sf/Heg2LaLhql7sEDGdnv
	McfseFMnWh7I2ocHSNOQqgP7B9u+jyOSlVSHWeO7N+BTAO+K84tGOtDabgFkWxtP
	8x7vqa5zSZIMJ6KQn/n5uP+/2Uv9muHGlvPNqgJK2ZGqwIZ/jS8+g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 86FD13001C;
	Wed, 10 Jul 2024 17:04:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6E19F3001A;
	Wed, 10 Jul 2024 17:04:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v10 03/10] fsck: add a unified interface for
 reporting fsck messages
In-Reply-To: <Zo6e61kSAvuvBvBS@ArchLinux> (shejialuo@gmail.com's message of
	"Wed, 10 Jul 2024 22:47:07 +0800")
References: <Zo6eJi8BePrQxTQV@ArchLinux> <Zo6e61kSAvuvBvBS@ArchLinux>
Date: Wed, 10 Jul 2024 14:04:15 -0700
Message-ID: <xmqqv81dufg0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F845ABDC-3EFF-11EF-A2A9-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> The static function "report" provided by "fsck.c" aims at checking fsck
> error type and calling the callback "error_func" to report the message.
> However, "report" function is only related to object database which
> cannot be reused for refs. In order to provide a unified interface which
> can report either objects or refs, create a new function "vfsck_report"
> by adding "checked_ref_name" parameter following the "report" prototype.
> Instead of using "...", provide "va_list" to allow more flexibility.

Like strbuf_vinsertf(), it is a good idea to have "v" in the name of
a function that takes va_list, but fsck_vreport() would probably be
a better name here.  Arguably, the original report() is misnamed (as
a printf-like function that takes format string, it probably would
have wanted to be reportf() instead), but unless we are fixing that
at the same time, calling this fsck_vreportf() would probably be too
much.  Consistently misnaming it by omitting the final "f" would be
fine.

At this step it is still not clear if the previous step was really
needed; you have this "v" thing that is designed to be usable by
both reporting issues around objects and issues around refs, but we
will hopefully see why when we read later patches.
> diff --git a/object-file.c b/object-file.c
> index 065103be3e..d2c6427935 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2470,11 +2470,12 @@ int repo_has_object_file(struct repository *r,
>   * give more context.
>   */
>  static int hash_format_check_report(struct fsck_options *opts UNUSED,
> -				     const struct object_id *oid UNUSED,
> -				     enum object_type object_type UNUSED,
> -				     enum fsck_msg_type msg_type UNUSED,
> -				     enum fsck_msg_id msg_id UNUSED,
> -				     const char *message)
> +				    const struct object_id *oid UNUSED,
> +				    enum object_type object_type UNUSED,
> +				    const char *ref_checked_name UNUSED,
> +				    enum fsck_msg_type msg_type UNUSED,
> +				    enum fsck_msg_id msg_id UNUSED,
> +				    const char *message)

That is somewhat annoying reindentation.  What happened here?
