Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5494EBB
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 00:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NhvZowLy"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5408C420B
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 16:27:49 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D83A42B483;
	Fri, 10 Nov 2023 19:27:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QYwQgS6pYMp2A3ZLz2Uc0bO604LduO0Ik/dio5
	fJ5KI=; b=NhvZowLyAFjdCpJiSjUZgASRWsxjUA+HhhIMCISywLX0MSXwOsVNko
	D14RzFMU+DuOVrrCsLeVObENVCMHZ9BWMUn1bEnOeWYIP2ibkN69xgDXBNwpjtP8
	QjiG68m2OHQTYJdolRf8DFEjJ6BcmPCZkHOMapkjpvJvRM4zkwch0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D05AB2B482;
	Fri, 10 Nov 2023 19:27:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6E0EC2B47B;
	Fri, 10 Nov 2023 19:27:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  "Eric W.
 Biederman" <ebiederm@gmail.com>,  Jeff King <peff@peff.net>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 5/5] builtin/merge-tree.c: implement support for
 `--write-pack`
In-Reply-To: <CABPp-BEfy9VOvimP9==ry_rZXu=metOQ8s=_-XiG_Pdx9c06Ww@mail.gmail.com>
	(Elijah Newren's message of "Fri, 10 Nov 2023 15:51:18 -0800")
References: <cover.1697736516.git.me@ttaylorr.com>
	<cover.1698101088.git.me@ttaylorr.com>
	<3595db76a525fcebc3c896e231246704b044310c.1698101088.git.me@ttaylorr.com>
	<CABPp-BEfy9VOvimP9==ry_rZXu=metOQ8s=_-XiG_Pdx9c06Ww@mail.gmail.com>
Date: Sat, 11 Nov 2023 09:27:42 +0900
Message-ID: <xmqqmsvlrv5t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 226D7052-8029-11EE-947C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Elijah Newren <newren@gmail.com> writes:

> I believe the above is built on an assumption that any objects written
> will not need to be read until after the merge is completed.  And we
> might have a nesting issue too...
> ...
> This is unsafe; the object may need to be read later within the same
> merge.

Thanks for a good analysis.  I agree.

