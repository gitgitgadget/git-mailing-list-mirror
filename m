Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A49381B07
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 23:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772840105; cv=none; b=VX6wSpjAqBj+rwZWUq5/dxHqHJTA8x8sCdhT1UIpH250D+fuqmGvpA7uAqc9GaewUf6AbKgT0owD1vzC7jcpTFMZG7tMU+HNzunTXQYx1apOu4my5weiVBSvteuz6tSP4oSkpCS6Q+cnU/d+0HpcBTPST37EI/Q5jCktXbQVDbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772840105; c=relaxed/simple;
	bh=3TnKL4RZ28xi9UWK4inmE2UhIYQhijF18566e2n6E1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzFOVoguH2CCR0vyeTZkvF3ZKbRMdSMXpk/kydcyPhdL3xfdQgqdF3CZebCvw4tnfCC4i2JNQhbK8yah2wDsc9ctlrxULhq1FnQxMjDiTVNcGfaUgeX0sjgFPcQTvWBcNFNg4KQU3GNRDk26zkwF31u3eRnwvLCSeWgk8aJXNrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=QdDTWIfW; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="QdDTWIfW"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772840102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6Mq4esCR4Kb3/Hq1nqAhJIpXgOhSQjdthQx6FoYvx0=;
	b=QdDTWIfW8ud18xhRnCC6fnHek1F8l03RhqzarHp5PGlKtARQqujH7tR+jvp6DAepgFMAFu
	NNbPkkb7qiqSTKZwCL//3mxzvnmoW8mKn4BBFR7lN/tHCJSk0VpfKkJNhHJbxji+/tB6lM
	Bs4KyWV/EAKjsvbfyiRkdIQeDShHflzR7MJA3fjloN3VpKJ92tXTOUWzGOi4M1xbM3hqVi
	hWYJ8p4gdlTxEdLWwnFZ9sk03IDZfJ1H6jCjDNNikfaklJqS+/T117nTvmQkwQ76MGPq5X
	IX7rtgph52u2g+lXlG9e5QbiE4QfoJPcTND8LBno8PBs12zdccxnEd4ld4EcAw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v7 0/5] format-patch: add cover-letter-format option
Date: Sat,  7 Mar 2026 00:34:39 +0100
Message-ID: <cover.1772839973.git.mroik@delayed.space>
In-Reply-To: <cover.1772837832.git.mroik@delayed.space>
References: <cover.1772837832.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=835; i=mroik@delayed.space; h=from:subject:message-id; bh=3TnKL4RZ28xi9UWK4inmE2UhIYQhijF18566e2n6E1c=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpq2R/eSfWXDgHjtUDDD+ggfdRrXVW7VW/nKr1P cr8uXo00HeJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaatkfwAKCRBIeX6hnBm+ 0cYeD/9BlC2y3Tq/Ux8JgEUSxxsZrj88p0/P8Oe4ZFCTXDkKmxKLhf27Oxr+oHEbljoh3fYdLVo pnDTz1ooE6a16UtZHB9pAy7M9lsiI0MA38a7Z6/IDxu/KmmuXzw/KqFqU8iNKl7nVL93Snjp4/z UV5yBMZzYBem0Z43LzIH1K7WdlZTQez1IhogCC6kAycvBOOW2rUI+9bmX3K/dpFcxj+kARMxHAY OxtCNCh6WwT74bQnudVEx0tnVgt8KesnDVR36NyfO8IZWTXmnmUXesb4jZlvPaN3nmpaeFY3e4V lOHbKosEfADr6P7L9MVQ3UcPHijYFCIwCU/jln2ACniLqcK66S10YUNCNZ3MPN9bJqHcQqyz6dw +B8jaWWvbF2iQak7QvQT4upzcbIGStFJ5Ww/9m/HrviF45TfqUxiWQZm48LfHMd/FBn0sYUQ+0c CvyN3DfVbKGflxY/Kh+Q499S7NTgLb5+lPjdTkobWwSOrizWvJfFbBOM1AHuduj4Tz0JWt8biSI 3Q07sE76z8NvMMnfZ6K9B8RV46Q1thHwhbH2fXYjAAfXZhohCtnTfTqu0TM0HzVNJGIaBgBZZ6g s5XWSh6Y6IEjKT99vl0m62XdMNZ8kPV9JqU9+pHsfEOBLKDo7+2j0+ccdSEYgHCJ8p69/2nCfJe 01DbOnxcgg
 0WmxA==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

I've applied the changes you suggested.
Thank you for the review

[1/5] pretty.c: add %(count) and %(total) placeholders (Mirko Faina)
[2/5] format-patch: move cover letter summary generation (Mirko Faina)
[3/5] format-patch: add ability to use alt cover format (Mirko Faina)
[4/5] format-patch: add commitListFormat config (Mirko Faina)
[5/5] docs: add usage for the cover-letter fmt feature (Mirko Faina)

 Documentation/config/format.adoc    |   5 ++
 Documentation/git-format-patch.adoc |  13 ++++
 builtin/log.c                       |  91 +++++++++++++++++++++----
 pretty.c                            |  15 +++++
 t/t4014-format-patch.sh             | 101 ++++++++++++++++++++++++++++
 t/t9902-completion.sh               |   1 +
 6 files changed, 212 insertions(+), 14 deletions(-)

-- 
2.53.0.5.gbe7197aef5

