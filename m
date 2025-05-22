Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38041A4E70
	for <git@vger.kernel.org>; Thu, 22 May 2025 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747938568; cv=none; b=QDFxiXUGWfMoVIAJlglWQoXrSQBU6CdrxVkqdwqnvB/CusL8SN/ICWmf9Cq/vbjmWwjvwFsS7CT+J3QEsk+dvyIDI04C8mAZqqhSO4GSFJqwsq1xdELl8kroZiQ0hOy5hnVlE3jvy4apuyJEwdn1KifTWXUdfH+qZJ0M55qQQf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747938568; c=relaxed/simple;
	bh=bXaQGWsog26Fk/Io3xcDDeec/0OuzRwJ3evaKSfK5/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSPaXC5MibC5vUUnt9qgFYlgkymzdKsB+A2mljiI87hZuWlzSGTmuORI1fpeycciunYAWMzz9iOemoyXQVrCrOZyDgddqGzfy80rzo3gA2Vr+yXcJEpkbt9cFh9D9193dRFqZTx5YZcn20t8fQABCiKjHUJOtMyW3Cyu9S1tY8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=emOa3r18; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="emOa3r18"
Received: (qmail 1015 invoked by uid 109); 22 May 2025 18:29:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=bXaQGWsog26Fk/Io3xcDDeec/0OuzRwJ3evaKSfK5/k=; b=emOa3r18jecCm/k7CeHmsGsvV4i+h2/Vcq74v0XBqLvvGhdZdzzvzvkKpL5Kos5nsrOAtYoeusAWhSqIxHHyxjMT0lt5Qp+2uJB6tX/z5fvKeNuat19XIq6k2nK/t9697A3itGwHX9hFECqhvUK6V+YOUlceSg6Zgt1MoM04Rd9JfAqf2qhpSUxQmNtZ1aoBQuZCmvh2ah6bj2jw2cg1UEXUkaD+xPIyeXaC/o0yQ09+trXhKaYizZ+BUYekhrFe4JIPHFbz2flI69CzsvKFVf1D8ooQT6BBHMd5G+V7/mE49D+bfw2FepB6mmyMYs3UQFpD9M4ycFAPYoCbQeT0PA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 May 2025 18:29:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21636 invoked by uid 111); 22 May 2025 18:29:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 May 2025 14:29:27 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 22 May 2025 14:29:24 -0400
From: Jeff King <peff@peff.net>
To: Aditya Garg <gargaditya08@live.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Julian Swagemakers <julian@swagemakers.org>,
	Shengyu Qu <wiagn233@outlook.com>, Zi Yao <ziyao@disroot.org>
Subject: Re: [PATCH 1/2] imap-send: fix bug causing cfg->folder being set to
 NULL
Message-ID: <20250522182924.GA14871@coredump.intra.peff.net>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95970F8CF7527648EC4BE907B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PN3PR01MB95970F8CF7527648EC4BE907B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>

On Thu, May 22, 2025 at 05:27:15PM +0000, Aditya Garg wrote:

> Upon setting up imap-send config file, I encountered the very first bug.
> An error showing "no imap store specified" was being displayed on the
> terminal. Upon investigating further, in static int git_imap_config,
> cfg->folder was being incorrectly set to NULL in case imap.user, imap.pass,
> imap.tunnel and imap.authmethod were defined, and the values that these configs
> intended to set were not being set at all.

I read "these configs[...]were not being set at all" as imap.user, etc.
But I think the only thing affected was imap.folder, which was
incorrectly being reset when we saw the other fields (and of course the
leak-fix for those fields was not kicking in correctly).

So:

  [imap]
  host = example.com
  user = foo
  folder = INBOX

was fine, but:

  [imap]
  host = example.com
  folder = INBOX
  user = foo

was not (we end up with a NULL folder variable).

> Because of this, git imap-send was basically not usable at all. The
> bug seems to be there for quite a while, and has not yet been
> detected, likely due to better options like git send-email being
> available.

I think that probably explains why it was not detected (by users or the
tests). It was dependent on the usage and ordering of particular config
options.

(The patch is still doing the right thing, of course; I'm just trying to
add more context to the commit message).

-Peff
