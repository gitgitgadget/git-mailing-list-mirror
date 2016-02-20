From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 25/27] refs: add LMDB refs storage backend
Date: Sat, 20 Feb 2016 09:58:27 +0700
Message-ID: <20160220025826.GA9338@lanh>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
 <1455772670-21142-26-git-send-email-dturner@twopensource.com>
 <20160218085023.GA30049@lanh>
 <1455922186.7528.97.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>, mhagger@alum.mit.edu,
	Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 03:58:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWxkH-0007zm-DY
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 03:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1428410AbcBTC6F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2016 21:58:05 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33615 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1428308AbcBTC6B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 21:58:01 -0500
Received: by mail-pf0-f174.google.com with SMTP id q63so60903167pfb.0
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 18:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6ODze3vc6E/xDNQC58PLwIIy/fk4ZHarbNaXYp/jKHk=;
        b=WCYB/2mtyiefZY8CP8Czv0YJPjUPPsP/WTy/kPqtoiKSb44bdUkArmC5Q+PIM34OVM
         B0xvlRm9bKqwI+byQBDlZQHTCplx3AAHow1aUhrbOKuEJ8e6yCK7zYONr37DTOaZNgZp
         6nHy8WFJVpRyElp5em1AFANdAFl6WEAbnVlHTlEcdPC0o8YCteAWJiv2qNFEaEf9AC4M
         SdPMdHU5xy3107jRXRY+9oXFwUk15AfVt4aRPKzLw1VXb/y+9HPpWFNRuiigIxIQs3jx
         /qawNjiPRNOIzuoOsUxNzN0j0vkaVUEmj0bBzJDtFJqvV7lktdhxA74HCzMz9LF2N3Jp
         SlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6ODze3vc6E/xDNQC58PLwIIy/fk4ZHarbNaXYp/jKHk=;
        b=K5q+zReMvIU4hNwzws1rxZi+zD8Hn+NHp+HQqIOdrcVndHQtKT2mYs3XcpmbH3poYp
         DvW4443DJ2pxlcacw7MVP1aIdiSBgJgT2PWXR5LeuBxXD5lc3fZFormUq4ms/kH3jvAt
         SJPG9XjlR8JQVqY/eRxNoPZtzrifzeNkGj1SUTS6T/guLJ5O9lxsRexwb0U4WMPbf62Z
         RT7cQStR7RduDFAA+jVVx2h31dYeCj+aQpOaS50E56ou1yhdjJR+34udnD7ZCsAlKdif
         bOvNFczYrvKPhojWwxnIpgNgPgx3+bySugaWzKPr3iqsOhZJYyMsWTWE7fl5Q1Cv7wqT
         XB3g==
X-Gm-Message-State: AG10YOTi5KjgdkqejfdH2RGpz7ZwMbwT4ik5JvhtEmWo/OmKypnoHSDFC1hMtiwUKL2h2g==
X-Received: by 10.98.0.194 with SMTP id 185mr22583225pfa.139.1455937081525;
        Fri, 19 Feb 2016 18:58:01 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id e79sm20613119pfb.76.2016.02.19.18.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Feb 2016 18:57:59 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 20 Feb 2016 09:58:27 +0700
Content-Disposition: inline
In-Reply-To: <1455922186.7528.97.camel@twopensource.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286764>

> On Fri, 2016-02-19 at 09:54 +0700, Duy Nguyen wrote:
>> On Fri, Feb 19, 2016 at 3:23 AM, David Turner <
>> dturner@twopensource.com> wrote:
>> > > > +static int read_per_worktree_ref(const char *submodule, const
>> > > > char
>> > > > *refname,
>> > > > +                            struct MDB_val *val, int
>> > > > *needs_free)
>> > >
>> > > From what I read, I suspect these _per_worktree functions will b=
e
>> > > identical for the next backend. Should we just hand over the job
>> > > for
>> > > files backend? For all entry points that may deal with per
>> > > -worktree
>> > > refs, e.g. lmdb_resolve_ref_unsafe, can we check ref_type() firs=
t
>> > > thing, if it's per-worktree we call
>> > > refs_be_files.resolve_ref_unsafe()
>> > > instead?  It could even be done at frontend level,
>> > > e.g. refs.c:resolve_ref_unsafe().
>> > >
>> > > Though I may be talking rubbish here because I don't know how
>> > > whether
>> > > it has anything to do with transactions.
>> >
>> > The reason I did it this way is that some ref chains cross backend
>> > boundaries (e.g. HEAD -> refs/heads/master).  But if we have other
>> > backends later, we could generalize.
>>
>> Crossing backends should go through frontend again, imo. But I don't
>> really know if it's efficient.
>
> It's pretty tricky to maintain state (e.g. count of symref redirects)
> across that barrier.  So I'm not sure how to do it cleanly.

I notice files backend does pretty much the same thing. "files"
backend looks more like two backends combined in one, one is files,
the other is packed-refs. And it looks like we could solve it by
providing a lower level api, read_raw_ref() or something, that
retrieves the ref without any validation or link following. More on
this later.

>> > > I'm not sure I get this comment. D/F conflicts are no longer a
>> > > thing
>> > > for lmdb backend, right?
>> >
>> > I'm trying to avoid the lmdb backend creating a set of refs that
>> > the
>> > files backend can't handle.  This would make collaboration with
>> > other
>> > versions of git more difficult.
>>
>> It already is. If you create refs "foo" and "FOO" on case sensitive
>> file system and clone it on a case-insensitive one, you face the sam=
e
>> problem. We may have an optional configuration knob to prevent
>> incompatibilities with files backend, but I think that should be don=
e
>> (and enforced if necessary) outside backends.
>
> Sure, the current state isn't perfect, but why make it worse?

I see it from a different angle. The current state isn't perfect, but
we will be moving to a better future where "files" backend may
eventually be deprecated. Why hold back?

But this line of reasoning only works if we have a new backend capable
of replacing "files" without regressions or introducing new
dependency. Which is why I suggest a new backend [1] (or implement
Shawn's RefTree if it's proven as good with small repos)

I have no problem if you want to stay strictly compatible with "files"
though.

[1] http://thread.gmane.org/gmane.comp.version-control.git/285893/focus=
=3D286654

On Fri, Feb 19, 2016 at 05:49:46PM -0500, David Turner wrote:
> >=20
> > This code looks a lot like near the end of resolve_ref_1(). Maybe w=
e
> > could share the code in refs/backend-common.c or something and call
> > here instead?
>=20
> Something like the following?
>=20
> commit aad6b84fd1869f6e1cf6ed15bcece0c2f6429e9d
> Author: David Turner <dturner@twopensource.com>
> Date:   Thu Feb 18 17:09:29 2016 -0500
>=20
>     refs: break out some functions from resolve_ref_1
>    =20
>     A bunch of resolve_ref_1 is not backend-specific, so we can
>     break it out into separate internal functions that other
>     backends can use.
=2E..
>=20
> I'm not sure I like it, because it breaks out these weird tiny
> functions that take a lot of arguments.  But maybe it's worth it?  Wh=
at
> do you think?

OK how about we keep resolve_ref_1() whole and split real backend code
out? Something like these three patches (only built, did not test). A
bit ugly with continue_symlink, but it's just demonstration.

commit ef46fcdc62ef89fd5260ca054cd1d98f9f2d7c2b
Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date:   Sat Feb 20 09:18:45 2016 +0700

    refs/files: move ref I/O code out of resolve_refs_1()

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4bddfb3..f54f2ae 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1407,6 +1407,95 @@ static int resolve_missing_loose_ref(const char =
*refname,
 	}
 }
=20
+static const char *continue_normal_ref =3D "read_ref returns a normal =
ref";
+static const char *continue_symlink =3D "read_ref returns a symlink";
+
+/*
+ * Read a ref from backend. Returning any values except
+ * continue_normal_ref or continue_symlink ends resolve_ref_1()
+ * execution. If the return value is not NULL, sha1 and flags must be
+ * updated correctly. except REF_ISBROKEN which is set by
+ * resolve_ref_1().
+ *
+ * If continue_* is returned, sb_contents must contain the ref data.
+ */
+static const char *parse_ref(const char *refname,
+			     int resolve_flags,
+			     unsigned char *sha1,
+			     int *flags,
+			     struct strbuf *sb_path,
+			     struct strbuf *sb_contents)
+{
+	const char *path;
+	struct stat st;
+	int fd;
+
+	strbuf_reset(sb_path);
+	strbuf_git_path(sb_path, "%s", refname);
+	path =3D sb_path->buf;
+
+	/*
+	 * We might have to loop back here to avoid a race
+	 * condition: first we lstat() the file, then we try
+	 * to read it as a link or as a file.  But if somebody
+	 * changes the type of the file (file <-> directory
+	 * <-> symlink) between the lstat() and reading, then
+	 * we don't want to report that as an error but rather
+	 * try again starting with the lstat().
+	 */
+stat_ref:
+	if (lstat(path, &st) < 0) {
+		if (errno !=3D ENOENT)
+			return NULL;
+		if (resolve_missing_loose_ref(refname, resolve_flags,
+					      sha1, flags))
+			return NULL;
+		return refname;
+	}
+
+	/* Follow "normalized" - ie "refs/.." symlinks by hand */
+	if (S_ISLNK(st.st_mode)) {
+		strbuf_reset(sb_contents);
+		if (strbuf_readlink(sb_contents, path, 0) < 0) {
+			if (errno =3D=3D ENOENT || errno =3D=3D EINVAL)
+				/* inconsistent with lstat; retry */
+				goto stat_ref;
+			else
+				return NULL;
+		}
+		return continue_symlink;
+	}
+
+	/* Is it a directory? */
+	if (S_ISDIR(st.st_mode)) {
+		errno =3D EISDIR;
+		return NULL;
+	}
+
+	/*
+	 * Anything else, just open it and try to use it as
+	 * a ref
+	 */
+	fd =3D open(path, O_RDONLY);
+	if (fd < 0) {
+		if (errno =3D=3D ENOENT)
+			/* inconsistent with lstat; retry */
+			goto stat_ref;
+		else
+			return NULL;
+	}
+	strbuf_reset(sb_contents);
+	if (strbuf_read(sb_contents, fd, 256) < 0) {
+		int save_errno =3D errno;
+		close(fd);
+		errno =3D save_errno;
+		return NULL;
+	}
+	close(fd);
+
+	return continue_normal_ref;
+}
+
 /* This function needs to return a meaningful errno on failure */
 static const char *resolve_ref_1(const char *refname,
 				 int resolve_flags,
@@ -1442,54 +1531,18 @@ static const char *resolve_ref_1(const char *re=
fname,
 		bad_name =3D 1;
 	}
 	for (;;) {
-		const char *path;
-		struct stat st;
+		const char *ret;
 		char *buf;
-		int fd;
=20
 		if (--depth < 0) {
 			errno =3D ELOOP;
 			return NULL;
 		}
=20
-		strbuf_reset(sb_path);
-		strbuf_git_path(sb_path, "%s", refname);
-		path =3D sb_path->buf;
+		ret =3D parse_ref(refname, resolve_flags, sha1,
+				flags, sb_path, sb_contents);
=20
-		/*
-		 * We might have to loop back here to avoid a race
-		 * condition: first we lstat() the file, then we try
-		 * to read it as a link or as a file.  But if somebody
-		 * changes the type of the file (file <-> directory
-		 * <-> symlink) between the lstat() and reading, then
-		 * we don't want to report that as an error but rather
-		 * try again starting with the lstat().
-		 */
-	stat_ref:
-		if (lstat(path, &st) < 0) {
-			if (errno !=3D ENOENT)
-				return NULL;
-			if (resolve_missing_loose_ref(refname, resolve_flags,
-						      sha1, flags))
-				return NULL;
-			if (bad_name) {
-				hashclr(sha1);
-				if (flags)
-					*flags |=3D REF_ISBROKEN;
-			}
-			return refname;
-		}
-
-		/* Follow "normalized" - ie "refs/.." symlinks by hand */
-		if (S_ISLNK(st.st_mode)) {
-			strbuf_reset(sb_contents);
-			if (strbuf_readlink(sb_contents, path, 0) < 0) {
-				if (errno =3D=3D ENOENT || errno =3D=3D EINVAL)
-					/* inconsistent with lstat; retry */
-					goto stat_ref;
-				else
-					return NULL;
-			}
+		if (ret =3D=3D continue_symlink) {
 			if (starts_with(sb_contents->buf, "refs/") &&
 			    !check_refname_format(sb_contents->buf, 0)) {
 				strbuf_swap(sb_refname, sb_contents);
@@ -1502,35 +1555,10 @@ static const char *resolve_ref_1(const char *re=
fname,
 				}
 				continue;
 			}
-		}
-
-		/* Is it a directory? */
-		if (S_ISDIR(st.st_mode)) {
-			errno =3D EISDIR;
-			return NULL;
-		}
-
-		/*
-		 * Anything else, just open it and try to use it as
-		 * a ref
-		 */
-		fd =3D open(path, O_RDONLY);
-		if (fd < 0) {
-			if (errno =3D=3D ENOENT)
-				/* inconsistent with lstat; retry */
-				goto stat_ref;
-			else
-				return NULL;
-		}
-		strbuf_reset(sb_contents);
-		if (strbuf_read(sb_contents, fd, 256) < 0) {
-			int save_errno =3D errno;
-			close(fd);
-			errno =3D save_errno;
-			return NULL;
-		}
-		close(fd);
-		strbuf_rtrim(sb_contents);
+		} else if (ret =3D=3D refname)
+			break;
+		else if (ret !=3D continue_normal_ref)
+			return ret;
=20
 		/*
 		 * Is it a symbolic ref?
@@ -1547,12 +1575,7 @@ static const char *resolve_ref_1(const char *ref=
name,
 				errno =3D EINVAL;
 				return NULL;
 			}
-			if (bad_name) {
-				hashclr(sha1);
-				if (flags)
-					*flags |=3D REF_ISBROKEN;
-			}
-			return refname;
+			break;
 		}
 		if (flags)
 			*flags |=3D REF_ISSYMREF;
@@ -1578,6 +1601,13 @@ static const char *resolve_ref_1(const char *ref=
name,
 			bad_name =3D 1;
 		}
 	}
+
+	if (bad_name) {
+		hashclr(sha1);
+		if (flags)
+			*flags |=3D REF_ISBROKEN;
+	}
+	return refname;
 }
=20
 static const char *files_resolve_ref_unsafe(const char *refname,

After this resolve_ref_1() is backend independent. So we can make it
take parse_ref() as a function pointer instead.

commit 50d96b6f79b30b5ba17fa00ec3ee42845546a123
Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date:   Sat Feb 20 09:22:03 2016 +0700

    refs/files-backend.c: let resolve_refs_1() accept parse_ref as call=
back

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f54f2ae..9b4de9f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1424,7 +1424,8 @@ static const char *parse_ref(const char *refname,
 			     unsigned char *sha1,
 			     int *flags,
 			     struct strbuf *sb_path,
-			     struct strbuf *sb_contents)
+			     struct strbuf *sb_contents,
+			     void *cb_data)
 {
 	const char *path;
 	struct stat st;
@@ -1497,13 +1498,21 @@ stat_ref:
 }
=20
 /* This function needs to return a meaningful errno on failure */
-static const char *resolve_ref_1(const char *refname,
-				 int resolve_flags,
-				 unsigned char *sha1,
-				 int *flags,
-				 struct strbuf *sb_refname,
-				 struct strbuf *sb_path,
-				 struct strbuf *sb_contents)
+const char *resolve_ref_1(const char *refname,
+			  int resolve_flags,
+			  unsigned char *sha1,
+			  int *flags,
+			  struct strbuf *sb_refname,
+			  struct strbuf *sb_path,
+			  struct strbuf *sb_contents,
+			  const char *(*parse_ref)(const char *refname,
+						   int resolve_flags,
+						   unsigned char *sha1,
+						   int *flags,
+						   struct strbuf *sb_path,
+						   struct strbuf *sb_contents,
+						   void *cb_data),
+			  void *cb_data)
 {
 	int depth =3D MAXDEPTH;
 	int bad_name =3D 0;
@@ -1540,7 +1549,8 @@ static const char *resolve_ref_1(const char *refn=
ame,
 		}
=20
 		ret =3D parse_ref(refname, resolve_flags, sha1,
-				flags, sb_path, sb_contents);
+				flags, sb_path, sb_contents,
+				cb_data);
=20
 		if (ret =3D=3D continue_symlink) {
 			if (starts_with(sb_contents->buf, "refs/") &&
@@ -1621,7 +1631,8 @@ static const char *files_resolve_ref_unsafe(const=
 char *refname,
 	const char *ret;
=20
 	ret =3D resolve_ref_1(refname, resolve_flags, sha1, flags,
-			    &sb_refname, &sb_path, &sb_contents);
+			    &sb_refname, &sb_path, &sb_contents,
+			    parse_ref, NULL);
 	strbuf_release(&sb_path);
 	strbuf_release(&sb_contents);
 	return ret;

And finally we can make lmdb use resolve_ref_1(). lmdb-specific code
is in the new retrieve_ref() function.

commit 62a5df3117c0f825bc26fd09dda29e713f94d743 (HEAD -> lmdb)
Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date:   Sat Feb 20 09:33:01 2016 +0700

    refs/lmdb-backend: use resolve_ref_1()

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9b4de9f..44b7136 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1407,7 +1407,7 @@ static int resolve_missing_loose_ref(const char *=
refname,
 	}
 }
=20
-static const char *continue_normal_ref =3D "read_ref returns a normal =
ref";
+const char *continue_normal_ref =3D "read_ref returns a normal ref";
 static const char *continue_symlink =3D "read_ref returns a symlink";
=20
 /*
diff --git a/refs/lmdb-backend.c b/refs/lmdb-backend.c
index 6c0d7fb..7f169bd 100644
--- a/refs/lmdb-backend.c
+++ b/refs/lmdb-backend.c
@@ -544,74 +544,64 @@ done:
 	return ret;
 }
=20
+extern const char *continue_normal_ref;
+
+static const char *retrieve_ref(const char *refname,
+				int resolve_flags,
+				unsigned char *sha1,
+				int *flags,
+				struct strbuf *sb_path,
+				struct strbuf *sb_contents,
+				void *cb_data)
+{
+	struct lmdb_transaction *transaction =3D cb_data;
+	MDB_val key, val;
+	int needs_free;		/* dont care, leak */
+
+	key.mv_data =3D (void *)refname;
+	key.mv_size =3D strlen(refname) + 1;
+
+	val.mv_data =3D NULL;
+	val.mv_size =3D 0;
+
+	if (mdb_get_or_die(transaction, &key, &val, &needs_free)) {
+		struct strbuf err =3D STRBUF_INIT;
+
+		if (resolve_flags & RESOLVE_REF_READING)
+			return NULL;
+
+		if (verify_refname_available_txn(transaction,
+						 refname, NULL, NULL, &err)) {
+			error("%s", err.buf);
+			strbuf_release(&err);
+			return NULL;
+		}
+
+		hashclr(sha1);
+		return refname;
+	}
+
+	strbuf_reset(sb_contents);
+	strbuf_add(sb_contents, val.mv_data, val.mv_size);
+	return continue_normal_ref;
+}
+
 static const char *resolve_ref_unsafe_txn(struct lmdb_transaction *tra=
nsaction,
 					  const char *refname,
 					  int resolve_flags,
 					  unsigned char *sha1,
 					  int *flags)
 {
-	int bad_name =3D 0;
-	char *ref_data;
-	struct MDB_val key, val;
-	struct strbuf err =3D STRBUF_INIT;
-	int needs_free =3D 0;
+	static struct strbuf sb_refname =3D STRBUF_INIT;
+	struct strbuf sb_contents =3D STRBUF_INIT;
+	struct strbuf sb_path =3D STRBUF_INIT;
 	const char *ret;
=20
-	val.mv_size =3D 0;
-	val.mv_data =3D NULL;
-
-	if (flags)
-		*flags =3D 0;
-
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		if (flags)
-			*flags |=3D REF_BAD_NAME;
-
-		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
-		    !refname_is_safe(refname)) {
-			errno =3D EINVAL;
-			return NULL;
-		}
-		/*
-		 * dwim_ref() uses REF_ISBROKEN to distinguish between
-		 * missing refs and refs that were present but invalid,
-		 * to complain about the latter to stderr.
-		 *
-		 * We don't know whether the ref exists, so don't set
-		 * REF_ISBROKEN yet.
-		 */
-		bad_name =3D 1;
-	}
-
-	key.mv_data =3D (void *)refname;
-	key.mv_size =3D strlen(refname) + 1;
-	if (mdb_get_or_die(transaction, &key, &val, &needs_free)) {
-		if (bad_name) {
-			hashclr(sha1);
-			if (flags)
-				*flags |=3D REF_ISBROKEN;
-		}
-
-		if (resolve_flags & RESOLVE_REF_READING)
-			return NULL;
-
-		if (verify_refname_available_txn(transaction, refname, NULL, NULL, &=
err)) {
-			error("%s", err.buf);
-			strbuf_release(&err);
-			return NULL;
-		}
-
-		hashclr(sha1);
-		return refname;
-	}
-
-	ref_data =3D val.mv_data;
-	assert(ref_data[val.mv_size - 1] =3D=3D 0);
-
-	ret =3D parse_ref_data(transaction, refname, ref_data, sha1,
-			     resolve_flags, flags, bad_name);
-	if (needs_free)
-		free(ref_data);
+	ret =3D resolve_ref_1(refname, resolve_flags, sha1, flags,
+			    &sb_refname, &sb_path, &sb_contents,
+			    retrieve_ref, transaction);
+	strbuf_release(&sb_path);
+	strbuf_release(&sb_contents);
 	return ret;
 }=20

lmdb-backend.c:retrieve_ref(), files-backend.c:parse_ref() can be made
part of ref api that, given a ref name, returns the ref raw data and
type. The frontend can decide what backend callback to use based on
refname, so retrieve_ref() in the end does not have to call
read_per_worktree_ref() internally anymore.

Hmm?
--
Duy
