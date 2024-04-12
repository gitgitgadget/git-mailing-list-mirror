Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D614F9C7
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943343; cv=none; b=KNCqA/Zv8j/lC96g+mq1gCc3A07wPSPCVMscZdVYdGw1RLGoGsdwruKKoWL4uyHxCMAXLoKm5Chf4SP3mZz6gYl7n8rQ7mn0JQ/vV7IKMKZvN9o8zpzU9FRUNtGvrETiRHF+snZnoahzGT9FUEIhGnL3kpFY0DHPDm5VRqiqCT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943343; c=relaxed/simple;
	bh=ASXiEBj/sgseIHy3ae1+mkbEeCRUWk9hoVbAU6+rnyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pl/1dmGUvryvPpcSai4eS3/MJqoKwwB6M2xaV+jVZVf8KFz40jNrDQdFWu+TgqklzGZ+p5t/7ODUlnE/D1m4pTdvskpjhDYWmrdljzDppxzvp4qDzMLB+p1my4L+eyENEg3SytKJi0tcsKDXDnbPEkpIzapGpA4UoJlL0IQN3ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wOpCHxR3; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wOpCHxR3"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 762AC1E152F;
	Fri, 12 Apr 2024 13:35:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ASXiEBj/sgse
	IHy3ae1+mkbEeCRUWk9hoVbAU6+rnyk=; b=wOpCHxR3SBTAFlZuzCCztvTO/dMt
	FxyB8luvo4ezuyI7Km4EF41IWROyLhfyf+kjlmRnkldcKYoNFRb+Uvq8Q+ClLTyd
	SsrvgwPwsWlDMbrGCKpiy/GDf12TU6aTs99j2VB5mF6c5zlKJs4FRvBk1Y5fC16m
	OKM34ihTFiJkprs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D20F1E152E;
	Fri, 12 Apr 2024 13:35:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DAC411E152D;
	Fri, 12 Apr 2024 13:35:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] launch_editor: waiting message on error
In-Reply-To: <40075168-24d8-4c46-89fb-30fe2ab2581b@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 12 Apr 2024 19:03:24 +0200")
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
	<96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
	<0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com>
	<xmqq4jcb495u.fsf@gitster.g>
	<54dcd4f1-5a79-47ba-9650-7115b7170a84@gmail.com>
	<xmqqle5lxlwm.fsf@gitster.g>
	<d485c4cd-f963-45b7-9fa6-801738c7c066@gmail.com>
	<xmqqwmp2posk.fsf@gitster.g>
	<40075168-24d8-4c46-89fb-30fe2ab2581b@gmail.com>
Date: Fri, 12 Apr 2024 10:35:38 -0700
Message-ID: <xmqqbk6emql1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 14765836-F8F3-11EE-B01C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Yes, but I also see it from another perspective;  I don't want to worry
> about a possible inconvenience.  And since it is perhaps an unexpected
> precaution, for a future reviewer, hence the explicit comment in the
> code.

But then the comment should say it only matters if the editor left
its message incomplete, shouldn't it?  If the editor did the right
thing and terminated its message before it exits with a newline, the
extra LF we emit after it will only waste the vertical screen real
estate.
