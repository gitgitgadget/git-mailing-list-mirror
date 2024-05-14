Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1427B180A77
	for <git@vger.kernel.org>; Tue, 14 May 2024 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722712; cv=none; b=ZUf+t60I2i168xZJOj7aK5kUedXR+q8M41iyEF5gZ9PY1DvmxnhDpG0PrZz5ZqhzMIeNzVUUHNZLVr1dWEgqS8TEL9kY1Z9RhpfWuQxvObEcga6F5A1IXkMSsgEp0plLLdlA40Z14p/E+zuYqdbTP4GV7RzsXBow0TdZNKG9VVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722712; c=relaxed/simple;
	bh=arjyat1I7NwoAY8Rl/7Rc4u5QLKlJ+lUlJPwvC57Edo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ReHX7eGmgQFDIZ0sYdWemvrsR63MhiIht1GXDvyvJ1AtnWIJFSnPwWg+HMVKYf865xSXKNwv12mn4f1wpnC0LVXd60NUAR7WlzyQZ88RRdmIEAc6RN/+67RB6z5RJHpOwKQ0LSLM0EEkfeaMTz/NWo8CjlEazzHuUYvrH7Tisd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GpCBv/Su; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GpCBv/Su"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A27D93EE27;
	Tue, 14 May 2024 17:38:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=arjyat1I7NwoAY8Rl/7Rc4u5QLKlJ+lUlJPwvC
	57Edo=; b=GpCBv/SubkYAwLXS1cD5Zwjqxqq1J6Xh49DQ/1uT0hHx2M9h+WKSVk
	/EQrqEKt3z0hP95loL306a/SmUq5a7hGQ2yQK46G+sWKmW2dmjYCN4XbL2b973xf
	0geOa/st6DxhQUHuhxmBInWEDLKbS3lfZkhgYW1oiadtoem62PlTM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9ABF43EE26;
	Tue, 14 May 2024 17:38:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6CF63EE25;
	Tue, 14 May 2024 17:38:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Yongmin <revi@omglol.email>,  git@vger.kernel.org
Subject: Re: git format-patch displays weird chars when filename includes
 non-ascii chars
In-Reply-To: <ZkPNHqAUemfdfaFD@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 14 May 2024 20:44:14 +0000")
References: <ea41a92d-35df-4b71-be70-a736d620b21f@app.fastmail.com>
	<ZkPNHqAUemfdfaFD@tapette.crustytoothpaste.net>
Date: Tue, 14 May 2024 14:38:21 -0700
Message-ID: <xmqq1q643whe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 49E58D06-123A-11EF-A524-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Thus, Git prefers to encode names in a way that is unambiguous and
> doesn't lead to mangling.  It is inconvenient that legitimate UTF-8 file
> names don't get rendered properly, though.  I don't _believe_ there's an
> option to show the regular UTF-8, but I could be wrong.

$ git config --global core.quotepath false

