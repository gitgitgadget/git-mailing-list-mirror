Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7763F59B64
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799077; cv=none; b=X+P5fVZyNMc+39oh76TmevzHfrNJRiMMSWQ9MD5sP4Ohc1FsS/Mr4NxUx2OBvlGzCfgHSBx26UTuCuFIiqpiRD2kfhsG7KHpobhZCsXmI9UzLjPK0B/NIL7cuNIJzSsWvYf2m3PVS4s6S7dSQ1hUNTFF/A0qsQ7fjTuRsrAPJbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799077; c=relaxed/simple;
	bh=e6OaJAGxbwQ544I6dGoY+wT6MNexLNwfluKIuE4ow3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h7KCt8q4ADDYQXuNMd5bRi2UWEYqKeWDr1/2r14c8C8WjCkZAStGy6w/dGrdkHMNRHvT4ir+HbkujslEulFUbS+ByOY0pe76EdzSfy5O0Pd0xaOotr3OhKpSFKasi9UASJR5m9jAKCspO1kp2oiAwofvzzU/Y9PoVjaobL/avWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xq4L+htj; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xq4L+htj"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0BA052393E;
	Mon, 18 Mar 2024 17:57:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=e6OaJAGxbwQ544I6dGoY+wT6MNexLNwfluKIuE
	4ow3c=; b=Xq4L+htjKPFFIIQZT6p4/hQw7o25UXqzAYEbZhzLmPoJ7JeJE+oYeY
	5nGC2Ods+MaiFHbzy5yMwx1BJYa8Lr27i6UyNFbn57ksuEsKeiEXQhcoGVANVEv3
	Ohgde1uCh7+Rr3uyJ84ZD8CFuOJPqO9HF0Vd6zFbetlLDDayyJayI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 03CEE2393C;
	Mon, 18 Mar 2024 17:57:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9BA152393A;
	Mon, 18 Mar 2024 17:57:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Mohit Marathe <mohitmarathe@proton.me>
Subject: Re: [PATCH 1/2] git-compat-util: migrate `convert_slashes()` from
 compat/mingw.h
In-Reply-To: <0157b1deaebd5de4734d35f96f22a8da752e09bd.1710766062.git.gitgitgadget@gmail.com>
	(Mohit Marathe via GitGitGadget's message of "Mon, 18 Mar 2024
	12:47:41 +0000")
References: <pull.1699.git.1710766062.gitgitgadget@gmail.com>
	<0157b1deaebd5de4734d35f96f22a8da752e09bd.1710766062.git.gitgitgadget@gmail.com>
Date: Mon, 18 Mar 2024 14:57:50 -0700
Message-ID: <xmqqh6h3dwyp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 90FC0C82-E572-11EE-A0BE-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Mohit Marathe <mohitmarathe@proton.me>
>
> This patch migrates the `convert_slashes` function to `git-compat-
> util.h` and renames it to `change_path_separators`.

That is something a reader can tell from looking at what the patch
does.  What they cannot read from the diff is why the author of the
patch thought it was a good idea and that is what we want to see
here.

> diff --git a/abspath.c b/abspath.c
> index 1202cde23db..ea35e2c05ce 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -58,7 +58,7 @@ static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
>  	strbuf_reset(resolved);
>  	strbuf_add(resolved, remaining->buf, offset);
>  #ifdef GIT_WINDOWS_NATIVE
> -	convert_slashes(resolved->buf);
> +	change_path_separators(resolved->buf);
>  #endif

In the context of "#ifdef GIT_WINDOWS_NATIVE..#endif" conditional
compilation, the name convert_slashes() may have made some sense,
i.e. "on this system, we get a path with the kind of slash that is
not suitable to be used in Git, so we correct it to the other kind
of slash".  But neither it, or change_path_separators(), as a name
of public function makes much sense.  The direction of the change
is totally unclear.

"normalize" may be a verb that has some connotation which direction
the conversion is going, but still, without knowing why this change
is being made (not the name change, but the part that makes it public),
I cannot offer much better candidates for its name.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 7c2a6538e5a..3db90c09295 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1309,6 +1309,13 @@ static inline int strtol_i(char const *s, int base, int *result)
>  	return 0;
>  }
>  
> +static inline void change_path_separators(char *path)
> +{
> +	for (; *path; path++)
> +		if (*path == '\\')
> +			*path = '/';
> +}
> +
>  void git_stable_qsort(void *base, size_t nmemb, size_t size,
>  		      int(*compar)(const void *, const void *));
>  #ifdef INTERNAL_QSORT
> diff --git a/path.c b/path.c
> index 8bb223c92c9..cd7c88ffa0d 100644
> --- a/path.c
> +++ b/path.c
> @@ -758,7 +758,7 @@ char *interpolate_path(const char *path, int real_home)
>  			else
>  				strbuf_addstr(&user_path, home);
>  #ifdef GIT_WINDOWS_NATIVE
> -			convert_slashes(user_path.buf);
> +			change_path_separators(user_path.buf);
>  #endif
>  		} else {
>  			struct passwd *pw = getpw_str(username, username_len);

If the idea were that "here we know that the path came from reading
filesystem and on platforms that use backslashes as path separators,
we need to normalize them into slashes before the path is usable in
Git", then I might understand if a change were more like:

 * Introduce normalize_path_separators_in_place(char *) that is a
   NOOP by default, but does the backslash->slash conversion ONLY on
   platforms that require it (i.e. Windows).

 * Lose "#ifdef GIT_WINDOWS_NATIVE" and corresponding "#endif", and
   call that normalize thing unconditionally, which gets optimized
   away on most systems other then where it is required.

That way, the affected .c files would become somewhat easier to
follow without ugly conditional compilation.

But with the proposed patch lacking any explanation why the author
thought it was a good idea, the above is just my wild guess.
