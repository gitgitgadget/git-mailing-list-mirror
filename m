Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C380018C324
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579134; cv=none; b=OFr9wHjU1WZGCWPTK/GhumSBiRkZ94qqjB6y5nwPKXf81NURk9UUsEnXV9VCmgPBRhqe1QzkJFjThSyVPcAbamLzYZ0IT2/8xK+bjID9p73tJRYBUTIKW0b8g+zshTyL1ehqyNrD3WpewOjBxEyFkxEW0t+3qx10B/YXG7es33M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579134; c=relaxed/simple;
	bh=okKi1nmumB2pdsKF0AvNp5mkPvlhx/9+BMZkVgYNv+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8zYfAhzX9PY+0mskSiSaLWO2oIEYwRFfS/G8eEuYrxvimEq0teA/t3w35AnaO18LVP1HgoiIUR4IP2X15hhOgBHMGh0OEGD4zUGV+zzcekRC/2zqO4UE8h0WK7OYHJ8uJ82Tbbn9OF9KXhO0OxGZvoLNVErGW+q260fizkVKBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24981 invoked by uid 109); 5 Jun 2024 09:18:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Jun 2024 09:18:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28190 invoked by uid 111); 5 Jun 2024 09:18:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Jun 2024 05:18:49 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 5 Jun 2024 05:18:50 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 06/13] dir.c: always copy input to add_pattern()
Message-ID: <20240605091850.GG2345232@coredump.intra.peff.net>
References: <20240604100814.GA1304520@coredump.intra.peff.net>
 <20240604101322.GF1304593@coredump.intra.peff.net>
 <f6951a8e-ab88-42f1-8c23-acc65d2d5646@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6951a8e-ab88-42f1-8c23-acc65d2d5646@web.de>

On Wed, Jun 05, 2024 at 10:53:53AM +0200, René Scharfe wrote:

> Am 04.06.24 um 12:13 schrieb Jeff King:
> >   b. Now that we don't need the original string to hang around, we can
> >      get rid of the "filebuf" mechanism entirely
> 
> Right.  This patch does remove its use from dir.c, but leaves it in dir.h:

Hmph. I'm not sure how I managed that. I definitely removed it from the
struct definition in order to find all of the sites that mention it, but
somehow that didn't end up in the final patch. Thanks for noticing.

It looks like the topic hasn't hit next yet. Rather than send a v3 with
this tiny change, Junio, do you mind squashing this into patch 6 (it's
d465adca6d in your tree)?

---
diff --git a/dir.h b/dir.h
index c8ff308fae..1398a53fb4 100644
--- a/dir.h
+++ b/dir.h
@@ -95,9 +95,6 @@ struct pattern_list {
 	int nr;
 	int alloc;
 
-	/* remember pointer to exclude file contents so we can free() */
-	char *filebuf;
-
 	/* origin of list, e.g. path to filename, or descriptive string */
 	const char *src;
 

-Peff
