Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61E3370
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566694; cv=none; b=dEqeqogYnlw6ae2+T6TkbGTPpWVKyS1Oi2dLP9Tg3qehr/tv0IAaoAAFCc51Rt6UqkcC87ZmFVAHSX6RrLwG3/mtsN/PEY0hWhYW1CyW0mmMowbnj+ZQ+FwOWKJQIYji4I3fJK6cyboNeBsqYV3nxagl7msLhF7YMB1HljmTdT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566694; c=relaxed/simple;
	bh=dp8o7P6oerXVdzdM2GFXguKf2bF9RXDSyshjUQd2mdw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UjhnkFz9TC8Rd+rlIpiXB8mOGWeGxf2XTnK6nQ0vu0hEhLSHlc4ulgyRtGyrYgKHsV3eOYmmRUc2Z3gw/vod59kxKk7lxHGhOmqbLGCLG5lXvd/yf3vlbkGpR6Jjt/L3n5DqfBxd4kmH4uYsnSwIe7mWNWMS/m3QNx4DEvWBE5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KoXqF/gN; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KoXqF/gN"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B0F2627D7D;
	Tue, 13 Aug 2024 12:31:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dp8o7P6oerXVdzdM2GFXguKf2bF9RXDSyshjUQ
	d2mdw=; b=KoXqF/gNFZpNn8XgV1904uEVTEuJMEp1lo8R/fvUdBxsSa3U11XSwm
	ms4d5ogcjGw/dFZFHVrmaQjiXR8cY+4iwGdwm0isvX/djybnwfIjDWD3AXqYZ3od
	7QfX17KpkBIZdmkHe75qCsZpoxzGHJmEd6Uguqka+6VsV+N2UDpnc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A9F8827D7C;
	Tue, 13 Aug 2024 12:31:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1937127D7B;
	Tue, 13 Aug 2024 12:31:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  James Liu <james@jamesliu.io>,  karthik nayak
 <karthik.188@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 21/22] diff: free state populated via options
In-Reply-To: <d5cb4ad580c7370a4ee48d2f5075a1764972c353.1723540931.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 13 Aug 2024 11:32:13 +0200")
References: <cover.1722933642.git.ps@pks.im> <cover.1723540931.git.ps@pks.im>
	<d5cb4ad580c7370a4ee48d2f5075a1764972c353.1723540931.git.ps@pks.im>
Date: Tue, 13 Aug 2024 09:31:29 -0700
Message-ID: <xmqqv80475b2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7F3704BE-5991-11EF-9305-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The `objfind` and `anchors` members of `struct diff_options` are
> populated via option parsing, but are never freed in `diff_free()`. Fix
> this to plug those memory leaks.

Thanks.

Even though "diff" is generally my bailiwick, I've never paid
attention to these features (hence the resources they consume and
leak).  The patch looks good to me.

