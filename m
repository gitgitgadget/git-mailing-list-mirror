Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F9517BB5
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708881414; cv=none; b=KPfZObdv7WswuEPAmNJ0hCxFWkDPJXy7YfzKdGUEYdiUUDmCn+wwM5Zpatsg2MPJV8zjduzRK//wE06sQ+I4eW1vQ6+oyhEDKZeKlhVtSx+Z8MYRii7K3zr8Qvgbc2jf47/J3Lt73xC02FoBkblvDTYaWxDUbTGBzEtJU60FlEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708881414; c=relaxed/simple;
	bh=6IgYILRNJTfF4toDKjnPc7ohR4X6uP1siEYlSI+oOvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d0HM26oEnMl9my6vd6+2UKVHskivCqoG/VUxsXHNIAMLgWvIjsDPsgs8sQBT2c9GBGgP9GZehwjppo1L4Q3NrUvSJ4hgeYH2eV9nA6RPJCwJWFJ+TzF08/IAuk5T+/zMLChaob//XTVwpSU/B3xj90k9JBfO/bkxCbh0zerQvPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bPj++pum; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bPj++pum"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B2B31EF301;
	Sun, 25 Feb 2024 12:16:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6IgYILRNJTfF4toDKjnPc7ohR4X6uP1siEYlSI
	+oOvI=; b=bPj++pumvTtxCI3NuINuy3RG7+egEBlyktGPnkeAdAWInWY4L3xRiM
	gSFNr8Etwsnwr+mZQxJvbnFIC54j4Wz+j6MMaX+40TJNtR9CRM4fCsCAMzePtVEG
	lrEq2sD/NsCv8xz1KpykirMHPf4MPnWTXOA3PVxrITJ8IENJLwVSM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 313FA1EF300;
	Sun, 25 Feb 2024 12:16:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 986851EF2FF;
	Sun, 25 Feb 2024 12:16:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Mike Hommey <mh@glandium.org>,  git@vger.kernel.org,
  git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.44.0
In-Reply-To: <ZdrnvKRl8oGPJxOD@framework> (Patrick Steinhardt's message of
	"Sun, 25 Feb 2024 08:09:48 +0100")
References: <xmqqbk87w164.fsf@gitster.g>
	<20240224051040.ftuo24smozqugbde@glandium.org>
	<ZdmOZRjJ-mClBR02@framework>
	<20240224195550.ignhzidmdy3ce6q4@glandium.org>
	<ZdrnvKRl8oGPJxOD@framework>
Date: Sun, 25 Feb 2024 09:16:49 -0800
Message-ID: <xmqqbk84jwfy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A9F42ADA-D401-11EE-B1ED-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> That's ultimately the reason why I don't want HEAD to look like a proper
> ref. But doing the "refs/heads/.invalid" workaround shouldn't be too bad,
> I guess.

Isn't the reason why reftable backend initializes refs/heads to be a
regular file exactly because we want to reject an attempt to create
such a file on the filesystem, though?
