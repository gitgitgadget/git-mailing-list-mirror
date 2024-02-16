Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662F2145341
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118372; cv=none; b=XSwxGRsYGrdnoVAt4Y0yl4wYRPcYbGab5Kgj26/SmZKj1HZdicaDw5elLF3C/Z+220IowG5A7H3OMlCohKMmAJKeYSPFIFeWs+MeHFSo1YIQrBj5frHAuc0O39HFBPSCSprKZA4PXO9xSdtykmiAkcM5jt/EbR8Nyw309XHT5LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118372; c=relaxed/simple;
	bh=DZCqrX/L6f4Brd1yU8wHrJWO58iS9bykQw+1hB2A2TU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KYYh9XRYEDBJkLeVuQidlvJQ/0vkX3mH6skWSAniqnHbnJ9fe4/+XNsyUQrWK0f/2rN2nGySbswSUBpQWAwQqupKDeDFLpfTHZ7SJaIeMswqU9Dv+e88Eg6RqqdJ6FBQZ5kidpJRR+cX2V7Pa95cOCE0KBA1wGNC6q75Ue51dms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rNqk7sJk; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rNqk7sJk"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A2DFD36408;
	Fri, 16 Feb 2024 16:19:30 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DZCqrX/L6f4Brd1yU8wHrJWO58iS9bykQw+1hB
	2A2TU=; b=rNqk7sJk9WLUL4+V+6PnPUPmdwQwhpNTUkxDIDFgZ9yKNOph7fsgdQ
	3j7nT8QDCqaQYUEWuvg/vIsSNdbUl5z/f02zK6zzg34OcOQY8sS5sXClBRX6K33q
	7WGvx94quQMU2DF95yP3DhNjXITZjWRHRAfyvtV0TIkI5k0io7048=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9AC4236407;
	Fri, 16 Feb 2024 16:19:30 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0F26236406;
	Fri, 16 Feb 2024 16:19:27 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>
Subject: Re: [BUG] git commit --trailer --verbose puts trailer below
 scissors line
In-Reply-To: <8b4738ad-62cd-789e-712e-bd45a151b4ac@gmail.com> (Philippe
	Blain's message of "Fri, 16 Feb 2024 16:04:18 -0500")
References: <8b4738ad-62cd-789e-712e-bd45a151b4ac@gmail.com>
Date: Fri, 16 Feb 2024 13:19:25 -0800
Message-ID: <xmqqmss0gl9e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 108B81BE-CD11-11EE-8D83-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> I checked that it works OK in 2.42.1 but not in 2.43.2 so it is not
> a new regression in the 2.44 cycle, but I thought I'd write now in case
> someone spots the culprit commit faster than me.

2.43.2 has changes that are meant to be bugfix only without any new
features, taken from 2.44 cycle, so checking 2.43.0 may be worth
doing.
