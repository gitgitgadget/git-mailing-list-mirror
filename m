Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E54157E7A
	for <git@vger.kernel.org>; Mon,  6 May 2024 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017932; cv=none; b=ctrtElxACXjyTsUFGhChZvxOLUThxJpk5eq4ESIvxcOwDKc9saeQCTvnL1Xr7RNSWBpC9WjnHupYg/rEyG2f7K78lDJ+wqoqzBTfOzM9bnr0B9vjExEqrjinTMGhLaWDXkjofCEfEp/xYni9HulUWj08Q27dkaHL3bHT2470lgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017932; c=relaxed/simple;
	bh=Shaw2nsK/px6hj+rU/pBsJlO8ppjji9/YjNfmHdxR24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gcjOPKjFqMGx9TrFR8BujLsqbEPXqwpAMeTESHMG8kbj36TKDNZkRJTAhyk+xFvaxsHmwuOjmH6DmvVdY0eAHd1LmJ9FzlcOsTGniJLznKpdHc+oAQ9V4vZTT/QA5b1Vsj4p/XYd0LGXOQfapltsoI2mGOoBdPYBnuy1xKCpqrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hIsYcowF; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hIsYcowF"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 912353EEC3;
	Mon,  6 May 2024 13:52:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Shaw2nsK/px6hj+rU/pBsJlO8ppjji9/YjNfmH
	dxR24=; b=hIsYcowFH7tzefFBekxWONRxBxZ0Qty6LmUCo2N3H+f8PgsgOM9ADK
	3naRACWlbaJkXHkl579+38O1hBs5sH7ZBehwOT7sEtkpIkxyiUE3lRJlOKa+3KDV
	I7IuZoi00uTj+OkFoZ60fhlcnxf1rOiDxVwMbgakD5Alpj36wJofs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 872C13EEC2;
	Mon,  6 May 2024 13:52:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CB3A13EEC1;
	Mon,  6 May 2024 13:52:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: John Passaro via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  John Passaro <john.a.passaro@gmail.com>
Subject: Re: [PATCH v5 0/3] builtin/tag.c: add --trailer option
In-Reply-To: <ZjhtZb5nJZ8vlvLw@tanuki> (Patrick Steinhardt's message of "Mon,
	6 May 2024 07:40:53 +0200")
References: <pull.1723.v4.git.1714488111.gitgitgadget@gmail.com>
	<pull.1723.v5.git.1714934950.gitgitgadget@gmail.com>
	<ZjhtZb5nJZ8vlvLw@tanuki>
Date: Mon, 06 May 2024 10:52:07 -0700
Message-ID: <xmqq34quzv3s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5BD5AD1C-0BD1-11EF-A808-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, May 05, 2024 at 06:49:07PM +0000, John Passaro via GitGitGadget wrote:
>> 5th follow-up patch taking welcome feedback from Patrick and JCH. Net new
>> changes include suggested tweaks in documentation, error messaging, code
>> formatting, and patch description.
>> 
>> Since git-tag --list --format="%(trailers)" can interpret trailers from
>> annotated tag messages, it seems natural to support --trailer when writing a
>> new tag message.
>> 
>> git-commit accomplishes this by taking --trailer arguments and passing them
>> to git-interpret-trailer. This patch series refactors that logic and uses it
>> to implement --trailer on git-tag.
>
> This version looks good to me, thanks!

Thanks.  Will queue.
