Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9A585628
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354343; cv=none; b=bViYpVa4r/pPlFQo4KkZ3vojfa8EN1OoAc5BvDZ2gv8jEbvr7xUt5dh5UBZFo1Q3vNgolbFWKBEiMMKvVIs93v0NHzuyvt1P89tfobMXufpzQnC58n3zsSyykZBQrcFnWn20DhIvb1msR+gJzn4noyi3F6+ZTNvNdUCdvr5K+KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354343; c=relaxed/simple;
	bh=/rw7T0TwnAsURSzzq3xALgWlYsfPqUXuVujlNdGU1cQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k92v4rdLhVGh7ZkuZuGpUuy/+AU5OcLiBxHMOyWPo6nVzamhdRri8ni3o8DuP+76qw5+H/RIPQ57R3e5fWW5lgg5efapsg41TZVKv+BRb0O+cfX80nrHYTrkrnJAUYgbcFCzPu/ThnPqaWf91ZXI38+sLwv/iX4UD3kcWhtBtTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZaQpU2ON; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZaQpU2ON"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F1CA7381BB;
	Tue, 30 Jul 2024 11:45:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/rw7T0TwnAsURSzzq3xALgWlYsfPqUXuVujlNd
	GU1cQ=; b=ZaQpU2ONa+LiorhkWfQrxPTehY6OCo9WDo5+YXiDiv0l/xkk7L2rcI
	rZ1Ai0TtazP7evhL20nXK7vNb9wzCjQg7e0a3kYqH45k57T6LyUuigEIXuWc7Xz/
	vaiExWLWLnQuYgyD0Ec0HjAeU5Mk1VUApHGL9D8UWacmANlGTI8qI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EA3A5381BA;
	Tue, 30 Jul 2024 11:45:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 76DF7381B6;
	Tue, 30 Jul 2024 11:45:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sayooj Surendran <sayooj.surendran@bigbinary.com>
Cc: git@vger.kernel.org
Subject: Re: Output of git checkout goes to stderr
In-Reply-To: <CAFGW38fkr+OuhpcyqNFxZNkhNDGPxTbOmCJLVHpCGUmbj05tMg@mail.gmail.com>
	(Sayooj Surendran's message of "Tue, 30 Jul 2024 11:14:18 +0530")
References: <CAFGW38fkr+OuhpcyqNFxZNkhNDGPxTbOmCJLVHpCGUmbj05tMg@mail.gmail.com>
Date: Tue, 30 Jul 2024 08:45:36 -0700
Message-ID: <xmqqed7ag9y7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C4BE187C-4E8A-11EF-9BF0-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Sayooj Surendran <sayooj.surendran@bigbinary.com> writes:

> Noticed that the output of git checkout command is going to stderr
> channel. Is this an intended behaviour?

Show messages meant for human consumptions (not just errors and
warnings, but informational messages and eye-candy progress bars) to
the standard error stream, and using the standard output stream to
show what informational commands are asked to produce (e.g. running
"git status" would describe the status of the current working tree
to the standard output stream), is very much in line with the
original design we laid out in 2005 when Git was still very young,
and continues to be "intended" behaviour to this day.
