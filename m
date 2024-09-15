Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C877517C6C
	for <git@vger.kernel.org>; Sun, 15 Sep 2024 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726418259; cv=none; b=YOttLsKcEjugt0qNluOh+yQa2/eWrHD5Alfii9EtXhvMdQ85jzcU9jRZXWEMyLDrGOSJylsqZZN0m7ecpA6WzdyEFeA9O0+9R4HC4ylXxsGpYy+56l71uwYKcxgSNosWmKjzXZNjI8tsg2BR8gaLZfvnUjg86RaWd0mTMjnH1zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726418259; c=relaxed/simple;
	bh=kHcALqcZx6b+IYtV17s0DLyvoC/ox5pIR5IKjQsMeww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dmE09ubdDVOJWsnepg7W/C7JLOVPRs5vFyo6knoigYkPWL3s2gpwlpP4BgQA0/50bFY8KBluMN11uSwn5xvPH5xshmZujp6J6Frtepm1Fe+rCY3D7kPuC6RWWImMsYOxYzkhsG/nAxXWXwvo/j+QL/lI3gEMJw9pBC8iQGRnyDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tCbD6i/J; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tCbD6i/J"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 97B2629AA2;
	Sun, 15 Sep 2024 12:37:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kHcALqcZx6b+IYtV17s0DLyvoC/ox5pIR5IKjQ
	sMeww=; b=tCbD6i/J1K3mi4jlRKS8xwlNnVGQQlRZcpYKFAUb+kAbGXprDCCWBd
	IHhxOQeTSzAifEeIvPpNZ9uynH5Y/J6ZQf4LDxcoRBYi2AlnRu0tMgUBHGjcrbGo
	oXDSYCiCe7kUvpdKpCsswsA2L6oFIt5jDB/wirbv5iiExfNG1UdTM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9034E29AA1;
	Sun, 15 Sep 2024 12:37:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F3FCB29AA0;
	Sun, 15 Sep 2024 12:37:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Henrik Holst <henrik.holst@outlook.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: ./configure fails to link test program due to missing dependencies
In-Reply-To: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
	(Henrik Holst's message of "Sat, 14 Sep 2024 22:57:39 +0000")
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
Date: Sun, 15 Sep 2024 09:37:34 -0700
Message-ID: <xmqqldzsrhyp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D05700F2-7380-11EF-B587-9B0F950A682E-77302942!pb-smtp2.pobox.com

Henrik Holst <henrik.holst@outlook.com> writes:

> If I set LDFLAGS to whatever pkg-config --libs libcurl says on my system (actually: -lcurl -lssl -lcrypto -lzstd -lbrotlidec -lz) then it compiles just fine. If I add LDFLAGS to the configure environment it will accept that test, and then detect, as expected, the pkg-config settings for libcurl.
>
> Should not ./configure FIRST check for a pkg-config environment without assuming that even the most trivial curl programs should compile without any additional dependencies like zstd etc?

Looking at configure.ac, pkg-config is not used for any package.
Specifically for curl, it seems that "curl-config --libs" is used.

Presumably the reason behind the current behaviour is combination of
(1) ./configure is an after-thought in the build infrastructure for
this project, (2) pkg-config was not ubiquitous back when autoconf
support was written for this project, and (3) nobody considered
"upgrading" our use of "curl-config" and our manual detection of
dependency detection for other libraries to just use "pkg-config".

Patches welcome ;-)

Thanks.
