Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C59948D874
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436191; cv=none; b=mmU23YObpBFfj/ctud8pFazUSclfskqptkS6SShMgN/ys87DCQIdxjce6QJfTvXEFaYrgrgrd4rN+TIZ4Tnyx2pN+R081/uP/n8vkG7JOa4HUixmXaa7VpSb1UchxASgaHgWRzssxsiSVKso8T3Q4eYEFec9wkeeaPOplMFh3Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436191; c=relaxed/simple;
	bh=giAxBOQQMdVb7SifCW8O89fNRkKqoIMJRvx60m881fc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Es96oCUIMd5jhsbr9WElwGywOBwPEZU/kjOzprO3S9UuKbM6vGgcsTKwdeyWiEZ2ofJvNApnG9K5L2IHYwtPmN9wzP0oXCtEXtg5wsFd3kp4YOBk/rDNb4rocBcgGAYejpITlK1s4Ppd68QnCbneIvp7VI5sV8j5VJ7EiBg37Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=UksKYDOR; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="UksKYDOR"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hbHvH0rMyzMlCJ;
	Thu, 03 Sep 2026 13:49:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1788436171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=giAxBOQQMdVb7SifCW8O89fNRkKqoIMJRvx60m881fc=;
	b=UksKYDOReAxShW/BAvcopfN/3iwzaww1w6lM7xRsDARnFALx4OqOkQXEPGvD8OQ2eRSPGP
	zlW82Q6GgVWuHdU8PBKTwoGMAxAOt30cdZ87L786cZYO9trliKHNW9b53TR0R/5Ht/FOvq
	nVAI2tl4xaCvNhHnFQ7IJ4mlXD9mmpjHWUnViKscI9Dweba6UROVYMriILjU+vmk2j7q8h
	T0d4ZPAHJym7pvRY6NNgwBGOj+aiPBRSN7OKcVx0pek5sYU7ONLGjhfh41mSvj+bu8Q63H
	g6mkaux2OW4qR4fqLNsTwwwuXGEOTgg9CXIPYxCDmQhbrno44yUAozCquUH3hQ==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2 2/2] dir: find common prefix among non-exclude pathspec
 items
From: Yannik Tausch <dev@ytausch.de>
In-Reply-To: <CY5PR17MB6144A1A7BF2E101FE26A6A85B1B62@CY5PR17MB6144.namprd17.prod.outlook.com>
Date: Thu, 3 Sep 2026 13:49:19 +0200
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <777C1706-60E8-4AAE-9EAB-E509567FABF6@ytausch.de>
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
 <xmqqecfbk2eb.fsf@gitster.g>
 <81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
 <886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
 <27FF785F-F5D5-44EC-93C2-5BD67BD99147@ytausch.de>
 <CY5PR17MB6144A1A7BF2E101FE26A6A85B1B62@CY5PR17MB6144.namprd17.prod.outlook.com>
To: Darik P <Prescottdarik@outlook.com>

Hi,

> Darik P <Prescottdarik@outlook.com> wrote:
>=20
> 940-842-9147

could you clarify what these numbers refer to?

Note that, as indicated in the v1 patch =
(https://lore.kernel.org/git/0CA8678D-0540-4A2E-B314-B9BEB04E2BF5@ytausch.=
de/), I already discussed this matter with the git security mailing =
list. Not sure if it might be related to it.

Yannik=
