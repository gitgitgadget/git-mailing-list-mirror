Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE5315ECFE
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970763; cv=none; b=H9aXDfNOmqYAH519IoqBLiPknJ0d+kQhp+oBCZ7SFKBYWuKkoHdoO12lfQhc6EOK+pOisFHHvDcTanj2s5WXe2nqkZUDgNpEU8+iKD8HgO72650keDfX8HGa4dq0ntV1pfFjUJ3Qy6RZRlyik/ZywX4orXgyljup3YtfGtaYyS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970763; c=relaxed/simple;
	bh=yrOL96WQB45BsOIOMe1pCQbL636wLaxuVIMO2PXPzWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=maqnV5AXel2rX7ewF82GpMcr9dzdAFt+Daj7TzIG13n88NcX+ih6kc3QmG9thi6SVo3rkRtd8mUELPkArk7J8OihePhQzijx06O67wTxslq0agJoyfol/b6oHesTxklLY+bhpoe91p/fm5ZUHjUXXS5OGQVpnMSahRx3a1wedcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=juD2uuvF; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="juD2uuvF"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A8EE33ED5;
	Wed, 24 Apr 2024 10:59:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yrOL96WQB45BsOIOMe1pCQbL636wLaxuVIMO2P
	XPzWQ=; b=juD2uuvF4VcgoR2vSITtSimdfHKpaodYty/Ly47e/85mC9dqYBdIMS
	+T4cVOum9BDFgwlCmUo0Q9cKziUVcqw78PXGj8DcIDjwMrMZ276608J8oPAcPZYA
	vrEMLgM96WBS+wNQeKoBCosJdQRJMPJ/N9JyVuwz4KKtHWlLGepsM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 227DB33ED4;
	Wed, 24 Apr 2024 10:59:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6355133ED3;
	Wed, 24 Apr 2024 10:59:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk,  James Liu <james@jamesliu.io>,
  git@vger.kernel.org
Subject: Re: [PATCH 0/2] advice: add "all" option to disable all hints
In-Reply-To: <ZikSNSszRzBz715c@ncase> (Patrick Steinhardt's message of "Wed,
	24 Apr 2024 16:07:49 +0200")
References: <20240424035857.84583-1-james@jamesliu.io>
	<xmqqo79z2s24.fsf@gitster.g> <ZiirKgXQPLmtrwLT@tanuki>
	<7d1d2892-d486-4e91-b100-e44c1d76893c@gmail.com>
	<ZikSNSszRzBz715c@ncase>
Date: Wed, 24 Apr 2024 07:59:16 -0700
Message-ID: <xmqq34ra3iyj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 399E236C-024B-11EF-B610-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Filtering out advices would be doable. But we probably wouldn't want to
> do so unconditionally whenever we execute Git commands.

Can you elaborate?  Would you only sometimes show advice messages
that come from "git" you invoke?  Based on what criteria would it
decide whether to filter or not to?  Is it purely per location in
your program (i.e., "every time the control flow reaches this call
to an equivalent of run_command(), we would filter the "hint:"
messages")?

In an invocation where you would not filter, what effect does users'
setting of advice.* configuration variables have, and what effect
does a new and unseen kind of advice messages have?
