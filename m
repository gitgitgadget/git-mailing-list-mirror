Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3991D34CD8
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726260500; cv=none; b=J7bfkzXXB1nmbAfF1Q32+X9KI6Rl7x+ljNgXqkKy4yZlXS1rhjExG4nYpcYCF8lEZyBMGx/GnIvrOMPRRdPyhPlbMxfYyUs5c5gp3pHYAcdPvvfNKI6VVXKVjQNnSEBCS6Zx5FkXqrPeXFO7L8yPR7qeEwV5OGcQJu2l0scWpdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726260500; c=relaxed/simple;
	bh=++U7FIDGB0igUfUoTfH8dESexKvFSAzyVzZU165p2FA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t4jQKT6uOrMj0Yq5ou5xwjPRdqxS42AGfvOPmzscSIj4BygWNOQJ9U78TgF0VVfQrzAVhsHPLn/4+B37qJhQfYO5dCA20pXtWEFCVAa6j8h33s+wFJBhVqrqDKjC1RMqSCSQfBezKav+q7KSdv73QiOq7lVYJhJUjm3o9nj++Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Iz/2TE8n; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Iz/2TE8n"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E4BD22C3C;
	Fri, 13 Sep 2024 16:48:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=++U7FIDGB0igUfUoTfH8dESexKvFSAzyVzZU16
	5p2FA=; b=Iz/2TE8nVZtq5ioapYQauVze/NcTkGE3BEnNA6CL9AOInicBCvG11h
	2F35QiEEd0bFSkFXxhpYcBlEGw2R/KuPTBOn0zyL3FaeDYSmm1O21t0HhAGFnLBb
	/f1McA+Ulebev7izEEeAyBaftqMt7PNzsyKgwAcxLRg5q0LwFKE7E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 845FB22C3B;
	Fri, 13 Sep 2024 16:48:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D149F22C3A;
	Fri, 13 Sep 2024 16:48:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH] t5512.40 sometimes dies by SIGPIPE
In-Reply-To: <CAPig+cTj-6HQa4XToOTXZ2gsXKpgqxbUvRLoBLrTZ0VC3tJ6Mg@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 13 Sep 2024 15:44:09 -0400")
References: <xmqqmskbwe1a.fsf@gitster.g>
	<CAPig+cTj-6HQa4XToOTXZ2gsXKpgqxbUvRLoBLrTZ0VC3tJ6Mg@mail.gmail.com>
Date: Fri, 13 Sep 2024 13:48:09 -0700
Message-ID: <xmqqikuzwa9i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7CFD1812-7211-11EF-8C93-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>> A trivial fix, presented here, os to make sure that the helper reads
>
> s/os/is/

Thanks.
