Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9573F382
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 00:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711066300; cv=none; b=IPWa7GQgjYJHpLGMsszdSC11zO4X5VykLJ99egJFCj+0nLMOVihd0/MW8ZH6ZKV7dWzT5xuQjkJ8Ir25jmfqk/or4Falj8s7wuML6KRfzJFJogueTBSzOS2HjuGfbijYgwvp9+Q0Vw0iZY/ZINB3ZJtX22z5W6DBC/xqlS0fWm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711066300; c=relaxed/simple;
	bh=Bo2kkt479ZmJLlJte6bW4xiJmAHcG/XD3S2xkADKy+Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Us7Mv/vgdciA5blMJVLyANXDmetCxL79VltyQlg1hJ7DmUC2ptg9cY+G8QktZHzjx0jrgwWgSsVGXzCRZA5KtWxqSwris+tlbPe335MzvJsSqEMJv34SPqe6wfOni9W6F2njuH1LHwe19dXnAiy3RCoYlzk9LvwNutmX0HeQ2Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=R8jIvIu5; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="R8jIvIu5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1711066296; x=1711325496;
	bh=Bo2kkt479ZmJLlJte6bW4xiJmAHcG/XD3S2xkADKy+Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=R8jIvIu56gpNT5zN2j6JaZ3z1CyuI2RqjGe9Vs4t9fSaH/FKEzF/tp1ruor4mcGzh
	 6OaSs3Sw7ayM4ZWlBDwqaLm23W/mnnN943CxaI4O9rf1fMCVcePXX1EdDVXSKXtYf3
	 NmTn8+nNvf/88XPVD2/AQB05AOoXxH3uJy6AyYbBNiTrYZrVdL1ll5+X0dXWzD+Aph
	 3EP0PrQyuY1dTVBgLlvfineUXi/eApB2eirqLmfZEwC/3FSAnZtImpQ3YKwUeqCw55
	 LB5IKe/iH/XX4g1Jjx7ZcGQVmhOO6DA+S8NxDlz0/AIi8WyWwzDl1V5ECkwkE1GD3/
	 DoQnOBWP3/PEw==
Date: Fri, 22 Mar 2024 00:11:21 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>, Thalia Rose Archibald <thalia@archibald.dev>
Subject: Re: [PATCH 1/6] fast-import: tighten parsing of paths
Message-ID: <E3673B5C-3D46-41A4-A204-9574F04F71D6@archibald.dev>
In-Reply-To: <20240322000304.76810-2-thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <20240322000304.76810-2-thalia@archibald.dev>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Looks like my cover letter was dropped and placing each Cc: on a separate l=
ine
only sends to the last one. Let=E2=80=99s try again. Here's my cover letter=
 and the full
relevant list from contrib/contacts is now CC'd:

> fast-import has subtle differences in how it parses file paths between ea=
ch
> occurrence of <path> in the grammar. Many errors were suppressed or not c=
hecked,
> which could lead to silent data corruption. A particularly bad case was w=
hen a
> front-end sent escapes that Git doesn't recognize (e.g., hex escapes are =
not
> supported), it would be treated as literal bytes instead of a quoted stri=
ng.
>=20
> Bring path parsing into line with the documented behavior and improve
> documentation to fill in missing details.
>=20
> This patch series is patterned after 06454cb9a3 (fast-import: tighten par=
sing of
> datarefs, 2012-04-07), which did similar fixes across the grammar, but fo=
r
> marks.
>=20
> This is my first contribution to Git, so please let me know if there's so=
mething
> I've missed. I'm working on a tool for advanced repo transformations (lik=
e a
> union of filter-repo and Reposurgeon workflows), so I've been living in
> fast-import code and I have more parsing fixes planned.

