From: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] submodule recursion in git-archive
Date: Tue, 26 Nov 2013 16:17:43 +0100
Message-ID: <5294BB97.7010707@web.de>
References: <2E636B58-47EB-4712-93CA-39E8D1BA3DB9@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Nick Townsend <nick.townsend@mac.com>, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 26 16:17:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlKOg-0003Ah-6C
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 16:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757137Ab3KZPRt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Nov 2013 10:17:49 -0500
Received: from mout.web.de ([212.227.17.11]:64405 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754390Ab3KZPRs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 10:17:48 -0500
Received: from [192.168.178.26] ([79.250.167.3]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LfAoO-1VIX1W2YHY-00okBw for <git@vger.kernel.org>;
 Tue, 26 Nov 2013 16:17:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <2E636B58-47EB-4712-93CA-39E8D1BA3DB9@mac.com>
X-Provags-ID: V03:K0:A+AD2FUI0Hf/Wyy4KHegBnvJiu8I8dcT/5XlmbjZuQjcLA2AnSM
 XTJReg46FBjaG5ZUbYhW16OJsdEAVxE3TLGhAcL0F4iZV7Sy699B8LanTyHN8tA1IDNWvjy
 Ep8wR8olgXYHW5vzHsPE4r5D7qxPRK1jtxGunDu/A1sS9mWX5z9uhnH1qKz8kAYW+yl5zdU
 junr2EmNZ9EiocFo7iQPA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238385>

Am 26.11.2013 01:04, schrieb Nick Townsend:
> My first git patch - so shout out if I=92ve got the etiquette wrong! =
Or
> of course if I=92ve missed something.

Thanks for the patches!  Please send only one per message (the second
one as a reply to the first one, or both as replies to a cover letter),
though -- that makes commenting on them much easier.

Side note: Documentation/SubmittingPatches doesn't mention that (yet),
AFAICS.

> Subject: [PATCH 1/2] submodule: add_submodule_odb() usability
>=20
> Although add_submodule_odb() is documented as being
> externally usable, it is declared static and also
> has incorrect documentation.
>=20
> This commit fixes those and makes no changes to
> existing code using them. All tests still pass.

Sign-off missing (see Documentation/SubmittingPatches).

> ---
>  Documentation/technical/api-ref-iteration.txt | 4 ++--
>  submodule.c                                   | 2 +-
>  submodule.h                                   | 1 +
>  3 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/technical/api-ref-iteration.txt b/Document=
ation/technical/api-ref-iteration.txt
> index aa1c50f..cbee624 100644
> --- a/Documentation/technical/api-ref-iteration.txt
> +++ b/Documentation/technical/api-ref-iteration.txt
> @@ -50,10 +50,10 @@ submodules object database. You can do this by a =
code-snippet like
>  this:
> =20
>  	const char *path =3D "path/to/submodule"
> -	if (!add_submodule_odb(path))
> +	if (add_submodule_odb(path))
>  		die("Error submodule '%s' not populated.", path);
> =20
> -`add_submodule_odb()` will return an non-zero value on success. If y=
ou
> +`add_submodule_odb()` will return a zero value on success. If you

"return zero on success" instead?

>  do not do this you will get an error for each ref that it does not p=
oint
>  to a valid object.
> =20
> diff --git a/submodule.c b/submodule.c
> index 1905d75..1ea46be 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -143,7 +143,7 @@ void stage_updated_gitmodules(void)
>  		die(_("staging updated .gitmodules failed"));
>  }
> =20
> -static int add_submodule_odb(const char *path)
> +int add_submodule_odb(const char *path)
>  {
>  	struct strbuf objects_directory =3D STRBUF_INIT;
>  	struct alternate_object_database *alt_odb;
> diff --git a/submodule.h b/submodule.h
> index 7beec48..3e3cdca 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -41,5 +41,6 @@ int find_unpushed_submodules(unsigned char new_sha1=
[20], const char *remotes_nam
>  		struct string_list *needs_pushing);
>  int push_unpushed_submodules(unsigned char new_sha1[20], const char =
*remotes_name);
>  void connect_work_tree_and_git_dir(const char *work_tree, const char=
 *git_dir);
> +int add_submodule_odb(const char *path);
> =20
>  #endif

> Subject: [PATCH 2/2] archive: allow submodule recursion on git-archiv=
e
>=20
> When using git-archive to produce a dump of a
> repository, the existing code does not recurse
> into a submodule when it encounters it in the tree
> traversal. These changes add a command line flag
> that permits this.
>=20
> Note that the submodules must be updated in the
> repository, otherwise this cannot take place.
>=20
> The feature is disabled for remote repositories as
> the git_work_tree fails. This is a possible future
> enhancement.

Hmm, curious.  Why does it fail?  I guess that happens with bare
repositories, only, right?  (Which are the most likely kind of remote
repos to encounter, of course.)

> Two additional fields are added to archiver_args:
>   * recurse  - a boolean indicator
>   * treepath - the path part of the tree-ish
>                eg. the 'www' in HEAD:www
>=20
> The latter is used within the archive writer to
> determin the correct path for the submodule .git
> file.
>=20
> Signed-off-by: Nick Townsend <nick.townsend@mac.com>
> ---
>  Documentation/git-archive.txt |  9 +++++++++
>  archive.c                     | 38 +++++++++++++++++++++++++++++++++=
+++--
>  archive.h                     |  2 ++
>  3 files changed, 47 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/git-archive.txt b/Documentation/git-archiv=
e.txt
> index b97aaab..b4df735 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -11,6 +11,7 @@ SYNOPSIS
>  [verse]
>  'git archive' [--format=3D<fmt>] [--list] [--prefix=3D<prefix>/] [<e=
xtra>]
>  	      [-o <file> | --output=3D<file>] [--worktree-attributes]
> +	      [--recursive|--recurse-submodules]

I'd expect git archive --recurse to add subdirectories and their
contents, which it does right now, and --no-recurse to only archive the
specified objects, which is not implemented.  IAW: I wouldn't normally
associate an option with that name with submodules.  Would
--recurse-submodules alone suffice?

Side note: With only one of the options defined you could shorten them
on the command line to e.g. --rec; with both you'd need to type at leas=
t
--recursi or --recurse to disambiguate -- even though they ultimately d=
o
the same.

>  	      [--remote=3D<repo> [--exec=3D<git-upload-archive>]] <tree-ish=
>
>  	      [<path>...]
> =20
> @@ -51,6 +52,14 @@ OPTIONS
>  --prefix=3D<prefix>/::
>  	Prepend <prefix>/ to each filename in the archive.
> =20
> +--recursive::
> +--recurse-submodules::
> +	Archive entries in submodules. Errors occur if the submodules
> +	have not been initialized and updated.
> +	Run `git submodule update --init --recursive` immediately after
> +	the clone is finished to avoid this.
> +	This option is not available with remote repositories.
> +
>  -o <file>::
>  --output=3D<file>::
>  	Write the archive to <file> instead of stdout.
> diff --git a/archive.c b/archive.c
> index 346f3b2..f6313c9 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -5,6 +5,7 @@
>  #include "archive.h"
>  #include "parse-options.h"
>  #include "unpack-trees.h"
> +#include "submodule.h"
> =20
>  static char const * const archive_usage[] =3D {
>  	N_("git archive [options] <tree-ish> [<path>...]"),
> @@ -131,13 +132,32 @@ static int write_archive_entry(const unsigned c=
har *sha1, const char *base,
>  		args->convert =3D ATTR_TRUE(check[1].value);
>  	}
> =20
> +	if (S_ISGITLINK(mode) && args->recurse) {
> +		const char *work_tree =3D get_git_work_tree();
> +		if (!work_tree) {
> +			  die("Can't go recursive when no work dir");
> +		}

Style nit: No curly braces around single-line statements, please.

Perhaps mention submodules in the error message?

It would be nicer to get_git_work_tree right after the parameters have
been parsed and before any archive contents have been written and error
out early.

> +		static struct strbuf dotgit =3D STRBUF_INIT;

We avoid declarations after statements because older compilers don't
support it.

You release the memory at the end of this block; that means there's no
advantage in making this strbuf static.  Allocating and freeing the
memory for the path of each submodule shouldn't cause any performance
issues, so please just drop static from the declaration.

> +		strbuf_reset(&dotgit);

=2E.. and then you don't need to reset anymore.

> +		strbuf_grow(&dotgit, PATH_MAX);

I'd drop that as well; the number of submodules should be low enough
that the possibly avoided reallocations by giving this hint shouldn't b=
e
noticeable.

> +		strbuf_addstr(&dotgit, work_tree);
> +		strbuf_addch(&dotgit, '/');
> +		if (args->treepath) {
> +			  strbuf_addstr(&dotgit, args->treepath);
> +			  strbuf_addch(&dotgit, '/');
> +		}
> +		strbuf_add(&dotgit, path_without_prefix,strlen(path_without_prefix=
)-1);
> +		if (add_submodule_odb(dotgit.buf))
> +			  die("Can't add submodule: %s", dotgit.buf);

Hmm, I wonder if we can traverse the tree and load all submodule object
databases before traversing it again to actually write file contents.
That would spare the user from getting half of an archive together with
that error message.

> +		strbuf_release(&dotgit);
> +	}
>  	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
>  		if (args->verbose)
>  			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
>  		err =3D write_entry(args, sha1, path.buf, path.len, mode);
>  		if (err)
>  			return err;
> -		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
> +		return (S_ISGITLINK(mode) && !args->recurse) ? 0: READ_TREE_RECURS=
IVE;

This line is longer than 80 characters, which we tend to avoid.  How
about this?

		if (ISGITLINK(mode) && !args->recurse)
			return 0;
		return READ_TREE_RECURSIVE;

>  	}
> =20
>  	if (args->verbose)
> @@ -256,10 +276,16 @@ static void parse_treeish_arg(const char **argv=
,
>  	const struct commit *commit;
>  	unsigned char sha1[20];
> =20
> +	const char *colon =3D strchr(name, ':');
> +
> +	/* Store the path on the ref for later (required for --recursive) *=
/
> +	char *treepath =3D NULL;
> +	if (colon) {
> +		treepath =3D strdup(colon+1);
> +	}

Style: No curly braces, space around operators, use wrapper functions
for simple memory error handling:

	if (colon)
		treepath =3D xstrdup(colon + 1);

>  	/* Remotes are only allowed to fetch actual refs */
>  	if (remote) {
>  		char *ref =3D NULL;
> -		const char *colon =3D strchr(name, ':');
>  		int refnamelen =3D colon ? colon - name : strlen(name);
> =20
>  		if (!dwim_ref(name, refnamelen, sha1, &ref))
> @@ -296,9 +322,11 @@ static void parse_treeish_arg(const char **argv,
>  		tree =3D parse_tree_indirect(tree_sha1);
>  	}
>  	ar_args->tree =3D tree;
> +	ar_args->treepath =3D treepath;
>  	ar_args->commit_sha1 =3D commit_sha1;
>  	ar_args->commit =3D commit;
>  	ar_args->time =3D archive_time;
> +
>  }

Please don't add empty lines before the end of a block.

>  #define OPT__COMPR(s, v, h, p) \
> @@ -318,6 +346,7 @@ static int parse_archive_args(int argc, const cha=
r **argv,
>  	const char *exec =3D NULL;
>  	const char *output =3D NULL;
>  	int compression_level =3D -1;
> +	int recurse =3D 0;
>  	int verbose =3D 0;
>  	int i;
>  	int list =3D 0;
> @@ -331,6 +360,8 @@ static int parse_archive_args(int argc, const cha=
r **argv,
>  			N_("write the archive to this file")),
>  		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
>  			N_("read .gitattributes in working directory")),
> +		OPT_BOOL(0, "recursive", &recurse, N_("include submodules in archi=
ve")),
> +		OPT_BOOL(0, "recurse-submodules", &recurse, N_("include submodules=
 in archive")),
>  		OPT__VERBOSE(&verbose, N_("report archived files on stderr")),
>  		OPT__COMPR('0', &compression_level, N_("store only"), 0),
>  		OPT__COMPR('1', &compression_level, N_("compress faster"), 1),
> @@ -355,6 +386,8 @@ static int parse_archive_args(int argc, const cha=
r **argv,
> =20
>  	argc =3D parse_options(argc, argv, NULL, opts, archive_usage, 0);
> =20
> +	if (is_remote && recurse)
> +		die("Cannot include submodules with option --remote");
>  	if (remote)
>  		die("Unexpected option --remote");
>  	if (exec)
> @@ -393,6 +426,7 @@ static int parse_archive_args(int argc, const cha=
r **argv,
>  					format, compression_level);
>  		}
>  	}
> +	args->recurse =3D recurse;
>  	args->verbose =3D verbose;
>  	args->base =3D base;
>  	args->baselen =3D strlen(base);
> diff --git a/archive.h b/archive.h
> index 4a791e1..577238d 100644
> --- a/archive.h
> +++ b/archive.h
> @@ -7,10 +7,12 @@ struct archiver_args {
>  	const char *base;
>  	size_t baselen;
>  	struct tree *tree;
> +	const char *treepath;
>  	const unsigned char *commit_sha1;
>  	const struct commit *commit;
>  	time_t time;
>  	struct pathspec pathspec;
> +	unsigned int recurse : 1;

Name it recurse_submodules?

>  	unsigned int verbose : 1;
>  	unsigned int worktree_attributes : 1;
>  	unsigned int convert : 1;
> -- 1.8.3.4 (Apple Git-47)=20

A test script (t/t5005-archive-submodules.sh?) would be nice which
exercises the new option.

Ren=E9
