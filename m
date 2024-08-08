Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AEE3398E
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 19:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723147062; cv=none; b=Ni3JM1q8l2TCRKHUABO+44z3h6SzZgbqw2Pu1rZZi/ZbTGxloFgUYuLDtYaYlGTVyyxSwjIlGJoNM4xqEPLQD6KR6C+/W+7CXKuLIw3t8lYfCchFEZqPzoH45nwlm55C45Q5+P2M4FASfkdcvJB5If58SGO6QKKEWmM018FjgMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723147062; c=relaxed/simple;
	bh=rInlWwENluNAdGQ6laNDnTNiTw0Zk92DEoFzUu+T9TM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i5GEQZu+PpuumyZJ61BmYDLx5OwnLX2omFak0w6itnMXERogi7PNCkvGzUToxHSCJ80QvNAuqDKtqELdUd9v1u2+JcSwvoiBaSgxJ0bgpU1cudbEvyVTiXI8D78IuGSjqt+g/Qxx/5hRtw1ecMpxYgVbrQrJNxIeZcvQqdhoZXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vcho87la; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vcho87la"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD38431EEC;
	Thu,  8 Aug 2024 15:57:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rInlWwENluNAdGQ6laNDnTNiTw0Zk92DEoFzUu
	+T9TM=; b=Vcho87las76tRyAxNNFVS3zTj20DxKgZIg5lac4lqZwT8xbr2bnz8w
	JOQGLVBZC2hfOlXbdWzdU8wd3Tw2IwVV1gKOcI8XM3p3kN/YzSeENR3pRdC9WSWX
	WB5/qbj/ZFfooaIuA0ttLKnUcJZCitvGYanYqEYX1J6AMAvUqB8hQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C2AF631EEB;
	Thu,  8 Aug 2024 15:57:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 277C231EEA;
	Thu,  8 Aug 2024 15:57:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Josh Steadmon'" <steadmon@google.com>,  "'brian m. carlson'"
 <sandals@crustytoothpaste.net>,  <git@vger.kernel.org>,
  <calvinwan@google.com>,  <spectral@google.com>,
  <emilyshaffer@google.com>,  <emrass@google.com>
Subject: Re: [RFC PATCH 3/6] contrib/cgit-rs: introduce Rust wrapper for
 libgit.a
In-Reply-To: <00d901dae9c2$dc9c29c0$95d47d40$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Thu, 8 Aug 2024 14:43:23 -0400")
References: <cover.1723054623.git.steadmon@google.com>
	<9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com>
	<ZrPlQRAGQDMnVGjo@tapette.crustytoothpaste.net>
	<0a4601dae912$68d8e920$3a8abb60$@nexbridge.com>
	<zrbylipleb7fd7jrlnsampufeiuyiw2suwvd3tuxqoukhz6h52@dnjr7urrwzn3>
	<0a8401dae924$c9e8e9b0$5dbabd10$@nexbridge.com>
	<bs36iyp3yzb5l52t6yw5364odvugrt22jfeypqohtzdwp22ecj@kurf4p62qibu>
	<00d901dae9c2$dc9c29c0$95d47d40$@nexbridge.com>
Date: Thu, 08 Aug 2024 12:57:37 -0700
Message-ID: <xmqqcymihjny.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7716148E-55C0-11EF-8E86-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

<rsbecker@nexbridge.com> writes:

> I got to:
>
> ld -r contrib/cgit-rs/public_symbol_export.o libgit.a reftable/libreftable.a
> xdiff/lib.a -o contrib/cgit-rs/partial_symbol_export.o
> /usr/bin/c89: illegal option -- r
>
> The -r option is not supported on NonStop. I think we had discussed this.

Does it happen to call the feature under different name?  'r' stands
for relocatable output, but some linkers may call the feature as
incremental linking and use '-i'.
