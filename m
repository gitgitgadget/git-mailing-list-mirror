Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55681D0554
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906339; cv=none; b=Z37R1kieZezjkCcZV5fPZMUPULwFWEwOt0IBH4nwoYYpdu2XnfYIQ9JBWOKAsVvVgl/903e1T4lgpfO843WNK1dyZjncBygPQnkyqx0Iyf85rUUWHhlejoyt+8HsfUE0DejRs4I7GIkT3akn4bynrLaxApcOLgrBP8bnhnClSAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906339; c=relaxed/simple;
	bh=d5+WJJDvhJoNimIhaT92zFAWxZA5N++QFIJ70Q6DYqE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aPQ+rja15AQUsatS4u4rYVOcpuqTi5AX51gK6rmAwzHBnWkGiyv2Piubg/2BqXiTqaeR8V9OuOpZNdpsLTzWUcO5Ob+19PW5oU6LHEDshmLBZHdyr3FhvE3dTKZbZxJVGU58e1PL8TGNFGJgKXt+lVtmG3I49eW2NwMMIhoRrcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xl0bKwvb; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xl0bKwvb"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FB0F2EC6C;
	Thu, 20 Jun 2024 13:58:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=d5+WJJDvhJoNimIhaT92zFAWxZA5N++QFIJ70Q
	6DYqE=; b=xl0bKwvbdZFz5SoKpMrSuSO+6b2gSAtL+gXnU6ylhtlQuk831NEAlb
	gSNedmBtNau+iCDACYTTuGX6p+fi5M8eSqcZX3oKFmuoDI00wAKLzanDD6dVQ8OW
	3QOi9MDT/djCb5KD9beCciFyJaiHWQXEXpNm6a3KIN7GNT0kGNQto=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CFBEC2EC6B;
	Thu, 20 Jun 2024 13:58:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 701222EC6A;
	Thu, 20 Jun 2024 13:58:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mingw: drop bogus (and unneeded) declaration of `_pgmptr`
In-Reply-To: <20240620105105.5xv2ywxzzye4wjtk@glandium.org> (Mike Hommey's
	message of "Thu, 20 Jun 2024 19:51:05 +0900")
References: <pull.1752.git.1718777398765.gitgitgadget@gmail.com>
	<20240620105105.5xv2ywxzzye4wjtk@glandium.org>
Date: Thu, 20 Jun 2024 10:58:51 -0700
Message-ID: <xmqqzfrfv6lg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C19841CA-2F2E-11EF-9577-C38742FD603B-77302942!pb-smtp20.pobox.com

Mike Hommey <mh@glandium.org> writes:

> I can only suppose it gets rid of the compiler error with close to 100%
> certainty because for some reason, it only happens intermittently for me
> and I don't know whether I'm lucky or if the issue is fixed for real,
> but what it absolutely sure is that it doesn't break anything.

That is a curious vote of confidence ;-)  Will queue.  Thanks, both.
