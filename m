Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C669F12CDBC
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 22:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708121903; cv=none; b=FUCC3E/0Y6G309snjJHT3ZzimgbOMiQonPGu3WuDaLamDPVYMA711XVAcCsTRnnTQpiXTDoDnSR6WyitjZLZLafn1C4lpuxPVN4zaMjkRdBs/X27v7WkrMP2vcqDR1QY0AVc1VlRj8lXaQORFlhJY6E5tqWkYMR2JxzhF+pID5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708121903; c=relaxed/simple;
	bh=A9eLwQliKoxdeELlVvJImvvqSUU9VUdNSUC24dro1zc=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=u4+gGa9QRoCc9hTTKELfawHl8yYGnjLK0AZHIC4i22CNZF5/w9vHCuyqnIey+Jj0W3stWep0PB2bOWvckiyJfj2dW/wgl+5sU8C2jqUZYNvug0RnvnwlMyggcoQKSHZnshOyzsSR58nDryQTDuZCSE2i/eNUClrsLHf+WB+yMKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
References: <20231226202102.3392518-1-sam@gentoo.org>
 <CABPp-BFZqa2wyNUs0OfUOokGORjAguCK7-1hqK6U+SUxm8E5Lw@mail.gmail.com>
User-agent: mu4e 1.10.8; emacs 30.0.50
From: Sam James <sam@gentoo.org>
To: Elijah Newren <newren@gmail.com>
Cc: Sam James <sam@gentoo.org>, git@vger.kernel.org, Junio C Hamano
 <gitster@pobox.com>
Subject: Re: [PATCH v2] diff: implement config.diff.renames=copies-harder
Date: Fri, 16 Feb 2024 22:16:04 +0000
Organization: Gentoo
In-reply-to: <CABPp-BFZqa2wyNUs0OfUOokGORjAguCK7-1hqK6U+SUxm8E5Lw@mail.gmail.com>
Message-ID: <87wmr4aw9q.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Elijah Newren <newren@gmail.com> writes:

> Hi,
>
> It helps when providing a new iteration of a patch to do two things:
>   (1) provide a range-diff against the previous version to make it
> easier for reviewers to see what has changed
>   (2) either reply to the previous submission or link to it in your
> header so reviewers can find previous comments

Thanks, I'll do that for upcoming v3.

>
> In this case, v1 was over at
> https://lore.kernel.org/git/pull.1606.git.1699010701704.gitgitgadget@gmai=
l.com/.
>
> On Tue, Dec 26, 2023 at 12:21=E2=80=AFPM Sam James <sam@gentoo.org> wrote:
>>
>> This patch adds a config value for 'diff.renames' called 'copies-harder'
>> which make it so '-C -C' is in effect always passed for 'git log -p',
>> 'git diff', etc.
>>
>> This allows specifying that 'git log -p', 'git diff', etc should always =
act
>> as if '-C --find-copies-harder' was passed.
>>
>> It has proven this especially useful for certain types of repository (li=
ke
>> Gentoo's ebuild repositories) because files are often copies of a previo=
us
>> version:
>>
>> Suppose a directory 'sys-devel/gcc' contains recipes for building
>> GCC, with one file for each supported upstream branch:
>>    gcc-13.x.build.recipe
>>    gcc-12.x.build.recipe
>>    gcc-11.x.build.recipe
>>    gcc-10.x.build.recipe
>>
>> gcc-13.x.build.recipe was started as a copy of gcc-12.x.build.recipe
>> (which was started as a copy of gcc-11.x.build.recipe, etc.). Previous v=
ersions
>> are kept around to support parallel installation of multiple versions.
>>
>> Being able to easily observe the diff relative to other recipes within t=
he
>> directory has been a quality of life improvement for such repo layouts.
>>
>> Cc: Elijah Newren <newren@gmail.com>
>> Cc: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Sam James <sam@gentoo.org>
>
> While the "Cc:" lines don't hurt, note that everything above this
> point is included in the commit message, so we'd typically rather
> those two lines be below the triple-dashed line.

ACK.

>
>> ---
>> v2: Improve the commit message using Elijah Newren's example (it is inde=
ed
>> precisely what I was thinking of, but phrased better), and improve the d=
ocumentation
>> to explain better what the new config option actually does & refer to gi=
t-diff's
>> --find-copies-harder.
>>
>>  Documentation/config/diff.txt   |  8 +++++---
>>  Documentation/config/status.txt |  3 ++-
>>  diff.c                          | 12 +++++++++---
>>  diff.h                          |  1 +
>>  diffcore-rename.c               |  4 ++--
>>  merge-ort.c                     |  2 +-
>>  merge-recursive.c               |  2 +-
>>  7 files changed, 21 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.t=
xt
>> index bd5ae0c337..cdd8a74ec0 100644
>> --- a/Documentation/config/diff.txt
>> +++ b/Documentation/config/diff.txt
>> @@ -131,9 +131,11 @@ diff.renames::
>>         Whether and how Git detects renames.  If set to "false",
>>         rename detection is disabled. If set to "true", basic rename
>>         detection is enabled.  If set to "copies" or "copy", Git will
>> -       detect copies, as well.  Defaults to true.  Note that this
>> -       affects only 'git diff' Porcelain like linkgit:git-diff[1] and
>> -       linkgit:git-log[1], and not lower level commands such as
>> +       detect copies, as well.  If set to "copies-harder", Git will spe=
nd extra
>> +       cycles to find more copies even in unmodified paths, see
>> +       '--find-copies-harder' in linkgit:git-diff[1]. Defaults to true.
>> +       Note that this affects only 'git diff' Porcelain like linkgit:gi=
t-diff[1]
>> +       and linkgit:git-log[1], and not lower level commands such as
>>         linkgit:git-diff-files[1].
>>
>>  diff.suppressBlankEmpty::
>> diff --git a/Documentation/config/status.txt b/Documentation/config/stat=
us.txt
>> index 2ff8237f8f..7ca7a4becd 100644
>> --- a/Documentation/config/status.txt
>> +++ b/Documentation/config/status.txt
>> @@ -33,7 +33,8 @@ status.renames::
>>         Whether and how Git detects renames in linkgit:git-status[1] and
>>         linkgit:git-commit[1] .  If set to "false", rename detection is
>>         disabled. If set to "true", basic rename detection is enabled.
>> -       If set to "copies" or "copy", Git will detect copies, as well.
>> +       If set to "copies" or "copy", Git will detect copies, as well.  =
If
>> +       set to "copies-harder", Git will try harder to detect copies.
>
> It'd be nice to have the improved text from diff.renames here ("If set
> to "copies-harder", Git will spend extra cycles to find more copies
> even in unmodified paths.").
>
>>         Defaults to the value of diff.renames.
>>
>>  status.showStash::
>> diff --git a/diff.c b/diff.c
>> index a2def45644..585acf9a99 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -206,8 +206,11 @@ int git_config_rename(const char *var, const char *=
value)
>>  {
>>         if (!value)
>>                 return DIFF_DETECT_RENAME;
>> +       if (!strcasecmp(value, "copies-harder"))
>> +               return DIFF_DETECT_COPY_HARDER;
>>         if (!strcasecmp(value, "copies") || !strcasecmp(value, "copy"))
>> -               return  DIFF_DETECT_COPY;
>> +               return DIFF_DETECT_COPY;
>> +
>
> I pointed out in response to v1 that these last couple lines, while a
> nice cleanup, should be in a separate patch.
>
>>         return git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
>>  }
>>
>> @@ -4849,8 +4852,11 @@ void diff_setup_done(struct diff_options *options)
>>         else
>>                 options->flags.diff_from_contents =3D 0;
>>
>> -       if (options->flags.find_copies_harder)
>> +       /* Just fold this in as it makes the patch-to-git smaller */
>> +       if (options->flags.find_copies_harder || options->detect_rename =
=3D=3D DIFF_DETECT_COPY_HARDER) {
>
> Again, I already responded to v1 that four of your lines were too long
> and needed to be split.  All four remain unsplit in your resubmission.
> For future reference, when you resubmit a patch, please either (a)
> first respond to the review explaining why you don't agree with the
> suggested changes, or (b) include the fixes reviewers point out, or
> (c) state in your cover letter or explanation after the '---' why you
> chose to not include the suggested changes.

I apologise for the rookie errors, I don't really have an excuse either.

>
>> +               options->flags.find_copies_harder =3D 1;
>>                 options->detect_rename =3D DIFF_DETECT_COPY;
>> +       }
>>
>>         if (!options->flags.relative_name)
>>                 options->prefix =3D NULL;
>> @@ -5281,7 +5287,7 @@ static int diff_opt_find_copies(const struct optio=
n *opt,
>>         if (*arg !=3D 0)
>>                 return error(_("invalid argument to %s"), opt->long_name=
);
>>
>> -       if (options->detect_rename =3D=3D DIFF_DETECT_COPY)
>> +       if (options->detect_rename =3D=3D DIFF_DETECT_COPY || options->d=
etect_rename =3D=3D DIFF_DETECT_COPY_HARDER)
>>                 options->flags.find_copies_harder =3D 1;
>>         else
>>                 options->detect_rename =3D DIFF_DETECT_COPY;
>> diff --git a/diff.h b/diff.h
>> index 66bd8aeb29..b29e5b777f 100644
>> --- a/diff.h
>> +++ b/diff.h
>> @@ -555,6 +555,7 @@ int git_config_rename(const char *var, const char *v=
alue);
>>
>>  #define DIFF_DETECT_RENAME     1
>>  #define DIFF_DETECT_COPY       2
>> +#define DIFF_DETECT_COPY_HARDER 3
>>
>>  #define DIFF_PICKAXE_ALL       1
>>  #define DIFF_PICKAXE_REGEX     2
>> diff --git a/diffcore-rename.c b/diffcore-rename.c
>> index 5a6e2bcac7..856291d66f 100644
>> --- a/diffcore-rename.c
>> +++ b/diffcore-rename.c
>> @@ -299,7 +299,7 @@ static int find_identical_files(struct hashmap *srcs,
>>                 }
>>                 /* Give higher scores to sources that haven't been used =
already */
>>                 score =3D !source->rename_used;
>> -               if (source->rename_used && options->detect_rename !=3D D=
IFF_DETECT_COPY)
>> +               if (source->rename_used && options->detect_rename !=3D D=
IFF_DETECT_COPY && options->detect_rename !=3D DIFF_DETECT_COPY_HARDER)
>>                         continue;
>>                 score +=3D basename_same(source, target);
>>                 if (score > best_score) {
>> @@ -1405,7 +1405,7 @@ void diffcore_rename_extended(struct diff_options =
*options,
>>         trace2_region_enter("diff", "setup", options->repo);
>>         info.setup =3D 0;
>>         assert(!dir_rename_count || strmap_empty(dir_rename_count));
>> -       want_copies =3D (detect_rename =3D=3D DIFF_DETECT_COPY);
>> +       want_copies =3D (detect_rename =3D=3D DIFF_DETECT_COPY || detect=
_rename =3D=3D DIFF_DETECT_COPY_HARDER);
>>         if (dirs_removed && (break_idx || want_copies))
>>                 BUG("dirs_removed incompatible with break/copy detection=
");
>>         if (break_idx && relevant_sources)
>> diff --git a/merge-ort.c b/merge-ort.c
>> index 6491070d96..7749835465 100644
>> --- a/merge-ort.c
>> +++ b/merge-ort.c
>> @@ -4782,7 +4782,7 @@ static void merge_start(struct merge_options *opt,=
 struct merge_result *result)
>>          * sanity check them anyway.
>>          */
>>         assert(opt->detect_renames >=3D -1 &&
>> -              opt->detect_renames <=3D DIFF_DETECT_COPY);
>> +              opt->detect_renames <=3D DIFF_DETECT_COPY_HARDER);
>>         assert(opt->verbosity >=3D 0 && opt->verbosity <=3D 5);
>>         assert(opt->buffer_output <=3D 2);
>>         assert(opt->obuf.len =3D=3D 0);
>> diff --git a/merge-recursive.c b/merge-recursive.c
>> index e3beb0801b..d52dd53660 100644
>> --- a/merge-recursive.c
>> +++ b/merge-recursive.c
>> @@ -3708,7 +3708,7 @@ static int merge_start(struct merge_options *opt, =
struct tree *head)
>>         assert(opt->branch1 && opt->branch2);
>>
>>         assert(opt->detect_renames >=3D -1 &&
>> -              opt->detect_renames <=3D DIFF_DETECT_COPY);
>> +              opt->detect_renames <=3D DIFF_DETECT_COPY_HARDER);
>>         assert(opt->detect_directory_renames >=3D MERGE_DIRECTORY_RENAME=
S_NONE &&
>>                opt->detect_directory_renames <=3D MERGE_DIRECTORY_RENAME=
S_TRUE);
>>         assert(opt->rename_limit >=3D -1);
>> --
>> 2.43.0
>
> The patch looks close, but it does continue to violate style
> guidelines and make unrelated changes, like v1.  And the wording in
> one of the documentation blurbs could be improved a little.  Looking
> forward to a v3 with those fixed.

I've not finished checking yet, but I think
5825268db1058516d05be03d6a8d8d55eea5a943 fixed a bug which I'd been
relying on for something, where I may need to add another option for git
log to suppress copies (for scripts).

Should I send that in a series when doing v3 if it ends up being
required?

thanks,
sam

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iOUEARYKAI0WIQQlpruI3Zt2TGtVQcJzhAn1IN+RkAUCZc/fIV8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MjVB
NkJCODhERDlCNzY0QzZCNTU0MUMyNzM4NDA5RjUyMERGOTE5MA8cc2FtQGdlbnRv
by5vcmcACgkQc4QJ9SDfkZBddAD+JP0zFRTowYj3QzrAk+9VqXu4pOkSoC6Oj57a
Rrt3FT0BALrKJ5FHTTYyJqVMTXYjGARznd+sHhmpQmyIcUGW9Z8G
=OGz/
-----END PGP SIGNATURE-----
--=-=-=--
