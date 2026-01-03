Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E463126F0A
	for <git@vger.kernel.org>; Sat,  3 Jan 2026 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767439615; cv=none; b=gcT/9gA2vq3Oy0qzJZRB0EW4hkqustPjSIDKt3KNXsi1DvvoxKRjcpZ5jPQVGVs3thLP7V/nhSNfgrGCDsdZAfscWIAnghjHc1/3s7ksFoO7QqBO8FTx5/xmOp+LL0yy+491lWfinuadhDlMGk7++tjmErPH0wofmXp8LK71GL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767439615; c=relaxed/simple;
	bh=8rZOCt+YPaeXQ9bI7HVCqJj1hoOkeZprdTQUsZFWbDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re0MkZ/g5TSSgGpgIRfKT22wHOlQbfRLHrFLxOB9s7H1q/HUrHKrA9AoJRJvnN9T6AZMGycS9Ht1oWMxP2PZxaAeohK/GnjZ7ADHTH1hXJgpkPV1i0KBz7ZbH68p7EhgJTa/zbn24tvwT803pvQxxSODa7xCjc3HKFgvM+CTWJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JW9gJZ5n; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JW9gJZ5n"
Received: (qmail 565248 invoked by uid 109); 3 Jan 2026 11:26:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8rZOCt+YPaeXQ9bI7HVCqJj1hoOkeZprdTQUsZFWbDY=; b=JW9gJZ5nemMgjMpvcm7iroRfvgqaz9n3gpkWXCRif8haMejr6xncm7K6Ql0uB+qyOAM/bQTGWoj61ID9TY8oNBNVIYfpZD7Ui5eZ5vu6n6/BOdJArsHE/dTzYkTbZNB77oACp4EGHNl1hjUDsYXta3g5ha0/ssCbF8wK8mbDODm/q8yFVOxb7Xmm2Uhd0TMgpt8JMaTV46sBk48xN5RNtFpCckk0r+Judz4OCU3nt0j0+CxP6L0PNEha4u+qs14Za39exFBxv6yD0wahV2e0sFKx0QFVTtvLYbu+ccdSulQrWH/m1BJ9jFiUXdmeaNV1qidAdg50SU/RkobcGZT8/Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 03 Jan 2026 11:26:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 738555 invoked by uid 111); 3 Jan 2026 11:26:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 03 Jan 2026 06:26:47 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 3 Jan 2026 06:26:42 -0500
From: Jeff King <peff@peff.net>
To: Artur Pyrogovskyi <arp@letterty.com>
Cc: git@vger.kernel.org
Subject: Re: bug report: git status -z doesn't respect
 status.relativePaths=true
Message-ID: <20260103112642.GA2706421@coredump.intra.peff.net>
References: <CALiS03_X4kA47-bimcovqAsTDXOM-KbKUAApM5xHdYzk9kqkbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALiS03_X4kA47-bimcovqAsTDXOM-KbKUAApM5xHdYzk9kqkbQ@mail.gmail.com>

On Sat, Jan 03, 2026 at 02:47:36AM -0800, Artur Pyrogovskyi wrote:

> According to the man page of git-status: "-z Terminate entries with
> NUL, instead of LF."
> 
> However, it ignores status.relativePaths=true and always shows absolute paths.

This matches the documented behavior. In --porcelain=v1 mode, we ignore
most configuration options (like status.relativePaths). And -z puts us
into v1 porcelain mode by default:

       -z
           Terminate entries with NUL, instead of LF. This implies the
           --porcelain=v1 output format if no other format is given.

I do think there is at least one bug here, though. I'd expect from that
documentation to be able to do:

  git -c status.relativePaths=true status --short -z

and get relative paths. But it doesn't work. The --short output code
that handles "-z" ignores the prefix entirely.

Something like this would fix it:

diff --git a/wt-status.c b/wt-status.c
index e12adb26b9..22797371a6 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2005,6 +2005,13 @@ static void wt_shortstatus_unmerged(struct string_list_item *it,
 	}
 }
 
+static void print_with_nul(struct wt_status *s, const char *fn)
+{
+	struct strbuf scratch = STRBUF_INIT;
+	fprintf(s->fp, "%s%c", relative_path(fn, s->prefix, &scratch), 0);
+	strbuf_release(&scratch);
+}
+
 static void wt_shortstatus_status(struct string_list_item *it,
 			 struct wt_status *s)
 {
@@ -2020,9 +2027,9 @@ static void wt_shortstatus_status(struct string_list_item *it,
 		fputc(' ', s->fp);
 	fputc(' ', s->fp);
 	if (s->null_termination) {
-		fprintf(s->fp, "%s%c", it->string, 0);
+		print_with_nul(s, it->string);
 		if (d->rename_source)
-			fprintf(s->fp, "%s%c", d->rename_source, 0);
+			print_with_nul(s, d->rename_source);
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;

but:

  1. it would need similar adjustments to a few other printing
     functions; and

  2. it's not clear to me if we want to change this behavior or keep
     it as a historical quirk and document it as such.

     I guess nobody noticed because using "-z" with "--short" is a bit
     of an odd thing to want to do.


There's another oddity, which is this:

> Repro steps:
> $ mkdir test-repo && cd test-repo && git init .
> $ mkdir subdir && touch subdir/test-file.txt && cd subdir && git add
> test-file.txt
> $ git -c status.relativePaths=true status --porcelain=2
> 1 A. N... 000000 100644 100644
> 0000000000000000000000000000000000000000
> e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 test-file.txt

I am surprised to see that the v2 porcelain respects that config option
at all. I don't know if that's a bug, or a subtle change from v1. I
don't see it mentioned in the documentation.

If it isn't a bug, and we expect v2 porcelain to respect the config,
then this:

> $ git -c status.relativePaths=true status --porcelain=2 -z
> 1 A. N... 000000 100644 100644
> 0000000000000000000000000000000000000000
> e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 subdir/test-file.txt%

is another bug similar to the --short one.

-Peff
