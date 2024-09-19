Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACCC1EF01
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726773093; cv=none; b=rGqaAodXOgsVu+9EWTD+9OwYv8DbNhfN0i4biJNQHXO4jVyO8B7QVatSfk/mxpGIW/C4Xe2Jy5nRGi1O7/YR7Iy2JlDfcQ0y5DolD2TFwOKf0ALJkNb48fk2chzafh3zJEbAcdvPF7331x20qrrPI0DkMops3byeqyWXnXmvDos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726773093; c=relaxed/simple;
	bh=O8cetz/DDn9IFequk/OPlfVUSekQaY99SycWFAxVdoM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T9hMjejfzben5vE9U8JkDQc+bueXmNeIC5xuVKslOZmVtdqdK7VHjxbQ22gwNfvsBIyvcfpj+oscl9afBiJ7ONqplPfyj9JHT+QdqjyyjwQr0oNx0iN9VqjTE2vVQItX94gZbXJtqtP2wfiFFyL4ZW4N+c27a+PeTogxl2bIkrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EGB+GucP; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EGB+GucP"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 36F7D2A88A;
	Thu, 19 Sep 2024 15:11:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=O8cetz/DDn9IFequk/OPlfVUSekQaY99SycWFA
	xVdoM=; b=EGB+GucPOlopwFeY2RUcjXKbDePKmbT4YgROGF+0QtgcEtLpPTL55Q
	8J9jKVJlelBS3vOmVU2MX3KFbk7qbHoJznjdeNtWUMQWZEvkeFayVxl0WOIVX0nb
	hiimBD8ITg0NXWC/XwHsZL4+bPFjuhUjJfH2DrNrjQeSVwWxnlFts=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F1062A889;
	Thu, 19 Sep 2024 15:11:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8D71F2A888;
	Thu, 19 Sep 2024 15:11:30 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Daniel Stenberg <daniel@haxx.se>
Subject: Re: curl 8.10.0 regression breaks uploads with HTTP/2 and
 http.postbuffer
In-Reply-To: <ZuPKvYP9ZZ2mhb4m@pks.im> (Patrick Steinhardt's message of "Fri,
	13 Sep 2024 07:16:54 +0200")
References: <ZuPKvYP9ZZ2mhb4m@pks.im>
Date: Thu, 19 Sep 2024 12:11:29 -0700
Message-ID: <xmqqmsk37926.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FA3B92CE-76BA-11EF-B91B-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I noticed that GitLab's CI started to fail consistently with our
> Alpine-based builds in t5559.30. After investigating a bit I couldn't
> notice anything obvious on our side changing, so I checked whether
> Alpine itself updated any packages. And indeed, it updated to curl 8.10
> yesterday.

FWIW, it seems that osx jobs at GitHub's CI started exhibiting the
same symptom.

  https://github.com/git/git/actions/runs/10932986544

