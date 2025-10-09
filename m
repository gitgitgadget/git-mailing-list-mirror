Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187FD25FA2C
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 06:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989794; cv=none; b=KW7oBtidxoB2cJzn7IvcD+0RPWt20Uz1+2om3QBkvlL3FdNjAbQScNT4sVOspu5BVCMdpm+e2yCXv9hyM1nwAHBQfiDgy4K/d48bkHVQcwCq5R4BxpJzyJ6UMznR2VAmlhTDhy3w3ym10Z5Jx+Fcl6Hu/vj4cdjKbdvE/xCLmUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989794; c=relaxed/simple;
	bh=1Vj+pqZawpqS5vPxdrN6QNC6gnev+gi3UXF7+5axbGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k783KP252ljhStndi+Ha6H2oqHvx0cEh1V7HTxpwVcOVeo2RH7BsLdYXJWtjozxrNw0+BvGNr8+dTam0gK7lJoKxKNKbubfLv6RR3Rdl7yqtAKjrKA/ptV1UtCGPG2qTfVyjRxVb8oQlWAHGQtaY4kTuSlyoG6DFjx8/t1bIgDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Faug6ui2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Faug6ui2"
Received: (qmail 174641 invoked by uid 109); 9 Oct 2025 06:03:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1Vj+pqZawpqS5vPxdrN6QNC6gnev+gi3UXF7+5axbGQ=; b=Faug6ui2rGx2GTbCrqKzQqOuu3mZZetkmuY0C7IkQ4CHZG8o2WU1NWR1Lawnbt2V3I4Q9JzCNWvZPsXAINYPfmtxg1/ZREQoTyEBhHjGUmUubzc3JzaMoIgbtQFOrqXs8ox4v7/t54c/Zwy2SA2g3KWYRI/0emOIFUwNPSndESJfNwfz65hFSDamo1rq3IE1TkCLBKbqd7mviGqW/uc19f1TsukVoW8Qwytx1VDV1/+Si8dbhWoT42u3bDNIiMIlVESUgrjwcm2sxT+gOm2AMlEIeZsjrJPzZ+DzdjNhSgGWPENDhZxQwo/QWGsK/OsP6LoAawfl3MQ92RgO5sh36Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Oct 2025 06:03:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 265832 invoked by uid 111); 9 Oct 2025 06:03:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Oct 2025 02:03:11 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Oct 2025 02:03:11 -0400
From: Jeff King <peff@peff.net>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 3/4] string-list: change
 "string_list_find_insert_index" return type to "size_t"
Message-ID: <20251009060311.GE1614343@coredump.intra.peff.net>
References: <aONhmrE0otiyZ16f@ArchLinux>
 <aONiiGlaUfT5cJpd@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aONiiGlaUfT5cJpd@ArchLinux>

On Mon, Oct 06, 2025 at 02:32:40PM +0800, shejialuo wrote:

> @@ -266,7 +265,7 @@ static struct string_list_item *lookup_prefix(struct string_list *map,
>  	 * overlong key would be inserted, which must come after the
>  	 * real location of the key if one exists.
>  	 */
> -	while (0 <= --i && i < map->nr) {
> +	while (i-- && i < map->nr) {
>  		int cmp = strncasecmp(map->items[i].string, string, len);
>  		if (cmp < 0)
>  			/*

BTW, Coverity complains about this line, because "i--" will wrap when
"i" is 0. I think that's OK for our purposes, because we will break out
of the loop on that condition (because it's a post-increment), and we
never look at "i" outside of the loop after that.

So I don't think it's worth changing even to try to shut Coverity up,
but it's an interesting data point in how subtle the signed/unsigned
conversions can be.

-Peff
