Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0EE1EEFC
	for <git@vger.kernel.org>; Fri,  3 May 2024 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764058; cv=none; b=V8MqukHVlfAYNfzBziDquDY5JRW91IXknhaDWk5Am+zO2QD/nIoskKxdh7AHDgQFWGKM7ymD14Nwv0V+OXdIln7gwxmOz5lGb9R8javUi6gDZf1Dx1tGqtVwzTkXD6EdJlkSTkDR1pjYZ2AtG9kza/VQIrrLixpMN+fBa6Qu6XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764058; c=relaxed/simple;
	bh=Ya276m95/I29BmipESR2bg0PAb3yff3PaQkR7620OwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A0U+8wKHryRS1tKeu5rnvE3rMyVzVgOz5r0VJeEV5QsnnrBMvHxYgEfT+4G9FTNTbtIN/E//LGAJj0Uu0noq5XpmqyBYDLjR39CKqz+drlJjEZCEq3xN8d8cm/wBKHoDcjgQoKrFRMYBGpd8mjhy5fGbN7dghtmW2vqKiqW+Y6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uh8VNg+e; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uh8VNg+e"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE44C2B439;
	Fri,  3 May 2024 15:20:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ya276m95/I29BmipESR2bg0PAb3yff3PaQkR76
	20OwI=; b=uh8VNg+eT/3Im6VKcglpWxsgNCCkf7N7kyKGk7H6jJ4HiJZphW8qrW
	+xgZDdrT93eLiewTKQ+Vdi+v7zsEnyr+b8nrrG/dz5Q1ndtsU7dgURm17xCnTIAU
	A65EbeGWiYIDz9t0VyaXzNMPJpxpabQ/QBuBL7PZSKTX89tZMHldI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A14A62B438;
	Fri,  3 May 2024 15:20:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13F4D2B437;
	Fri,  3 May 2024 15:20:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 4/5] cocci: apply rules to rewrite callers of "refs"
 interfaces
In-Reply-To: <ZjUxlLyyvmHNifDp@nand.local> (Taylor Blau's message of "Fri, 3
	May 2024 14:48:52 -0400")
References: <cover.1714717057.git.ps@pks.im>
	<5109468b356637b8b4521a3e96ba228622804ca0.1714717057.git.ps@pks.im>
	<ZjUxlLyyvmHNifDp@nand.local>
Date: Fri, 03 May 2024 12:20:54 -0700
Message-ID: <xmqqy18q66sp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4348B678-0982-11EF-8F39-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> I don't think it's wrong per-se to use the_repository here, but it does
> create something to clean up in the future.

Very true.  This change can be mechanically reproduced on top of an
updated codebase.  Such a semantic fix should come on top and it is
better to leave them clearly separated.

Thanks.
