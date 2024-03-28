Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4855A4E1C9
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637114; cv=none; b=MMJL/cMRtw8n61bYcg69FF2kSoivKUcZd+py7Db4rmAkJyScJ6rKYFlyt8c8nCSslOHk0ORBEFhgt/x4RjJ9/wJYEiZIYq9+cfusgem7jH8Kv77UUF189C8kGO4ra5tZ/5lC1uXOtPx6kVPYOPIYbz3tgbIz2+psOhbUKU4NBlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637114; c=relaxed/simple;
	bh=+Gs+TfCC012xgrXqJ4pYhVOWXnsbH/TYSJT4iuvjzgQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bNEnWW1kRO/61Bp2l6uNMbALP8+amUaY2EmPCo9yQwu87sGFvw3qEEpb5Y2MB9SqEjV++x8VjAyaXwhXRs2QAB+v+HdCuuy/zZ/cbdUXhEBCAP5c3LpKNmFKwwjuj4YPo9oW5lJg/oIkXub2YpHxBKvz91imecAWkn1lkBrpvS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ABCP3Vb9; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ABCP3Vb9"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE1631EA8C9;
	Thu, 28 Mar 2024 10:45:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+Gs+TfCC012x
	grXqJ4pYhVOWXnsbH/TYSJT4iuvjzgQ=; b=ABCP3Vb9mWQTp/GB55wMwbpB8hjk
	oQBD/jsqlfv4pQayZ4igWgKOsJhhN568TwycAjxZvt3b+GYT+mlw9p8xFljfTQ9s
	QPDpKbo+cvO5nTHP1k3G90MpP6kPhnhN6m8IByBZIYyGjdJCEC8ouvz1BtVZfEZf
	Lma1+xoeoCsC7rE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D0C321EA8C8;
	Thu, 28 Mar 2024 10:45:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A7AD1EA8C7;
	Thu, 28 Mar 2024 10:45:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 1/2] add-patch: introduce 'p' in interactive-patch
In-Reply-To: <4fc0e4ba-16c2-48ae-beaa-239568dcd16d@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Thu, 28 Mar 2024 02:12:05 +0100")
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
	<6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
	<60d978d0-f69a-4b65-b4ba-d30dac8f112a@gmail.com>
	<4fc0e4ba-16c2-48ae-beaa-239568dcd16d@gmail.com>
Date: Thu, 28 Mar 2024 07:45:07 -0700
Message-ID: <xmqqttkqxvnw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 C672E6B4-ED11-11EE-866E-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Shortly we're going make interactive-patch stop printing automatically
> the hunk under certain circumstances.
>
> Let's introduce a new option to allow the user to explicitly request
> the printing.
>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  Documentation/git-add.txt  |  1 +
>  add-patch.c                |  4 ++++
>  t/t3701-add-interactive.sh | 22 +++++++++++-----------
>  3 files changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 14a371fff3..2965cd0fb6 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -348,6 +348,7 @@ patch::
>         K - leave this hunk undecided, see previous hunk
>         s - split the current hunk into smaller hunks
>         e - manually edit the current hunk
> +       p - print the current hunk again

With the hint of "stop printing under certian circumstances" in the
proposed log message, this makes us anticipate that "again" will be
dropped dynamically when we did skip, and after we printed, "again"
will be kept.

But such a dynamic rewording would be more appropriate for the
interactive command prompt (which is already dynamic).  Perhaps
dropping "again" from this static text would be better.

Let's see what happens in [2/2].  Perhaps we have already code to
dynamically update the help text, in which case the above does not
apply.
