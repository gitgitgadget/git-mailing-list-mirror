Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8885C10F3
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 01:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dJrX2WSX"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10136D5A
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 17:32:06 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 78C5C1E56B;
	Wed,  8 Nov 2023 20:32:06 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=j+M1YiMkcDKxNdjVmQ/vBLvvRXD/MeGY9Nf8+L
	vCPIE=; b=dJrX2WSXChD9vBkRYD6PYvX3cGYaUFepl/2nVOsy0hngQWWFpdCOKj
	SFhJFNsMFksjtBzzPsOJehW948rF2yTvU6zSe57Z/l+9Y1Tuqo/w9fAzKhfWNvwD
	czQeyiT8BjcF0SZoNIVjv9wdLplysoAtL6iY8ydyOS8H0L0Bhyi8I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7111F1E56A;
	Wed,  8 Nov 2023 20:32:06 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8D1901E563;
	Wed,  8 Nov 2023 20:32:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Victoria Dye <vdye@github.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Victoria Dye via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 8/9] for-each-ref: add option to fully dereference tags
In-Reply-To: <xmqqfs1f3eji.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	09 Nov 2023 10:23:45 +0900")
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
	<352b5c42ac39d5d2646a1b6d47d6d707637db539.1699320362.git.gitgitgadget@gmail.com>
	<ZUoWWo7IEKsiSx-C@tanuki>
	<cf691b7c-288f-4cc9-a2ac-1a43972ae446@github.com>
	<xmqq4jhx7x8l.fsf@gitster.g>
	<898d3850-b0ca-485e-9489-320eee3121e4@github.com>
	<xmqqfs1f3eji.fsf@gitster.g>
Date: Thu, 09 Nov 2023 10:32:02 +0900
Message-ID: <xmqq5y2b3e5p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C9396714-7E9F-11EE-ABA7-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> You have to feed it to "git cat-file tag" and parse the contents of
> the tag obbject yourself to manually peel further levels of onion.

Alternatively, you can drive "git show -s" with "--format" and you
probably can produce a machine parseable output.

But it does not change the argument fundamentally.  The point is
that "for-each-ref --format=%(*field)" that peels only the first
layer would not have helped all that much, if somebody really cares
about each levels of nested tags.  They would have been relying on
a solution to deal with the second and further layers anyway, and
that solution would have been working with the first layer, too.

