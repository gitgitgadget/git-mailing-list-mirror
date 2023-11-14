Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762F36101
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 01:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aGjWUDs9"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25F21AB
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 17:41:03 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5DC9F29B0E;
	Mon, 13 Nov 2023 20:41:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=e0tTDUVWNe5mIBLBzt1tIyIMEKIigoLRXgYzDv
	4yKsw=; b=aGjWUDs92JtxmRm+FcEkRHzB9FuTX7NeKtC2bq5/6GMcxcVqOWMcPf
	48vCePyQxplUaNejj5asLycTyaUF7tiM5VYjYRb6DPNmyWVdU1CzI5Cg1kAnl8Li
	IlSucYqqCWi7Kd/bNVFNvJOkWvO3MruUdGq79xnqT1Vt1RsENqTtc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 555BC29B0D;
	Mon, 13 Nov 2023 20:41:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EC97F29B00;
	Mon, 13 Nov 2023 20:40:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  Elijah Newren <newren@gmail.com>,
  git@vger.kernel.org,  "Eric W. Biederman" <ebiederm@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 5/5] builtin/merge-tree.c: implement support for
 `--write-pack`
In-Reply-To: <20231113220546.GB2065691@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 13 Nov 2023 17:05:46 -0500")
References: <cover.1697736516.git.me@ttaylorr.com>
	<cover.1698101088.git.me@ttaylorr.com>
	<3595db76a525fcebc3c896e231246704b044310c.1698101088.git.me@ttaylorr.com>
	<CABPp-BEfy9VOvimP9==ry_rZXu=metOQ8s=_-XiG_Pdx9c06Ww@mail.gmail.com>
	<ZU7X3N/rqCK/Y9cj@nand.local>
	<20231113220546.GB2065691@coredump.intra.peff.net>
Date: Tue, 14 Nov 2023 10:40:58 +0900
Message-ID: <xmqqpm0d1591.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DD00E9AA-828E-11EE-BC49-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> I posted an alternative in response to Elijah; the general idea being to
> allow the usual object-lookup code to access the in-progress pack. That
> would keep us limited to a single pack.

If such a mechanism is done in a generic way, would we be able to
simplify fast-import a lot, I wonder?  IIRC, it had quite a lot of
code to remember what it has written to its output to work around
the exact issue your alternative tries to solve.  In fact, maybe we
could make fast-import a thin wrapper around the bulk checkin
infrastructure?

