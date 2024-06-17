Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AC3199E94
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 23:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665733; cv=none; b=buoggssu8W7q2g6XxKBxxJO3JLJCjxvt3/OPGV7LhVFtXe249JP/hUGs3Qw+EXSfUKoF+T4/3dBGNuP8B15sZcW8begaqkFg7L9rG4Kz2zSfL/llHRjgGGoR/siq/tkJSkd8k5b00LbCwAVwc8ym22rgoFdPZ7eOssuPcS+l9Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665733; c=relaxed/simple;
	bh=0bRlf5QH/b8UBEdLTHeoLJDfmoCFVhW0EzQQ0orewx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lA0HbFRK4NiOr9R0/kWzmfYo+XtsLr0d0K0u4m8B+85aYMQIbbDDbkdT0INNltGCmNWkBLuuC5/m4NZMnBgYe6joqHjcPUgDXEGldceuvQ9Julcx6du9dJDXmbsgqGzrs0UkuXgiV+Qh8H4MQ/aps2XOXZqmDR6pu9CeitnH9QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FOSFpFRW; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FOSFpFRW"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ED215201C3;
	Mon, 17 Jun 2024 19:08:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0bRlf5QH/b8UBEdLTHeoLJDfmoCFVhW0EzQQ0o
	rewx0=; b=FOSFpFRW5gxQakqPB56JwDWV3pDTpVL73DOnZwjr77cqeo0gGt+87E
	D3Msl8L5TPEGFs9inX+ADhaGxQJDQgiEEED6h2W7SRrRDGpTwYwJpo9/E4u96TCt
	jEiFuMGc+FdxU2gpK9hFZq/2hb/EuvRu9h013VNLCsKMNQ1h39alg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E51F1201C2;
	Mon, 17 Jun 2024 19:08:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 33C88201C1;
	Mon, 17 Jun 2024 19:08:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] t9700: ensure cat-file info isn't buffered by default
In-Reply-To: <20240617104326.3522535-3-e@80x24.org> (Eric Wong's message of
	"Mon, 17 Jun 2024 10:43:26 +0000")
References: <20240617104326.3522535-1-e@80x24.org>
	<20240617104326.3522535-3-e@80x24.org>
Date: Mon, 17 Jun 2024 16:08:48 -0700
Message-ID: <xmqqmsnj416n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8EE1EA4C-2CFE-11EF-8A40-965B910A682E-77302942!pb-smtp2.pobox.com

Eric Wong <e@80x24.org> writes:

> While working on buffering changes to `git cat-file' in a
> separate patch, I inadvertently made the output of --batch-check
> and the `info' command of --batch-command buffered by default.

Here "buffered" means "as if opt->buffer_output is turned on", which
in turn means "the output goes through stdio"?  Just making sure
that my understanding of what the breakage was is in line with what
you wanted to convey.

Thanks.

