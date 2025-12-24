Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F3A2C859
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766563055; cv=none; b=pjZXt3xRbdR0AEl9JvXJ8zATpMVyQbGz0BAdhrQJ5PZnV1Q4SD4Gp4T1jV8x1jQTDxfVyz7U3ad7S89byv0R79376nAxcJGGRABjPILKGgYqBYwY+R303OcPWAXCH9GPZ6CjQXeN8zQtqn16pqqodQ6nIExQv1v+s/wEcz0EbeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766563055; c=relaxed/simple;
	bh=Bb/edFWaLNW7/jG60H8A8M/kjQnOb3m9z1iRIzsoXGE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=tuAhII6M0A96jr0gsiIwyK2AojxLXJfyHyfiwLylRXVHltZruqS46mVA0cuguugyw/92jZxlZD2q5bW+RKnl3Yu8kNUZrVIkiRpzyZpUZhCT8/gWHhdeILNdU/EAqaFk/1W3Swj+5DwmjgBhYT5fqoN5XwvxDd9y5uEpkRRiDmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=wNiboRQo; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="wNiboRQo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766563050; x=1767167850; i=l.s.r@web.de;
	bh=AUZEyraecvOAa4x+rJjkY0qvEDdxPw2xRXZYAo2gRcg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wNiboRQo7TeMapzBNdvPzRIIoosHtye9Hb7A6avPTVYmZMKOcuz4x/Ly1o5t8Ogs
	 2w0hhtcZgT5to+GLjob3wC+YHJVVvorBNs+gqsc4bJ/SDsjXioV6y/BTGY7Ufgiix
	 uwgYlKz1+OWPwUZO5tk5ksb15ZjKdPUyTwhFfjBTxQZ8fargcPqBedhiNYAMqayau
	 UiHlptMVBIqdHXoQqy0VLUKYdlPwCf3U1MMR9F6RW4CEClZ3hX2fCKY/FAL3iTXfT
	 V+M9+SN7g3UdHlSrb5oOoQvmU6Y/ixQuVRjs61jivRt2t9HquP5z6/gvExXxm9IzM
	 Z7wszkDSJFGZPahL3g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.30.2]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6b8s-1w1PEQ2ggw-0176gY; Wed, 24
 Dec 2025 08:52:04 +0100
Message-ID: <ce030c90-f635-42b5-82e1-814cd4c29505@web.de>
Date: Wed, 24 Dec 2025 08:52:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 0/2] macOS: use iconv from Homebrew if needed and present
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
Content-Language: en-US
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Koji Nakamaru <koji.nakamaru@gree.net>,
 Yee Cheng Chin <ychin.macvim@gmail.com>, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xnznWdIRMDGw/wwUZGeTpxARf66coGlhLXjJn2guuEFdWkgzcGc
 Yt9cybVdaTwL3zD/rU2wbbLcin+tRIDuLaxq5+/7wdwtBN3icjcR9hupZu4CtYDcdW2h0bZ
 Bn3bjX5+ZKz+0vRq72DksotCZ5eeKw6U/jn98bvMpwrrM+nFd8r+Kg89YKZOXAtqO4Qto7s
 uiU8gV9zK12B/aC5FfCGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9SxTeP8TO1o=;K4tzxzjh8PfFDq76AjYyc3mgGiS
 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
 eX1C8ABTxn3E20Vrg=

Changes since v3:
- Removed unnecessary USE_HOMEBREW_GETTEXT and USE_HOMEBREW_MSGFMT.
- Set USE_HOMEBREW_LIBICONV only on known-broken OS versions.

Changes since v2:
- Added HOMEBREW_PREFIX.
- Added USE_HOMEBREW_GETTEXT, USE_HOMEBREW_MSGFMT and USE_HOMEBREW_LIBICON=
V.

Changes since v1:
- Added NO_HOMEBREW.

  macOS: make Homebrew use configurable
  macOS: use iconv from Homebrew if needed and present

 Makefile         | 26 ++++++++++++++++++++++++++
 config.mak.uname | 30 ++++++++----------------------
 2 files changed, 34 insertions(+), 22 deletions(-)

=2D-=20
2.52.0
