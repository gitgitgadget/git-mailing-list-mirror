Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5E64683
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 00:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783105; cv=none; b=h8FEJK/C3iAVBucAWnm0renVhD1yBL6Ln4Z5f0oxzGZwLFXzgwk5/u31jxlgPpICbmlMd/9YbcsfZIkZ0p7JV+nDr04jaAw9D686gr/YbRlJUVI4XyUB+RZ/tX1gfyTno9jNcNACYK3ZuW25nyAoImemqEOW/SP6kJuKNYtJvbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783105; c=relaxed/simple;
	bh=DyEohaNYMHlfwWLtucD6O1vIE3DKpTzEePiXkQZVeyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D0aTwIRR6IWI7CCT5ydGPZG/NW7DdOikhKCeHITSoteWc0lIv9K7lOM9WKQ2Vm45tq5qlpxoNcQWxdClr5p0Q2GRjVb9GVHvZxjgneJ8eypGBfRLBpzsAZ4rqMwVm+X0Q04VyMexQd0erVj6MlrOZ5LTYdg8gCslHKNRoGVBN3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=t93M62JN; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t93M62JN"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB69D1F5FAF;
	Mon, 12 Feb 2024 19:11:41 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DyEohaNYMHlf
	wWLtucD6O1vIE3DKpTzEePiXkQZVeyU=; b=t93M62JNwui80J6ipc/UchkX/14D
	VBKfeW4HR9IAshP3ad091YSIAcVtA/42zOgva7D/DLsP5FcCzSdqRBaJSbDep0h3
	htZKksV1ZqY42JtdtLqFvaGikbRvO/V3eHX1WmogQHADjt+Z73pP+ZDnSKzGnMos
	Xhmx6fsZZ++5+so=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C194B1F5FAE;
	Mon, 12 Feb 2024 19:11:41 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2FAAC1F5FAD;
	Mon, 12 Feb 2024 19:11:41 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH v4 00/28] Enrich Trailer API
In-Reply-To: <CAP8UFD3qLGua5PTA+i29N+yJH8iKVBPwUn=S606B2E+s959JFQ@mail.gmail.com>
	(Christian Couder's message of "Tue, 13 Feb 2024 00:37:23 +0100")
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
	<CAP8UFD3qLGua5PTA+i29N+yJH8iKVBPwUn=S606B2E+s959JFQ@mail.gmail.com>
Date: Mon, 12 Feb 2024 16:11:39 -0800
Message-ID: <xmqqjzn94404.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 768421E8-CA04-11EE-B836-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> This patch series is the first 10 patches of a larger cleanup/bugfix s=
eries
>> (henceforth "larger series") I've been working on.
>
> There are now 28 patches in this series.
>
> I took a look at all of them, and I think that this series should be
> split into 4 or more series.

I presume that [01-09/28] would be the first part, nothing
controversial and consisting of obvious clean-ups?  I do not mind
merging that part down to remove the future review load if everybody
agrees.

Thanks.
