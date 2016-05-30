From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] strbuf: allow to use preallocated memory
Date: Mon, 30 May 2016 14:13:52 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605301326530.4449@virtualbox>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr> <20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	matthieu.moy@grenoble-inp.fr, mhagger@alum.mit.edu
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 30 14:14:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7M5k-0002mm-5D
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 14:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbcE3MOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 08:14:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:58457 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561AbcE3MOi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 08:14:38 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lcjgd-1bpAsi0knH-00k76L; Mon, 30 May 2016 14:14:31
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:sGS4DobS+uPF8bcSebq/4aT8ShcYp8tY0ErJ/JXgG0t1Vts0b5s
 2KsfPhoWiL938nH21jk9h5M1MAp+xGFk8shJ8T9t6otwiKcmNuqLBU0hQN510oy4GLP2yn9
 oRhl1OiPCG0tl9Astk70L0OFAEJ/qzVLh+py4ZXUNNvNn4mcYg4fzRX0ezqNi/8FTNi1Blk
 KnFmTawQWCvM8dkAi0T8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fEJN7JDQS7Y=:dMI/VlsQR9rgKjM7RpR5/e
 iAUoDHDb3egrDMI5ieRZ0NL+W15W+NJCWDAIWJ1Etd8yl5N+9nBWUEZ68TWT1k+0FcMQfO92m
 TbfKZkqKOn84Kus2lZxHTwIduDuMcf/qlG639jz7SBCeKIJgHAmpuW7lr6azVPufKmr6tQJKy
 9W4Z+zjCr7h4pFf1WhLjYj2S3YiJS+QSCwZNcqJtou0XaAxeunvJz0ckVl+1E/U/SmrOSpEGa
 7BMpoc00+av8kTx4UUV9kuHelm3hsapLBN3C5DBu796AeX0xlubJR9f4M/Oi4WkVfHd6Zi3ER
 WciEippxgSy6yLOlCrUzY3LcTxJRIjS4EQUPUiygTsWGFTLonukQbxTYrHCz9HSybDhGiHRuF
 QG8ojEpzfceFmB7CuFsdGEY+cTjb8rI4+8xeEFt2Aqa9y950+gV9LLx+JSAlPZOafUPjl4QFU
 yIEDiiohXHhpcrPjvWzQn/Jlp15OFS0kNxz+EuWIxHncXhYV/MIsk4CU2NAuebBm1kYDAbAlL
 MOECF3nuZvHjLAvIT6RsTOw3LSU6D3Svr7HRsh0vrKTDqf5pc4jgzKuI9QPzxecfBamfoAFg6
 ShlyQzgntigIqfANn/WuEmLh3DC31XNbDgCL2OLFmGKNSDUOaDZq7PsZVt4g9vz0BYffzR4mo
 DhqrSUDbTL7sTeNlhS6MuO0TXQdp82+3eBvtKXb3PmrV0vM1Jyh9DWmvuii6re3sxsLU1JKSJ
 dcJF3RLKtXVHFhgFwyvhKtcMqIPEjNcbTK5hkvzJohJNXMEKYdprnK5v9/8hRbrpZqyQ72xE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295890>

Hi William,

On Mon, 30 May 2016, William Duclot wrote:

> It is unfortunate that it is currently impossible to use a strbuf
> without doing a memory allocation. So code like
> 
> void f()
> {
>     char path[PATH_MAX];
>     ...
> }
> 
> typically gets turned into either
> 
> void f()
> {
>     struct strbuf path;
>     strbuf_add(&path, ...); <-- does a malloc
>     ...
>     strbuf_release(&path);  <-- does a free
> }
> 
> which costs extra memory allocations, or
> 
> void f()
> {
>     static struct strbuf path;
>     strbuf_add(&path, ...);
>     ...
>     strbuf_setlen(&path, 0);
> }
> 
> which, by using a static variable, avoids most of the malloc/free
> overhead, but makes the function unsafe to use recursively or from
> multiple threads. Those limitations prevent strbuf to be used in
> performance-critical operations.

This description is nice and verbose, but maybe something like this would
introduce the subject in a quicker manner?

	When working e.g. with file paths or with dates, strbuf's
	malloc()/free() dance of strbufs can be easily avoided: as
	a sensible initial buffer size is already known, it can be
	allocated on the heap.

The rest of the commit message flows nicely.

> diff --git a/strbuf.c b/strbuf.c
> index 1ba600b..527b986 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -1,6 +1,14 @@
>  #include "cache.h"
>  #include "refs.h"
>  #include "utf8.h"
> +#include <sys/param.h>

Why?

> +/**
> + * Flags
> + * --------------
> + */
> +#define STRBUF_OWNS_MEMORY 1
> +#define STRBUF_FIXED_MEMORY (1 << 1)

>From reading the commit message, I expected STRBUF_OWNS_MEMORY.
STRBUF_FIXED_MEMORY still needs to be explained.

> @@ -20,16 +28,37 @@ char strbuf_slopbuf[1];
>  
>  void strbuf_init(struct strbuf *sb, size_t hint)
>  {
> +	sb->flags = 0;
>  	sb->alloc = sb->len = 0;
>  	sb->buf = strbuf_slopbuf;
>  	if (hint)
>  		strbuf_grow(sb, hint);
>  }
>  
> +void strbuf_wrap_preallocated(struct strbuf *sb, char *path_buf,
> +			      size_t path_buf_len, size_t alloc_len)
> +{
> +	if (!path_buf)
> +		die("you try to use a NULL buffer to initialize a strbuf");
> +
> +	strbuf_init(sb, 0);
> +	strbuf_attach(sb, path_buf, path_buf_len, alloc_len);
> +	sb->flags &= ~STRBUF_OWNS_MEMORY;
> +	sb->flags &= ~STRBUF_FIXED_MEMORY;

Shorter: sb->flags &= ~(STRBUF_OWNS_MEMORY | STRBUF_FIXED_MEMORY);

> +}
> +
> +void strbuf_wrap_fixed(struct strbuf *sb, char *path_buf,
> +		       size_t path_buf_len, size_t alloc_len)
> +{
> +	strbuf_wrap_preallocated(sb, path_buf, path_buf_len, alloc_len);
> +	sb->flags |= STRBUF_FIXED_MEMORY;
> +}

Rather than letting strbuf_wrap_preallocated() set sb->flags &=
~FIXED_MEMORY only to revert that decision right away, a static function
could be called by both strbuf_wrap_preallocated() and
strbuf_wrap_fixed().

>  void strbuf_release(struct strbuf *sb)
>  {
>  	if (sb->alloc) {
> -		free(sb->buf);
> +		if (sb->flags & STRBUF_OWNS_MEMORY)
> +			free(sb->buf);
>  		strbuf_init(sb, 0);
>  	}

Should we not reset the flags here, too?

> @@ -38,7 +67,11 @@ char *strbuf_detach(struct strbuf *sb, size_t *sz)
>  {
>  	char *res;
>  	strbuf_grow(sb, 0);
> -	res = sb->buf;
> +	if (sb->flags & STRBUF_OWNS_MEMORY)
> +		res = sb->buf;
> +	else
> +		res = xmemdupz(sb->buf, sb->alloc - 1);

This looks like a usage to be avoided: if we plan to detach the buffer,
anyway, there is no good reason to allocate it on the heap first. I would
at least issue a warning here.

> @@ -51,6 +84,8 @@ void strbuf_attach(struct strbuf *sb, void *buf, size_t len, size_t alloc)
>  	sb->buf   = buf;
>  	sb->len   = len;
>  	sb->alloc = alloc;
> +	sb->flags |= STRBUF_OWNS_MEMORY;
> +	sb->flags &= ~STRBUF_FIXED_MEMORY;
>  	strbuf_grow(sb, 0);
>  	sb->buf[sb->len] = '\0';
>  }
> @@ -61,9 +96,32 @@ void strbuf_grow(struct strbuf *sb, size_t extra)
>  	if (unsigned_add_overflows(extra, 1) ||
>  	    unsigned_add_overflows(sb->len, extra + 1))
>  		die("you want to use way too much memory");
> -	if (new_buf)
> -		sb->buf = NULL;
> -	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
> +	if ((sb->flags & STRBUF_FIXED_MEMORY) && sb->len + extra + 1 > sb->alloc)
> +		die("you try to make a string overflow the buffer of a fixed strbuf");

We try to avoid running over 80 columns/row. This message could be
more to the point: cannot grow fixed string

> +	/*
> +	 * ALLOC_GROW may do a realloc() if needed, so we must not use it on
> +	 * a buffer the strbuf doesn't own
> +	 */
> +	if (sb->flags & STRBUF_OWNS_MEMORY) {
> +		if (new_buf)
> +			sb->buf = NULL;
> +		ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
> +	} else {
> +		/*
> +		 * The strbuf doesn't own the buffer: to avoid to realloc it,
> +		 * the strbuf needs to use a new buffer without freeing the old
> +		 */
> +		if (sb->len + extra + 1 > sb->alloc) {
> +			size_t new_alloc = MAX(sb->len + extra + 1, alloc_nr(sb->alloc));
> +			char *buf = xmalloc(new_alloc);
> +			memcpy(buf, sb->buf, sb->alloc);
> +			sb->buf = buf;
> +			sb->alloc = new_alloc;
> +			sb->flags |= STRBUF_OWNS_MEMORY;
> +		}
> +	}
> +
>  	if (new_buf)
>  		sb->buf[0] = '\0';
>  }
> diff --git a/strbuf.h b/strbuf.h
> index 7987405..634759c 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -11,11 +11,16 @@
>   * A strbuf is NUL terminated for convenience, but no function in the
>   * strbuf API actually relies on the string being free of NULs.
>   *
> + * You can avoid the malloc/free overhead of `strbuf_init()`, `strbuf_add()` and
> + * `strbuf_release()` by wrapping pre-allocated memory (stack-allocated for
> + * example) using `strbuf_wrap_preallocated()` or `strbuf_wrap_fixed()`.
> + *
>   * strbufs have some invariants that are very important to keep in mind:
>   *
>   *  - The `buf` member is never NULL, so it can be used in any usual C
>   *    string operations safely. strbuf's _have_ to be initialized either by
> - *    `strbuf_init()` or by `= STRBUF_INIT` before the invariants, though.
> + *    `strbuf_init()`, `= STRBUF_INIT`, `strbuf_wrap_preallocated()` or
> + *    `strbuf_wrap_fixed()` before the invariants, though.
>   *
>   *    Do *not* assume anything on what `buf` really is (e.g. if it is
>   *    allocated memory or not), use `strbuf_detach()` to unwrap a memory
> @@ -62,13 +67,14 @@
>   * access to the string itself.
>   */
>  struct strbuf {
> +	unsigned int flags;
>  	size_t alloc;
>  	size_t len;
>  	char *buf;
>  };
>  
>  extern char strbuf_slopbuf[];
> -#define STRBUF_INIT  { 0, 0, strbuf_slopbuf }
> +#define STRBUF_INIT  { 0, 0, 0, strbuf_slopbuf }

If I am not mistaken, to preserve the existing behavior the initial flags
should be 1 (own memory).

BTW this demonstrates that it may not be a good idea to declare the
"flags" field globally but then make the actual flags private.

Also: similar use cases in Git used :1 flags (see e.g. the "configured"
field in credential.h).

Ciao,
Johannes
