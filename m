Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931B23B632
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 11:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759492332; cv=none; b=O5Uh0P5JNN/adzr7jIbzcb55gJVU3z+ycd97tzYvaNQUaWEBoaQ0pIlynd5yrJtYAN/aSB4JVCH5VJO/5Eg70BMoYOim9ZM+/eQC0hWT8he5HiaDszAtZtbmeh8c0NZ50ofhlMj6xPLNtsTd/Piz1np8rAR9EZXjiC18AReGNuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759492332; c=relaxed/simple;
	bh=TQcXsz61z6999huRIIcIUAeOcvStwQQyfW4EGmt1B5M=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m4luk/5jVkOd3mLYfkB1cGJumMCURpV1TPigDdJWBmIUN1Ur5kxxHqZ7W/uVxUinDMQv7St9dogMusqB+Oh1vq7WUf21aSimE20ZAXDSsWpAgo+qUkB4LSoKW04l1FipgPEudh7HthzxDRy86gzfOLAjsjmMzc5YFCAoqzvv0KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=calamity.inc; spf=pass smtp.mailfrom=calamity.inc; dkim=pass (2048-bit key) header.d=calamity.inc header.i=@calamity.inc header.b=EiJGdgTw; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=calamity.inc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=calamity.inc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=calamity.inc header.i=@calamity.inc header.b="EiJGdgTw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calamity.inc;
	s=protonmail3; t=1759492319; x=1759751519;
	bh=TQcXsz61z6999huRIIcIUAeOcvStwQQyfW4EGmt1B5M=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EiJGdgTw/iecCim11xrAfxXGjEJWhTY10oizx8j2XjKmYhDFg8xIy5DzYh9IxQx9h
	 TkY2uuzPcbUaBeMVKIhcySg63PvrM72/NhQU4+ddu2wghr5Mngw+ORz+XxBJguMT5u
	 kagl5TFvr6KNt6IfhbyDs2ljFgTDEAev1hsOf3E9L8p/CISeIh6MfrkUq+DJ2PHjEN
	 wrxvA0n+E2Qpuj896iprwYlLlZ2eUB9ea9yFTOtpadEYRsyp5yh5pY+Aa6C+aTKJKp
	 7vT101Ih9fndmG5ixbDFEwWgnO01FxTLBpvci2PqGzIvXPyTCH1CfHVSTgSVTvk3YF
	 MIy7hKqzt2JjA==
Date: Fri, 03 Oct 2025 11:51:53 +0000
To: Jeff King <peff@peff.net>, "git@vger.kernel.org" <git@vger.kernel.org>
From: Sainan <sainan@calamity.inc>
Subject: Re: Could Git be smarter about object reuse?
Message-ID: <mVMA1eOYhWQp-1-EXnXsp31DUwjoqszklcsfGiT15qy_QKmQWj6Z8PrDLMoIQeAvEvxrRhW3dXblWbtSKLuYycnaU5x_DM06A_XxWH_lWBk=@calamity.inc>
In-Reply-To: <B0Y9iigwIf1VSJpVtY_IzINon0LTimi0sIg9B4j8pDJt2FoxHmQ-Gn5C0s0l-GhsHMP2ZptgNbm879BqQgpDOo-CFEOhh-nQqhlISosKoWY=@calamity.inc>
References: <pmKix6R7b3WVLrcK6ig1Lh7RhrB5G4Hm5yam_fEoC839aatB-OjJEmSJJ-weErGEnt4Mvgf5slxgu6Pm1xlGZ4mr_i4MIAAEMYy8DjJnWgk=@calamity.inc> <f478fc6f-77ab-4d4e-a8d9-2d44622ba8dd@hogyros.de> <2RWL_muy24EPDZ9wWFx-WZfu4Br_F2LenvcVJbKewfSVYipYM3qmeEIgV-6o4EbL39ZjMXtLHbVFOCPcBdHHVAU-0BrgBtuQ9BdRjS_2niE=@calamity.inc> <20250922200510.GC2205919@coredump.intra.peff.net> <ZURUr5sfXi0wsjBeXiwAxyNgalVa2ZveXDgoTcexUNOAgcP_JscHvFFDIss4stpsiB2MzUQ_Z30tFrPSgr8W8V02ecfCj4BFFwQqWwJpba4=@calamity.inc> <20250923005421.GB2271307@coredump.intra.peff.net> <B0Y9iigwIf1VSJpVtY_IzINon0LTimi0sIg9B4j8pDJt2FoxHmQ-Gn5C0s0l-GhsHMP2ZptgNbm879BqQgpDOo-CFEOhh-nQqhlISosKoWY=@calamity.inc>
Feedback-ID: 116374642:user:proton
X-Pm-Message-ID: 0278dac1399bac9bab3ab5316e19bfe97b2ae7a6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The push didn't fail! git fetch on another clone gives me:

remote: Enumerating objects: 46, done.
remote: Counting objects: 100% (46/46), done.
remote: Compressing objects: 100% (16/16), done.
remote: Total 40 (delta 30), reused 34 (delta 24), pack-reused 0 (from 0)
Unpacking objects: 100% (40/40), 4.29 KiB | 28.00 KiB/s, done.

--=C2=A0Sainan
