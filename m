Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67C771B24
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398658; cv=none; b=qWDvnCjp4K+vbFesnVI/VOviTIeB2yG3FTivAaemRUaYXSHWaswlZjNbWteDJZofs15UcxBbdkN+He7eSV0Z/0AjznnyptdU3N6jRY19kju8GX8nEZabVQw7PdcvdrD+ZeNfjlTW8Hk1lmERlID87ZYuT6UAtMjfzNg+gyEb0Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398658; c=relaxed/simple;
	bh=haoHX78jbK9CCquo6rYfQ4yJ76UkLiV22jngRtzHjSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KmYjfeGaSTSz5FC2jegnPDwyUP+OS1HDGa+pbFAN7FHm0bxBWUbTN3Uh+CdS3rUGynXmeXWIgDLQzKeQngsfWcMUVrQA9v9B828qTxoqwCUylN8eoP91yeLL15Md7XsWzmJgeh3X2ujfl3IvM9g3isMEUqtD0Z0FJaVIND8GQKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nZj65cFR; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nZj65cFR"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 774E421F0B;
	Mon, 29 Apr 2024 09:50:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=haoHX78jbK9CCquo6rYfQ4yJ76UkLiV22jngRt
	zHjSY=; b=nZj65cFR4iCELUikEqU7Q8Nl0+tB1JFTQwqSlVORpRzJNVUVycx3KH
	9nnHsc+wJ4Rq0WbG5OUehjn2V/hWhvQ4P+iFAgj1pvLSSzUA3TzIHS+eijy833vF
	Z11hHDzg7H3UdvE9MRw1oYwxqYAuMgXRb+mz3nlug1/5SFyUnozFU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F02D21F0A;
	Mon, 29 Apr 2024 09:50:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D186521F07;
	Mon, 29 Apr 2024 09:50:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: James Liu <james@jamesliu.io>,  Dragan Simic <dsimic@manjaro.org>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] advice: add --no-advice global option
In-Reply-To: <20240429064025.GA2905826@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 29 Apr 2024 02:40:25 -0400")
References: <20240424035857.84583-1-james@jamesliu.io>
	<20240429010925.93205-1-james@jamesliu.io>
	<20240429010925.93205-2-james@jamesliu.io>
	<37512328b1f3db4e8075bdb4beeb8929@manjaro.org>
	<D0WCCOLSMM9K.24BIGLR6EEJI8@jamesliu.io>
	<20240429064025.GA2905826@coredump.intra.peff.net>
Date: Mon, 29 Apr 2024 06:50:53 -0700
Message-ID: <xmqqh6fk1dmq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7FC72612-062F-11EF-B46C-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> You need an environment variable if you want the command-line option to
> work consistently across commands that spawn external processes. E.g.:
> ...
> commands, then propagating becomes too cumbersome and error-prone.

Ah, you've explained this---thanks.  As an internal implementation
detail, this is inevitable, and I am OK as long as we document it as
such.


