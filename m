Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0981D6A8
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067496; cv=none; b=CsdwjJUdN3+5mGWPKsIiW4eV5n6wxISoFzl3EB/rIUqtUPYxUkyF8MdWzmMDCr3ayRkobyycYSiSekKA1xqdRe5m7v4YEn8QAclFK8LPX3QEIQMQvfM5DB204VF1nHVbUOzaxMkyoMPt8hsSQ4hY42tjLKO6+UWXBkIfLPPLBFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067496; c=relaxed/simple;
	bh=kzqASAfFy/1dXfpTU64bGFGYJqOgDZ1hdRsUNYaePz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QLsdBlDIsWGWtV+Uge1wLQLQX3emyX1Zdu3JbWTlR4s22eZ8aqEmfVZ74aszSubCJMt/bqGtv4WWxO/RBQEn8aYiZ4bmUfb2v/P+IgDD73xAHPtDncMJP594keTnvi2mz3f0vx1uAFYARsEcTSS9ah0qZE23u/4TaxdgBhAp5mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hMOxMTZ+; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hMOxMTZ+"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E66725920;
	Tue, 27 Feb 2024 15:58:14 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kzqASAfFy/1dXfpTU64bGFGYJqOgDZ1hdRsUNY
	aePz0=; b=hMOxMTZ+hkvTTQY3752ugdfHmLTKdTB0YgUeAqcE9oIAlbMXq4W7xD
	CFyIbup8QFGMcDX7lv7VfHSxFkqFxKJ/2L3rbsIJcHYoAWcOLXmrtCb7I0G3cHhZ
	+5yxsxWgdFtwaD4khIY1MkPEisQopnbJWaape4pgnA6NN5OEMb37M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 873AD2591F;
	Tue, 27 Feb 2024 15:58:14 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 29CDD2591C;
	Tue, 27 Feb 2024 15:58:11 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 0/2] builtin/clone: allow remote helpers to detect repo
In-Reply-To: <cover.1709041721.git.ps@pks.im> (Patrick Steinhardt's message of
	"Tue, 27 Feb 2024 15:27:34 +0100")
References: <cover.1709041721.git.ps@pks.im>
Date: Tue, 27 Feb 2024 12:58:09 -0800
Message-ID: <xmqqcyshr5em.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EA994EA0-D5B2-11EE-8110-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series addresses a regression reported by Mike in Git v2.44
> where remote helpers cannot access the Git repository anymore when
> running git-clone(1).
> ...
>  builtin/clone.c            | 46 ++++++++++++++++++++++++++++++++++++++
>  refs/reftable-backend.c    |  1 +

Sorry, but this confuses me.  Was a regression really in v2.44.0,
where refs/reftable-backend.c did not even exist?  If so why does a
fix for it need to touch that file?

Thanks.
