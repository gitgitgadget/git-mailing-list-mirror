Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080127F4CA
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 23:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772233705; cv=none; b=i/HyXaJXJIBa620FKMsseGhjGjFVF9m1+AXgn8VKoSTbNYPuors26sgv6gcO2baxYQ8gGo2nawXq39wRHJNd+atBY8oHalxNAWVAcfjdlEAkl09sS2nDH5/P7/CMjhh5biyn+kXFrhAJplg8TcilsZshEErAStcaqKVQWPDDKXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772233705; c=relaxed/simple;
	bh=Hzj9+BE1ObzrxVktE6a8nkD/97+rdrXrfbmvyek4dJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMzA8OISHZS3EAZoEOYyQCBier63hh0wpxHRxTa3U1AUEub9NnbguSvV/o4HJChwIh2Rjl42WYWN8IOG94e2FMMrYtzHp46xbNKrfsbV7e/4+ivaA5aNQmL6GKBQ5j7AhhaHLR3TeF18/absH9MO9AP/koCX5dnKwtediRxuqA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Keh3EbCt; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Keh3EbCt"
Received: (qmail 83609 invoked by uid 109); 27 Feb 2026 23:08:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=Hzj9+BE1ObzrxVktE6a8nkD/97+rdrXrfbmvyek4dJc=; b=Keh3EbCtgL1ME6bpWQyDiDNrpv4FRmhE+jq3sAslmz0V3HcScp6Mrhgb3pEVaFhzkIp5bdkJmTsLXGaZNMJrMUGp7N1BhHTar4csvLv5m1X7QL/LC4kgZWNuhAi9YjQhsG6wjE/YMYMs7iUw1ZxhAWMGWEwQ3opeLLEDFAu1awVh9vOZDFY2Ia5hW8pv7biW/GEnptDSeQZpRXzXvN/vXatZf1Mm8z4jXeUJ9M5ZSKr2y21nWcCJ+jabN2RTGlg3AZhdE8mjgAi3h3fJIE343nQir28AfArrWS1osP8dTQLH1nxAVJaksW0MSIse4HXIJCGYK8hydrOYeXcIHg9yaQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Feb 2026 23:08:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 282259 invoked by uid 111); 27 Feb 2026 23:08:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Feb 2026 18:08:25 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 27 Feb 2026 18:08:22 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] parseopt: check for duplicate long names and
 numerical options
Message-ID: <20260227230822.GA2965111@coredump.intra.peff.net>
References: <xmqq5x7jujqb.fsf@gitster.g>
 <7693799a-91a2-480a-ae3e-29f8eed5b55a@web.de>
 <20260227225055.GC2956443@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260227225055.GC2956443@coredump.intra.peff.net>

On Fri, Feb 27, 2026 at 05:50:56PM -0500, Jeff King wrote:

> On Fri, Feb 27, 2026 at 08:27:02PM +0100, René Scharfe wrote:
> 
> > The check clearly has a cost, but I have a hard time measuring it.
> > We already do lots of (kinda cheap) checks.  Turning them on only
> > in DEVELOPER builds (and ideally demonstrating a speedup) left as
> > an exercise for interested readers (with stronger benchmark-fu)..
> 
> I agree it is probably not introducing a measurable slowdown. If we were
> to make it conditional, I'd suggest a run-time toggle (so we could turn
> it on for all test scripts, but not regular use).

Just for fun, I was going to write a script that generated a test-tool
parse-options list with 100k entries. But then I realized we already
have something like that!

If you do this:

  (
    echo usage
    echo --
    for i in $(seq 100000); do
      echo "opt$i option $i"
    done
  ) >input

then hyperfine reports (before and after your patches):

  Benchmark 1: ./git.old rev-parse --parseopt -- --opt42 <input
    Time (mean ± σ):      22.2 ms ±   0.4 ms    [User: 16.6 ms, System: 5.6 ms]
    Range (min … max):    21.5 ms …  23.9 ms    127 runs
  
  Benchmark 2: ./git.new rev-parse --parseopt -- --opt42 <input
    Time (mean ± σ):      32.5 ms ±   0.5 ms    [User: 23.8 ms, System: 8.6 ms]
    Range (min … max):    31.7 ms …  34.8 ms    89 runs
  
  Summary
    ./git.old rev-parse --parseopt -- --opt42 <input ran
      1.46 ± 0.03 times faster than ./git.new rev-parse --parseopt -- --opt42 <input

So it is measurable (even with the extra per-option costs to generate
the option structs in the first place). Looks like on the order of 10ms
for 100k options, or about 100ns per option. If you imagine that most
option lists are smaller than 100, we're talking about probably the
equivalent of 50-100 syscalls. If we are really looking to
micro-optimize startup time, I suspect there's pretty low-hanging fruit
to be found of that magnitude.

> > +		if (opts->long_name) {
> > +			if (strset_contains(&long_names, opts->long_name))
> > +				optbug(opts, "long name already used");
> > +			strset_add(&long_names, opts->long_name);
> > +		}
> 
> ...if you want to micro-optimize, note that the return value of
> strset_add() tells you whether the item was already in the set. That can
> save one hash of the string.
> 
> Probably the allocation for each element is the dominating cost, though,
> and it doesn't help with that.

Doing this:

diff --git a/parse-options.c b/parse-options.c
index 51b72eee11..f056a4471e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -659,9 +659,8 @@ static void parse_options_check(const struct option *opts)
 				optbug(opts, "short name already used");
 		}
 		if (opts->long_name) {
-			if (strset_contains(&long_names, opts->long_name))
+			if (!strset_add(&long_names, opts->long_name))
 				optbug(opts, "long name already used");
-			strset_add(&long_names, opts->long_name);
 		}
 		if (opts->type == OPTION_NUMBER) {
 			if (saw_number_option)

seems to shave off ~1% of my benchmark. Not that exciting, but hey, it's
one line shorter to boot.

-Peff
