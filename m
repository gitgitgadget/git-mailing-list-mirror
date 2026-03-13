Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D551A3029
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 01:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773364382; cv=none; b=BtTUcevUQXHVQ5Z4MMvxpAbttSkEs+9pzg/ngUaUhWsMpKjKNWP+6YQe/ZbqJ9XPdv6qx35MowFrHzHcoUFRl+IzRPApyqYmddtpGx8pF0o5Q2oJ27oTPhVeYY7ur6V7mVQ28mn8dRIdQCYASmbfAL42uti5aA6JL7JNnLQznwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773364382; c=relaxed/simple;
	bh=7mU4Ib+cq4tXdugRvecmoV0NPfDB3eKe2kln0YF950Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Acp+H4DG2sr/GcFKf+BRidYebz2PHFP3MQmRefacUXB8EtYTNUG+B4+2FxZMYOp17QpofMqzJIYupeYD8AmTB3UW0NkZX9IIenZWiRArMzsW4msv6dRfUcO9blYdEbZ292rGRt024I1I0Qo/IMhT01S8acN8QPvkfkkFaffBx/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aHL9KV1x; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aHL9KV1x"
Received: (qmail 94965 invoked by uid 106); 13 Mar 2026 01:12:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7mU4Ib+cq4tXdugRvecmoV0NPfDB3eKe2kln0YF950Q=; b=aHL9KV1xTUIOUk+Z6Zd4GypoAbWmHzQao7USq/PAOu9+9q8DdVru+VFZkBnaqPfSGFJ6xh9CqBhDun3w4JxdLm2sh7867ESZ7Reb82JJRsIiZsBFj2cN6imTZxyhXpSbQUZ2hi3C+TUYa2lqShUohb/Gg21hwTFA+rod9SfO4cOjkbgA/8ywD25kGipafirhE0W7zNSBpa6a4ngN1/wIHlwG+xNCaT2mQdnS80vF0mgAhxfj4WLZ5xT19owtirX5+hbO07bsVt5Iij4eaSM/my3k+yMHm4cod+PKBitHySScnnl2cfLhAA/EeM2Moa4HhbH3UhmNPMIHLUtC2lBRmA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Mar 2026 01:12:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 517918 invoked by uid 111); 13 Mar 2026 01:13:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Mar 2026 21:13:02 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Mar 2026 21:12:59 -0400
From: Jeff King <peff@peff.net>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] apply.c: fix -p argument parsing
Message-ID: <20260313011259.GA3204960@coredump.intra.peff.net>
References: <20260310005408.2022216-1-mroik@delayed.space>
 <20260310050621.3849719-1-mroik@delayed.space>
 <20260313001629.GA3193660@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260313001629.GA3193660@coredump.intra.peff.net>

On Thu, Mar 12, 2026 at 08:16:29PM -0400, Jeff King wrote:

> > +test_expect_success 'git apply -p 1 patch' '
> > +	test_when_finished "rm -rf t" &&
> > +	git apply -p 1 $TEST_DIRECTORY/t4120/patch &&
> > +	test_path_is_dir t
> > +'
> 
> This test seems to fail on Windows. From CI:
> 
>     ++ git apply -p 1 /d/a/git/git/t/t4120/patch
>     error: git diff header lacks filename information when removing 1 leading pathname component (line 14)
>     error: last command exited with $?=128
> 
> but I can't figure out why (and don't have a local Windows machine to
> test on easily).

Ah, I figured it out. The culprit is CRLF line endings. Naturally. :-/

It looks like there is an existing bug in apply.c when reading patches
with CRLF endings. Because of complicated historical reasons, parsing
the:

  diff --git a/t/test/test b/t/test/test

line insists that we find the same "t/test/test" path at the very end of
the line. But instead, we find the extra CR. As a result, we leave
patch->def_name NULL instead of filling it in with "t/test/test".

Usually this is not too big a deal, as we can pick up the name from the
"---" and "+++" lines. But in your patch:

  diff --git a/t/test/test b/t/test/test
  new file mode 100644
  index 0000000000..e69de29bb2

since there is no content, we omit them entirely. And so Git has no idea
where to apply the patch (even without "-p" at all).

I think the fix is probably:

diff --git a/apply.c b/apply.c
index 61df3bdcd0..62d6a1f8d7 100644
--- a/apply.c
+++ b/apply.c
@@ -1295,7 +1295,7 @@ static char *git_header_name(int p_value,
 			 * (that are separated by one HT or SP we just
 			 * found) exactly match?
 			 */
-			if (second[len] == '\n' && !strncmp(name, second, len))
+			if ((second[len] == '\n' || second[len] == '\r') && !strncmp(name, second, len))
 				return xmemdupz(name, len);
 		}
 	}

but I'm not sure if there are other lurking CRLF issues, or if this
might allow malicious input to cause confusion.


Getting back to your patch: why is there a CRLF here in the first place?
Because on Windows, we check out the whole repo with CRLF conversion,
except for a few known file types listed in .gitattributes. And that
includes your t/t4120/patch file.

Coincidentally the style suggestion I made earlier, to just inline it in
the t4120 script itself, makes the problem go away. Because we check out
those scripts with bare line feeds, per .gitattributes, the file we
create will also have regular line feeds.

So I would suggest doing that as a workaround. It might be worth
addressing the CRLF header parsing problem above, too, but I think that
should be a separate topic.

-Peff
