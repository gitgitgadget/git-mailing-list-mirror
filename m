Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34B73D57E
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="atg69u4b"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 78F661CA056;
	Tue,  9 Jan 2024 15:20:50 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=+
	1JSYhFP9wi54Wl9AMyQnyiH6JmEhPUNwYw4eHbza2U=; b=atg69u4bIeuahbwdb
	X+4bKh7PrBPrb3yJFamiWmD3TSr7xQE2nOVZTLVURLQh31IquXO3D7ZQMs/RWfCb
	gdvvx/rWJMm7CU54b97zvnoFcieVUjz6pfs2jcTTi71RLY+gouknE7RsOlUgDpJo
	ane8B++yFOaPE9oMqdTnjJV7fE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 704B01CA054;
	Tue,  9 Jan 2024 15:20:50 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF52E1CA053;
	Tue,  9 Jan 2024 15:20:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: what should "git clean -n -f [-d] [-x] <pattern>" do?
Date: Tue, 09 Jan 2024 12:20:48 -0800
Message-ID: <xmqq34v6gswv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9462B546-AF2C-11EE-BFBB-25B3960A682E-77302942!pb-smtp2.pobox.com

I think the current code makes "-n" take precedence, and ignores
"-f".  Shouldn't it either

 (1) error out with "-n and -f cannot be used together", or
 (2) let "-n" and "-f" follow the usual "last one wins" rule?

The latter may be logically cleaner but it is a change that breaks
backward compatibility big time in a more dangerous direction, so it
may not be desirable in practice, with too big a downside for a too
little gain.
