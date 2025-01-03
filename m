Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C80526281
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 19:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735933262; cv=none; b=VxxzwGiN16QpwueQYQlEJiIZTb/V4bAQc286LMocflJvMpMO+NuAgRzDGERxoiFc/x6tu3NBZjj9rll49d1LDS9uMqkUfnsx7tgYCLFNVq0AEaxZcE4eJvk/GnY78f3Xpe91ACLJlcZ/GAoXOqhLOCd8DCo5/u16/Wf3DHYqw2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735933262; c=relaxed/simple;
	bh=gSmdeq+SmIC27MQpgpsiWLVVcNGQ/JVYxcVP2PqE1XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgH37iJpHn/tR2U4w4fnW/83IRgjMGPlbB89SI6XVfTZESOxI6yNgY8/q3kUY1hy6Dce+4u/nSMFHnpsIBFtJwV4mhoJfg2yV1U/7VqnlaxxFBwm+ijBq5F12kCdiutf1W5sH1OGls6enhqK0PPMQdj2iVXs8MD3nMFd/+imI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ecGz6cN2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ecGz6cN2"
Received: (qmail 18636 invoked by uid 109); 3 Jan 2025 19:40:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=gSmdeq+SmIC27MQpgpsiWLVVcNGQ/JVYxcVP2PqE1XI=; b=ecGz6cN2ZHsLghVyOZL+qupbbBnRs7VXgAA3wvqRLfTiQuXno1KApYh+bueeLtaXzeEcpPCwX27nl1ybeRm5SvhViVeAnezDLTDWVgSzNcBtU7hSyJ9fKwpofSYFD/aO/irf7ydwan0Aa8O2q9lnHsncPNniC4cqYsPIRsnR0s7+5Xxw/LZ6H0kSy46Av9HRE1h6b6oWyhDslQU7q9/arJvgn2c6OgodWRYJaTGa3sMTgih9nIE/AT9CExEMdGSY5svbZ1OniT/HIHZ+UiwzhqhRMjxH2fJOOUceuW9cKG++Yp5CuaNDwuHPreJfRpnh3Z1akEsD3Cy0ApTDi/Ol9A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Jan 2025 19:40:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4461 invoked by uid 111); 3 Jan 2025 19:40:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Jan 2025 14:40:58 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 3 Jan 2025 14:40:58 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] object-file: retry linking file into place when
 occluding file vanishes
Message-ID: <20250103194058.GE3208749@coredump.intra.peff.net>
References: <20250103-b4-pks-object-file-racy-collision-check-v1-0-6ef9e2da1f87@pks.im>
 <20250103-b4-pks-object-file-racy-collision-check-v1-2-6ef9e2da1f87@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250103-b4-pks-object-file-racy-collision-check-v1-2-6ef9e2da1f87@pks.im>

On Fri, Jan 03, 2025 at 09:19:55AM +0100, Patrick Steinhardt wrote:

> In a preceding commit, we have adapted `check_collision()` to ignore

If it's in next and we are building on top, I think we can mention it by
name: 0ad3d65652 (object-file: fix race in object collision check,
2024-12-30).

> the case where either of the colliding files vanishes. This should be
> safe in general when we assume that the contents of these two files were
> the same. But the check is all about detecting collisions, so that
> assumption may be too optimistic.

I found this a little vague about what "too optimistic" means. ;)
Maybe something like:

  Prior to 0ad3d65652, callers could expect that a successful return
  from finalize_object_file() means that either the file was moved into
  place, or the identical bytes were already present. If neither of
  those happens, we'd return an error.

  Since that commit, if the destination file disappears between our
  link() call and the collision check, we'd return success without
  actually checking the contents, and without retrying the link. This
  solves the common case that the files were indeed the same, but it
  means that we may corrupt the repository if they weren't (this implies
  a hash collision, but the whole point of this function is protecting
  against hash collisions).

  We can't be pessimistic and assume they're different; that hurts the
  common case that 0ad3d65652 was trying to fix. But after seeing that
  the destination file went away, we can retry linking again...

> Furthermore, stop treating `ENOENT` specially for the source file. It
> shouldn't happen that the source vanishes as we're using a fresh
> temporary file for it, so if it does vanish it indicates an actual
> error.

OK. I think this is worth doing, but I'd probably have put it into its
own commit.

> @@ -1987,6 +1988,8 @@ static int check_collision(const char *source, const char *dest)
>  	if (fd_dest < 0) {
>  		if (errno != ENOENT)
>  			ret = error_errno(_("unable to open %s"), dest);
> +		else
> +			ret = CHECK_COLLISION_DEST_VANISHED;
>  		goto out;
>  	}

OK. We're depending on error() never using "-2" itself, but I think that
is a reasonable thing.

> @@ -2034,8 +2037,10 @@ int finalize_object_file(const char *tmpfile, const char *filename)
>  int finalize_object_file_flags(const char *tmpfile, const char *filename,
>  			       enum finalize_object_file_flags flags)
>  {
> -	struct stat st;
> -	int ret = 0;
> +	int ret;
> +
> +retry:
> +	ret = 0;
>  
>  	if (object_creation_mode == OBJECT_CREATION_USES_RENAMES)
>  		goto try_rename;
> @@ -2056,6 +2061,8 @@ int finalize_object_file_flags(const char *tmpfile, const char *filename,
>  	 * left to unlink.
>  	 */
>  	if (ret && ret != EEXIST) {
> +		struct stat st;
> +

OK, we move the stat struct here where it's needed. I think that's
somewhat orthogonal to your patch, but reduced scoping does help make
the goto's less confusing.

I suspect there's a way to write this as a loop that would be more
structured, but it would be a bigger refactor. Bonus points if it also
get rid of the try_rename goto, too. ;)

I'm OK punting on that, though.

> @@ -2071,9 +2078,13 @@ int finalize_object_file_flags(const char *tmpfile, const char *filename,
>  			errno = saved_errno;
>  			return error_errno(_("unable to write file %s"), filename);
>  		}
> -		if (!(flags & FOF_SKIP_COLLISION_CHECK) &&
> -		    check_collision(tmpfile, filename))
> +		if (!(flags & FOF_SKIP_COLLISION_CHECK)) {
> +			ret = check_collision(tmpfile, filename);
> +			if (ret == CHECK_COLLISION_DEST_VANISHED)
> +				goto retry;
> +			else if (ret)
>  				return -1;
> +		}
>  		unlink_or_warn(tmpfile);
>  	}

I share Junio's uneasiness with looping forever based on external input
from the filesystem (even though you _should_ eventually win the race,
that's not guaranteed, and of course a weird filesystem might confuse
us). Could we put a stop-gap in it like:

diff --git a/object-file.c b/object-file.c
index 88432cc9c0..262a2f3df2 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2038,6 +2038,7 @@ int finalize_object_file_flags(const char *tmpfile, const char *filename,
 			       enum finalize_object_file_flags flags)
 {
 	int ret;
+	int retries = 0;
 
 retry:
 	ret = 0;
@@ -2080,8 +2081,11 @@ int finalize_object_file_flags(const char *tmpfile, const char *filename,
 		}
 		if (!(flags & FOF_SKIP_COLLISION_CHECK)) {
 			ret = check_collision(tmpfile, filename);
-			if (ret == CHECK_COLLISION_DEST_VANISHED)
+			if (ret == CHECK_COLLISION_DEST_VANISHED) {
+				if (retries++ > 5)
+					return error(_("unable to write repeatedly vanishing file %s"), filename);
 				goto retry;
+			}
 			else if (ret)
 				return -1;
 		}

Otherwise, I think the logic looks good.

-Peff
