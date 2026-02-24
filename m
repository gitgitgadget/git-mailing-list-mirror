Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4732436B071
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925358; cv=none; b=X3Af83DKaVXgqOnFc55fut8eVd7LqTGpG8/tHrgUvnCI4SxOvfJQKCKzw9mM10/R10Bje9c8dOgF9ZyNDT94emHmtetqjnMQBtGHtCt8XPKIvda6elOK/BV8IgvrbhCKDwBgOVTsBodLkNmzIto7uL78N9Agt8GMWvzgHbog+SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925358; c=relaxed/simple;
	bh=tL8GxO0CA3h/s+SDKKSTtfVu0nKIZVFQh85+wupuZYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnD0Qk4wR6nPiZHqpeeNz6rxQ2dPDAV7E3FAGTQJ8qXqYwD0PGl5F62ecty/wsNAXjdaBLOBg8oAvSK72IHCr3GsWzxKZmVqWXhlCmpzBsSY7t6V6RjyarANt36MFm6e439Sa3iDIxOU87gZBfqXoJIWxauFEmiWsROsFVN/BhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=MQyWBeyc; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="MQyWBeyc"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771925354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u4cb0MeuoVodYyRamrirfrxC4+0C91wCKIur6nTN8xA=;
	b=MQyWBeyc/mq2+3505QAPyMCNLrSjxvnGBCDgAYaIG8NG3zs6c1BpfSVsHXegD5XzhI2Anj
	4RKbRNs3A0VrxEiXG3CC3o3DLhyCCDOinS9ykwRSudUWqzDLHfYZ8Pn6BRTnTy3CtqMYY6
	hSttUm+zrhdefx9nFn+4qw7q/Z4D+9Vx0pl9JuctEMyvfZkdJBuraa/RR+2s86seZdvXve
	uM/7W3ezw4Bo/J0hwZZNuI8itvR+8TQWOPHhPu9vyyQoOxub6y3kki3kaXfoU87EmvWNTP
	1Qadsy4CXqO3i5BOZYdk3wnMwwhJkbMrfPRrkUUQY6z4ZzZ2djH5is7zMG3wIQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mroik <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 0/2] format-patch: add cover-letter-format option
Date: Tue, 24 Feb 2026 10:29:00 +0100
Message-ID: <cover.1771925291.git.mroik@delayed.space>
In-Reply-To: <20260224040400.751247-1-mroik@delayed.space>
References: <20260224040400.751247-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=473; i=mroik@delayed.space; h=from:subject:message-id; bh=ypIH0V+mViJCUiXXwaomhde+JevHv9G3tZj3gjN093A=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpnW9SmTbfR6rC9F+g8jZwnF6hKfklrUnyxGNHn 3UzVCq7Z3SJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZ1vUgAKCRBIeX6hnBm+ 0fZVEAC225Z1r67VZhWHJUbzBauV4pOSVGRLHMTY+jYEvly/TsIMKbIgxfa8m82fA/IFd2hG838 acga7p3FyN4drNRYtCSw8pgOcP4GU2k14Ef4m5URB8Pez1dCM76EN5G5zBNlXjSUXndPkHilJ9q A6uw89y2LoBlvfTBUDP4q+NZeLbuY25S8VcOZl6RZs9t1FxDJ2cUYrMORu2pI8yDzzw6aH38NiM BLqWdtSAkGHdMC+UnFUxXzr6sHbzSVM7vIXSc5ecVq893uOaTbZUH9dkL06VQOZm49k2tQzbLcH DdOLft36lKD62lO10FqDO5YvZQ2UO41eXAtF+v7OZxDVFkJ6wFLijhOE7mWJQ1Coi5PE78Xf92h 4C+HTpP50HB4STlfcjTdoGKtm9OyPlPkQkuKiwKHAhrgIwaDn3YaTYGvZsjTBTKIdX3uQHuSfRG HNgL73xoMZBsNQFWcfgtRs2SfcySgy7PpdpAM/M7aNj7eMHQJqBE6SbW+IEGnMA9k7E9H4GP0cH 6hNHHwmd+JLaRsPhz6naeIAQWRyhe71CDKrIoCFPEKHcPqMvgUycgsw4Ph9WkKgbiJzE5z161XL D7yBJkJGD3/WvhoRVZDLhib8BQlR18PekwuJqwFlKD61DpFr64yK7m6RQVZ+NgM7vH1MBifjhuP jkpK72l4On
 k/ZBQ==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

From: Mroik <mroik@delayed.space>

I've dropped the first patch of the series and applied the changes that
Jeff suggested.

Thank you both for the review.

[1/2] format-patch: add ability to use alt cover format (Mirko Faina)
[2/2] format-patch: add commitListFormat config (Mirko Faina)

 builtin/log.c | 87 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 16 deletions(-)


base-commit: a8e89346a7731cb3104010f322c65e2a0c922618
-- 
2.53.0.3.g6a0c7aecfd

