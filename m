Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569EE2836A1
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744285444; cv=none; b=MYFs+bz/l3huv8NAcCcSK5tsMSskDHoWtJgqZvs36hSYFwkXHEs2y+bZrnugPRBURy6ASMHib/TQotn7DnRSA3ShEYA8Ev5q2oH/xylczv5y2pcW7GuhPiknyrOU57RATOb16uh1uxipT/P8N97KEoNCU8He1s7XC+y0dV3taJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744285444; c=relaxed/simple;
	bh=w0+Y1zROokJoQneJaPgfsiBwyUNRmPWUJc/6siT5Tyw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ShzECitpux5aiQo29oY+A3SoJCUQWivcrDoPK7vaw2V06foa9vGqqFLzbFf5w8i2nAJUewOgcEKQw2QR+TMaHTZLtDKqrzJ3WC70GYrZiG3fg/HU+nA6mrki4Jx+h3dZ6USvjPOyyUKiePKJV2iDkqZQnx7kAoPPMh6uNM4NHEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=aT7KZNaa; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="aT7KZNaa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1744285438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00n4dp9MFuhj99WPS+yN+c/s7uFCVds6QsNq+/qwGq8=;
	b=aT7KZNaaRdfyi2J5HJ7cOG93rhRpNJXOTwn3t0c4OkWhV0KokcQaebFKoN5cd0alVH00u3
	DUuIIvElcX0TMg+SNeTW7yLJudCIy85kyKA7QsEYj6XlcXhWdFer3ArSBWnvc6FOC+te6+
	8r8wHVJg0nQ76C+2CvwjnADDVQ8WYXk=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 2/5] t/perf: use configured PERL_PATH
In-Reply-To: <20250331-pks-meson-benchmarks-v1-2-b2ace85616a3@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
 <20250331-pks-meson-benchmarks-v1-2-b2ace85616a3@pks.im>
Date: Thu, 10 Apr 2025 13:43:44 +0200
Message-ID: <87semgdyxb.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Our benchmarks use a couple of Perl scripts to compute results. These
> Perl scripts get executed directly, and as the shebang is hardcoded to
> "/usr/bin/perl" this will fail on any system where the Perl interpreter
> is located in a different path.
>
> Our build infrastructure already lets users configure the location of
> Perl, which ultimately gets written into the GIT-BUILD-OPTIONS file.
> This file is being sourced by "test-lib.sh", and consequently we already
> have the "PERL_PATH" variable available that contains its configured
> location.
>
> Use "PERL_PATH" to execute Perl scripts, which makes them work on more
> esoteric systems like NixOS.

I see in `t/perf/README` there's a mention of running `./aggregate.perl`
directly? Shall we inform the user to run that through their Perl as
well?

-    $ ./aggregate.perl . /path/to/other/git ./p0001-rev-list.sh
+    $ perl ./aggregate.perl . /path/to/other/git ./p0001-rev-list.sh

Or do we expect users to know what they are doing when they don't have
Perl installed at /usr/bin/perl?

--
Toon
