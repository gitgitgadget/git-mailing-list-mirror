From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/POC 2/7] Add new environment variable $GIT_SUPER_DIR
Date: Fri, 13 Dec 2013 10:12:45 -0800
Message-ID: <xmqqmwk4r55u.fsf@gitster.dls.corp.google.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
	<1386771333-32574-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 13 19:12:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrXEM-0005a4-TU
	for gcvg-git-2@plane.gmane.org; Fri, 13 Dec 2013 19:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255Ab3LMSMu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Dec 2013 13:12:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49313 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960Ab3LMSMt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Dec 2013 13:12:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6EB0562A2;
	Fri, 13 Dec 2013 13:12:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7jVlrQ7bhAAZ
	1fVQgvdMCH7uSS0=; b=l7+iC1H8585PsLIoXMxFsYe/tfzH+M6eTsBwt3Fblhgl
	FFqBCVo0sYpbXU7Ino/ivQW9QpY0BlRkG/Wa0I4WvZXhgAQadG0EUZkcFKs5+FA/
	9UVV8uhJ4qKtWoZp2ACEBJf5VJBbNHJqnbW9mDcgk/K9clYCf+UviY1XzBBqQXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TVod3m
	37EfUV6tqYwUa1CRqt3RVwhOQIa9qUobT3mOKa/Ypp7/jrSgjgzGWDLnrYR8Vpp0
	sLcxIDM8dxYwXLFEQwMFZCy/cqIOLaLDMR8TGsKJ9Briy8bomUjbIl/MP6mVQiXM
	SziKT0qEWysTO7RICR18SkA5hG13juZyG+zvU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C07D8562A0;
	Fri, 13 Dec 2013 13:12:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC75A5629F;
	Fri, 13 Dec 2013 13:12:47 -0500 (EST)
In-Reply-To: <1386771333-32574-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 11
 Dec 2013 21:15:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2BE1956A-6422-11E3-A39A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239261>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This is the base for git-new-workdir integration. The git-new-workdir
> script creates a separate worktree that shares everything except
> worktree-related stuff. The sharing is eanbled by this new env
> variable.
>
> In the new worktree, both variables are set at the same time, GIT_DIR
> and GIT_SUPER_DIR. Shared paths are checked at adjust_git_path() and
> rewritten to use $GIT_SUPER_DIR instead of $GIT_DIR. Let's call this
> "split-repo" setup to distinguish from $GIT_DIR-only one.
>
> The "ln -s" is avoided because Windows probably does not have the
> support, and symlinks don't survive operations that delete the old
> file, then create a new one.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  cache.h               |  2 ++
>  environment.c         | 11 +++++++--
>  path.c                | 10 ++++++++
>  t/t0060-path-utils.sh | 67 +++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  4 files changed, 88 insertions(+), 2 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index cdafbd7..823582f 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -347,6 +347,7 @@ static inline enum object_type object_type(unsign=
ed int mode)
> =20
>  /* Double-check local_repo_env below if you add to this list. */
>  #define GIT_DIR_ENVIRONMENT "GIT_DIR"
> +#define GIT_SUPER_DIR_ENVIRONMENT "GIT_SUPER_DIR"
>  #define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
>  #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
>  #define GIT_PREFIX_ENVIRONMENT "GIT_PREFIX"
> @@ -399,6 +400,7 @@ extern int is_inside_git_dir(void);
>  extern char *git_work_tree_cfg;
>  extern int is_inside_work_tree(void);
>  extern const char *get_git_dir(void);
> +extern const char *get_git_super_dir(void);
>  extern int is_git_directory(const char *path);
>  extern char *get_object_directory(void);
>  extern char *get_index_file(void);
> diff --git a/environment.c b/environment.c
> index 1d74dde..d5ae7a3 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -79,7 +79,7 @@ static char *work_tree;
>  static const char *namespace;
>  static size_t namespace_len;
> =20
> -static const char *git_dir;
> +static const char *git_dir, *git_super_dir;
>  static char *git_object_dir, *git_index_file, *git_graft_file;
>  int git_db_env, git_index_env, git_graft_env;
> =20
> @@ -131,10 +131,12 @@ static void setup_git_env(void)
>  		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
>  	gitfile =3D read_gitfile(git_dir);
>  	git_dir =3D xstrdup(gitfile ? gitfile : git_dir);
> +	git_super_dir =3D getenv(GIT_SUPER_DIR_ENVIRONMENT);
>  	git_object_dir =3D getenv(DB_ENVIRONMENT);
>  	if (!git_object_dir) {
>  		git_object_dir =3D xmalloc(strlen(git_dir) + 9);
> -		sprintf(git_object_dir, "%s/objects", git_dir);
> +		sprintf(git_object_dir, "%s/objects",
> +			git_super_dir ? git_super_dir : git_dir);
>  	} else
>  		git_db_env =3D 1;
>  	git_index_file =3D getenv(INDEX_ENVIRONMENT);
> @@ -167,6 +169,11 @@ const char *get_git_dir(void)
>  	return git_dir;
>  }
> =20
> +const char *get_git_super_dir(void)
> +{
> +	return git_super_dir;
> +}
> +
>  const char *get_git_namespace(void)
>  {
>  	if (!namespace)
> diff --git a/path.c b/path.c
> index eda9176..86a7c15 100644
> --- a/path.c
> +++ b/path.c
> @@ -75,6 +75,16 @@ static void adjust_git_path(char *buf, int git_dir=
_len)
>  		strcpy(buf, get_index_file());
>  	else if (git_db_env && dir_prefix(base, "objects"))
>  		replace_dir(buf, git_dir_len + 7, get_object_directory());
> +	else if (get_git_super_dir()) {
> +		if (dir_prefix(base, "objects") || dir_prefix(base, "info") ||
> +		    dir_prefix(base, "refs") ||
> +		    (dir_prefix(base, "logs") && strcmp(base, "logs/HEAD")) ||
> +		    dir_prefix(base, "rr-cache") || dir_prefix(base, "hooks") ||
> +		    dir_prefix(base, "svn") ||
> +		    !strcmp(base, "config") || !strcmp(base, "packed-refs") ||
> +		    !strcmp(base, "shallow"))
> +			replace_dir(buf, git_dir_len, get_git_super_dir());
> +	}

This is essentially the list of what are shared across workdirs,
right?  I wonder if it is a bad idea to make everything under .git
of the borrowed repository shared by default, with selected
exceptions.  Granted, not sharing by default is definitely safer
than blindly sharing by default, so that alone may be a good
argument to use a set of known-to-be-safe-to-share paths, like this
code does.

Don't we want .git/branches and .git/remotes shared?  After all,
their moral equivalents from .git/config are shared with the code.

The name "super" might need to be rethought, but getting the
mechanism and the semantics right is the more important first step,
and I think this is going in a good direction.
