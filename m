Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706A01E4A2
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 04:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709613001; cv=none; b=eyMtIH3ENmW8xSZJRqCFR66QJm8AgRtM4Wz66yxD6RHpaauK8sOACDiLwzbt5zf89WlFAO/WEhInGELvVno7OKg5qhqoxAj+XTX8NKFxisocUJmn0ciAlItPYHvospL8U0uibZpKtkmc5sDtAFzddzX2B1pHEl3tcZYA8lVp7bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709613001; c=relaxed/simple;
	bh=OwQJqKYjtnPzK9hdtzjloS40ucRh0vdmBpM0olQjnak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7quRAZo0DYMAYyOwBLI0U+WNfXS3zqInpCoJVkGE/oBPTk9NXoQ8Ju9IcDPgzqAq6+nMODCWhHCQkar9F/3Si4KQuqqivdfrlVHAVEaW2b4lUInreeg5Nqklrwv1Kg8RmPcnxijAC6u0fmQJgkVvNe1Dy3xoXnUV7RJcFH3Ssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42a0ba5098bso37574101cf.0
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 20:29:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709612998; x=1710217798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVp7ZBQxTbX2HXZcpTW+ONOFTORe9cosyn3cY0Z6lq0=;
        b=G8/QYoKWopZDwTRBlmlUfJqMdx7pdvEunUKW7eB79lpxJ0p/Ewzo8B6lWVKnfAfjMs
         XG5ibIe6n3RmjsKYdXh02UYpZUGoIbqpBvsY0wJ7JbUVp2m1zlZlY2Ev/ELadZOGtx5Z
         Ehv8l8o6OYvpX3Xfh3OPl28YeJgbkr9W7vioBBrMo9RbHRMZtLF95aBUK73fLgzmeNlZ
         +QOQIKhqYPYDeoeHL1k7ptvQ0Kb4O7RJnFRcbGiDpZFWY2IXL6OwmZzvOE0mIutI1wJr
         6ZkeyP21mSZ31Trh4ukB2Dsx7IOXrRT8cxkz6feoYC6XLorlh/OWOd0uYg9Ulv52lr2f
         DfnA==
X-Gm-Message-State: AOJu0YxX818ngTCugW3JRkBpL8ctqnp5A2j9h2z6NemDP+0MqIjN1gbD
	JT7RiawXJJ4J4Ugx4FOU7E6QWIYw65hkot2bfE69jDqkRpgaJGpF5kSmFHicZyDQ7v2e4bqvyAP
	wKoFjiiUvcLsW3TX2iqyKFobk27U=
X-Google-Smtp-Source: AGHT+IEJ+AeM1d8nwy5/uByjWX4PVqfGuzzG+uosRMkhG8qv55gy04wBY+e1arBUwRiIhRsNf0M1EhMoeIw7C3v5JJ0=
X-Received: by 2002:a05:622a:146:b0:42e:febb:8cf4 with SMTP id
 v6-20020a05622a014600b0042efebb8cf4mr963621qtw.42.1709612998270; Mon, 04 Mar
 2024 20:29:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305012112.1598053-2-atneya@google.com> <20240305012112.1598053-3-atneya@google.com>
In-Reply-To: <20240305012112.1598053-3-atneya@google.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 4 Mar 2024 23:29:46 -0500
Message-ID: <CAPig+cQvyScjiWe1ghFrv9B=v2+JxkkErdCyYFSA_8dTrWu60g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] Make read_gitfile and resolve_gitfile thread safe
To: Atneya Nair <atneya@google.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jeffhost@microsoft.com, 
	me@ttaylorr.com, nasamuffin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 8:22=E2=80=AFPM Atneya Nair <atneya@google.com> wrot=
e:
> Continue the work in commit: 3d7747e318532a36a263c61cdf92f2decb6424ff
> to remove unsafe shared buffer usage in read_gitfile_gently.
>
> Migrate read_gitfile_gently and resolve_gitfile_gently to take strbuf
> out params to allocate their return values into, rather than returning
> a view into a shared buffer.
>
> Leave the shared buffer in case a caller passes null for this param (for
> cases we haven't cleaned up yet).
>
> Migrate callers of resolve_gitfile to resolve_gitfile_gently.
>
> Signed-off-by: Atneya Nair <atneya@google.com>
> ---
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> @@ -198,11 +198,11 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
> -               const char *p;
> +               struct strbuf gitfile =3D STRBUF_INIT;
>
> -               p =3D read_gitfile_gently(git_dir, &err);
> -               if (p && get_common_dir(&sb, p)) {
> +               read_gitfile_gently(git_dir, &err, &gitfile);
> +               if (!err && get_common_dir(&sb, gitfile.buf)) {
>                         struct strbuf mainwt =3D STRBUF_INIT;

If you're going to adopt this idiom of checking `err` rather than the
return code of read_gitfile_gently(), then you should document that
`err` will be set to zero in the success case. Presently, the
documentation for read_gitfile_gently() only talks about the failure
case and doesn't mention that zero indicates success.

> diff --git a/setup.c b/setup.c
> @@ -830,7 +833,8 @@ void read_gitfile_error_die(int error_code, const cha=
r *path, const char *dir)
>  /*
>   * Try to read the location of the git directory from the .git file,
> - * return path to git directory if found. The return value comes from
> + * return path to git directory if found. If passed a valid strbuf, the =
return
> + * value is is a ptr to within the buffer. If strbuf is null, the return=
 value comes from
>   * a shared buffer.

What is "a valid strbuf"? Perhaps say instead "if `result_buf` is not
NULL, ...". The "is not NULL" wording is consistent with the existing
wording used below...

Also...
  s/is is/is/
  s/ptr/pointer/

>   * On failure, if return_error_code is not NULL, return_error_code

... "is not NULL" wording is already used here.

> @@ -848,7 +852,10 @@ const char *read_gitfile_gently(const char *path, in=
t *return_error_code)
> -       static struct strbuf realpath =3D STRBUF_INIT;
> +       static struct strbuf shared =3D STRBUF_INIT;
> +       if (!result_buf) {
> +               result_buf =3D &shared;
> +       }

Junio mentioned style violations in his response. Omit braces around
one line `if` bodies.

> @@ -900,8 +907,10 @@ const char *read_gitfile_gently(const char *path, in=
t *return_error_code)
> -       strbuf_realpath(&realpath, dir, 1);
> -       path =3D realpath.buf;
> +       strbuf_realpath(result_buf, dir, 1);
> +       path =3D result_buf->buf;

It's a minor thing, but if you name the function argument `realpath`,
then the diff becomes less noisy since changes such as these do not
need to be made. On the other hand, if `realpath` isn't a good output
variable name, then by all means choose a better name.

> @@ -1316,12 +1325,13 @@ static enum discovery_result setup_git_directory_=
gently_1(struct strbuf *dir,
> +               struct strbuf gitdirenvbuf =3D STRBUF_INIT;
>                 gitdirenv =3D read_gitfile_gently(dir->buf, die_on_error =
?
> -                                               NULL : &error_code);
> +                                               NULL : &error_code, &gitd=
irenvbuf);
>                 if (!gitdirenv) {
> @@ -1330,8 +1340,10 @@ static enum discovery_result setup_git_directory_g=
ently_1(struct strbuf *dir,
> -                       } else if (error_code !=3D READ_GITFILE_ERR_STAT_=
FAILED)
> +                       } else if (error_code !=3D READ_GITFILE_ERR_STAT_=
FAILED) {
> +                               strbuf_release(&gitdirenvbuf);
>                                 return GIT_DIR_INVALID_GITFILE;
> +                       }

Releasing the strbuf before `return`. Good.

> @@ -1365,9 +1377,10 @@ static enum discovery_result setup_git_directory_g=
ently_1(struct strbuf *dir,
>                         free(gitdir_path);
>                         free(gitfile);
> +                       strbuf_release(&gitdirenvbuf);
>                         return ret;

Likewise. Good.

>                 }
> +               strbuf_release(&gitdirenvbuf);
>
>                 if (is_git_directory(dir->buf)) {
>                         trace2_data_string("setup", NULL, "implicit-bare-=
repository", dir->buf);

There are additional `return` statements (not shown in the context)
following this code, but you make this final strbuf_release() call
before any of those other `return` statements can be taken. Good.

> diff --git a/submodule.c b/submodule.c
> @@ -316,9 +316,10 @@ int is_submodule_populated_gently(const char *path, =
int *return_error_code)
>         int ret =3D 0;
>         char *gitdir =3D xstrfmt("%s/.git", path);
>
> -       if (resolve_gitdir_gently(gitdir, return_error_code))
> +       struct strbuf resolved_gitdir_buf =3D STRBUF_INIT;
> +       if (resolve_gitdir_gently(gitdir, return_error_code, &resolved_gi=
tdir_buf))
>                 ret =3D 1;

Style: Declare `resolved_gitdir_buf` along with `ret` and `gitdir`,
then have a blank line before the actual code.

> @@ -1879,22 +1880,25 @@ unsigned is_submodule_modified(const char *path, =
int ignore_untracked)
> +       struct strbuf gitdirbuf =3D STRBUF_INIT;
> +               strbuf_release(&gitdirbuf);
>                 /* The submodule is not checked out, so it is not modifie=
d */
>                 return 0;
>         }
> +               strbuf_release(&gitdirbuf);
>         strbuf_reset(&buf);

Style: Strange indentation?

> @@ -1958,15 +1962,16 @@ int submodule_uses_gitfile(const char *path)
> -       const char *git_dir;
> +       struct strbuf gitfilebuf =3D STRBUF_INIT;
>
>         strbuf_addf(&buf, "%s/.git", path);
> -       git_dir =3D read_gitfile(buf.buf);
> -       if (!git_dir) {
> +       read_gitfile_gently(buf.buf, NULL, &gitfilebuf);
> +       if (!gitfilebuf.buf) {
>                 strbuf_release(&buf);
>                 return 0;
>         }

Not sure what you're trying to do here. strbuf guarantees that its
`buf` member will never be NULL, so the new `if (!gitfilebuf.buf)`
conditional seems to be dead code. If you really want to check whether
an error occurred, pass non-NULL for the second argument and check the
return value of read_gitfile_gently() or check the error code.

> diff --git a/worktree.c b/worktree.c
> @@ -685,7 +684,7 @@ void repair_worktree_at_path(const char *path,
> -       char *backlink =3D NULL;
> +       struct strbuf backlink =3D STRBUF_INIT;
> @@ -701,12 +700,12 @@ void repair_worktree_at_path(const char *path,
> -       backlink =3D xstrdup_or_null(read_gitfile_gently(realdotgit.buf, =
&err));
> +       read_gitfile_gently(realdotgit.buf, &err, &backlink);
>         if (err =3D=3D READ_GITFILE_ERR_NOT_A_FILE) {
>                 fn(1, realdotgit.buf, _("unable to locate repository; .gi=
t is not a file"), cb_data);
>                 goto done;
>         } else if (err =3D=3D READ_GITFILE_ERR_NOT_A_REPO) {
> -               if (!(backlink =3D infer_backlink(realdotgit.buf))) {
> +               if (!(backlink.buf =3D infer_backlink(realdotgit.buf))) {

Don't do this. Never modify the internal state of strbuf directly;
consider the state read-only. Modifications should only be made via
the API. You'll need to rewrite this code a bit to make it work
correctly with the changes proposed by this patch.
