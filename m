Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8628405B
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 19:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814419; cv=none; b=NCwYNYoKjHRm9LSJ5S7RwMlJ0MhbP+iXGuCv08JRGZgi80Rj7noZkoWD+XhYbg1E99bLbpL4Aoilzfya99WHPUW1d7PRAB5myxKcHVoj/gqlg342zBvVLGc1nJgyk+kU7BIgVc02lQnelZ12XccpyAqOoyEb3HrSnE9jMgWGtN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814419; c=relaxed/simple;
	bh=F2JsmpZVb5HXZ/O9PfRwYiWcofU/34ErkJraZWcrC4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q5z98QNU/ii8jqZdsFwcE+K7oMZvIau3KfUWIJ56maJBxlYgkhxLDp+2HRFXGFs+4+uK9nIt1MMb3GZh3EVU5PIcA+XtCql379tVVlbdLcHJLgOHugJingqWfeOJH9VC1D/8WB8RtcphbRKv4SNHHetrB43ZXELYq21goJxQ5mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DOR/iDmO; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DOR/iDmO"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 81DAA1E1517;
	Thu,  1 Feb 2024 14:06:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=F2JsmpZVb5HXZ/O9PfRwYiWcofU/34ErkJraZW
	crC4Q=; b=DOR/iDmOHNxg9L8yadNTAU7x5TBJQlUsAK9KNA3d/Kv0Dcb9F4Yi6b
	vwDuMrygW3mFEE3i7Bai2+B6T4GzJuCQjPAo69+qSgzR2pCynUWZOeYic/+3WAo/
	vaBFadp5CAEw34sRddG4sfQARRc7ET8QI9RckaYUmbyajxVPUdNXI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 77E561E1516;
	Thu,  1 Feb 2024 14:06:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE70E1E1515;
	Thu,  1 Feb 2024 14:06:55 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH v3 07/10] trailer: prepare to move
 parse_trailers_from_command_line_args() to builtin
In-Reply-To: <97e5d86ddf0ea25df1b512dfbf620910298c1b02.1706664145.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Wed, 31 Jan 2024 01:22:21
	+0000")
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<97e5d86ddf0ea25df1b512dfbf620910298c1b02.1706664145.git.gitgitgadget@gmail.com>
Date: Thu, 01 Feb 2024 11:06:54 -0800
Message-ID: <xmqqeddwypf5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1104A428-C135-11EE-9B3D-25B3960A682E-77302942!pb-smtp2.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Rename add_arg_item() to trailer_add_arg_item() because it will have to
> be exposed as an API function in the next patch. Rename
> new_trailers_clear() to free_new_trailers() because it will be promoted
> into an API function; the API already has free_trailers(), so using the
> "free_*" naming style will keep it consistent. Also rename "conf_info"
> to "trailer_conf" for readability, dropping the low-value "_info" suffix
> as we did earlier in this series for "trailer_info" to "trailer_block".

Makes sense.

Thanks.
