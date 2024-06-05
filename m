Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D25510E5
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 05:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717565060; cv=none; b=i/WoBMHbOWriJYsHE4JzPnW8Gs6wH3jli/x9zhobKOlntgrri+gacoRiDsHWIxPx0q88jqghIf6ohIMdsZGiBWvhlqsgVmRoX4/cqndPgZUT1ddhjFW6n8O7o7HGH2+XiSOC4N34C4paEVD21fkytWg3tGgLmjmewkiAfxkSESA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717565060; c=relaxed/simple;
	bh=gbpoYUoolceeaBmrbXiIu3FEkoEiZMlghFDJKNsySIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o9MxeJhKYPd3DK5SeHHnMLUqxKK6WffNnzolTYqEZTawE1EMbLOmMF5ToinJR9GAd4uuAuCDeOaJHNmLdb3/RUy1z0JlyxJdWb3Dv23ueDew30MQYLWKrOx9OgkFUBj6KHZKyOfzQkU+sU65oYGbqCZFdDl7npG78IbqVtU36Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gTTRgYGP; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gTTRgYGP"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B7FB521CC7;
	Wed,  5 Jun 2024 01:24:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gbpoYUoolceeaBmrbXiIu3FEkoEiZMlghFDJKN
	sySIA=; b=gTTRgYGPVV3V/FOw9lZrw8uojRSz/WYKrhJ2uh/vinMwovO8faSf6H
	6h5B7nANAzoYR1/tA+Q4kYcP4Kuc9JzP/Ob0fB6x6+jEhrPhswzOaxmYxOpk2oW5
	kdunXWk0nWyHEBY0Biv39lygZHvddi6w+Kvzh7vy9uGQ2UkNWuuk0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B107E21CC6;
	Wed,  5 Jun 2024 01:24:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29C0821CC5;
	Wed,  5 Jun 2024 01:24:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] ci/test-documentation: work around SyntaxWarning in
 Python 3.12
In-Reply-To: <c758b45282f8eb5fec401da6021d7ded6cebb243.1717564310.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 5 Jun 2024 07:17:01 +0200")
References: <cover.1717564310.git.ps@pks.im>
	<c758b45282f8eb5fec401da6021d7ded6cebb243.1717564310.git.ps@pks.im>
Date: Tue, 04 Jun 2024 22:24:16 -0700
Message-ID: <xmqqplswx8qn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DAA062B8-22FB-11EF-A681-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> These escape sequences seem to be part of Asciidoc itself. In the long
> term, we should probably consider dropping support for Asciidoc in favor
> of Asciidoctor. Upstream also considers itself to be legacy software and
> recommends to move away from it [2]:
> ...
> For now though, let's expand its lifetime a little bit more by filtering
> out these new warnings. We should probably reconsider once the warnings
> are upgraded to errors by Python.

Sounds sensible.  We can throw it in to the Git 3.0 list, perhaps
;-)
