From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 02/16] path.c: refactor relative_path(), not only strip prefix
Date: Wed, 26 Jun 2013 10:44:46 -0700
Message-ID: <7v7ghgwyup.fsf@alter.siamese.dyndns.org>
References: <cover.1372175282.git.worldhello.net@gmail.com>
	<cover.1372175282.git.worldhello.net@gmail.com>
	<31fc3821962b83e79cd8f59127c8c11ba1551073.1372175282.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 19:45:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrtmA-0007P9-Pz
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 19:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487Ab3FZRov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 13:44:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60415 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751766Ab3FZRot (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 13:44:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B65D2B00F;
	Wed, 26 Jun 2013 17:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=nqA5I4DUuk/URIvefs9N68HcNjA=; b=enc1Umo4jR2O8slIVAJT
	yTe3/zNAbMZfDwo6iFnRkAaWHdRFWa3feZOv2qKwdgL3YZMPzKuFroWLE91UOKUW
	7iwlPXYnXK/6P2y8+dRaGmksZe5IvEV2ZtLNwzDnP4SzYO4mBkgAkcuu+bNeBDaN
	rtT2+rFKbAunC6dcPvs4zPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=vLYMNcSJfWhmJhPNECeVz7pnaqR7FOekwXHseyJZ6kvdxY
	hXE6+B3g0gGqucjCfRdqdDjpxySU0z+HTEOj0Rj+tT8Ixhop7l6FTUDeKUgRRmz0
	WVHG2UVlJrVPGh7xNEJdBMGjPCZEyvdFOZBW6oeIgQeA8jzWTBaw3M41OUdWw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F41E72B00E;
	Wed, 26 Jun 2013 17:44:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E64E82B00B;
	Wed, 26 Jun 2013 17:44:47 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1852AE96-DE88-11E2-AB54-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229049>

Jiang Xin <worldhello.net@gmail.com> writes:

> Original design of relative_path() is simple, just strip the prefix
> (*base) from the absolute path (*abs). In most cases, we need a real
> relative path, such as: ../foo, ../../bar. That's why there is another
> reimplementation (path_relative()) in quote.c.
>
> Borrowed some codes from path_relative() in quote.c to refactor

s/Borrowed/Borrow/; will locally amend.

> relative_path() in path.c, so that it could return real relative path,
> and user can reuse this function without reimplement his/her own.

s/reimplement/&ing/; will locally amend.

> The function path_relative() in quote.c will be substituted, and I
> would use the new relative_path() function when implement the

s/implement/&ing/; will locally amend.

> interactive git-clean later.
>
> Different results for relative_path() before and after this refactor:

I'd remove the rows that show the same result in the latter two
columns (will locally amend, if you do not object).

>     abs path  base path  relative (original)  relative (refactor)
>     ========  =========  ===================  ===================
>     /a/b      /a/b       .                    ./
>     /a/b/     /a/b       .                    ./
>     /a        /a/b/      /a                   ../
>     /         /a/b/      /                    ../../
>     /a/c      /a/b/      /a/c                 ../c
>     /x/y      /a/b/      /x/y                 ../../x/y
>
>     a/b/      a/b/       .                    ./
>     a/b/      a/b        .                    ./
>     a         a/b        a                    ../
>     x/y       a/b/       x/y                  ../../x/y
>     a/c       a/b        a/c                  ../c
>
>     (empty)   (null)     (empty)              ./
>     (empty)   (empty)    (empty)              ./
>     (empty)   /a/b       (empty)              ./
>     (null)    (null)     (null)               ./
>     (null)    (empty)    (null)               ./
>     (null)    /a/b       (segfault)           ./

> You may notice that return value "." has been changed to "./".
> It is because:
>
>  * Function quote_path_relative() in quote.c will show the relative
>    path as "./" if abs(in) and base(prefix) are the same.
>
>  * Function relative_path() is called only once (in setup.c), and
>    it will be OK for the return value as "./" instead of ".".

Good explanation.  Thanks.

> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  cache.h               |   2 +-
>  path.c                | 116 +++++++++++++++++++++++++++++++++++++-------------
>  setup.c               |   5 ++-
>  t/t0060-path-utils.sh |  39 ++++++++---------
>  test-path-utils.c     |   4 +-
>  5 files changed, 113 insertions(+), 53 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index dd0fb..c2886 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -758,7 +758,7 @@ int is_directory(const char *);
>  const char *real_path(const char *path);
>  const char *real_path_if_valid(const char *path);
>  const char *absolute_path(const char *path);
> -const char *relative_path(const char *abs, const char *base);
> +const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
>  int normalize_path_copy(char *dst, const char *src);
>  int longest_ancestor_length(const char *path, struct string_list *prefixes);
>  char *strip_path_suffix(const char *path, const char *suffix);
> diff --git a/path.c b/path.c
> index 04ff..fbe52c9b 100644
> --- a/path.c
> +++ b/path.c
> @@ -441,42 +441,100 @@ int adjust_shared_perm(const char *path)
>  	return 0;
>  }
>  
> +/*
> + * Give path as relative to prefix.
> + *
> + * The strbuf may or may not be used, so do not assume it contains the
> + * returned path.
> + */
> +const char *relative_path(const char *in, const char *prefix,
> +			  struct strbuf *sb)
>  {
> +	int in_len = in ? strlen(in) : 0;
> +	int prefix_len = prefix ? strlen(prefix) : 0;
> +	int in_off = 0;
> +	int prefix_off = 0;
> +	int i = 0,j = 0;

s/0,j/0, j/; will locally amend.

> +
> +	if (!in_len)
> +		return "./";
> +	else if (!prefix_len)
> +		return in;
> +
> +	while (i < prefix_len && j < in_len && prefix[i] == in[j]) {
> +		if (is_dir_sep(prefix[i])) {
> +			while (is_dir_sep(prefix[i]))
>  				i++;
> +			while (is_dir_sep(in[j]))
>  				j++;

These i++/j++ are not checked for lengths of strings, but it is OK
because is_dir_sep() will never return true for NUL.

> +			prefix_off = i;
> +			in_off = j;

(mental note) *_off keeps track of the last directory separator of
the common part, i.e. where the difference begins.

> +		} else {
> +			i++;
> +			j++;
> +		}
> +	}
> +
> +	if (
> +	    /* "prefix" seems like prefix of "in" */
> +	    i >= prefix_len &&

So shouldn't this be "i == prefix_len"?

> +	    /*
> +	     * but "/foo" is not a prefix of "/foobar"
> +	     * (i.e. prefix not end with '/')
> +	     */
> +	    prefix_off < prefix_len) {
> +		if (j >= in_len) {

Again, "j == in_len", isn't it?  Or can i and j overrun in_len and
prefix_len?

> +			/* in="/a/b", prefix="/a/b" */
> +			in_off = in_len;
> +		} else if (is_dir_sep(in[j])) {
> +			/* in="/a/b/c", prefix="/a/b" */
> +			while (is_dir_sep(in[j]))
> +				j++;
> +			in_off = j;
> +		} else {
> +			/* in="/a/bbb/c", prefix="/a/b" */
> +			i = prefix_off;
> +		}
> +	} else if (
> +		   /* "in" is short than "prefix" */
> +		   j >= in_len &&
> +		   /* "in" not end with '/' */
> +		   in_off < in_len) {
> +		if (is_dir_sep(prefix[i])) {
> +			/* in="/a/b", prefix="/a/b/c/" */
> +			while (is_dir_sep(prefix[i]))
> +				i++;
> +			in_off = in_len;
> +		}
> +	}
> +	in += in_off;
> +	in_len -= in_off;

(mental note) Now in points at the part after stripping common
leading directories and in_len is adjusted accordingly.

> +	if (i >= prefix_len) {

(mental note) it turns out that "in" covered the entire prefix, so
there is no need for "../" in this case.

> +		if (!in_len)
> +			return "./";
> +		else
> +			return in;
> +	}
> +
> +	strbuf_reset(sb);
> +	strbuf_grow(sb, in_len);
> +
> +	while (i < prefix_len) {
> +		if (is_dir_sep(prefix[i])) {
> +			strbuf_addstr(sb, "../");
> +			while (is_dir_sep(prefix[i]))
> +				i++;
>  			continue;
>  		}
>  		i++;
>  	}

(mental note) otherwise count '/' in the remainder of the prefix and
prepend as many "../" as necessary.

> +	if (!is_dir_sep(prefix[prefix_len - 1]))
> +		strbuf_addstr(sb, "../");

(mental note) ... and one more?  E.g. for prefix="/a/b/c" in="/a/x",
we stripped the common "/a/" and the above loop started counting
from 'b' in the prefix, which counted one slash between b and c, but
we need to go two levels up.  If prefix were "/a/b/c/", we would
already have counted the slash after c, so we do not need to do so.

OK.
