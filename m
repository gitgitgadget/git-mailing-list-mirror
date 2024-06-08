Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D861CA9C
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 19:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717873292; cv=none; b=IFN4+ZW74KjkrpcUEe4FZLgM/puhRDuSQ5I99nWxPysHv7LAJZxEKvbCK2UreuQqy9XWsA2VMzI7Lg99NbvhVwD+fv09pEbbl4S8rTpdjx21eKqrJqAo3tIJF04Kc2KDCuuVH7F5YPpMiKQW9CDZ/BDShIBch/oBswOpDLLe3eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717873292; c=relaxed/simple;
	bh=CDz9VVzaGLLFG71FlCf/p2xa4hxjOp9SucWE7Dtbq/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eq7Qh/OKazaW07kqJxtD898KhqWLJ3CqbMLBGi/do1zy+WlOoG4+mogUNnaU7Pg+tSZ6qHQz9ZyDSYaNth7pz7S8YT9B/Z1ym6UXO62mLM0tid8ox/WNBGUUKbojH0t7y0vUhanAHhD7C2S18TI39scW14Y4eKruschtq7nIVHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gTR5qRKv; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gTR5qRKv"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3714438F02;
	Sat,  8 Jun 2024 15:01:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CDz9VVzaGLLFG71FlCf/p2xa4hxjOp9SucWE7D
	tbq/0=; b=gTR5qRKvb28j2FFkzxIGqoht5r5KqN1qa8ahoM7gFMbADQpL2maMX0
	+L+0hHjaazHz2uJvyA9sg1HgL80U08x6NK5aNxO7gtwfnbStE/5H68g8xoXiDJI4
	jk9bDzwHqdCs7KeAJJUzMtlMOGAgM6FLuhaKugwFDp4omZ1y905bk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2DEF238F01;
	Sat,  8 Jun 2024 15:01:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9290738F00;
	Sat,  8 Jun 2024 15:01:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v3 2/4] Makefile: add ability to append to CFLAGS and
 LDFLAGS
In-Reply-To: <20240608085528.GD2390433@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 8 Jun 2024 04:55:28 -0400")
References: <20240606080552.GA658959@coredump.intra.peff.net>
	<cover.1717742752.git.ps@pks.im>
	<d68539834f3827fa3ffe91517e053c043243a378.1717742752.git.ps@pks.im>
	<20240608085528.GD2390433@coredump.intra.peff.net>
Date: Sat, 08 Jun 2024 12:01:28 -0700
Message-ID: <xmqq4ja3cl87.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8378B6B8-25C9-11EF-980A-6488940A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> Another way to do this is just:
>
> diff --git a/Makefile b/Makefile
> index 2f5f16847a..9cd3b252ff 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1446,8 +1446,8 @@ ALL_COMMANDS_TO_INSTALL += git-upload-archive$(X)
>  ALL_COMMANDS_TO_INSTALL += git-upload-pack$(X)
>  endif
>  
> -ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS)
> -ALL_LDFLAGS = $(LDFLAGS)
> +ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS) $(CFLAGS_APPEND)
> +ALL_LDFLAGS = $(LDFLAGS) $(LDFLAGS_APPEND)

Much nicer.

> I can't think offhand of any way that your override would not do the
> right thing, but:
>
>  - this is roughly the same problem faced by DEVELOPER_CFLAGS, etc, so
>    handling it in the same way makes sense to me
>
>  - I always get nervous around make features like "override", as there
>    are sometimes corner cases lurking
>
> -Peff
