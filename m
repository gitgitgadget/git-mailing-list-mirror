Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2211BC064
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718908514; cv=none; b=H2D6N6qGFMC5yCBCZbJHY4R6LhS6R4H8CRn+ksHUCrZxZxfu3NLHVLNkTWpsRGpK5uOdZ9je+WrWdASjdIE+syE0MTK9xincwfReTlKJbZEe8rLN58Ku5OIxvqF/xcB42WpeFLWh3y2KmYnBu40QOvWjSXBHD7VgJZY9JvIIJBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718908514; c=relaxed/simple;
	bh=D2pyFezePh04RYRtDIMFZOtz7ede/vUygkFImVvOGfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ksMUGVxf2TaEJBEFSZ77Abg7oaJZP9570DFEd6ORTFte3akgBKDcPzdMPekfgfmBFmUqLfE/W5GYQSQirx9DbNX1lDY53dumXixaf/owNmJo9lJjGBdDCRblMgd4HHplnjIW7tRbXuBMK5hPcamRAzYY5OS2ROk6O5CJMNa53A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZlpQk55+; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZlpQk55+"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CC5F119B21;
	Thu, 20 Jun 2024 14:35:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=D2pyFezePh04RYRtDIMFZOtz7ede/vUygkFImV
	vOGfE=; b=ZlpQk55+GkKZRrgQ+OCnnmvPdeaEdLbMkKilThWNxVyQeFTrXfLWP4
	DZT6/e14lJrjrh4fi6R8b+D7vbpQtqnosqVy0fqPzlzpA4DltIdHk3Lds16P9iYf
	xvgtZO3mnkSzeQc9rFUmas95d1ODEIlt+CEkpkPsLNHfHLr3Yf0K0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C573919B20;
	Thu, 20 Jun 2024 14:35:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6ADC419B1F;
	Thu, 20 Jun 2024 14:35:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Randall S. Becker" <the.n.e.key@gmail.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <randall.becker@nexbridge.ca>,
  "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v0 1/1] Teach git version --build-options about OpenSSL
In-Reply-To: <xmqq8qyzv5a3.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	20 Jun 2024 11:27:16 -0700")
References: <20240619172421.33548-1-randall.becker@nexbridge.ca>
	<20240619172421.33548-2-randall.becker@nexbridge.ca>
	<xmqq8qyzv5a3.fsf@gitster.g>
Date: Thu, 20 Jun 2024 11:35:06 -0700
Message-ID: <xmqq34p7v4x1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D1FBC9F6-2F33-11EF-A093-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> "Randall S. Becker" <the.n.e.key@gmail.com> writes:
>
>> This change uses the OpenSSL supplied OPENSSL_VERSION_TEXT #define supplied
>> for this purpose by that project. If the #define is not present, the version
>> is not reported.
> ...
> If some unknown version of OpenSSL does define it but not as a
> string constant, it would break the build, e.g.,
>
> 	#define OPENSSL_VERSION_TEXT 2 plus 4 is 6
>
> We could stringify it ourselves, but that is probably not worth
> worrying about.
>
> Will queue.  Thanks.

Having said that, we do link with and depend on libraries like
libcURL, libPCRE, libz, etc.  I wonder if they are also worth
reporting, and if so how?

We can leave it just like any other new features, "if you have an
itch to see it, you can offer a patch", but I am wondering if we are
going to get a several more, we'd at least want to standardize the
process and the output (e.g., do we limit the line counts to 1 and
line length to some reasonably low number?).

Thanks.
