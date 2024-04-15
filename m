Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA68248E
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201027; cv=none; b=DVq6FdtP3U1f9oOGMiv3pWfQc2bdcP8yEEE4yMERQ/tPDaXr9n0984SBLFSI1Xc2V2E/3Lwahrth+nV7pcWOoe+v0v0aKCvnFQCL+RNlu26lMunFLYNeswo3h/PHZO/Obxyx047JFM6iavUTQ0FeGIbbaVmn3bamU0mltWWe2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201027; c=relaxed/simple;
	bh=nIHed3PoJ7dCtlDO4Ms9JvQ+KsAhjQ2jYtZJ1iI7Ehk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sxB6NGCjgpgJgN+07VHKTJA6Z3h82ZbPH0cYe2g5Tb4rhokbkYAwkBo3vEVY1uIynL8ipJtKvw+Vrj3ML9sUVcfoadbbYLhxd9aTAMSn9Uy4vDRCdXL5wtsMUhZuBNg2wtw7MDnmCQ4sMCdsmh3chkLiBQ26HhIgaXmZJu+Fjgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DchzRcyn; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DchzRcyn"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4551028A89;
	Mon, 15 Apr 2024 13:07:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nIHed3PoJ7dCtlDO4Ms9JvQ+KsAhjQ2jYtZJ1i
	I7Ehk=; b=DchzRcyn9DK9RT3neuUSRQTs6ZKCSqNG7Td9MV0PIhZg8HbAZ4AWWE
	rh1m+jeFHaZrW9yEoKi9NDaBFTTgtJzGR7PukSs9ov4G+QJUvEo8Gd7hl4owK9kV
	oaHXO/vjDYvI1WZ9QpVLhnsjrFvKSWncsFF9gNUIfFUOyHHaSa/3A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3DE0628A88;
	Mon, 15 Apr 2024 13:07:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3D0B228A86;
	Mon, 15 Apr 2024 13:07:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Thalia Archibald <thalia@archibald.dev>,  git@vger.kernel.org,  Chris
 Torek <chris.torek@gmail.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 0/8] fast-import: tighten parsing of paths
In-Reply-To: <ZhzR3QiuzfQ8LYgy@tanuki> (Patrick Steinhardt's message of "Mon,
	15 Apr 2024 09:06:05 +0200")
References: <20240322000304.76810-1-thalia@archibald.dev>
	<cover.1711960552.git.thalia@archibald.dev>
	<cover.1712741870.git.thalia@archibald.dev>
	<cover.1712907684.git.thalia@archibald.dev>
	<cover.1713056559.git.thalia@archibald.dev> <ZhzR3QiuzfQ8LYgy@tanuki>
Date: Mon, 15 Apr 2024 10:07:20 -0700
Message-ID: <xmqqpluqpnav.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9FD3C55E-FB4A-11EE-A51C-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I had another cursory read of this patch series that relied on the range
> diffs for most of the part. In any way, this version looks good to me.
> Thanks!

Likewise.  Let's mark it for 'next'.
