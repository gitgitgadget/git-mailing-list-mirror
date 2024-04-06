Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAA5BE6C
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712423276; cv=none; b=lNa57EJltno1qOXqMiPuiMzSYnZe+6YGRBDi0c4HiaUZGfbkIRA1c5MaC5ju9wZ+hqZ20zo8H2zopNGdR/QW+On2KPQdJ47yuvDSOphUYBpiFHPSs637cPYUaM4CPwCVCXD1Jn4UqBmf47vlEzufwzZDsPeyeLPN1InvDqVLTAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712423276; c=relaxed/simple;
	bh=EW0qTfYY2MeLZ/FmDmyv0CsRcc+m0jcY1o06Cv9ybXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IdZIIFDwEF9p46KaKqGaZLTj6+n3MFZ0aJfFeeQ+MIyJJKWP5qU6IJ3OnCEiWOvqPlMuqvgA1Ewu13pfMn5JYF7FXpjK64zexgWXe5CbQUM6s1hV4myqtdqHZXFXxwNHCJjtTFUFq0Rk6el3Xo4CaTda+mrmFC36elrbrKx1EGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xyOUkjxq; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xyOUkjxq"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DF469299D3;
	Sat,  6 Apr 2024 13:07:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EW0qTfYY2MeLZ/FmDmyv0CsRcc+m0jcY1o06Cv
	9ybXU=; b=xyOUkjxqPb1uY4zgkulPWRiHCBW8dhSLJ0owxymQp8tiCTQVhY1yjx
	Xyll0nOL/GSE1hgC2tZaaU+rmGzOLCRqgeGbkSZYsVGBuKPxnlHuaODVz9K3ks20
	jPU59HPM8+jWGBQLsl6uz2rg4RMUHRbruwgPSp22yiuvuRNrrKZFQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D7EB8299D2;
	Sat,  6 Apr 2024 13:07:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 646DF299D1;
	Sat,  6 Apr 2024 13:07:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Stefan Haller <lists@haller-berlin.de>
Subject: Re: [RFC] bisect: Introduce skip-when to automatically skip commits
In-Reply-To: <b194ba7c-454b-494f-bef2-e9eac7ca87f1@schinagl.nl> (Olliver
	Schinagl's message of "Sat, 6 Apr 2024 12:06:25 +0200")
References: <20240330081026.362962-2-oliver@schinagl.nl>
	<864b0f22-b07b-469b-8fc2-56940fd89a8b@schinagl.nl>
	<xmqqcyr3s3gj.fsf@gitster.g>
	<b194ba7c-454b-494f-bef2-e9eac7ca87f1@schinagl.nl>
Date: Sat, 06 Apr 2024 10:07:49 -0700
Message-ID: <xmqq1q7il8re.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 337D9A10-F438-11EE-B1FF-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Olliver Schinagl <oliver@schinagl.nl> writes:

> But seeing that these are your main concerns, I'm more confident I'm
> not completly on the wrong path here.

Mind you that they are not "MAIN" concerns.  They were the ones that
jumped out at me from your sketch.  After seeing the real thing, I
may find completely different issues that I could have spotted in
this version as well---it is natural that people notice things they
did not initially notice with a richer context.
