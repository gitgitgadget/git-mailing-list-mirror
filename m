Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2139147C9F
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 21:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712611771; cv=none; b=gIYF8kf+UivVtgZokPr/Q2WDlddWLDT6nHYzQnQcB/OeANRzl+7Zl4Zun062JZywGyv8oKIxxV6+dvYf0hZXMeaUnUF3MiVoRjeK9eHN0Y10/DK01KzwuDe94X54ECpZLa0f9jK/wlLYw++jbRx2mSTI+4eWbReOcWy5DsTIf20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712611771; c=relaxed/simple;
	bh=FgCqEaZQl+nPRr+lt3o7/Xq6oIdUfAIihNCA0C9QswU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OTKnm0uruQhXffXymk82n2Ntp4Xtl6iEAj1aTDmBXIqPOFs63bvro4wVnaPByJOcnHYVYDT3ySk0jAc6TwQM/SSOdDd385VZd2y0WdJYSFuY/lJERLEk0QSVjP04A1Vx0BcCY5S+Gto23EFteKBls88MIBcgLXLABM07pfzJOqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=klS7rW9G; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="klS7rW9G"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C5DE41DC2BA;
	Mon,  8 Apr 2024 17:29:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FgCqEaZQl+nPRr+lt3o7/Xq6oIdUfAIihNCA0C
	9QswU=; b=klS7rW9GxgoAQqENx9AB5HyTftSdnQi8s0haeZjZRYmRnauAsTQxli
	E1EL4hBUaLTPSD5aNbEAYHTWpVAexR++w+ixlR4p0KmGufLLoD1+lcPHQJRt48gL
	gVfWSNaaYIShmUxlADOFS4ESYs7v361zatQSm/UfCoJK9iYkhg36s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BDD4F1DC2B9;
	Mon,  8 Apr 2024 17:29:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 338731DC2B8;
	Mon,  8 Apr 2024 17:29:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: rsbecker@nexbridge.com,  'Calvin Wan' <calvinwan@google.com>,  'Git
 Mailing List' <git@vger.kernel.org>
Subject: Re: [RFD] Libification proposal: separate internal and external
 interfaces
In-Reply-To: <ZhND3hZXlzDxff5e@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 8 Apr 2024 01:09:50 +0000")
References: <CAFySSZAB09QB7U6UxntK2jRJF0df5R7YGnnLSsYc9MYhHsBhWA@mail.gmail.com>
	<ZhMRNxgwRJ25P4Ud@tapette.crustytoothpaste.net>
	<037001da8935$4a6e3720$df4aa560$@nexbridge.com>
	<ZhND3hZXlzDxff5e@tapette.crustytoothpaste.net>
Date: Mon, 08 Apr 2024 14:29:27 -0700
Message-ID: <xmqqr0ff8rwo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 14565BA0-F5EF-11EE-BAE3-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> As mentioned in the original proposal, we don't have to support all
> platforms in the libified code.  The main Git binaries will continue to
> function and be supported, but the new libified code will rely on newer
> features.  You will still be able to have all the Git binaries and
> functionality, but if you want the new shared library to compile
> against, you'll have to furnish a newer compiler.

I thought one of the yardstick to gauge the success of this
"libification" effort, if not the purpose of this effort, is to
allow Git to be its first client.

I am not sure how it would supposed to work.  Unless you are giving
parallel implementations of "main Git binaries", one with the native
code and the other replaced the native code with thin wrappers
around the library calls, that is.

Puzzled...

