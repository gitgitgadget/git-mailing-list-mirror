Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3104539C
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 05:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712468278; cv=none; b=Eqk2A0zWeVymXsbW/wKHhi0lOoJyof7TZrhHmqI2Qwc2wWXHoXmvW+C33bHTTjFxvI/OICxauj6kyjlg7sAoTcyXrhdMSS6s9HPybg6kLS3L1WSYhwe1CJIWBwWK13RbQsVIZZkJ0eupjnE1ZOioBhmZlbKLjPXjviO7y1Q0Uw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712468278; c=relaxed/simple;
	bh=GsH4hNnGql+ZyGPpC6nyF/h0ZdEiX6/GPXBuQC0OfoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sjQnrCCLfHJyX5OrsX4TzyXx/ta/b/KTJSn7cR6an8C5zhYtk4Q3HZw6bsm2IBgXnud/x0UvWItjLe5f3SiHOO4KyCu2M5Z9jIwaYM/QEnFVeDudUFy0f82HHyh9O1ZQbl6Gbodsrk9mkD0y6+o1X4Rhy3TiYeoG6OlS8qSy7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=O65ZcGp8; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O65ZcGp8"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A6CB2D98F;
	Sun,  7 Apr 2024 01:37:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GsH4hNnGql+ZyGPpC6nyF/h0ZdEiX6/GPXBuQC
	0OfoI=; b=O65ZcGp8/TFi2AZKEeOxuAyC3zKhp1GU+fVJ31BB39/75F7fWgdN26
	+I2FaszZBJ1pc5w8uII80vCwChN82JQPMNhwd1cxNuHhU49K0oeifCAvsi7Jne4b
	AWviwwTCj0c3uatHE8ch7kVMotX13v6ZcX0/sV3jhOiHVhgvNiLjM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 35D9C2D98E;
	Sun,  7 Apr 2024 01:37:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A650C2D98D;
	Sun,  7 Apr 2024 01:37:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: =?utf-8?Q?L=C3=AA?= Duy Quang <leduyquang753@gmail.com>,
  git@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] Add lines to `git log --graph` to separate
 connected regions
In-Reply-To: <CAPig+cQVQrrXrDqys-TyCqFynR6=pmbxs-NK-ca-s0K8mjADaA@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 7 Apr 2024 01:30:48 -0400")
References: <20240407051031.6018-1-leduyquang753@gmail.com>
	<CAPig+cQVQrrXrDqys-TyCqFynR6=pmbxs-NK-ca-s0K8mjADaA@mail.gmail.com>
Date: Sat, 06 Apr 2024 22:37:51 -0700
Message-ID: <xmqq4jcdivgw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FA55FBD8-F4A0-11EE-BB96-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>> This leads to a problem. Say there are two connected regions, each having two
>> commits, the graph would look like this:
>>
>> * a2
>> * a1
>> * b2
>> * b1
>>
>> which may lead to a misunderstanding that these four commits belong to the same
>> timeline, i.e. b2 is a parent of a1.
>>
>> This patchset adds a separator line between each pair of connected regions to
>> clarify that they are not actually connected:
>>
>> * a2
>> * a1
>> ---
>> * b2
>> * b1
>
> This sort of information which explains why the patch may be desirable
> is not only helpful to reviewers of the submission, but will be
> helpful to future readers of the patch once it becomes part of the
> project's permanent history (assuming it is accepted). However, the
> cover letter does not become part of the project's history (it exists
> only in the mailing list). As such, please move this discussion into
> the commit message of the patch itself.

True.  But because we are doing graph, shouldn't we be able to do
better?  For example, you can draw the two lineage of histories
on different columns and ...

       * a2
       * a1
     * b2
     * b1

... that way, you do not need to lose one line of precious vertical
screen real estate.
