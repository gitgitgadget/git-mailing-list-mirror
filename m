From: Nick Townsend <nick.townsend@mac.com>
Subject: Re: [PATCH] submodule recursion in git-archive
Date: Tue, 26 Nov 2013 21:03:09 -0800
Message-ID: <94296AEE-D806-4B67-AAA6-CE57B2CACCBE@mac.com>
References: <0MWW00M0GODZPV00@nk11p03mm-asmtp002.mac.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 06:03:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlXHv-00068y-Ih
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 06:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868Ab3K0FDk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Nov 2013 00:03:40 -0500
Received: from nk11p03mm-asmtpout001.mac.com ([17.158.232.236]:41518 "EHLO
	nk11p03mm-asmtp001.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750772Ab3K0FDj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 00:03:39 -0500
Received: from [172.16.1.4]
 (99-120-78-245.lightspeed.sntcca.sbcglobal.net [99.120.78.245])
 by nk11p03mm-asmtp001.mac.com
 (Oracle Communications Messaging Server 7u4-27.08(7.0.4.27.7) 64bit (built Aug
 22 2013)) with ESMTPSA id <0MWW00ALFOQ22U80@nk11p03mm-asmtp001.mac.com> for
 git@vger.kernel.org; Wed, 27 Nov 2013 05:03:39 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.11.72,1.0.14,0.0.0000
 definitions=2013-11-27_02:2013-11-26,2013-11-27,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=15 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1308280000 definitions=main-1311260248
X-Mailer: Apple Mail (2.1822)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238407>

On 26 Nov 2013, at 07:17, Ren=E9 Scharfe <l.s.r@web.de> wrote:

> Am 26.11.2013 01:04, schrieb Nick Townsend:
>> My first git patch - so shout out if I=92ve got the etiquette wrong!=
 Or
>> of course if I=92ve missed something.
>=20
> Thanks for the patches!  Please send only one per message (the second
> one as a reply to the first one, or both as replies to a cover letter=
),
> though -- that makes commenting on them much easier.
>=20
> Side note: Documentation/SubmittingPatches doesn't mention that (yet)=
,
> AFAICS.
>=20
>> Subject: [PATCH 1/2] submodule: add_submodule_odb() usability
>>=20
>> Although add_submodule_odb() is documented as being
>> externally usable, it is declared static and also
>> has incorrect documentation.
>>=20
>> This commit fixes those and makes no changes to
>> existing code using them. All tests still pass.
>=20
> Sign-off missing (see Documentation/SubmittingPatches).
>=20
>> ---
>> Documentation/technical/api-ref-iteration.txt | 4 ++--
>> submodule.c                                   | 2 +-
>> submodule.h                                   | 1 +
>> 3 files changed, 4 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/Documentation/technical/api-ref-iteration.txt b/Documen=
tation/technical/api-ref-iteration.txt
>> index aa1c50f..cbee624 100644
>> --- a/Documentation/technical/api-ref-iteration.txt
>> +++ b/Documentation/technical/api-ref-iteration.txt
>> @@ -50,10 +50,10 @@ submodules object database. You can do this by a=
 code-snippet like
>> this:
>>=20
>> 	const char *path =3D "path/to/submodule"
>> -	if (!add_submodule_odb(path))
>> +	if (add_submodule_odb(path))
>> 		die("Error submodule '%s' not populated.", path);
>>=20
>> -`add_submodule_odb()` will return an non-zero value on success. If =
you
>> +`add_submodule_odb()` will return a zero value on success. If you
>=20
> "return zero on success" instead?

I like the brevity of your suggestion. Again, I just used what was ther=
e=85

>=20
>> do not do this you will get an error for each ref that it does not p=
oint
>> to a valid object.
>>=20
>> diff --git a/submodule.c b/submodule.c
>> index 1905d75..1ea46be 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -143,7 +143,7 @@ void stage_updated_gitmodules(void)
>> 		die(_("staging updated .gitmodules failed"));
>> }
>>=20
>> -static int add_submodule_odb(const char *path)
>> +int add_submodule_odb(const char *path)
>> {
>> 	struct strbuf objects_directory =3D STRBUF_INIT;
>> 	struct alternate_object_database *alt_odb;
>> diff --git a/submodule.h b/submodule.h
>> index 7beec48..3e3cdca 100644
>> --- a/submodule.h
>> +++ b/submodule.h
>> @@ -41,5 +41,6 @@ int find_unpushed_submodules(unsigned char new_sha=
1[20], const char *remotes_nam
>> 		struct string_list *needs_pushing);
>> int push_unpushed_submodules(unsigned char new_sha1[20], const char =
*remotes_name);
>> void connect_work_tree_and_git_dir(const char *work_tree, const char=
 *git_dir);
>> +int add_submodule_odb(const char *path);
>>=20
>> #endif
>=20
>> Subject: [PATCH 2/2] archive: allow submodule recursion on git-archi=
ve
>>=20
>> When using git-archive to produce a dump of a
>> repository, the existing code does not recurse
>> into a submodule when it encounters it in the tree
>> traversal. These changes add a command line flag
>> that permits this.
>>=20
>> Note that the submodules must be updated in the
>> repository, otherwise this cannot take place.
>>=20
>> The feature is disabled for remote repositories as
>> the git_work_tree fails. This is a possible future
>> enhancement.
>=20
> Hmm, curious.  Why does it fail?  I guess that happens with bare
> repositories, only, right?  (Which are the most likely kind of remote
> repos to encounter, of course.)

I=92m not sure why it failed - I didn=92t think it should - but it did.
See discussion in other email.

>=20
>> Two additional fields are added to archiver_args:
>>  * recurse  - a boolean indicator
>>  * treepath - the path part of the tree-ish
>>               eg. the 'www' in HEAD:www
>>=20
>> The latter is used within the archive writer to
>> determin the correct path for the submodule .git
>> file.
>>=20
>> Signed-off-by: Nick Townsend <nick.townsend@mac.com>
>> ---
>> Documentation/git-archive.txt |  9 +++++++++
>> archive.c                     | 38 +++++++++++++++++++++++++++++++++=
+++--
>> archive.h                     |  2 ++
>> 3 files changed, 47 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/Documentation/git-archive.txt b/Documentation/git-archi=
ve.txt
>> index b97aaab..b4df735 100644
>> --- a/Documentation/git-archive.txt
>> +++ b/Documentation/git-archive.txt
>> @@ -11,6 +11,7 @@ SYNOPSIS
>> [verse]
>> 'git archive' [--format=3D<fmt>] [--list] [--prefix=3D<prefix>/] [<e=
xtra>]
>> 	      [-o <file> | --output=3D<file>] [--worktree-attributes]
>> +	      [--recursive|--recurse-submodules]
>=20
> I'd expect git archive --recurse to add subdirectories and their
> contents, which it does right now, and --no-recurse to only archive t=
he
> specified objects, which is not implemented.  IAW: I wouldn't normall=
y
> associate an option with that name with submodules.  Would
> --recurse-submodules alone suffice?
>=20
> Side note: With only one of the options defined you could shorten the=
m
> on the command line to e.g. --rec; with both you'd need to type at le=
ast
> --recursi or --recurse to disambiguate -- even though they ultimately=
 do
> the same.

See other comments - I agree - recurse-submodules it is!

>=20
>> 	      [--remote=3D<repo> [--exec=3D<git-upload-archive>]] <tree-ish=
>
>> 	      [<path>...]
>>=20
>> @@ -51,6 +52,14 @@ OPTIONS
>> --prefix=3D<prefix>/::
>> 	Prepend <prefix>/ to each filename in the archive.
>>=20
>> +--recursive::
>> +--recurse-submodules::
>> +	Archive entries in submodules. Errors occur if the submodules
>> +	have not been initialized and updated.
>> +	Run `git submodule update --init --recursive` immediately after
>> +	the clone is finished to avoid this.
>> +	This option is not available with remote repositories.
>> +
>> -o <file>::
>> --output=3D<file>::
>> 	Write the archive to <file> instead of stdout.
>> diff --git a/archive.c b/archive.c
>> index 346f3b2..f6313c9 100644
>> --- a/archive.c
>> +++ b/archive.c
>> @@ -5,6 +5,7 @@
>> #include "archive.h"
>> #include "parse-options.h"
>> #include "unpack-trees.h"
>> +#include "submodule.h"
>>=20
>> static char const * const archive_usage[] =3D {
>> 	N_("git archive [options] <tree-ish> [<path>...]"),
>> @@ -131,13 +132,32 @@ static int write_archive_entry(const unsigned =
char *sha1, const char *base,
>> 		args->convert =3D ATTR_TRUE(check[1].value);
>> 	}
>>=20
>> +	if (S_ISGITLINK(mode) && args->recurse) {
>> +		const char *work_tree =3D get_git_work_tree();
>> +		if (!work_tree) {
>> +			  die("Can't go recursive when no work dir");
>> +		}
>=20
> Style nit: No curly braces around single-line statements, please.
>=20
> Perhaps mention submodules in the error message?
>=20
> It would be nicer to get_git_work_tree right after the parameters hav=
e
> been parsed and before any archive contents have been written and err=
or
> out early.
>=20
>> +		static struct strbuf dotgit =3D STRBUF_INIT;
>=20
> We avoid declarations after statements because older compilers don't
> support it.
>=20
> You release the memory at the end of this block; that means there's n=
o
> advantage in making this strbuf static.  Allocating and freeing the
> memory for the path of each submodule shouldn't cause any performance
> issues, so please just drop static from the declaration.
>=20
>> +		strbuf_reset(&dotgit);
>=20
> ... and then you don't need to reset anymore.
>=20
>> +		strbuf_grow(&dotgit, PATH_MAX);
>=20
> I'd drop that as well; the number of submodules should be low enough
> that the possibly avoided reallocations by giving this hint shouldn't=
 be
> noticeable.

I just cut and pasted this code from another location - didn=92t really=
 think too hard
and I wasn=92t familiar with the strbuf routines in the codebase. Thank=
s for the input.

>=20
>> +		strbuf_addstr(&dotgit, work_tree);
>> +		strbuf_addch(&dotgit, '/');
>> +		if (args->treepath) {
>> +			  strbuf_addstr(&dotgit, args->treepath);
>> +			  strbuf_addch(&dotgit, '/');
>> +		}
>> +		strbuf_add(&dotgit, path_without_prefix,strlen(path_without_prefi=
x)-1);
>> +		if (add_submodule_odb(dotgit.buf))
>> +			  die("Can't add submodule: %s", dotgit.buf);
>=20
> Hmm, I wonder if we can traverse the tree and load all submodule obje=
ct
> databases before traversing it again to actually write file contents.
> That would spare the user from getting half of an archive together wi=
th
> that error message.

See comments in another email about where and how to parse submodules. =
If we do the
parse .gitmodules approach then we could do something like this. The as=
-you-go
method seemed easier and more accurate - after all you may not traverse=
 into a
submodule at all - so any time spent adding it=92s objects would be was=
ted.

In the same conversation I agree that it=92s best to warn when a submod=
ule can=92t be
located, and continue with just a directory entry in its place (as curr=
ently)

>=20
>> +		strbuf_release(&dotgit);
>> +	}
>> 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
>> 		if (args->verbose)
>> 			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
>> 		err =3D write_entry(args, sha1, path.buf, path.len, mode);
>> 		if (err)
>> 			return err;
>> -		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
>> +		return (S_ISGITLINK(mode) && !args->recurse) ? 0: READ_TREE_RECUR=
SIVE;
>=20
> This line is longer than 80 characters, which we tend to avoid.  How
> about this?
>=20
> 		if (ISGITLINK(mode) && !args->recurse)
> 			return 0;
> 		return READ_TREE_RECURSIVE;
>=20
>> 	}

Agreed. I don=92t usually enjoy multiple returns (especially so close t=
o the end!)
but if the style guidelines are OK with that then so am I.

>>=20
>> 	if (args->verbose)
>> @@ -256,10 +276,16 @@ static void parse_treeish_arg(const char **arg=
v,
>> 	const struct commit *commit;
>> 	unsigned char sha1[20];
>>=20
>> +	const char *colon =3D strchr(name, ':');
>> +
>> +	/* Store the path on the ref for later (required for --recursive) =
*/
>> +	char *treepath =3D NULL;
>> +	if (colon) {
>> +		treepath =3D strdup(colon+1);
>> +	}
>=20
> Style: No curly braces, space around operators, use wrapper functions
> for simple memory error handling:
>=20
> 	if (colon)
> 		treepath =3D xstrdup(colon + 1);

Is that the standard practice? To use the wrapper functions? =20

>=20
>> 	/* Remotes are only allowed to fetch actual refs */
>> 	if (remote) {
>> 		char *ref =3D NULL;
>> -		const char *colon =3D strchr(name, ':');
>> 		int refnamelen =3D colon ? colon - name : strlen(name);
>>=20
>> 		if (!dwim_ref(name, refnamelen, sha1, &ref))
>> @@ -296,9 +322,11 @@ static void parse_treeish_arg(const char **argv=
,
>> 		tree =3D parse_tree_indirect(tree_sha1);
>> 	}
>> 	ar_args->tree =3D tree;
>> +	ar_args->treepath =3D treepath;
>> 	ar_args->commit_sha1 =3D commit_sha1;
>> 	ar_args->commit =3D commit;
>> 	ar_args->time =3D archive_time;
>> +
>> }
>=20
> Please don't add empty lines before the end of a block.
>=20
>> #define OPT__COMPR(s, v, h, p) \
>> @@ -318,6 +346,7 @@ static int parse_archive_args(int argc, const ch=
ar **argv,
>> 	const char *exec =3D NULL;
>> 	const char *output =3D NULL;
>> 	int compression_level =3D -1;
>> +	int recurse =3D 0;
>> 	int verbose =3D 0;
>> 	int i;
>> 	int list =3D 0;
>> @@ -331,6 +360,8 @@ static int parse_archive_args(int argc, const ch=
ar **argv,
>> 			N_("write the archive to this file")),
>> 		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
>> 			N_("read .gitattributes in working directory")),
>> +		OPT_BOOL(0, "recursive", &recurse, N_("include submodules in arch=
ive")),
>> +		OPT_BOOL(0, "recurse-submodules", &recurse, N_("include submodule=
s in archive")),
>> 		OPT__VERBOSE(&verbose, N_("report archived files on stderr")),
>> 		OPT__COMPR('0', &compression_level, N_("store only"), 0),
>> 		OPT__COMPR('1', &compression_level, N_("compress faster"), 1),
>> @@ -355,6 +386,8 @@ static int parse_archive_args(int argc, const ch=
ar **argv,
>>=20
>> 	argc =3D parse_options(argc, argv, NULL, opts, archive_usage, 0);
>>=20
>> +	if (is_remote && recurse)
>> +		die("Cannot include submodules with option --remote");
>> 	if (remote)
>> 		die("Unexpected option --remote");
>> 	if (exec)
>> @@ -393,6 +426,7 @@ static int parse_archive_args(int argc, const ch=
ar **argv,
>> 					format, compression_level);
>> 		}
>> 	}
>> +	args->recurse =3D recurse;
>> 	args->verbose =3D verbose;
>> 	args->base =3D base;
>> 	args->baselen =3D strlen(base);
>> diff --git a/archive.h b/archive.h
>> index 4a791e1..577238d 100644
>> --- a/archive.h
>> +++ b/archive.h
>> @@ -7,10 +7,12 @@ struct archiver_args {
>> 	const char *base;
>> 	size_t baselen;
>> 	struct tree *tree;
>> +	const char *treepath;
>> 	const unsigned char *commit_sha1;
>> 	const struct commit *commit;
>> 	time_t time;
>> 	struct pathspec pathspec;
>> +	unsigned int recurse : 1;
>=20
> Name it recurse_submodules?
>=20
>> 	unsigned int verbose : 1;
>> 	unsigned int worktree_attributes : 1;
>> 	unsigned int convert : 1;
>> -- 1.8.3.4 (Apple Git-47)=20
>=20
> A test script (t/t5005-archive-submodules.sh?) would be nice which
> exercises the new option.

I take all the style points noted, and will create a test script - I di=
dn=92t want to invest too much
in this project until I=92d received a response!

Thanks for your time in reviewing - these things are a great help.

Cheers
Nick

>=20
> Ren=E9
