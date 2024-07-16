Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565819A86A
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721147560; cv=none; b=WWPtWBMIvAcW/0Ge7Q/emLvEPwv6kjZDhLgt26mqVwCieUsNtJz+TMzRimZgSZp/L3s9h8TjU+IBP2znyhAW7xbT8cEuSI7q52abCFfMzCaAsKfCOrP32LoN1ObNlGTZrDuHkva3FJSy2vaavtjqjgRlhZ1AF6C5XqrZJU8+5QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721147560; c=relaxed/simple;
	bh=oaaGnM3MI0voAUGRcWygM2oGmOW+Yk7unaS/QVoFl4E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fTj1hFvKVtAqOZYGA0IH9XLc4VzVtxyNL8u9n8vSPW43fAayecFYN1Tcb2Cvq49Q5XdkUgJvRqONBoeFWhzTF+7l/fmjEACLRse2HBNabH3qhH2lc/IawaPe+ySObW+z0ostrZItQAJ82OZ8MZf+O8FNnUFPuGL1DJT+pTB9fv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pE19ZRIh; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pE19ZRIh"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 74D8B354FE;
	Tue, 16 Jul 2024 12:32:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oaaGnM3MI0voAUGRcWygM2oGmOW+Yk7unaS/QV
	oFl4E=; b=pE19ZRIh9MJNQqrf3epeaX0zs2OszwozaKsqkcrnQLxbDKX71VL5ds
	/l6nAvqynVehWWxbKeQ5PX+9BGpbGcoIwnH2UXDlgvgHkCHgD76fWtfsP9haJESC
	Zvp2IYK//5bgXNhV8bEYyaXgnMtRtfGc9XvxOt683yKA6LfuvkdXM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6DD10354FD;
	Tue, 16 Jul 2024 12:32:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.161.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E1B64354FC;
	Tue, 16 Jul 2024 12:32:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Scott Moser <scott.moser@chainguard.dev>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: Can dependency on /bin/sh be removed?
In-Reply-To: <CADaTQqB4wm5qzRzgRw7wz1L=Lju=X9iKtktLgdN2MfKf0kg3jA@mail.gmail.com>
	(Scott Moser's message of "Tue, 16 Jul 2024 11:23:15 -0400")
References: <CADaTQqDZ_6wORXOFc2CE90aizgHJ116NDHZhNeY4Nx7NH8DHJw@mail.gmail.com>
	<xmqq8qy21k9f.fsf@gitster.g>
	<20240715235212.GA628996@coredump.intra.peff.net>
	<CADaTQqB4wm5qzRzgRw7wz1L=Lju=X9iKtktLgdN2MfKf0kg3jA@mail.gmail.com>
Date: Tue, 16 Jul 2024 09:32:33 -0700
Message-ID: <xmqqfrs99u1q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 01B00D62-4391-11EF-B6BE-C38742FD603B-77302942!pb-smtp20.pobox.com

Scott Moser <scott.moser@chainguard.dev> writes:

> I was too.  It seems odd to combine the arguments into a single string
> early.  I was also surprised / didn't realize that 'use_shell' might be
> ignored.

Call it "optimized away" ;-)
