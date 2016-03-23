From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 04/33] files-backend: break out ref reading
Date: Wed, 23 Mar 2016 11:19:33 +0100
Message-ID: <56F26DB5.70708@alum.mit.edu>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
 <1456793586-22082-5-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	peff@peff.net, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 23 11:20:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiftR-0007oH-Ta
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025AbcCWKTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:19:55 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54388 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754964AbcCWKTv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:19:51 -0400
X-AuditID: 12074413-f03ff7000000516b-7c-56f26db80ed3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 5C.2F.20843.8BD62F65; Wed, 23 Mar 2016 06:19:37 -0400 (EDT)
Received: from [192.168.69.130] (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NAJYCj018688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:19:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <1456793586-22082-5-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqLsz91OYwfvtnBbzN51gtOi60s1k
	0dB7hdmie8pbRosfLT3MDqweO2fdZfd41ruH0ePiJWWPBc/vs3t83iQXwBrFbZOUWFIWnJme
	p2+XwJ1xfN4M5oKPdRULFm5kaWDcH9/FyMkhIWAi8fnfP6YuRi4OIYGtjBJTuzdAOReYJFbs
	mMEGUiUs4CQx++9EdhBbRCBbYs6nc6wQRe2MEp1r/jGDJJgF1CTaN01hBbHZBHQlFvU0M4HY
	vAKaEkunnwEbxCKgKtE24x5YjahAiMS2dd9YIWoEJU7OfMICYnMKeEo8WfORHWKmnsSO679Y
	IWx5ie1v5zBPYOSfhaRlFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdfLzSzR
	S00p3cQICWfhHYy7TsodYhTgYFTi4S089zFMiDWxrLgy9xCjJAeTkijv+aBPYUJ8SfkplRmJ
	xRnxRaU5qcWHGCU4mJVEeNWzgXK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZ
	GQ4OJQne5hygRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQVMYXA+MSJMUDtFcG
	pJ23uCAxFygK0XqKUVFKnFcJ5CABkERGaR7cWFiSesUoDvSlMO98kHYeYIKD634FNJgJaPBC
	H7DBJYkIKakGRtm32Yw36j8vDtJJt7krcTj6/rr74doeGVyF7eXdJU3i/Jf/Wrjvnf5rfWsH
	D39FkbrBowuHajMmZu+7GcJ57JHiBjWu8rPhHnfvbfortEbx40V3r5Cw9Y2Pr66c 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289637>

On 03/01/2016 01:52 AM, David Turner wrote:
> Refactor resolve_ref_1 in terms of a new function read_raw_ref, which
> is responsible for reading ref data from the ref storage.
> 
> Later, we will make read_raw_ref a pluggable backend function, and make
> resolve_ref_unsafe common.
> 
> Testing done: Hacked in code to run both old and new version of
> resolve_ref_1 and compare all outputs, failing dramatically if outputs
> differed.  Ran test suite.

I spent an inordinate amount of time trying to review this patch. It is
much too big and does too much at the same time. And, in fact, it makes
some mistakes, which were impossible to see until I picked the patch
apart into smaller steps.

The reference-reading code before this patch wasn't structured very
well. Part of the reason that the code is a mess is that it is pretty
intricate and has to get things just right to avoid race conditions. But
the rest of the reason is that it was overdue for a refactoring, and
this patch shows a great way forward.

Because of the intricacy of this code, it is really important to do a
careful job changing it. To me that means refactoring in the smallest
possible steps, ideally so that each step is obviously correct.

So to review your patch, I picked it apart into tiny preparatory
refactorings, followed by the main patch (the extraction of the function
read_raw_ref()), followed by some more cleanups. When I did so I found
that there were some differences between my end product and yours. Some
of these introduce minor bugs, so it is worth fixing them.

I've annotated your patch below, but in my opinion a better way forward
would be to commit not this single giant patch, but rather the
picked-apart version, which also addresses my comments below. I just
submitted that patch series [1]. It's twenty-one patches(!), though a
bit over half of them do things that go beyond this patch. In the
future, it would help the review process if you would submit smaller
patches that do a single thing at a time.

I've reviewed the patches that precede this one and they look fine to
me. I haven't reviewed this version of patches 05 through 33 yet.

Michael

[1] http://mid.gmane.org/cover.1458723959.git.mhagger@alum.mit.edu

> Signed-off-by: David Turner <dturner@twopensource.com>
> Helped-by: Duy Nguyen <pclouds@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  refs/files-backend.c | 265 ++++++++++++++++++++++++++++++---------------------
>  1 file changed, 159 insertions(+), 106 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 9676ec2..8c6a58e 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1369,12 +1369,11 @@ static struct ref_entry *get_packed_ref(const char *refname)
>  
>  /*
>   * A loose ref file doesn't exist; check for a packed ref.  The
> - * options are forwarded from resolve_safe_unsafe().
> + * options are forwarded from resolve_ref_unsafe().
>   */
>  static int resolve_missing_loose_ref(const char *refname,
> -				     int resolve_flags,
>  				     unsigned char *sha1,
> -				     int *flags)
> +				     unsigned int *flags)

This patch changes some flags variables from "int" to "unsigned int"
without discussion. I think the change is OK, but why not do it in a
separate patch?

>  {
>  	struct ref_entry *entry;
>  
> @@ -1390,64 +1389,48 @@ static int resolve_missing_loose_ref(const char *refname,
>  		return 0;
>  	}
>  	/* The reference is not a packed reference, either. */
> -	if (resolve_flags & RESOLVE_REF_READING) {
> -		errno = ENOENT;
> -		return -1;
> -	} else {
> -		hashclr(sha1);
> -		return 0;
> -	}
> +	errno = ENOENT;
> +	return -1;
>  }
>  
> -/* This function needs to return a meaningful errno on failure */
> -static const char *resolve_ref_1(const char *refname,
> -				 int resolve_flags,
> -				 unsigned char *sha1,
> -				 int *flags,
> -				 struct strbuf *sb_refname,
> -				 struct strbuf *sb_path,
> -				 struct strbuf *sb_contents)
> +/*
> + * Read a raw ref from the filesystem or packed refs file.
> + *
> + * If the ref is a sha1, fill in sha1 and return 0.
> + *
> + * If the ref is symbolic, fill in *symref with the referrent
> + * (e.g. "refs/heads/master") and return 0.  The caller is responsible
> + * for validating the referrent.  Set REF_ISSYMREF in flags.
> + *
> + * If the ref is neither a symbolic ref nor a sha1, it is broken.  Set
> + * REF_ISBROKEN in flags, set errno to EINVAL, and return -1.
> + *
> + * If the ref doesn't exist, set errno to ENOENT and return -1.
> + *
> + * If there is another error reading the ref, set errno appropriately and
> + * return -1.
> + *
> + * Backend-specific flags might be set in flags as well, regardless of
> + * outcome.
> + *
> + * sb_path is workspace: the caller should allocate and free it.
> + */
> +static int read_raw_ref(const char *refname, unsigned char *sha1,
> +			struct strbuf *symref, struct strbuf *sb_path,
> +			unsigned int *flags)
>  {
> -	int depth = MAXDEPTH;
> -	int bad_name = 0;
> -
> -	if (flags)
> -		*flags = 0;
> +	struct strbuf sb_contents = STRBUF_INIT;

I see you've pushed responsibility for managing the scratch space
sb_contents from resolve_ref_unsafe() down to read_raw_ref(). This seems
like a good idea to decouple the code better (albeit at the expense of
some extra memory allocations). But why don't you push responsibility
for managing sb_path down at the same time? It seems that the same
considerations would apply.

BTW if you do so, then resolve_ref_unsafe() becomes trivial and
resolve_ref_1() could easily be inlined into it.

> +	int ret = -1;
> +	const char *path;
> +	const char *buf;
>  
> -	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
> -		if (flags)
> -			*flags |= REF_BAD_NAME;
> +	strbuf_reset(sb_path);
> +	strbuf_git_path(sb_path, "%s", refname);
> +	path = sb_path->buf;
>  
> -		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
> -		    !refname_is_safe(refname)) {
> -			errno = EINVAL;
> -			return NULL;
> -		}
> -		/*
> -		 * dwim_ref() uses REF_ISBROKEN to distinguish between
> -		 * missing refs and refs that were present but invalid,
> -		 * to complain about the latter to stderr.
> -		 *
> -		 * We don't know whether the ref exists, so don't set
> -		 * REF_ISBROKEN yet.
> -		 */
> -		bad_name = 1;
> -	}
>  	for (;;) {
> -		const char *path;
>  		struct stat st;
> -		char *buf;
>  		int fd;
> -
> -		if (--depth < 0) {
> -			errno = ELOOP;
> -			return NULL;
> -		}
> -
> -		strbuf_reset(sb_path);
> -		strbuf_git_path(sb_path, "%s", refname);
> -		path = sb_path->buf;
> -
>  		/*
>  		 * We might have to loop back here to avoid a race
>  		 * condition: first we lstat() the file, then we try
> @@ -1457,49 +1440,45 @@ static const char *resolve_ref_1(const char *refname,
>  		 * we don't want to report that as an error but rather
>  		 * try again starting with the lstat().
>  		 */
> -	stat_ref:
> +
>  		if (lstat(path, &st) < 0) {
>  			if (errno != ENOENT)
> -				return NULL;
> -			if (resolve_missing_loose_ref(refname, resolve_flags,
> -						      sha1, flags))
> -				return NULL;
> -			if (bad_name) {
> -				hashclr(sha1);
> -				if (flags)
> -					*flags |= REF_ISBROKEN;
> -			}
> -			return refname;
> +				break;
> +			if (resolve_missing_loose_ref(refname, sha1, flags))
> +				break;
> +			ret = 0;
> +			break;
>  		}
>  
>  		/* Follow "normalized" - ie "refs/.." symlinks by hand */
>  		if (S_ISLNK(st.st_mode)) {
> -			strbuf_reset(sb_contents);
> -			if (strbuf_readlink(sb_contents, path, 0) < 0) {
> +			strbuf_reset(&sb_contents);
> +			if (strbuf_readlink(&sb_contents, path, 0) < 0) {
>  				if (errno == ENOENT || errno == EINVAL)
>  					/* inconsistent with lstat; retry */
> -					goto stat_ref;
> +					continue;
>  				else
> -					return NULL;
> +					break;
>  			}
> -			if (starts_with(sb_contents->buf, "refs/") &&
> -			    !check_refname_format(sb_contents->buf, 0)) {
> -				strbuf_swap(sb_refname, sb_contents);
> -				refname = sb_refname->buf;
> +			if (starts_with(sb_contents.buf, "refs/") &&
> +			    !check_refname_format(sb_contents.buf, 0)) {
> +				strbuf_swap(&sb_contents, symref);
>  				if (flags)
>  					*flags |= REF_ISSYMREF;
> -				if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
> -					hashclr(sha1);
> -					return refname;
> -				}
> -				continue;
> +				ret = 0;
> +				break;
> +			} else {
> +				/* bogus symlink ref  */
> +				if (flags)
> +					*flags |= REF_ISBROKEN;
> +				break;

I think this is a functional change.

Some background: We still support writing symrefs as symlinks if
core.prefersymlinkrefs is set (the code is in create_ref_symlink()).
Such symlinks contain the full ref name (e.g., "refs/heads/foo") and are
read via the

    if starts_with(sb_contents.buf, "refs/")

block above.

I suppose that this code was used in the old days when "HEAD" was the
only symbolic reference, in which case the symlink would really point at
the file representing the referred-to loose reference. Nowadays symbolic
references can live elsewhere, and references can be packed, so the
symlink representing the symbolic reference might not even point at a
file at the filesystem level. But that's not really a problem; the OS
doesn't care what bytes you stick in a symlink.

Anyway, at this point in the code we're not talking about that kind of
symlink. We're talking about a symlink that might point legitimately at
another file at the filesystem level, even though its contents might be
something like "../foo/bar" that doesn't even look like a reference name.

The old resolve_ref_1() did NOT consider such a symlink to be bogus *if*
it pointed to a file. Instead the code fell through to a questionable
S_ISDIR() test followed by an attempt to read the loose reference file
directly through the symlink. Thus, for example, the old code would
resolve a symlink "refs/heads/foo" with contents "bar" to
"refs/heads/bar", albeit without marking it REF_ISSYMREF.

We might not want to continue supporting this kind of
symlink-as-reference. It seems pretty silly and broken to me (e.g., if
the referred-to reference is packed, it would break). But maybe the
old-timers can think of a reason to preserve this behavior. Let's have
that discussion.

Either way, it is NOT OK to change behavior like this in a big patch
without even mentioning it in the commit message. Ideally, the behavior
change should be done in a separate patch with an explicit justification.

>  			}
>  		}
>  
>  		/* Is it a directory? */
>  		if (S_ISDIR(st.st_mode)) {
>  			errno = EISDIR;
> -			return NULL;
> +			break;
>  		}
>  
>  		/*
> @@ -1510,35 +1489,110 @@ static const char *resolve_ref_1(const char *refname,
>  		if (fd < 0) {
>  			if (errno == ENOENT)
>  				/* inconsistent with lstat; retry */
> -				goto stat_ref;
> +				continue;
>  			else
> -				return NULL;
> +				break;
>  		}
> -		strbuf_reset(sb_contents);
> -		if (strbuf_read(sb_contents, fd, 256) < 0) {
> +		strbuf_reset(&sb_contents);
> +		if (strbuf_read(&sb_contents, fd, 256) < 0) {
>  			int save_errno = errno;
>  			close(fd);
>  			errno = save_errno;
> -			return NULL;
> +			break;
>  		}
>  		close(fd);
> -		strbuf_rtrim(sb_contents);
> +		strbuf_rtrim(&sb_contents);
> +		buf = sb_contents.buf;
> +		if (starts_with(buf, "ref:")) {
> +			buf += 4;
> +			while (isspace(*buf))
> +				buf++;
> +
> +			strbuf_reset(symref);
> +			strbuf_addstr(symref, buf);
> +			if (flags)


read_raw_ref() is only called with a valid flags pointer, so you can get
rid of these "if (flags)" guards (here and elsewhere).

In fact, the code in resolve_ref_1() could be simplified the same way if
resolve_ref_unsafe() (the only public entry point) would contain

int unused_flags;

if (!flags)
flags = &unused_flags;

but feel free to consider that outside of the scope of your patch series.


> +				*flags |= REF_ISSYMREF;
> +			ret = 0;
> +			break;
> +		}
>  
>  		/*
> -		 * Is it a symbolic ref?
> +		 * Please note that FETCH_HEAD has additional
> +		 * data after the sha.
>  		 */
> -		if (!starts_with(sb_contents->buf, "ref:")) {
> -			/*
> -			 * Please note that FETCH_HEAD has a second
> -			 * line containing other data.
> -			 */
> -			if (get_sha1_hex(sb_contents->buf, sha1) ||
> -			    (sb_contents->buf[40] != '\0' && !isspace(sb_contents->buf[40]))) {
> +		if (get_sha1_hex(buf, sha1) ||
> +		    (buf[40] != '\0' && !isspace(buf[40]))) {
> +			if (flags)
> +				*flags |= REF_ISBROKEN;
> +			errno = EINVAL;
> +			break;
> +		}
> +		ret = 0;
> +		break;
> +	}
> +
> +	strbuf_release(&sb_contents);
> +	return ret;
> +}
> +
> +/* This function needs to return a meaningful errno on failure */
> +static const char *resolve_ref_1(const char *refname,
> +				 int resolve_flags,
> +				 unsigned char *sha1,
> +				 int *flags,
> +				 struct strbuf *sb_refname,
> +				 struct strbuf *sb_path)
> +{
> +	int bad_name = 0;
> +	int symref_count;
> +
> +	if (flags)
> +		*flags = 0;
> +
> +	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
> +		if (flags)
> +			*flags |= REF_BAD_NAME;
> +
> +		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
> +		    !refname_is_safe(refname)) {
> +			errno = EINVAL;
> +			return NULL;
> +		}
> +		/*
> +		 * dwim_ref() uses REF_ISBROKEN to distinguish between
> +		 * missing refs and refs that were present but invalid,
> +		 * to complain about the latter to stderr.
> +		 *
> +		 * We don't know whether the ref exists, so don't set
> +		 * REF_ISBROKEN yet.
> +		 */
> +		bad_name = 1;
> +	}
> +
> +	for (symref_count = 0; symref_count < MAXDEPTH; symref_count++) {
> +		unsigned int read_flags = 0;
> +
> +		if (read_raw_ref(refname, sha1, sb_refname, sb_path, &read_flags)) {
> +			int saved_errno = errno;
> +			if (flags)
> +				*flags |= read_flags;
> +			errno = saved_errno;
> +			if (bad_name) {
> +				hashclr(sha1);
>  				if (flags)
>  					*flags |= REF_ISBROKEN;
> -				errno = EINVAL;
> +			}
> +			if (resolve_flags & RESOLVE_REF_READING || errno != ENOENT) {
>  				return NULL;
> +			} else {
> +				hashclr(sha1);
> +				return refname;
>  			}
> +		}
> +		if (flags)
> +			*flags |= read_flags;
> +
> +		if (!(read_flags & REF_ISSYMREF)) {
>  			if (bad_name) {
>  				hashclr(sha1);
>  				if (flags)
> @@ -1546,44 +1600,43 @@ static const char *resolve_ref_1(const char *refname,
>  			}
>  			return refname;
>  		}
> -		if (flags)
> -			*flags |= REF_ISSYMREF;
> -		buf = sb_contents->buf + 4;
> -		while (isspace(*buf))
> -			buf++;
> -		strbuf_reset(sb_refname);
> -		strbuf_addstr(sb_refname, buf);
> +
>  		refname = sb_refname->buf;
>  		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
>  			hashclr(sha1);
> +			if (bad_name && flags)
> +				*flags |= REF_ISBROKEN;
>  			return refname;
>  		}
> -		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
> +
> +		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
>  			if (flags)
>  				*flags |= REF_ISBROKEN;
> -
>  			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
> -			    !refname_is_safe(buf)) {
> +			    !refname_is_safe(refname)) {
>  				errno = EINVAL;
>  				return NULL;
>  			}
>  			bad_name = 1;
>  		}
>  	}
> +
> +	if (flags)
> +		*flags |= REF_ISBROKEN;
> +	return NULL;
>  }
>  
>  const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
>  			       unsigned char *sha1, int *flags)
>  {
>  	static struct strbuf sb_refname = STRBUF_INIT;
> -	struct strbuf sb_contents = STRBUF_INIT;
>  	struct strbuf sb_path = STRBUF_INIT;
>  	const char *ret;
>  
>  	ret = resolve_ref_1(refname, resolve_flags, sha1, flags,
> -			    &sb_refname, &sb_path, &sb_contents);
> +			    &sb_refname, &sb_path);
> +
>  	strbuf_release(&sb_path);
> -	strbuf_release(&sb_contents);
>  	return ret;
>  }
>  
> 
