Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BF44F887
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775656; cv=none; b=mNWa2DB75zL1i8z0sTc1aLj2nAR6m9sNw17rGvAyeM71TO/t60so5f2ZHUTqZ+3xiBC+meuwXpBJ3NhmWLrGHdJ6VqZUzZF0ATY6HFlDAUyGJpbjDN5v0aR8MAKQatAZsSi5LXnMSTPxFvA2TtvrIxyBz+ac3d4ig1A3KEoxuRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775656; c=relaxed/simple;
	bh=RU5ZaAUt/2SquLofrK+pxeN8mafC2C2wc6raPOGjRfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MOJWpICZT5kbdXTRkdKzDheavludMPa2gfA3DX+B4bYwUfH1OIAJ+BEDR8YDXm7dFnw1DGj2MUGvcKLx95frJwrXC7DgHHbTXySZX4Xg8caz6LmbIbR71WQNMwn/SybV9kStpk1rbj4Cpm4v4UIgYf91AvcbEEtG2Mq2bUeL3n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JqncF0ab; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JqncF0ab"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CB254201EA;
	Mon, 18 Mar 2024 11:27:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RU5ZaAUt/2SquLofrK+pxeN8mafC2C2wc6raPO
	GjRfo=; b=JqncF0abmg0cK9WXR+TBlMAt3+F+P3NvzFsWRLVsmO6eFNMcJjvTlH
	KPyOdsc9zDc39t+01LWAUNKtbcjN2hyTYEGOEGoJLZ7amuT6EpyUOGwqChU7Brdt
	Q13qSg8d8u1HGv0TtJ8zjYXzR7bOVNkGIzje+i13fQLENi7KLItqE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C48DE201E7;
	Mon, 18 Mar 2024 11:27:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 94912201E2;
	Mon, 18 Mar 2024 11:27:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Mohit Marathe <mohitmarathe@proton.me>
Cc: Mohit Marathe via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Mohit Marathe <mohitmarathe23@gmail.com>,
  Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 2/2] patch-id: replace `atoi()` with
 `strtoi_with_tail()`
In-Reply-To: <jnBS0qo8QZFzqzU38VOg0t-BVquGuzjDdY820B8DW1uCd70FAetOik5rSV01nzSidyMqIPbarZ7lL9JNra-hR8Xzdfv9ZLcLI9wU3nyVgrI=@proton.me>
	(Mohit Marathe's message of "Thu, 14 Mar 2024 10:22:46 +0000")
References: <boJAHbg3xUqJ1hriFJu3QNlF9CYWbP9x9zu9mcV1jk1SI2WGAOes-wU1MMBZBWvMxs6VTkhlfE59iMEnYcDTOUTxA-3M72kvOJN613jaygw=@proton.me>
	<xmqq34st1bhh.fsf@gitster.g>
	<jnBS0qo8QZFzqzU38VOg0t-BVquGuzjDdY820B8DW1uCd70FAetOik5rSV01nzSidyMqIPbarZ7lL9JNra-hR8Xzdfv9ZLcLI9wU3nyVgrI=@proton.me>
Date: Mon, 18 Mar 2024 08:27:22 -0700
Message-ID: <xmqq7chzlfvp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0562C278-E53C-11EE-9E1E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Mohit Marathe <mohitmarathe@proton.me> writes:

> I thought replying in the same thread as that of patch would be enough.

Well, if you look at the headers of your message, there only is its
own Message-ID and no In-Reply-To or References, which some/many
MUAs go by.

> Just for the record, I was talking about this patch:
> https://lore.kernel.org/git/pull.1646.v6.git.1707025718.gitgitgadget
> @gmail.com/

Yup, thanks.  I ended up at the same place with subject search ;-)

