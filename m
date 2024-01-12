Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8362101E7
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11867 invoked by uid 109); 12 Jan 2024 15:16:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 Jan 2024 15:16:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18443 invoked by uid 111); 12 Jan 2024 15:16:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 Jan 2024 10:16:56 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 12 Jan 2024 10:16:55 -0500
From: Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Stan Hu <stanhu@gmail.com>
Subject: Re: [PATCH 1/2] t9902: verify that completion does not print anything
Message-ID: <20240112151655.GA640039@coredump.intra.peff.net>
References: <cover.1704969119.git.ps@pks.im>
 <73406ca9c8f38ac2ad8f0e32d6d81f1566a6b4d1.1704969119.git.ps@pks.im>
 <d978494d-6c48-5923-4745-c42a39e1187a@gmx.de>
 <ZaEZar9OTVgfkD9r@framework>
 <27edf445-d7fa-7aaf-7682-4ecc03366ef0@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27edf445-d7fa-7aaf-7682-4ecc03366ef0@gmx.de>

On Fri, Jan 12, 2024 at 02:12:43PM +0100, Johannes Schindelin wrote:

> But my main concern is: Why does this happen in the first place? If we are
> running with Bash, why does `BASH_XTRACEFD` to work as intended here and
> makes it necessary to filter out the traced commands?

BASH_XTRACEFD was introduced in bash 4.1. macOS ships with the ancient
bash 3.2.57, which is the last GPLv2 version.

One simple solution is to mark the script with test_untraceable. See
5fc98e79fc (t: add means to disable '-x' tracing for individual test
scripts, 2018-02-24) and 5827506928 (t1510-repo-setup: mark as
untraceable with '-x', 2018-02-24).

That will disable tracing entirely in the script for older versions of
bash, which could make debugging harder. But it will still work as
expected for people on reasonable versions of bash, and doesn't
introduce any complicated code.

-Peff
