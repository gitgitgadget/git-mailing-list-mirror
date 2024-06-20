Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4D659167
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718917357; cv=none; b=hq2F5z7RRX3hZ9oXMZYUYxp/DuKnZr3D552CXYbx51h7CRfKWm+OKz+EV45QoU4FzW3gcjC/RSmrekYQuPXSV94TY+L2tvjsfSIXQzgglrxCvZKOW7bn7SecGvGchFa6NIZh9u0Qgd1UE8S9Nd+om16ms/fWKePk5T7kWhHZ6Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718917357; c=relaxed/simple;
	bh=bQAo7MtWQfznRt3r0rC/k4fLD+qSiZnI60PEXCBaYRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W4LEdIw41hL31xmM+sYylIZliteTJn310+RgU3E76lGVomeZSk0qVXht8mQjdfEKlP4ndbMQADxH2htfmgklqA2OD8KuRM1oK34IWis8nZ6+MhbaRO3QV5ZZyMdSgYDhJunju9pt9c0RI4l4Bcg9N9ggsCMD5NuRnr8cXenmxP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=G6xUuEro; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G6xUuEro"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A300F1AA87;
	Thu, 20 Jun 2024 17:02:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bQAo7MtWQfznRt3r0rC/k4fLD+qSiZnI60PEXC
	BaYRc=; b=G6xUuEroGKhGgkQ0Ok5e5uGI2RQYtYJjOd261KSCXRyhfgbDCg4Fc7
	wXWHqq+QZajUHtFdVWB+7ddWBExuhTIC47wwekzbo2s5SCnHZX8WdjZJJ/UVIvGm
	/4Edr/dEM+a/sLH5hUnp8v4VpMWB2k3UtNGTIv4R4kYz+QcihDKx8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9A00C1AA86;
	Thu, 20 Jun 2024 17:02:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3016A1AA85;
	Thu, 20 Jun 2024 17:02:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  newren@gmail.com,  anh@canva.com
Subject: Re: [PATCH 0/5] sparse-index: improve
 clear_skip_worktree_from_present_files()
In-Reply-To: <77974c37-b82f-42fb-848f-e060495c4f49@gmail.com> (Derrick
	Stolee's message of "Thu, 20 Jun 2024 16:21:20 -0400")
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
	<xmqqiky3tofw.fsf@gitster.g>
	<77974c37-b82f-42fb-848f-e060495c4f49@gmail.com>
Date: Thu, 20 Jun 2024 14:02:30 -0700
Message-ID: <xmqq7cejtjix.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6946095C-2F48-11EF-AB7C-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Derrick Stolee <stolee@gmail.com> writes:

> But what you are really asking is how close this is to the optimal.
> I didn't include that in Patch 5 details, but I was able to look at
> my notes and see that the sparse_path_count data point was 1,962,
> meaning there are that many sparse trees in the sparse index before
> expanding. Thus, the 6,521 lstat() calls are 3.3x more than the
> absolute minimum required.

Nice, and still impressive.  Thanks.
