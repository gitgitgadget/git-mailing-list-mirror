Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4831329C339
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220875; cv=none; b=BrG1/U3aebGJxIx7PvvuIkMHVJSxr0Zi/gVi7KMW67k8wd7NM+aAFDAywEl6jNESlOHujosiNqX3c1xkq4N0zFPDTl7C5XIoIbgtrMxRiruk4gWlCi7umW5fBoWs73xKmkuC7sgsaejSYNJLIVnYPfr3UIwdk0JVZiozAa3/RZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220875; c=relaxed/simple;
	bh=y1g/oA6cB0FA4TSL2Fo1kgSmdSlVkyw0UQyO9pXkdh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/FT/e0rsup908g9Hg1qEwGHRiwizYyxrLAUgIYvulbBtbj6LWxhTQjCaAQXfbhfnzh6p/ifGbm2facN4VijFuBHpVjwXo3gHSzZVQ5sz/4JZo18K9YvubEJpBrv9duEVu66w+USSL1dbSZMfxLMX2PzUuAj6GvqbzOfQLxbShw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=f+MMcA6c; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="f+MMcA6c"
Received: (qmail 315532 invoked by uid 109); 23 Oct 2025 12:01:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=y1g/oA6cB0FA4TSL2Fo1kgSmdSlVkyw0UQyO9pXkdh0=; b=f+MMcA6cBS2zua0/exVLizZ1IX7aG9Znp0paYlzsnqGGD9xPhDx0W5efHUb/gGKh8W5izziqgonrY1JSw96DGufV6J2bXJaxruWFbjgR5/CBgEjBXZ3AEi41/Knb+1qkSIDw/0w4A/5XtDtfXHjG8ffZIOYN7ggFaubWcdnubPtA1OtZ31+ONDgElcoUL8CDjGu6/+O5siLXdPHPZxFbpgTknijSDpSSMgHn0lw5lvXTTdrbT00p8on1wWJEhbGr7jualldPQKdM7KtE8SbeDEyAbs4k3SEE7N+Odgym0ozHPhXg+YjuNAcjtVwXJIiRtM9inLZpGAykJpEX/PiZkw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Oct 2025 12:01:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 490577 invoked by uid 111); 23 Oct 2025 12:01:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Oct 2025 08:01:01 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 Oct 2025 08:01:01 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jake Zimmerman <jake@zimmerman.io>, Lidong Yan <yldhome2d2@gmail.com>,
	git@vger.kernel.org
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
Message-ID: <20251023120101.GA1123594@coredump.intra.peff.net>
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
 <20251017075153.GA4078773@coredump.intra.peff.net>
 <xmqq7bwt1kyf.fsf@gitster.g>
 <20251018094037.GA1060824@coredump.intra.peff.net>
 <xmqqh5vww7xa.fsf@gitster.g>
 <20251021073640.GB259661@coredump.intra.peff.net>
 <xmqqy0p4wcac.fsf@gitster.g>
 <20251022091112.GB853931@coredump.intra.peff.net>
 <xmqqikg6zxui.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqikg6zxui.fsf@gitster.g>

On Wed, Oct 22, 2025 at 09:48:37AM -0700, Junio C Hamano wrote:

> Here is what I have on top of your patch right now, after ditching
> the idea to move the redirect to flush_quietly() because it would
> mean redirecting N times for a N-path patch, but one thing that is
> frustrating is that I cannot come up with a scenario or test in
> which it makes a difference to this other caller if we forget to
> restore o->file member.

Isn't it just running "git show -w --name-status" at all? If I take the
patch you showed below and drop the restoration, like so:

  diff --git a/diff.c b/diff.c
  index ceb57d1ef8..d402f960a9 100644
  --- a/diff.c
  +++ b/diff.c
  @@ -6836,11 +6836,6 @@ void diff_flush(struct diff_options *options)
   
   			flush_one_pair(p, options);
   		}
  -		if (options->flags.diff_from_contents) {
  -			fclose(options->file);
  -			options->file = saved_file;
  -			options->color_moved = saved_color_moved;
  -		}
   		separator++;
   	}
   

and then do:

  git init
  echo content >file
  git add file
  git commit -m file
  git show -w --name-status

then we do not show anything. We redirect to /dev/null to run
diff_flush_patch_quietly() and find that it does indeed have changes to
show (despite -w). But when we try to show the name-status output via
flush_one_pair(), we are still redirected to /dev/null.

But wait! That bug is already there in what you have queued in
jc/diff-from-contents-fix, even without my change!

That is because you are trying to redirect to /dev/null once at the
beginning of the loop. But the loop is effectively:

  for each pair
    check for content changes with diff_flush_patch_quietly();
    output actual pair data with flush_one_pair();

We want the redirection to /dev/null for the first part of the loop
body, but not the second. So you have to do the redirection inside the
loop.

I agree that opening /dev/null over and over is silly. But we can reuse
the same filehandle for each one. I.e., like:

diff --git a/diff.c b/diff.c
index dac3ea9e01..e903afcf04 100644
--- a/diff.c
+++ b/diff.c
@@ -6835,11 +6835,11 @@ void diff_flush(struct diff_options *options)
 		/*
 		 * make sure diff_Flush_patch_quietly() to be silent.
 		 */
-		FILE *saved_file = options->file;
+		FILE *dev_null = NULL;
 		int saved_color_moved = options->color_moved;
 
 		if (options->flags.diff_from_contents) {
-			options->file = xfopen("/dev/null", "w");
+			dev_null = xfopen("/dev/null", "w");
 			options->color_moved = 0;
 		}
 		for (i = 0; i < q->nr; i++) {
@@ -6848,15 +6848,20 @@ void diff_flush(struct diff_options *options)
 			if (!check_pair_status(p))
 				continue;
 
-			if (options->flags.diff_from_contents &&
-			    !diff_flush_patch_quietly(p, options))
-				continue;
+			if (options->flags.diff_from_contents) {
+				FILE *saved_file = options->file;
+				int r;
+				options->file = dev_null;
+				r = diff_flush_patch_quietly(p, options);
+				options->file = saved_file;
+				if (!r)
+					continue;
+			}
 
 			flush_one_pair(p, options);
 		}
 		if (options->flags.diff_from_contents) {
-			fclose(options->file);
-			options->file = saved_file;
+			fclose(dev_null);
 			options->color_moved = saved_color_moved;
 		}
 		separator++;

You could even imagine diff_flush_patch_quietly() saving the /dev/null
descriptor in a static variable and effectively leaking it (or if we
want to be more structured, cached inside the diff_options struct). And
then the callers do not have to worry about it at all.

And of course this all explains your confusion with Lidong's t4013 test
that started failing. It should generate three lines, because they are
the actual --raw lines. Once the bug in jc/diff-from-contents-fix is
fixed as above, they come back. And running it with the test fixup you
have queued on ly/diff-name-only-with-diff-from-content yields a failure
with:

  'actual' is not empty, it contains:
  :100644 000000 e69de29 0000000 D	file1
  :100644 000000 e69de29 0000000 D	file2
  :000000 100644 0000000 0000000 U	file3

-Peff
