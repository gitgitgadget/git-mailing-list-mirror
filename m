Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AE46087C
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929958; cv=none; b=ZFfuAsT+dq/SfPY5UJRx4v9vuil/MOOMp0PTN42syTa4OOl4vgvI5i53ByeXLFjiK3D7zC9Pg2/JD46xG31Fayn5kayxyUjl341qCy3LdTJyzpuzkcGT6xA+Gk+scJn5CvPB8fBSVUtM0MOJDoMoBBSMKEbQ3qSmFSKk9GgJbME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929958; c=relaxed/simple;
	bh=MBzVAEdXhBoeWCmLmY4fgu4zrJ8GPT4onidMOSq7ALw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kcFwYvqtSvck9TYohAQGkVXo+AxtbUf6D5gbWhSntuheBiDEoIjrKRmeG+tsInAnmVQPwfgr7kIRL5FU8gD0cOryCucc80Tx9HWxAiAYwzlq3b7AIEztnwS6uqN57HTguZ+BReYgIV82rz5WLY1b6NBdVUUbWS9cRrYogt/JaqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lhrDMQHH; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lhrDMQHH"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C22F223A1;
	Wed, 14 Feb 2024 11:59:16 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MBzVAEdXhBoeWCmLmY4fgu4zrJ8GPT4onidMOS
	q7ALw=; b=lhrDMQHHQdJQNTDdsm7BLGjAtpDXz2wh6e9dMjY3zzGPEO2JiVmDJy
	DHTHgisZ2OOL9RHKSjMYQQsYLbUB1GwNQpkDzvdMUUPCy3D6AOvszTDs+PEnBIjB
	dlysGtsFcu2E4IoWh/LZPKFOtCQLAbj+0IBepONMaL5axFxapgy84=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 64830223A0;
	Wed, 14 Feb 2024 11:59:16 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0D33F2239F;
	Wed, 14 Feb 2024 11:59:13 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
  phillip.wood123@gmail.com,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/5] refs: introduce `is_pseudoref()` and `is_headref()`
In-Reply-To: <CAOLa=ZQN17Nyxo-uv7CytO1RkaPu9TPfeVHANvV=tycCGpy+Ng@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 14 Feb 2024 11:28:44 +0100")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240211183923.131278-1-karthik.188@gmail.com>
	<20240211183923.131278-2-karthik.188@gmail.com>
	<ZcoTbRxIaGmTd4fJ@tanuki> <xmqqh6ic5ex3.fsf@gitster.g>
	<CAOLa=ZQN17Nyxo-uv7CytO1RkaPu9TPfeVHANvV=tycCGpy+Ng@mail.gmail.com>
Date: Wed, 14 Feb 2024 08:59:11 -0800
Message-ID: <xmqqzfw3vv6o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 610BC92C-CB5A-11EE-87C2-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio, let me know if you want me to reroll for the whitespace issues.

I think I applied with "am --whitespace=fix", so we should be OK,
but if you can double check the result that would be appreciated.
