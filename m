Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8039613A24B
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718400086; cv=none; b=ZqpZf/UZFc4kxSv628B/v94CHSolfoCQIiwpzXjUTWCyLoROWAfDlfp+bfixNCMJ485G8m+fonqOUqnzT9g9bugp3ntGcXkb9w369iYjNqlJOnilYeoBoN4wRBqvwdQ67CZ1wIoTvjmGUhqtIHPe2vTU//WgFZbD84tVp4zXcLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718400086; c=relaxed/simple;
	bh=BHB9xdrAe72QDGxTg4M3UrC5m3TJnoNCqjEUD+805zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HCiF6O1RNXv3aMxz37k/lAISMWa1yvwLwihvCABcCFRPKKlTIQom2O7qazs0wkAZBryA89U7Ny60dnajZQ40B5PmSbjPQ4Rgo7fbb1cOlmBiI5VgnalxVBuNP1X0RYv1WlT9YGo0ETg2qCQ3Q0uHDRB9iH+indUDpq8nq+uxhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nwwGJnuO; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nwwGJnuO"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D37C533F93;
	Fri, 14 Jun 2024 17:21:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BHB9xdrAe72QDGxTg4M3UrC5m3TJnoNCqjEUD+
	805zs=; b=nwwGJnuOtPiJ0pl0BmPRIp8m4Tb52Yuxkzzu4J6DqqTV7Fp25nf4nd
	4dVPWDCoIXiMGbVyqaf2NxoSUrEmjDa8x/JTOnRlgUYiqFzucYC9p826hZSalvhB
	BcV8gkzQ6pgI0e/ehHVm0ZQUj8SO80NB6fZ1IGlTBv4eWh+fzZ4js=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CD30733F92;
	Fri, 14 Jun 2024 17:21:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 130BF33F91;
	Fri, 14 Jun 2024 17:21:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] show-ref: introduce --branches and deprecate
 --heads
In-Reply-To: <CABPp-BH3ZozGnDueK=J4QvZMYZkS13Gk+0rhe+Dywqbx1F30DA@mail.gmail.com>
	(Elijah Newren's message of "Fri, 14 Jun 2024 19:32:27 +0000")
References: <20240603200539.1473345-1-gitster@pobox.com>
	<20240604220145.3260714-1-gitster@pobox.com>
	<20240604220145.3260714-4-gitster@pobox.com>
	<CABPp-BH3ZozGnDueK=J4QvZMYZkS13Gk+0rhe+Dywqbx1F30DA@mail.gmail.com>
Date: Fri, 14 Jun 2024 14:21:19 -0700
Message-ID: <xmqq7cerdxv4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0BA8F11E-2A94-11EF-A4D5-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Elijah Newren <newren@gmail.com> writes:

> If we are renaming --heads to --branches, should --head also be renamed?

I do not think so.  It is specifically about HEAD (the thing that
lives above refs/ hierarchy, historically implemented as a file
whose name is "HEAD" that is directly inside $GIT_DIR).

Thanks.
