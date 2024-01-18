Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ABE1844
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 01:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705540041; cv=none; b=HW73LVPWQ0HXSRaLM3Vt+fE1lfVmvpdQqvBDjlBL/mockE0ddZEKgiCYRtF0xfvrP39Xi2YggGpWQbpdxljAg+tZqF5nUEXLRvd2KgvVtKzO4PH+fIsoRWetZaeeLuufYlJbErFd4woMVqkdOTEd0ZaV0IByfQ/qW6ltvyethbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705540041; c=relaxed/simple;
	bh=29IKzY0zIqoQw6Lc5Cnq2W/Lp0cpWaVVZX+DHOIotFs=;
	h=Received:DKIM-Signature:Received:Received:From:To:Subject:Date:
	 Message-ID:User-Agent:MIME-Version:Content-Type:X-Pobox-Relay-ID;
	b=m55p5eyTndUB2/4wWZu1cKoAX1yNVUDNPUAzGAfoW5Y7V6EdjlwTCU2Y+//MvXok4nX/vtvIZNLHoWWGN9ueQkQVaOuuB+YjPbPHbZDjpFk62dxRgunhgO6SUnpTcsks3TrH1bDtGu8skDTWqCiF1qZYscR6sxU1EN/3OP+N1e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cThKYaJb; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cThKYaJb"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F9171C3C93;
	Wed, 17 Jan 2024 20:07:18 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=2
	9IKzY0zIqoQw6Lc5Cnq2W/Lp0cpWaVVZX+DHOIotFs=; b=cThKYaJbjCNO0ca40
	MZkwISEWVMRlFmCevupUb6hZASfXWAy447J6faemEegLhvWkNTx3H1hBmtBBnI3N
	wnTAcQZVpRgZbsCnMfmqfDsZ8Wzd7S/x7VGVlPJqQl8RpPe1ERH6vJerSlTG5BEW
	K9ElBQ64lupcf1mtqDdwA9mSN0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 779271C3C92;
	Wed, 17 Jan 2024 20:07:18 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B121E1C3C91;
	Wed, 17 Jan 2024 20:07:17 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [Bug?] "git diff --no-rename A B"
Date: Wed, 17 Jan 2024 17:07:16 -0800
Message-ID: <xmqq34uvtpob.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EC80A13A-B59D-11EE-B346-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

When the user misspells "--no-renames" as "--no-rename", it seems
that the rename detection (which is ont by default these days) still
kicks in, which means the misspelt option is silently ignored.
Should we show an error message instead?
