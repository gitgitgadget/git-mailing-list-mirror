Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DFC1F61C
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722612410; cv=none; b=EsDgXBJvr5TRJToIIi2eT6lqnJiAGiHi5zWHIVXFY8h/lRNUrEVn1cggirySL0TYmaHbh9UCTxokLpkO1BMlstrQTscqaMJ/5igAN03/6mhAI0A5jDdQb4KSSBMIsA3u0T5+oJdwJKbx+DJcsTU2+i91Nj/jqek/yY973subZBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722612410; c=relaxed/simple;
	bh=vQV86ufhgFIXHL6o9XqWR7K+ixzMXz4I/TQkELF5y8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o2uJs14PExCJ4WmokYIGWN7L9QjVfDgn7+2oNW1j2N0LgKEr+ju9+qZH6UFGkctmhEDHYGJP2dPI4jOunCFAbJYDKNF4PkzybG/8kYkAaawJTH2IkFg6tZhZRQiL8123xy0XkKQtgCACBU5la+8nRkKS4NL3tWxA/P/tBF+v+Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JnLGLeCF; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JnLGLeCF"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D2CB4267AE;
	Fri,  2 Aug 2024 11:26:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vQV86ufhgFIXHL6o9XqWR7K+ixzMXz4I/TQkEL
	F5y8c=; b=JnLGLeCFtUWQ/dQooAN+80WVVJxOBSNVnW3oz75pc605MiWgjN8jIH
	P7Xbk7il2Xb9hGoqcZptM9vIQA9C9YdGGcy00lJlXfREYCq+/6pl8hfTtcdgYtiG
	ppUjSsidiL2aQut8zckk2gSz1SOOxjt+bqhUCHytz2pNHOFVU80SI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C95C8267AD;
	Fri,  2 Aug 2024 11:26:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 33875267AC;
	Fri,  2 Aug 2024 11:26:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] builtin/ls-remote: fall back to SHA1 outside of a repo
In-Reply-To: <c52112d3946b2fd8d030580cd7acb809fa54012a.1722573777.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 2 Aug 2024 06:44:11 +0200")
References: <20240727191917.p64ul4jybpm2a7hm@glandium.org>
	<c52112d3946b2fd8d030580cd7acb809fa54012a.1722573777.git.ps@pks.im>
Date: Fri, 02 Aug 2024 08:26:45 -0700
Message-ID: <xmqqle1feyiy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A1B12198-50E3-11EF-90AB-BAC1940A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I didn't spot this in the "What's cooking" report. I guess that's my own
> fault for not sending it as a proper patch, so let me fix that now :)

Yeah, I had a fix already when I gave my response to the initial
problem report, but felt that it was too premature to commit to the
approach before listening to others (you included) for potentially
better alternative approaches, and then forgot about it.

The fix here is in line with my thoughts, after seeing how other
parts of the transport work.  Thanks for tying the loose ends.
