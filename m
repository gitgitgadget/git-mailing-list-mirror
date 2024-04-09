Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A93F4E1BE
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 02:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712629035; cv=none; b=gsWj+zGic/2tOYgKayK0XWZMJm1SrXJ3U7jevrt94s+Ipm7lALPD4upndb3UsQgWNASroMoBMaWL2gY2SEI2IqQqBsvs/XMC4CsSAC9iha6yMgChSC7xw8vUIlHohsHx90UPblY4n6WL8vQWvtcqEb6DmxWjxzufDL8iHRf9ojs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712629035; c=relaxed/simple;
	bh=FUODQa25qfMpxatFlWhnnuoCQKc9t0RtRRKIBgFa3AQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ITDkn9PNf3oCzICSXvpfBoVjSfP0wRx9LZaSvC9EzNrzFl9iFeokzZXj315KXN1WYNRYrIe28KT+wS57lxwCDYfgH0jLjS7fX7ihAhHG1iyfmdRAtvB+N25xBYIIn9PZp5nArsV2YWn02lSl+XPrx5ExMSz1GAeNc7czN9z2+Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jt4Wb4an; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jt4Wb4an"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EE4F93CB2F;
	Mon,  8 Apr 2024 22:17:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FUODQa25qfMpxatFlWhnnuoCQKc9t0RtRRKIBg
	Fa3AQ=; b=Jt4Wb4anEOdAZL3v08ZI2Lg/jSIKDj0sDIQUE9X1xc31HFTVmw3C1d
	EeyHUKZuKrATJtVmA1fQ6p288KH0hQRumKnWMcsQnmEPTq7IqceZ0DjecZffM/P7
	UzRbibX+nQo9QmrWYlo9z5SU+YZiAPK7jRC0WrQdLcZOF6y9f1Ldo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E61FD3CB2E;
	Mon,  8 Apr 2024 22:17:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6EC763CB2D;
	Mon,  8 Apr 2024 22:17:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwenn@gmail.com>,  Josh
 Steadmon <steadmon@google.com>,  Luca Milanesio
 <luca.milanesio@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/12] t: exercise Git/JGit reftable compatibility
In-Reply-To: <cover.1712555682.git.ps@pks.im> (Patrick Steinhardt's message of
	"Mon, 8 Apr 2024 08:45:36 +0200")
References: <cover.1712235356.git.ps@pks.im> <cover.1712555682.git.ps@pks.im>
Date: Mon, 08 Apr 2024 19:17:08 -0700
Message-ID: <xmqqle5n2sbf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 456FD5B8-F617-11EE-B190-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> CI runs for this series:
>
>     - https://github.com/git/git/actions/runs/8595241646/
>     - https://gitlab.com/gitlab-org/git/-/pipelines/1243766428

Thanks.

When this is queued on 'seen', I seem to be getting test errors from
t0610.  I suspect that it is not a breakage in this series, but the
fact that this series enables reftable tests without setting any
GIT_TEST_ environment variables, that causes an existing breakage
(or two) more visible.  I did not have time to locate which (other)
topic introduces the breakage, though.

