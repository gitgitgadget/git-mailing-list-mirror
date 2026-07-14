Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE27E3EB0E8
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013215; cv=none; b=g48ebPznt3A/E6ZVy8BW8WLZKya3qwXj+Nv2g5A6zomUVBRm4LKV6asCvNmc8jIl+sTXUj7RQgaNrH/z7rK1dI7XTsksOyHMI6sZCzHUVcE8vqHBZ5SmilpV9TZop5MFtgmsIhOBJATH6stCZkAcx/WWPK6cBIQjF2IivlsEDHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013215; c=relaxed/simple;
	bh=tOXg+uvrOkCqWjwQgBIqUdAvu60FKfiG7k59Ja4Tqak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMkn4cjETB4AosuDOyPhdyLPMaYCA0gYKBd080cm85icnq0zZFX7M7btNel1XSqatNDg6gqFML8YEknXc1gelkZ2ptMVRRX4XNJG+k7dWkms5t8UijjNfA7W3pYBWx68c62lDjy9WfNpMPeowT09p8DgEzD3GQ+3vixaOEr2Z8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dbzykRtg; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dbzykRtg"
Received: (qmail 21737 invoked by uid 106); 14 Jul 2026 07:13:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=tOXg+uvrOkCqWjwQgBIqUdAvu60FKfiG7k59Ja4Tqak=; b=dbzykRtg1llaUAzwUpr2ivuIiOHLuZkSFSVh/MkIgQ/lU4+saarwExPXF5UoMFSBdiGZy/wpSD2Rf8hJLbaXBzTydoOJyb7srtJPEcKC2dazh3hGASaQNu9z1xp9oiC+9J3/1X0yH8hQx6Fgl29B0ceOIMzs7fQT0by+/dM8U3FtKUovTe/mL7wwW9qEmDb72vMaGQqMTNmRS0OARMPb2UKVnA9wtP/GyNjDE049cgfPH2kSSRB/TAs9+Cp5pEBvXgGZVFOHFHrQRQwwh4DI9vsxE5gcOhfHqKYuOSEdFCXxL4+d46dI+6LupoHX5+N9Z/yLXO7mjvlbOioeVBJamQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Jul 2026 07:13:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 42750 invoked by uid 111); 14 Jul 2026 07:13:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jul 2026 03:13:36 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Jul 2026 03:13:31 -0400
From: Jeff King <peff@peff.net>
To: Ted Nyman <tnyman@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/2] fetch-pack: accept "pack" output for packfile URIs
Message-ID: <20260714071331.GA4058163@coredump.intra.peff.net>
References: <cover.1783982021.git.tnyman@openai.com>
 <alVoA5-fDDPwKPZZ@com-76773>
 <20260714071231.GD2516582@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714071231.GD2516582@coredump.intra.peff.net>

On Tue, Jul 14, 2026 at 03:12:31AM -0400, Jeff King wrote:

> Would a more generic name like "cmd_output" or something make sense? I
> also think this would all be much nicer with a strbuf (which would let
> us get rid of the magic numbers), but that is a slightly larger
> refactor:
> 
> diff --git a/fetch-pack.c b/fetch-pack.c

In case anybody does pursue this, it is obviously missing this bit:

diff --git a/fetch-pack.c b/fetch-pack.c
index 5f94f35c30..359740f231 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1935,6 +1935,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 						 xstrfmt("%s/pack/pack-%s.keep",
 							 repo_get_object_directory(the_repository),
 							 packhash));
+
+		strbuf_release(&cmd_output);
 	}
 	string_list_clear(&packfile_uris, 0);
 	strvec_clear(&index_pack_args);

to avoid a leak.

-Peff
