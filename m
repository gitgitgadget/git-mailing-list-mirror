Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511EE86AE6
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412045; cv=none; b=bmQH+CBFAQjz6f2eeJ0sYgI+gfoZRIi62BehiHpHHv3g0eL9VURcTQAddqJ4dQLcvqQNMQom0Q1sWWXK25gunknzDDfvYI57OB3IdvcSLCEwoghHgNxTzCaW3ROjP7Uoj9kTerHUb6lTJQcBcXhToAIW7y3U9Dv9WTV0/0j/AyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412045; c=relaxed/simple;
	bh=ohzxFwf2wKnF17zlrwW9DT7se360zd2i7vcHu92YYkY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CwChxn4ePRSyk65Ip3D7v3Qhu4uZEdK/Tdo8Hz5tmrOzeNoyJsUv+2g50+2rA5CJ1cP+PiGv0yRCZIYWAsS2dn4XAf2dPCG6VFTK87pBUW5wKLeQ41atvANa+teCe+7Iw+bnyZp2yIHO9ofvE+4hAFnajZSx/OHQcM8sI4lq8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BKSnIV+G; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BKSnIV+G"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A91231E752F;
	Thu,  8 Feb 2024 12:07:21 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ohzxFwf2wKnF17zlrwW9DT7se360zd2i7vcHu9
	2YYkY=; b=BKSnIV+G1uJkq4WFyNrmOA0gR7wn7tP1+6xPVXKF3/yYmKw23rapHJ
	dM39yt6T2CWYq9UghLe9GBt0Ap1LONJ+z05aBZ3bVe/fIV5oH2CP38qEjiurQOrR
	w4r4sSz20rwgeu35MIawinMAB6jlbSGpB0K9qCelGEXv6H3JV+fko=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A20891E752E;
	Thu,  8 Feb 2024 12:07:21 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0E25A1E752D;
	Thu,  8 Feb 2024 12:07:20 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
In-Reply-To: <613b85a3-677d-40d8-84b5-69dd5c27cafe@gmail.com> (Phillip Wood's
	message of "Thu, 8 Feb 2024 10:28:52 +0000")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240129113527.607022-1-karthik.188@gmail.com>
	<20240129113527.607022-5-karthik.188@gmail.com>
	<98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com>
	<CAOLa=ZR=_tt=ppphGMkxqj_YB5G+YkTMWGzRzcHTbrZz4ysb5w@mail.gmail.com>
	<92ba680d-0b48-49f0-aafc-f503e5a5e0ea@gmail.com>
	<xmqqle7xjzic.fsf@gitster.g> <xmqqr0hph1ku.fsf@gitster.g>
	<CAOLa=ZSZJ=_VCppHXcJeE=Z61go4_040xyc1NBTu-o=xysLrdg@mail.gmail.com>
	<xmqqcyt9fdc7.fsf@gitster.g>
	<613b85a3-677d-40d8-84b5-69dd5c27cafe@gmail.com>
Date: Thu, 08 Feb 2024 09:07:19 -0800
Message-ID: <xmqq34u2q3zs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8570603A-C6A4-11EE-B2E9-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> This is a bit of a tangent but I've been wondering what the practical
> benefit of distinguishing between "HEAD" and "pseudoref" is.

I hate that distinction too.  The practical difference they gave me
was that we historically never made FOO_HEAD to be a symref, and we
do not want them to be in the future, but for HEAD, it is perfectly
natural to be a symref.

