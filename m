From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 07/10] checkout: add -S to update sparse checkout
Date: Mon, 15 Nov 2010 15:16:36 -0600
Message-ID: <20101115211636.GH16385@burratino>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 22:17:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI6QX-000617-IX
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 22:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933784Ab0KOVRQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 16:17:16 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44766 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933054Ab0KOVRO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 16:17:14 -0500
Received: by fxm6 with SMTP id 6so2154976fxm.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 13:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=AMujkb4UqbATTmTWWNf2O3NZl5sRR3nyRrZknsHpEjM=;
        b=gSC9VPMlJaOMKyaDAMNDWUGZa/6Jx9oVOsOwfVmSgOHNhSFS8BUEEgg6cjNlGaFBgw
         usDwv9ioXlvb76SMmQZosnn3KZ7GRVBcR/cGs5HelVHrClFQ+yvvxyY+0jRym8RPQkoN
         TFxD2knDZcV4MgN3+JqVYjl0T4aGecZOsFgZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Y40dVgpFsgcPCN+h9Hf1XWz0OGbTUGG117IVQc0lVYw7Oj2jh6b2x1FtZY1BY0PeP9
         LKplW7RxjIQLizvyxF6SkhlidCmJJfvYDhp5VCvNZ0yYgBgxo6LrUQmDIOfjD5Y7Srzv
         8IxiOWNHyLCrIwPl2j90QtOHHX+K73j1+t/JI=
Received: by 10.223.122.146 with SMTP id l18mr5147897far.102.1289855833090;
        Mon, 15 Nov 2010 13:17:13 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id b20sm1054395fab.35.2010.11.15.13.17.09
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 13:17:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289817410-32470-8-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161514>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -12,6 +12,7 @@ SYNOPSIS
>  'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<star=
t_point>]
>  'git checkout' [-f|--ours|--theirs|-m|--conflict=3D<style>] [<tree-i=
sh>] [--] <paths>...
>  'git checkout' --patch [<tree-ish>] [--] [<paths>...]
> +'git checkout' -S
> =20
>  DESCRIPTION
>  -----------
> @@ -176,6 +177,13 @@ the conflicted merge in the specified paths.
>  This means that you can use `git checkout -p` to selectively discard
>  edits from your current working tree.
> =20
> +-S::
> +--update-sparse-checkout::
> +	An editor is invoked to let you update your sparse checkout
> +	patterns. The updated patterns will be saved in
> +	$GIT_DIR/info/sparse-checkout. The working directory is also
> +	updated. An empty file will abort the process.

Wording nit: this doesn't make the worktree more up-to-date.  How
about:

 --edit-sparse-checkout
 --define-work-area
 --narrow-worktree

Hmph.

--edit-sparse-checkout seems best for consistency of the choices I can
think of.

[...]
> @@ -316,6 +324,14 @@ $ git add frotz
>  ------------
> =20
> =20
> +ENVIRONMENT AND CONFIGURATION VARIABLES
> +---------------------------------------
> +The editor used to edit the commit log message will be chosen from t=
he
                                 ^
  patterns defining what subset of the tracked tree to work on

> +GIT_EDITOR environment variable, the core.editor configuration varia=
ble, the

Might be simpler to say:

 CONFIGURATION
 -------------
 --edit-sparse-checkout uses the configured editor.  See git-var(1) for
 details.

[...]
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -675,6 +675,31 @@ static const char *unique_tracking_name(const ch=
ar *name)
>  	return NULL;
>  }
> =20
> +static void edit_info_sparse_checkout()
> +{
> +	char *tmpfile =3D xstrdup(git_path("sparse-checkout"));

git_pathdup()?

> +	struct exclude_list el;
> +	int i;
> +
> +	copy_file(tmpfile, git_path("info/sparse-checkout"), 0666);
> +
> +	if (launch_editor(tmpfile, NULL, NULL))
> +		exit(1);
> +
> +	memset(&el, 0, sizeof(el));
> +	if (add_excludes_from_file_to_list(tmpfile, "", 0, NULL, &el, 0) < =
0 ||
> +	    el.nr =3D=3D 0)
> +		die("No valid sparse patterns. Abort.");

Perhaps the error message should mention the temp file.

> +	for (i =3D 0; i < el.nr; i++)
> +		free(el.excludes[i]);
> +	free(el.excludes);

Neat.

> +
> +	if (rename(tmpfile, git_path("info/sparse-checkout")) < 0)
> +		die_errno("Can't update %s", git_path("info/sparse-checkout"));

Wouldn't git_path() clobber errno?  Probably worth keeping a temporary
with the result from git_path before the rename.

> +
> +	free(tmpfile);
> +}
> +
>  int cmd_checkout(int argc, const char **argv, const char *prefix)
>  {
>  	struct checkout_opts opts;
> @@ -685,6 +710,7 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
>  	char *conflict_style =3D NULL;
>  	int patch_mode =3D 0;
>  	int dwim_new_local_branch =3D 1;
> +	int update_sparse_checkout =3D 0;
>  	struct option options[] =3D {
>  		OPT__QUIET(&opts.quiet),
>  		OPT_STRING('b', NULL, &opts.new_branch, "branch",
> @@ -704,6 +730,8 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
>  		OPT_STRING(0, "conflict", &conflict_style, "style",
>  			   "conflict style (merge or diff3)"),
>  		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively=
"),
> +		OPT_BOOLEAN('S', "update-sparse-checkout", &update_sparse_checkout=
,
> +			    "open up editor to edit $GIT_DIR/info/sparse-checkout" ),
>  		{ OPTION_BOOLEAN, 0, "guess", &dwim_new_local_branch, NULL,
>  		  "second guess 'git checkout no-such-branch'",
>  		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
> @@ -722,6 +750,9 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
>  	argc =3D parse_options(argc, argv, prefix, options, checkout_usage,
>  			     PARSE_OPT_KEEP_DASHDASH);
> =20
> +	if (update_sparse_checkout && !core_apply_sparse_checkout)
> +		die("core.sparseCheckout needs to be turned on");

--%s requires core.sparsecheckout to be turned out

> +
>  	/* we can assume from now on new_branch =3D !new_branch_force */
>  	if (opts.new_branch && opts.new_branch_force)
>  		die("-B cannot be used with -b");
> @@ -874,6 +905,9 @@ no_reference:
>  		if (!pathspec)
>  			die("invalid path specification");
> =20
> +		if (update_sparse_checkout)
> +			die("git checkout: update paths is incompatible with updating spa=
rse checkout.");
> +

"updating paths is incompatible", I think.

Maybe an area for future work. :)

> @@ -892,8 +926,11 @@ no_reference:
>  		return checkout_paths(source_tree, pathspec, &opts);
>  	}
> =20
> -	if (patch_mode)
> +	if (patch_mode) {
> +		if (update_sparse_checkout)
> +			die("git checkout: interactive checkout is incompatible with upda=
ting sparse checkout.");

Hmm, I'd put

	if (patch_mode && update_sparse_checkout)
		die(...

earlier as part of option validation.

[...]
> --- a/t/t1011-read-tree-sparse-checkout.sh
> +++ b/t/t1011-read-tree-sparse-checkout.sh
> @@ -184,4 +184,22 @@ test_expect_success 'read-tree --reset removes o=
utside worktree' '
>  	test_cmp empty result
>  '
> =20
> +test_expect_success 'git checkout -S fails to launch editor' '
> +	GIT_EDITOR=3D/non-existent test_must_fail git checkout -S &&

Exporting envvars via a function is non-portable.  The usual workaround=
:

	(
		GIT_EDITOR=3D... &&
		export  GIT_EDITOR &&
		test_must_fail ...
	) &&

Maybe it's time to introduce

	eval_must_fail GIT_EDITOR=3D/non-existent git checkout -S

?

[...]
> +test_expect_success 'git checkout -S' '
> +	git checkout -f top &&
> +	cat >editor.sh <<\EOF &&
> +#!/bin/sh
> +echo sub > "$1"
> +EOF

Style: the git test scripts usually omit the space after >.

> --- a/templates/info--sparse-checkout
> +++ b/templates/info--sparse-checkout
> @@ -1,3 +1,4 @@
>  # Specify what files are checked out in working directory
>  # Run "git checkout" after updating this file to update working dire=
ctory
> +# If this is opened by "git checkout -S", empty this file will abort=
 it.
>  *

Usage nits: s/if/when/; s/opened/edited/; s/will/to/; s/it//.

 # When editing with "git checkout -S", empty this file to abort.
