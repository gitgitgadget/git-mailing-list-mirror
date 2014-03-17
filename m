From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 03/28] Convert git_snpath() to strbuf_git_path()
Date: Mon, 17 Mar 2014 11:11:52 -0700
Message-ID: <xmqqvbvceluf.fsf@gitster.dls.corp.google.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
	<1394246900-31535-1-git-send-email-pclouds@gmail.com>
	<1394246900-31535-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 19:12:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPc1M-0001aY-F8
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 19:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780AbaCQSL7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2014 14:11:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60910 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756424AbaCQSL4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2014 14:11:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3819E756B2;
	Mon, 17 Mar 2014 14:11:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Kc+I8mQZocKb
	q8KfoYO5gtToAdA=; b=JV9BbDBAoHeuuasXXbUesScXxKmjc1ypDlCwrGn96LWc
	0AQCIT9dBz39R+ZgsVK760H4bg2XVX7MOL211E4caI1ddL4V2Hzv+o3X8Anfzhj8
	VQ5H2C89kCLu+cdRTvFvvi1mXyY2qi5X0TZ4+rnTPY48cL/WpRWN+95fAEJmzbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UwcmN/
	W+qYkhX0xw+m6tTOsPcBf8D66PYfUYOBsGIYgFLlnNffhRl+vt8OfS1f3hSGdJaU
	v9b+ArrFZzxtg/oFM1DZLfH27nhQZ8cuKQMGRI+a6bn2PT4BMiga/INk1Gjfi1Yr
	3o3MslggcSjtEt1bji4547LTD55a3LmFjnmg8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26435756B1;
	Mon, 17 Mar 2014 14:11:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CD4E756AA;
	Mon, 17 Mar 2014 14:11:54 -0400 (EDT)
In-Reply-To: <1394246900-31535-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 8 Mar
 2014 09:47:55 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9EA70AA4-ADFF-11E3-8624-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244261>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> In the previous patch, git_snpath() is modified to allocate a new
> strbuf buffer because vsnpath() needs that. But that makes it awkward
> because git_snpath() receives a pre-allocated buffer from outside and
> has to copy data back. Rename it to strbuf_git_path() and make it
> receive strbuf directly.
>
> The conversion from git_snpath() to git_path() in
> update_refs_for_switch() is safe because that function does not keep
> any pointer to the round-robin buffer pool allocated by
> get_pathname().

s/that function does not/that function and all of its callers do not/

is the guarantee we need to say it is safe.  And I think that holds
true.

Thanks.

>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/checkout.c | 25 +++++++++--------
>  cache.h            |  4 +--
>  path.c             | 11 ++------
>  refs.c             | 78 +++++++++++++++++++++++++++++++++-----------=
----------
>  refs.h             |  2 +-
>  5 files changed, 65 insertions(+), 55 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 64c2aca..efb5e2f 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -585,18 +585,21 @@ static void update_refs_for_switch(const struct=
 checkout_opts *opts,
>  		if (opts->new_orphan_branch) {
>  			if (opts->new_branch_log && !log_all_ref_updates) {
>  				int temp;
> -				char log_file[PATH_MAX];
> -				const char *ref_name =3D mkpath("refs/heads/%s", opts->new_orpha=
n_branch);
> +				struct strbuf log_file =3D STRBUF_INIT;
> +				int ret;
> +				const char *ref_name;
> =20
> +				ref_name =3D mkpath("refs/heads/%s", opts->new_orphan_branch);
>  				temp =3D log_all_ref_updates;
>  				log_all_ref_updates =3D 1;
> -				if (log_ref_setup(ref_name, log_file, sizeof(log_file))) {
> +				ret =3D log_ref_setup(ref_name, &log_file);
> +				log_all_ref_updates =3D temp;
> +				strbuf_release(&log_file);
> +				if (ret) {
>  					fprintf(stderr, _("Can not do reflog for '%s'\n"),
>  					    opts->new_orphan_branch);
> -					log_all_ref_updates =3D temp;
>  					return;
>  				}
> -				log_all_ref_updates =3D temp;
>  			}
>  		}
>  		else
> @@ -651,14 +654,10 @@ static void update_refs_for_switch(const struct=
 checkout_opts *opts,
>  					new->name);
>  			}
>  		}
> -		if (old->path && old->name) {
> -			char log_file[PATH_MAX], ref_file[PATH_MAX];
> -
> -			git_snpath(log_file, sizeof(log_file), "logs/%s", old->path);
> -			git_snpath(ref_file, sizeof(ref_file), "%s", old->path);
> -			if (!file_exists(ref_file) && file_exists(log_file))
> -				remove_path(log_file);
> -		}
> +		if (old->path && old->name &&
> +		    !file_exists(git_path("%s", old->path)) &&
> +		     file_exists(git_path("logs/%s", old->path)))
> +			remove_path(git_path("logs/%s", old->path));
>  	}
>  	remove_branch_state();
>  	strbuf_release(&msg);
> diff --git a/cache.h b/cache.h
> index a344a5f..0fae730 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -646,8 +646,8 @@ extern int check_repository_format(void);
> =20
>  extern char *mksnpath(char *buf, size_t n, const char *fmt, ...)
>  	__attribute__((format (printf, 3, 4)));
> -extern char *git_snpath(char *buf, size_t n, const char *fmt, ...)
> -	__attribute__((format (printf, 3, 4)));
> +extern void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
> +	__attribute__((format (printf, 2, 3)));
>  extern char *git_pathdup(const char *fmt, ...)
>  	__attribute__((format (printf, 1, 2)));
>  extern char *mkpathdup(const char *fmt, ...)
> diff --git a/path.c b/path.c
> index 36d461e..417df76 100644
> --- a/path.c
> +++ b/path.c
> @@ -70,19 +70,12 @@ static void vsnpath(struct strbuf *buf, const cha=
r *fmt, va_list args)
>  	strbuf_cleanup_path(buf);
>  }
> =20
> -char *git_snpath(char *buf, size_t n, const char *fmt, ...)
> +void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
>  {
> -	struct strbuf sb =3D STRBUF_INIT;
>  	va_list args;
>  	va_start(args, fmt);
> -	vsnpath(&sb, fmt, args);
> +	vsnpath(sb, fmt, args);
>  	va_end(args);
> -	if (sb.len >=3D n)
> -		strlcpy(buf, bad_path, n);
> -	else
> -		memcpy(buf, sb.buf, sb.len + 1);
> -	strbuf_release(&sb);
> -	return buf;
>  }
> =20
>  char *git_pathdup(const char *fmt, ...)
> diff --git a/refs.c b/refs.c
> index f846f2f..c5613b0 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1325,10 +1325,12 @@ static const char *handle_missing_loose_ref(c=
onst char *refname,
> =20
>  const char *resolve_ref_unsafe(const char *refname, unsigned char *s=
ha1, int reading, int *flag)
>  {
> +	struct strbuf sb_path =3D STRBUF_INIT;
>  	int depth =3D MAXDEPTH;
>  	ssize_t len;
>  	char buffer[256];
>  	static char refname_buffer[256];
> +	const char *ret;
> =20
>  	if (flag)
>  		*flag =3D 0;
> @@ -1337,15 +1339,17 @@ const char *resolve_ref_unsafe(const char *re=
fname, unsigned char *sha1, int rea
>  		return NULL;
> =20
>  	for (;;) {
> -		char path[PATH_MAX];
> +		const char *path;
>  		struct stat st;
>  		char *buf;
>  		int fd;
> =20
>  		if (--depth < 0)
> -			return NULL;
> +			goto fail;
> =20
> -		git_snpath(path, sizeof(path), "%s", refname);
> +		strbuf_reset(&sb_path);
> +		strbuf_git_path(&sb_path, "%s", refname);
> +		path =3D sb_path.buf;
> =20
>  		/*
>  		 * We might have to loop back here to avoid a race
> @@ -1359,10 +1363,11 @@ const char *resolve_ref_unsafe(const char *re=
fname, unsigned char *sha1, int rea
>  	stat_ref:
>  		if (lstat(path, &st) < 0) {
>  			if (errno =3D=3D ENOENT)
> -				return handle_missing_loose_ref(refname, sha1,
> -								reading, flag);
> +				ret =3D handle_missing_loose_ref(refname, sha1,
> +							       reading, flag);
>  			else
> -				return NULL;
> +				ret =3D NULL;
> +			goto done;
>  		}
> =20
>  		/* Follow "normalized" - ie "refs/.." symlinks by hand */
> @@ -1373,7 +1378,7 @@ const char *resolve_ref_unsafe(const char *refn=
ame, unsigned char *sha1, int rea
>  					/* inconsistent with lstat; retry */
>  					goto stat_ref;
>  				else
> -					return NULL;
> +					goto fail;
>  			}
>  			buffer[len] =3D 0;
>  			if (starts_with(buffer, "refs/") &&
> @@ -1389,7 +1394,7 @@ const char *resolve_ref_unsafe(const char *refn=
ame, unsigned char *sha1, int rea
>  		/* Is it a directory? */
>  		if (S_ISDIR(st.st_mode)) {
>  			errno =3D EISDIR;
> -			return NULL;
> +			goto fail;
>  		}
> =20
>  		/*
> @@ -1402,12 +1407,13 @@ const char *resolve_ref_unsafe(const char *re=
fname, unsigned char *sha1, int rea
>  				/* inconsistent with lstat; retry */
>  				goto stat_ref;
>  			else
> -				return NULL;
> +				goto fail;
>  		}
> +
>  		len =3D read_in_full(fd, buffer, sizeof(buffer)-1);
>  		close(fd);
>  		if (len < 0)
> -			return NULL;
> +			goto fail;
>  		while (len && isspace(buffer[len-1]))
>  			len--;
>  		buffer[len] =3D '\0';
> @@ -1424,9 +1430,10 @@ const char *resolve_ref_unsafe(const char *ref=
name, unsigned char *sha1, int rea
>  			    (buffer[40] !=3D '\0' && !isspace(buffer[40]))) {
>  				if (flag)
>  					*flag |=3D REF_ISBROKEN;
> -				return NULL;
> +				goto fail;
>  			}
> -			return refname;
> +			ret =3D refname;
> +			goto done;
>  		}
>  		if (flag)
>  			*flag |=3D REF_ISSYMREF;
> @@ -1436,10 +1443,15 @@ const char *resolve_ref_unsafe(const char *re=
fname, unsigned char *sha1, int rea
>  		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
>  			if (flag)
>  				*flag |=3D REF_ISBROKEN;
> -			return NULL;
> +			goto fail;
>  		}
>  		refname =3D strcpy(refname_buffer, buf);
>  	}
> +fail:
> +	ret =3D NULL;
> +done:
> +	strbuf_release(&sb_path);
> +	return ret;
>  }
> =20
>  char *resolve_refdup(const char *ref, unsigned char *sha1, int readi=
ng, int *flag)
> @@ -2717,41 +2729,41 @@ static int copy_msg(char *buf, const char *ms=
g)
>  	return cp - buf;
>  }
> =20
> -int log_ref_setup(const char *refname, char *logfile, int bufsize)
> +int log_ref_setup(const char *refname, struct strbuf *logfile)
>  {
>  	int logfd, oflags =3D O_APPEND | O_WRONLY;
> =20
> -	git_snpath(logfile, bufsize, "logs/%s", refname);
> +	strbuf_git_path(logfile, "logs/%s", refname);
>  	if (log_all_ref_updates &&
>  	    (starts_with(refname, "refs/heads/") ||
>  	     starts_with(refname, "refs/remotes/") ||
>  	     starts_with(refname, "refs/notes/") ||
>  	     !strcmp(refname, "HEAD"))) {
> -		if (safe_create_leading_directories(logfile) < 0)
> +		if (safe_create_leading_directories(logfile->buf) < 0)
>  			return error("unable to create directory for %s",
> -				     logfile);
> +				     logfile->buf);
>  		oflags |=3D O_CREAT;
>  	}
> =20
> -	logfd =3D open(logfile, oflags, 0666);
> +	logfd =3D open(logfile->buf, oflags, 0666);
>  	if (logfd < 0) {
>  		if (!(oflags & O_CREAT) && errno =3D=3D ENOENT)
>  			return 0;
> =20
>  		if ((oflags & O_CREAT) && errno =3D=3D EISDIR) {
> -			if (remove_empty_directories(logfile)) {
> +			if (remove_empty_directories(logfile->buf)) {
>  				return error("There are still logs under '%s'",
> -					     logfile);
> +					     logfile->buf);
>  			}
> -			logfd =3D open(logfile, oflags, 0666);
> +			logfd =3D open(logfile->buf, oflags, 0666);
>  		}
> =20
>  		if (logfd < 0)
>  			return error("Unable to append to %s: %s",
> -				     logfile, strerror(errno));
> +				     logfile->buf, strerror(errno));
>  	}
> =20
> -	adjust_shared_perm(logfile);
> +	adjust_shared_perm(logfile->buf);
>  	close(logfd);
>  	return 0;
>  }
> @@ -2762,20 +2774,22 @@ static int log_ref_write(const char *refname,=
 const unsigned char *old_sha1,
>  	int logfd, result, written, oflags =3D O_APPEND | O_WRONLY;
>  	unsigned maxlen, len;
>  	int msglen;
> -	char log_file[PATH_MAX];
> +	struct strbuf sb_log_file =3D STRBUF_INIT;
> +	const char *log_file;
>  	char *logrec;
>  	const char *committer;
> =20
>  	if (log_all_ref_updates < 0)
>  		log_all_ref_updates =3D !is_bare_repository();
> =20
> -	result =3D log_ref_setup(refname, log_file, sizeof(log_file));
> +	result =3D log_ref_setup(refname, &sb_log_file);
>  	if (result)
> -		return result;
> +		goto done;
> +	log_file =3D sb_log_file.buf;
> =20
>  	logfd =3D open(log_file, oflags);
>  	if (logfd < 0)
> -		return 0;
> +		goto done;
>  	msglen =3D msg ? strlen(msg) : 0;
>  	committer =3D git_committer_info(0);
>  	maxlen =3D strlen(committer) + msglen + 100;
> @@ -2788,9 +2802,13 @@ static int log_ref_write(const char *refname, =
const unsigned char *old_sha1,
>  		len +=3D copy_msg(logrec + len - 1, msg) - 1;
>  	written =3D len <=3D maxlen ? write_in_full(logfd, logrec, len) : -=
1;
>  	free(logrec);
> -	if (close(logfd) !=3D 0 || written !=3D len)
> -		return error("Unable to append to %s", log_file);
> -	return 0;
> +	if (close(logfd) !=3D 0 || written !=3D len) {
> +		error("Unable to append to %s", log_file);
> +		result =3D -1;
> +	}
> +done:
> +	strbuf_release(&sb_log_file);
> +	return result;
>  }
> =20
>  static int is_branch(const char *refname)
> diff --git a/refs.h b/refs.h
> index 87a1a79..783033a 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -166,7 +166,7 @@ extern void unlock_ref(struct ref_lock *lock);
>  extern int write_ref_sha1(struct ref_lock *lock, const unsigned char=
 *sha1, const char *msg);
> =20
>  /** Setup reflog before using. **/
> -int log_ref_setup(const char *ref_name, char *logfile, int bufsize);
> +int log_ref_setup(const char *ref_name, struct strbuf *logfile);
> =20
>  /** Reads log for the value of ref during at_time. **/
>  extern int read_ref_at(const char *refname, unsigned long at_time, i=
nt cnt,
