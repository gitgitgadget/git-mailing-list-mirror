Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304B1186A
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764510389; cv=none; b=UahgN0JhDP6mvPCWUOIqsc0xyr7SL7RcKy8EejhwZ+vqh5M7DxCrLrKhNYw3bKsF8QBV8Y05fme0hFjQRw/CYh+oMuX8RAC7C/ClKU7xHTpnGjV5WXlBXxhlH8YnyAtLfI10rc2R9lMwlpODt0uqsf7elxYVs1jt+SDKVJ/wkHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764510389; c=relaxed/simple;
	bh=15ewrSBYQ/XBBhaA43SDLWB9Ga5lgK8I+q9pgYNyOTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJ7MqoMrYt6zINTzNYOjDVH3aW8mX1zdzX9kjpTdHcC6XQUUvjAXB1+VPkV19aqdlbL85LVbXXuO76c5OXN0ZFq81S2URHLERpPX8gfmBXaCX9Rghmo8pXUp1yKR5h+lQTLg7Rd8KrvVC3EflUtTCHg5whGxffyYbnKKijTzGk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VropDp18; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VropDp18"
Received: (qmail 171177 invoked by uid 109); 30 Nov 2025 13:46:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=15ewrSBYQ/XBBhaA43SDLWB9Ga5lgK8I+q9pgYNyOTg=; b=VropDp18uuuU0bQ8bnGR7ndRam36yaCy5b8CAdJpwahz47RMBYGcYktco/1t83Bx9URGOjOkQHz5m4uTMjb3Sorc2gpjEqtMscsOx/OLZQrDLhiqPV7Q7P79MHsI9J0SFBMT0sDln/WM8N2U0iiF2PlhC0YX6F6MfrqL9a1kHMQ7ymFrmaEWeCNrVKHytAoEdQmDvRNcEuPX+t+3ruY3AinxvhspQqSaRe3lGeEcn5xyL53VqDWjDvjbKrsUQAxl/tk1DsQKseSTdV2LMWgOxonnYmcD38erZhteQSNI3fgmlT7FdBNgSqu1mOdNEJKT3gxVPfQXWJOltkDRRiHtmQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 30 Nov 2025 13:46:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 255162 invoked by uid 111); 30 Nov 2025 13:46:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 30 Nov 2025 08:46:26 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 30 Nov 2025 08:46:25 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>
Subject: my complaints with clar
Message-ID: <20251130134625.GA199421@coredump.intra.peff.net>
References: <20251130131351.GA198697@coredump.intra.peff.net>
 <20251130131537.GB199335@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251130131537.GB199335@coredump.intra.peff.net>

> --- /dev/null
> +++ b/t/unit-tests/u-parse-int.c

This was my first time writing unit tests with clar, so I thought I'd
document a few rough edges I found. It's possible I'm holding it wrong
in some areas.

> +static void check_int(const char *buf, size_t len,
> +		      size_t expect_ep_ofs, int expect_errno,
> +		      int expect_result)
> +{
> +	const char *ep;
> +	int result;
> +	bool ok = parse_int_from_buf(buf, len, &ep, &result);
> +
> +	if (expect_errno) {
> +		cl_assert(!ok);
> +		cl_assert_equal_i(expect_errno, errno);
> +		return;
> +	}
> +
> +	cl_assert(ok);
> +	cl_assert_equal_i(expect_result, result);
> +	cl_assert_equal_i(expect_ep_ofs, ep - buf);
> +}

The error messages I got on failure from this function were not super
informative. Naively, if you do something like:

  check_int_full("0", 0);
  check_int_full("11", 11);
  check_int_full("-23", -23);
  check_int_full("+23", 23);

and it fails, you'll get not much beyond "expected ok, but it's not
true" with a line number in the helper, but no idea which input failed.
So OK, we have cl_invoke for that, and:

  cl_invoke(check_int_full("0", 0));
  cl_invoke(check_int_full("11", 11));
  cl_invoke(check_int_full("-23", -23));
  cl_invoke(check_int_full("+23", 23));

gives you the line number in the caller. Better, but there's a lot of
cross-referencing the line numbers (plus sprinkling cl_invoke everywhere
is ugly).

What I really would have liked is some notion of "context". If the
helper could have done:

  cl_context("input: %.*s", (int)len, buf);

or similar, and failed assertions print that context, then that would
have made the failing part of the test easy to see, even without using
cl_invoke() at all.

Alternatively, I kind of wonder if cl_invoke() could just stringify the
entire macro argument and shove that into the context. That helps for:

  cl_invoke(check_int_full("11", 11));

though not if parameters are opaque in that line, like:

  cl_invoke(check_int_full(str, expect));

But I think boilerplate-saving helpers tend to be written more like the
first way.

In a more general sense, what I'd really have loved is an automatic
backtrace, but I suspect getting a readable one is impossible. Even if
we knew the called function and the parameters, a generic backtracer
cannot know the meaning of "buf" and "len" enough to show what was in
the buffer.

And of course the more obvious way to avoid that is to break this:

> +void test_parse_int__basic(void)
> +{
> +	cl_invoke(check_int_full("0", 0));
> +	cl_invoke(check_int_full("11", 11));
> +	cl_invoke(check_int_full("-23", -23));
> +	cl_invoke(check_int_full("+23", 23));
> +	cl_invoke(check_int_str("  31337  ", 7, 0, 31337));
> +
> +	cl_invoke(check_int_err("  garbage", EINVAL));
> +	cl_invoke(check_int_err("", EINVAL));
> +	cl_invoke(check_int_err("-", EINVAL));
> +
> +	cl_invoke(check_int("123", 2, 2, 0, 12));
> +}

into a series of nine separate tests, each of which gets a name. But
each of those tests is at least five lines of boilerplate, which sucks
(plus you have to come up with syntactically valid C names for them).

> +	/*
> +	 * Do not use cl_assert_equal_i_fmt(..., PRIuMAX) here. The macro
> +	 * casts to int under the hood, corrupting the values.
> +	 */
> +	clar__assert_equal(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC,
> +			   CLAR_CURRENT_LINE,
> +			   "expect_result != result", 1,
> +			   "%"PRIuMAX, expect_result, result);
> +}

This was an exciting bug to track down. If you use i_fmt() here, you get
some neat undefined behavior. It worked for gcc, but failed with clang
(but only with -O2!).

Obviously this was me using it wrong, and the "i" in the macro should
have been a hint. But this invocation is kind of ugly, with the explicit
mentions of internal CLAR variables. clar__assert_equal() understands
PRIuMAX as a comparator, but there doesn't appear to be any macro to use
it nicely.

Should there be a generic cl_assert_equal() that fills in the first
few parameters but is otherwise type-agnostic?

It also looked error-prone to me that if you pass in an unknown format
specifier, clar__assert_equal() will assume you want integers. So a
typo, or using an unknown-but-equivalent specifier will give you weird
undefined behavior bugs. These are just tests, so we can perhaps a bit
more loose, but these kinds of things can be hard to track down
(especially if they trigger only in certain compiler combos via CI,
which is what happened to me).

And that brings me to my final complaint. ;)

When the unit-tests fail in CI, you get very little useful feedback,
because the output is eaten by "prove", and the unit tests don't
understand --verbose-log at all. And then to make it more exciting, the
output that clar produces actually chokes prove. For example, if I do
this:

diff --git a/t/unit-tests/u-parse-int.c b/t/unit-tests/u-parse-int.c
index a1601bb16b..da706d5840 100644
--- a/t/unit-tests/u-parse-int.c
+++ b/t/unit-tests/u-parse-int.c
@@ -38,7 +38,7 @@ static void check_int_err(const char *buf, int err)
 void test_parse_int__basic(void)
 {
 	cl_invoke(check_int_full("0", 0));
-	cl_invoke(check_int_full("11", 11));
+	cl_invoke(check_int_full("11", 10));
 	cl_invoke(check_int_full("-23", -23));
 	cl_invoke(check_int_full("+23", 23));
 

then running t/unit-tests/bin/unit-tests produces:

  
  # start of suite 10: parse_int
  not ok 59 - parse_int::basic
      ---
      reason: |
        expect_result != result
        10 != 11
      at:
        file: 't/unit-tests/u-parse-int.c'
        line: 41
        function: 'test_parse_int__basic'
      ---

OK, but "prove t/unit-tests/bin/unit-tests" gives me:

  t/unit-tests/bin/unit-tests .. Failed 1/59 subtests
  
  Test Summary Report
  -------------------
  t/unit-tests/bin/unit-tests (Wstat: (none) Tests: 59 Failed: 1)
    Failed test:  59
    Parse errors: Badly formed hash line: '---' at /usr/share/perl/5.40/TAP/Parser/YAMLish/Reader.pm line 244.

Yuck. It actually does have what I need (that test 59 was the failure),
so the extra parse error is mostly a red herring (though it does prevent
us finding any further failures). I think in TAP that arbitrary output
is supposed to be prefixed with a "#". In test-lib.sh, we solve this by
only allowing "--verbose-log", not regular "-v", under a TAP harness.

I kind of wonder if we should have t0011-unit-tests.sh that simply runs
unit-tests and filters the output into stdout and stderr. But maybe it's
too ugly. I think --verbose-log works because we know in the test code
when we are outputting TAP on stdout, and everything else goes to the
log. But because it's all generated by the unit-tests bin, we'd end up
having to parse its output ourselves and redirect some to stdout and
some to the log. It might be less work to implement --verbose-log in
our clar harness.

Anyway. Those are all of my complaints. For now. ;) I don't know if I'll
work on any of them or not, and maybe people more familiar with clar can
offer suggestions. But I thought it worth documenting the experience.

-Peff
