Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DB628DD5
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710007021; cv=none; b=hL4avkhRl+kpkzQr8q2sYiEsRkTJtvc6b2glT6Hbpz1k02lZdHGKtEsswTGFdKi/tJuP7yBe/wFveISN9mCZX58L+E0V8wG72qGJTaJoZyPJ4s7BReQNjqE7OEsoe/6YfJOoWprmnYyLa3CAuIcbOHAathmeof8KDQfvm/0cAHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710007021; c=relaxed/simple;
	bh=ue1PkzIvcnHXxks0VF9wIGaalWS72bGoqmB+/ZkfoqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D5bcMjKJBj0726+Fr8kTuQez8dHuXL5KvkABXJFMsBzX7RFmLUSFVKdBjTU6/ya7xA9uzv6JwkOKANbczp1kbxmMV0ttLjN8WYeb5HFJhPt6T7Ee8gF44RuKWrAHVsb8qNSR/z4faMaXv0Hc7xQUUkYT79oz/lkgBAey6guEoSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=R1OFgpAN; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R1OFgpAN"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DAE461A6AE;
	Sat,  9 Mar 2024 12:56:59 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ue1PkzIvcnHXxks0VF9wIGaalWS72bGoqmB+/Z
	kfoqA=; b=R1OFgpANST+ymGuwY7vvLdircMZ2oR7yMJkyz8bvGwQQEXJL20lvEW
	df+owKCeczfI3duSkbTTzTR88OmusSHyYP0suDDp2y7nYsZuxls9R1DukyWU6qn0
	MxV+EB/Ze0RWGRUQB0cThc73yv1sX9OhJLHUAoxzofuje+edIQ99I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D364E1A6AD;
	Sat,  9 Mar 2024 12:56:59 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 865901A6AC;
	Sat,  9 Mar 2024 12:56:56 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Dirk Gouders
 <dirk@gouders.net>,  Jeff King <peff@peff.net>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] The merge-base logic vs missing commit objects
 (follow-up)
In-Reply-To: <CABPp-BFKciBPN0WAaGaK4tb8hXit22Up4LMoJNxo-+DqEspD+A@mail.gmail.com>
	(Elijah Newren's message of "Sat, 9 Mar 2024 08:51:48 -0800")
References: <pull.1686.git.1709993397.gitgitgadget@gmail.com>
	<CABPp-BFKciBPN0WAaGaK4tb8hXit22Up4LMoJNxo-+DqEspD+A@mail.gmail.com>
Date: Sat, 09 Mar 2024 09:56:55 -0800
Message-ID: <xmqqsf0zcmqg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6B5D1164-DE3E-11EE-BC7F-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Elijah Newren <newren@gmail.com> writes:

>> This is a follow-up for
>> https://lore.kernel.org/git/pull.1657.v4.git.1709113457.gitgitgadget@gmail.com/,
>> based on the js/merge-base-with-missing-commit branch.
>
> This series looks good to me; thanks.

Thanks, both.
