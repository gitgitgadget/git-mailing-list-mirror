Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.33.87.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471574;
	b=jXJjN2Sm+UjqdiUL28Q3ctZ3VJyFuNNhsu2BndyjGNbngG1qR+zcIpb5luHRONHL7NfQ
	 9Es9LHpamQV/KbsEBdCnEJEPJ3AZlwHrRwiFHpl8Yf0yTWRCjLOgDlfAS8Zw+vZUNuLbs
	 bt/zcsOoTvTDIjtS6zDnpfhruyREhYfHOyAjngkjQaCgvsslIo+UD3DF9JiJcUSdq/WnA
	 3FluW37QQW0zge6T87QbtlqAlB92emAjB/2TAcc4W4jBdL/ZFUoulyWXsU5tQLuoiTWY+
	 ecW77jtGWxe+GhRvAG0fk4+hheMXfkja+TA5RVqWKlkBwdpmWWO99Un12X9jhuIwNxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471574;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=v+Xz9y2D0DvqB7OZ+pS5LEPLgXUKxIktFwORfBqgMMA=;
	b=5toKKESCQ6lgEGiKyb5YJX4tV4cVy4B1o3KJcJtHgjbTYyx5U6e5Eo9Xzy/kKWR+epXg
	 uHBNpZpr5YzmHYJ5Xi701gUO0EFItBYIga9kaLn7s0nbrITIuWgMceCV45ArNM48m2nUw
	 dEifc7jfNYiJnk0y60VvowyFkXDIyR4FfQWub6jG/AQs7Bj27Dzq1nYW6ebJmWkHjMEXb
	 osFK/bZ35Npz8zNAAr7V4iXXJStmafTHfAG+Uk2VcEmXlrg+lH9upVZO6zJMsMjXxVkLh
	 ThJFe2lXR2XLz9dti/6fZyHT83ZunhTd42o24uJwnv75ko2BzdKI5Bk7nC9LAA5XraA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kdbg.org;
	spf=pass smtp.mailfrom=kdbg.org;
	arc=none smtp.remote-ip=213.33.87.14
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6694B606A321
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 08:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6694B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4jQCwW0qHbzRlWw;
	Thu, 12 Nov 2026 09:19:22 +0100 (CET)
Message-ID: <0182f66a-f602-4ec6-8eea-055a69f0a1c3@kdbg.org>
Date: Thu, 12 Nov 2026 09:19:22 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] ci: some speedups for slow tests
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Torsten_B=C3=B6gershausen?=
 <tboegi@web.de>, git@vger.kernel.org
References: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
 <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 09.11.26 um 10:58 schrieb Patrick Steinhardt:
> The series contains a couple of bits that are specific to GitLab, and a
> couple of fixes that are generic. Some highlights:
> 
>   - Installing the Git for Windows SDK speeds up from 3 minutes to 10
>     seconds by using tar(1) instead of Extract-Archive.
> 
>   - t0027 speeds up from >10 minutes to 6 minutes on Windows by avoiding
>     the overhead of spawning redundant processes.
> 
>   - t5551 and t5559 both speed up by a factor of 10 on macOS, going from
>     20 minutes each to 2 minutes each by using reftables in a repo with
>     100k refs. "osx-meson" and "osx-clang" thus go from 29 minutes to 18
>     minutes end-to-end.
> 
>   - "fedora-breaking-changes-meson" speeds up by a factor of 2, going
>     from 35 minutes to 16 minutes. Turns out our SHA256 implementation
>     is quite slow with "-O0".
> 
> Unfortunately, our Windows runners at GitLab are still atrociously slow
> by themselves. So the critical path only improves by about ~10 minutes,
> going from 60-70 minutes to 53 minutes end-to-end. But hey, at least the
> other jobs now give feedback a bit faster. And I guess on GitHub it may
> be a different story because Windows runners are way better there and
> are typically not on the critical path.


I've tested this series on my Windows notebook and it is looking good.

The runtime of t0027 went down from 4:45 to 3:14, and that of t1092 from
6:15 to 5:33. t5551 is skipped in my setup.

Thanks!

-- Hannes

