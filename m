Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AF0145A11
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722379784; cv=none; b=PnYa3KVxyVicEsScqNgQRMAXzY0NqTfcRTfZr68UygKG+vTHT2+eyQrptTWXO5pfvbpf72tX0xCtoEq5RYRd1W5SloFpLs+P+/qiOgFEHmEEo4SIYhlNsRObw1Z395QYtPAC2Kgrg0hht7DYyFY2d+vuvw5UkYFEfVtoxcZXnb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722379784; c=relaxed/simple;
	bh=75LeONvbGJ7DhezuAvNRyCql/cD2auppXgwyJmzrHzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IPHUleOrCd4ntWl7K9umjArxEOB/KHMOi5qn6z3DgQn2cxKtBalG/RkR2EDiIRpUnhx5TiclrFmM045exACJBY5j849XmF7IuGqgz/L+tdY/ugytH5oJ4FLByxbUNoA4NsapqymBXUFZLjPyqT1UeRCeBF2xCBzMG5paRBb7jIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=a1ihHoww; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a1ihHoww"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 438321CC25;
	Tue, 30 Jul 2024 18:49:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=75LeONvbGJ7DhezuAvNRyCql/cD2auppXgwyJm
	zrHzM=; b=a1ihHowwZKkvl9Jnu0Dcbpy4G9YISBwevaBI+7o20db+03TIhIol94
	ZKeDb8s7CoH5FJO3sezS2DYo+bfPMkI0WgvmSo1NLgSnN+O0iuqqrsGhkJlzhooU
	yo54gfGxmSgcMLf/jlFzmJcX8pzmWrWVPjGmU/0X+2ZlamO5TiKmI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B9A71CC24;
	Tue, 30 Jul 2024 18:49:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C82FA1CC23;
	Tue, 30 Jul 2024 18:49:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: "W. Michael Petullo" <mike@flyn.org>,  Jeff King <peff@peff.net>,
  git@vger.kernel.org
Subject: Re: Git clone reads safe.directory differently?
In-Reply-To: <Zqlo-i8uCb1Yr4Jm@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 30 Jul 2024 22:28:10 +0000")
References: <ZqUc8DJ1uKcHYlcy@imp.flyn.org>
	<20240727215845.GA1263246@coredump.intra.peff.net>
	<ZqZjRMqpEV_3WIkD@imp.flyn.org>
	<20240728224807.GA1299337@coredump.intra.peff.net>
	<ZqjQi6i2kiY4gcc1@imp.flyn.org>
	<Zqlo-i8uCb1Yr4Jm@tapette.crustytoothpaste.net>
Date: Tue, 30 Jul 2024 15:49:37 -0700
Message-ID: <xmqqv80m8pha.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 005CA11A-4EC6-11EF-BA05-9625FCCAB05B-77302942!pb-smtp21.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I think if we're using --no-local (that is, if we're using upload-pack
> instead of creating symlinks), then we should not complain about the
> repository ownership.  It's supposed to always be safe to clone or fetch
> from an untrusted repository, and we shouldn't complain about that.

The safety is promised by "git fetch" when you fetch from some other
machine because the only thing you will be seeing from that
untrusted source is a bytestream that is the packfile, plus the tips
of their histories---nothing runs as yourself in this exchange other
than what you control, i.e. "git fetch", locally defined hooks and
filters defined by your configuration..  They cannot affect your
configuration file and hooks that may name extra programs that may
run as you while fetching or cloning.

When you are using "--no-local" on the same machine, I do not think
there is any guarantee that "upload-pack" side is safe.  And that is
where the safe.directory thing needs to kick in.

Stepping into an untrusted repository and running git operations
opens up the user the Git process runs as to attacks by the
untrusted repository, i.e. you may invoke hooks on the upload-pack
side, defined in the source repository that is controlled by others,
and that is where the safe.directory thing kicks in.  You need to
declare that you trust that source repository.

