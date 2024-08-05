Received: from srv1.79p.de (srv1.79p.de [213.239.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDBA41746
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.239.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873011; cv=none; b=rrWSPjYy+0rJowoLSdZfdVWdG4qQoYOV6qfTFwViLyJRbh6nxYRJHapfbKZ6Gm+Xx6YsGDgkQnbGc7oEx0Yq6Lhrp23SsgyzYfG4FpaWlyrRfdH9ijBLCtzdTZ/gWCSJPd2mBE9JMT1UGfTpRX8wj6b2dvPqmhP3/ly5n9i9evk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873011; c=relaxed/simple;
	bh=7W/iV6IMA5AOajf8VPpWdFrZdeWLhdmLFTPr5xCv6bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJQNyucCxYReVYT9jsFlsJ4E3LVV0aGY+kkpxbkYuaVnI4apmdYaAzhrLaJ2OvZMavcbmtJrLUIX9Nl3dekTimrofxHx8qr0U8XQRBkV94bw4Bv3VJQnVXcsarqHpQCZieaaZT2ip/bYjevxBkel6c7uQYzsPA6ENzjmluH1jNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs-ware.de; spf=pass smtp.mailfrom=cs-ware.de; dkim=pass (2048-bit key) header.d=cs-ware.de header.i=@cs-ware.de header.b=Clk2F+mu; arc=none smtp.client-ip=213.239.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs-ware.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-ware.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-ware.de header.i=@cs-ware.de header.b="Clk2F+mu"
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPV6:2001:9e8:2bd2:4700:dd04:f896:ad94:80b0] (unknown [IPv6:2001:9e8:2bd2:4700:dd04:f896:ad94:80b0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id A0D846000A2;
	Mon,  5 Aug 2024 17:50:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
	s=mail2024; t=1722873004;
	bh=7W/iV6IMA5AOajf8VPpWdFrZdeWLhdmLFTPr5xCv6bY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Clk2F+mucje65qK9qN2Fr2CU0TFENt62oiyy6HdD+x2sj4UGLYnOvnWuvJV2/UJyO
	 HmSRJwkIsE++BNC0+Ztf5ZJuED1ITIaoI5NMPqwNdokcLkwjOG0saBw0a1MDcfU4Fa
	 L5o54ha/KAACZyc0ScTtG5CEOZVgPfNM7kytoAvL8dDUqmPEEHcH396fHotiDcNQKo
	 lt/CpxkLtdYNRXdznRjCpEGrEpOZHZ0XWlhsFNmFsgXg38R+YdC6xm91IfbXk42WqO
	 HoEJbBettkQyu4K7nTCcVBayMakRMtjRhe0uJ4XTokL6RZKTjbD9DLI0ezlkUMcyp3
	 7kKhumqnk1dFg==
Message-ID: <8594c7bb-07ed-4c54-8712-5b0d4299b8eb@cs-ware.de>
Date: Mon, 5 Aug 2024 17:50:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] repository: prevent memory leak when releasing ref stores
Content-Language: en-US
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
 Sven Strickroth via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1758.git.git.1722855364436.gitgitgadget@gmail.com>
From: Sven Strickroth <email@cs-ware.de>
Autocrypt: addr=email@cs-ware.de; keydata=
 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
In-Reply-To: <pull.1758.git.git.1722855364436.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 05.08.2024 um 12:56 schrieb Sven Strickroth via GitGitGadget:
> -	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e)
> +	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e) {
>   		ref_store_release(e->value);
> +		free(e->value);
> +	}
>   	strmap_clear(&repo->submodule_ref_stores, 1);

After further checking this does not seem to be necessary. The ref 
stores are already free'd in strmap_clear.

-- 
Best regards,
  Sven Strickroth
  PGP key id F5A9D4C4 @ any key-server
