Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B5E38398
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536708; cv=none; b=g+qqbW6Lwim27EtT9p4rFhPVJ+2B/ugBun8ah90e4tHE5+6WDRgiczyn03x9G9IQivJbGb62nhGlaMdsjUlnV/Kn+5+Un5aOyYvTwFq+/1/TgLlxqBAgJq0/a3OdYV8bmaxttPoAAS+FvY5a5EGuttSj27S+jY8L0yBAoxlFSuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536708; c=relaxed/simple;
	bh=xvKElvq6EObhIIC/b5ZCu4bVyixOGctgg0TXU5eQ3iQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QkbQMRhrJEnjrLaPqD0Csc+LbhhfWBSdJ3kdk7CFsHmSfuBKG7Jnjk23HyXg/8M0e02UDRMs27UARI4wka4c4zzWr7eIe0ZOwBt4lJ0vZ26t/36qt0+A5+cRIGa/3Y2L7K67i3uOGT8pdpe7fCnQQNFJu+S+NBePaxijjuAtt2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OZQmii3N; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OZQmii3N"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FBF01C3AAF;
	Wed, 21 Feb 2024 12:31:46 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xvKElvq6EObhIIC/b5ZCu4bVyixOGctgg0TXU5
	eQ3iQ=; b=OZQmii3NpmB51LC9jxTqUI03zmqpXdFueApCOsNfoAqw067ZIxQIM/
	/o4bE3gmL6S/t0QBU+eRyoZ+RYNwlfNpepAmm59SZuhbG3DMk9/cAmjxK2odHxAC
	9TfDD7M0X4OUsIqdCn9xd/AGa4d3eAGZVDxODPxKS7aBsVRFalQD0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 874221C3AAE;
	Wed, 21 Feb 2024 12:31:46 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E69091C3AAC;
	Wed, 21 Feb 2024 12:31:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Harmen Stoppels via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harmen Stoppels <me@harmenstoppels.nl>
Subject: Re: [PATCH] rebase: make warning less passive aggressive
In-Reply-To: <ZdWiyYhKAB3_P6_k@tanuki> (Patrick Steinhardt's message of "Wed,
	21 Feb 2024 08:14:17 +0100")
References: <pull.1669.git.1708442603395.gitgitgadget@gmail.com>
	<ZdWiyYhKAB3_P6_k@tanuki>
Date: Wed, 21 Feb 2024 09:31:44 -0800
Message-ID: <xmqq8r3dpvun.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 15F2BC2C-D0DF-11EE-A0F0-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>>  	if (options.action != ACTION_NONE && !in_progress)
>> -		die(_("No rebase in progress?"));
>> +		die(_("No rebase in progress"));
>
> While we're at it changing this message, do we also want to convert it
> to start with a lower-case letter so that it aligns with our error
> message style?

Good eyes.  Thanks for a good suggestion.
