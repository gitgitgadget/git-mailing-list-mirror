Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0552FC47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 07:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21DC60720
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 07:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhFBH4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 03:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhFBH4y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 03:56:54 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7513AC061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 00:55:11 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id z26so1548241pfj.5
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 00:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=huR6agFjElK3M66+5JDbSv5QiEl4U7ACQ/FrI7ycbYE=;
        b=W4RBgwpdWlDmg2TpNDvrH8TF8nYsRZEbuNhr5f/8FmXoP1EBXOF/dRqHlBGAepehl2
         5TGmHPeqRwd23UTTdZqH3R30BWAgjrlDawD2mvadP19K7ooKYWATwTmTRtbP2C88Etp6
         AJu5LuNlFCH0iGAjBcAWjTzzDPr34ll9wS8JZDJyxDUVqKrQNKALeGqR1a/NmADGTbsA
         KsMsNCAypSM4WSDXP+u4om2ANRAg4JasvGc9drlmsfJ+elGXUgDGiphd6hSVLM3SL5Le
         BDmBKKmq/BvFISnQozieNAu1Nj+xYKTlpOVMZFKPv4lR/CmYqsb10Y0DGUGUrgPrWHV4
         Lphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=huR6agFjElK3M66+5JDbSv5QiEl4U7ACQ/FrI7ycbYE=;
        b=p11iwR2yUbI20AUlOeLTCCt9lbSCujvsUR78KMYyOUXO2xrwZ9aoM8zSOvtSKxEmRa
         sg/RcFd49o/gGkebVJdrtN78twXx/QKzgZxkrFNkF+UuA2GRO2p7/I1LHAkH2dUutxvC
         LZuaxnTbLw6tFIs+KR6WlqjAx5ULgGFunsoxkcgnEHPYExsEPKHoMr5V6Ep2KxIm+fzI
         rm7iaugL4YZOFT9v9jxLnXGcMlmLDfvbTEdCWji3EY3M3nXZUfZhW2j7rSw5vOMVeeK2
         m5NrQiwVVQyc14LKANY3+rnI/5DQNbqzjyofOjJWVvJNY3a5c7vG97p3YhgU+VEne2fS
         GY/g==
X-Gm-Message-State: AOAM531BcnqX/pDU4pRVhl/+GFQ0pmr2eyPGyeOG64EOlIeoAbijV2gu
        J3sf/3E/tUwQ8IUV8oVo90eZFKYl64IQV8Uf
X-Google-Smtp-Source: ABdhPJwzBRfAtbQzBo28RlfR2OUFlfgy/0p7cDTRrYyoahtAVDKts+VpZ8mdoRR6Hf0Z1KwjtXm25g==
X-Received: by 2002:a65:6644:: with SMTP id z4mr32997757pgv.101.1622620510826;
        Wed, 02 Jun 2021 00:55:10 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id s29sm12022077pgm.82.2021.06.02.00.55.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jun 2021 00:55:10 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH][GSoC] submodule: introduce add-clone helper for submodule
 add
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <CAP8UFD3SMghGb0y0jKuLScrKqqHgZFDxW1c97MwoEz+1hXt1hA@mail.gmail.com>
Date:   Wed, 2 Jun 2021 13:25:07 +0530
Cc:     git <git@vger.kernel.org>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <38AEA0B4-FCF7-4123-9412-98C1394972B0@gmail.com>
References: <20210528081224.69163-1-raykar.ath@gmail.com>
 <CAP8UFD3SMghGb0y0jKuLScrKqqHgZFDxW1c97MwoEz+1hXt1hA@mail.gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02-Jun-2021, at 03:40, Christian Couder <christian.couder@gmail.com> =
wrote:
>=20
> On Fri, May 28, 2021 at 10:13 AM Atharva Raykar <raykar.ath@gmail.com> =
wrote:
>>=20
>> Convert the the shell code that performs the cloning of the =
repository that is
>=20
> s/the the/the/
>=20
>> to be added, and checks out to the appropriate branch.
>=20
> Something a bit more explicit might make things easier to understand.
> For example:
>=20
> "Let's add a new "add-clone" subcommand to `git submodule--helper`
> with the goal of converting part of the shell code in git-submodule.sh
> related to `git submodule add` into C code. This new subcommand clones
> the repository that is to be added, and checks out to the appropriate
> branch."
>=20
> Then a simpler title could be:
>=20
> "submodule--helper: introduce add-clone subcommand"

Great suggestions. I'll update my commit message.

>> This is meant to be a faithful conversion that leaves the behaviour =
of
>> 'submodule add' unchanged. The only minor change is that if a =
submodule name has
>> been supplied with a name that clashes with a local submodule, the =
message shown
>> to the user ("A git directory for 'foo' is found locally...") is =
prepended with
>> "error" for clarity.
>=20
> Good.
>=20
>> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Shourya Shukla <shouryashukla.oo@gmail.com>
>> Based-on-patch-by: Shourya Shukla <shouryashukla.oo@gmail.com>
>> Based-on-patch-by: Prathamesh Chavan <pc44800@gmail.com>
>> ---
>>=20
>> This is part of a series of changes that will result in all of =
'submodule add'
>> being converted to C, which is a more familiar language for Git =
developers, and
>> paves the way to improve performance and portability.
>>=20
>> I have made this patch based on Shourya's patch[1]. I have decided to =
send the
>> changes in smaller, more reviewable parts. The add-clone subcommand =
of
>> submodule--helper is an intermediate change, while I work on =
translating all of
>> the code. So in the next few patches, this helper subcommand is =
likely to be
>> removed as its functionality would be invoked from the C code itself.
>=20
> It might be a good idea to let us know how many such new subcommands
> you'd like to introduce before removing them.

I'll add that in my description of v2.

> Anyway I think it's a good idea to send changes in smaller, more
> easily reviewable parts. Hopefully this way more work will end up
> being merged.
>=20
>> [...]
>> +static void show_fetch_remotes(FILE *output, const char *sm_name, =
const char *git_dir_path)
>> +{
>> +       struct child_process cp_remote =3D CHILD_PROCESS_INIT;
>> +       struct strbuf sb_remote_out =3D STRBUF_INIT;
>> +
>> +       cp_remote.git_cmd =3D 1;
>> +       strvec_pushf(&cp_remote.env_array,
>> +                    "GIT_DIR=3D%s", git_dir_path);
>> +       strvec_push(&cp_remote.env_array, "GIT_WORK_TREE=3D.");
>> +       strvec_pushl(&cp_remote.args, "remote", "-v", NULL);
>> +       if (!capture_command(&cp_remote, &sb_remote_out, 0)) {
>> +               char *next_line, *name, *url, *tail;
>=20
> Maybe name, url and tail could be declared in the while loop below
> where they are used.

Will do. Just to better understand your intent, is the reason to
do this to make the declarations closer to usage, for the sake of
better readability?

I've not yet fully developed a taste for good C style, so I wanted
to ask, which one looks better to you in these?

/* Sample 1 */
while (begin !=3D end && (line =3D get_next_line(begin, end))) {
	char *name, *url, *tail;
	name =3D parse_token(&begin, next_line);
	url =3D parse_token(&begin, next_line);
	tail =3D parse_token(&begin, next_line);
	...
}

/* Sample 2 */
while (begin !=3D end && (line =3D get_next_line(begin, end))) {
	char *name =3D parse_token(&begin, next_line);
	char *url =3D parse_token(&begin, next_line);
	char *tail =3D parse_token(&begin, next_line);
	...
}

>> +               char *begin =3D sb_remote_out.buf;
>> +               char *end =3D sb_remote_out.buf + sb_remote_out.len;
>> +               while (begin !=3D end &&
>> +                      (next_line =3D get_next_line(begin, end))) {
>=20
> It would be nice if the above 2 lines could be reduced into just one
> line. Maybe renaming "next_line" to just "line" could help with that.

Noted.

>> +                       name =3D parse_token(&begin, next_line);
>> +                       url =3D parse_token(&begin, next_line);
>> +                       tail =3D parse_token(&begin, next_line);
>> +                       if (!memcmp(tail, "(fetch)", 7))
>> +                               fprintf(output, "  %s\t%s\n", name, =
url);
>> +                       free(url);
>> +                       free(name);
>> +                       free(tail);
>> +               }
>> +       }
>> +
>> +       strbuf_release(&sb_remote_out);
>> +}
>> +
>> +static int add_submodule(const struct add_data *info)
>> +{
>> +       char *submod_gitdir_path;
>> +       /* perhaps the path already exists and is already a git repo, =
else clone it */
>> +       if (is_directory(info->sm_path)) {
>> +               printf("sm_path=3D%s\n", info->sm_path);
>=20
> Is this a leftover debug statement?

Nope, at least not _my_ leftover debug statement.

I saw it in git-submodule.sh here, so I preserved it:

-	# perhaps the path exists and is already a git repo, else clone =
it
-	if test -e "$sm_path"
-	...

Personally, I found that comment quite useful when I was trying to
understand the shell version, because at a glance I immediately
knew what the intention of the big block of code was, that followed
the comment.

Perhaps it could be broken into many functions to make it more
readable without needing a comment, but that is outside the scope
of this particular patch, which is aiming for a faithful conversion.

>> +               submod_gitdir_path =3D xstrfmt("%s/.git", =
info->sm_path);
>> +               if (is_directory(submod_gitdir_path) || =
file_exists(submod_gitdir_path))
>> +                       printf(_("Adding existing path at '%s' to =
index\n"),
>> +                              info->sm_path);
>> +               else
>> +                       die(_("'%s' already exists and is not a valid =
git repo"),
>> +                           info->sm_path);
>> +               free(submod_gitdir_path);
>> +       } else {
>> +               struct strvec clone_args =3D STRVEC_INIT;
>> +               struct child_process cp =3D CHILD_PROCESS_INIT;
>> +               submod_gitdir_path =3D xstrfmt(".git/modules/%s", =
info->sm_name);
>> +
>> +               if (is_directory(submod_gitdir_path)) {
>> +                       if (!info->force) {
>> +                               error(_("A git directory for '%s' is =
found "
>> +                                       "locally with remote(s):"), =
info->sm_name);
>> +                               show_fetch_remotes(stderr, =
info->sm_name,
>> +                                                  =
submod_gitdir_path);
>> +                               fprintf(stderr,
>> +                                       _("If you want to reuse this =
local git "
>> +                                         "directory instead of =
cloning again from\n"
>> +                                         "  %s\n"
>> +                                         "use the '--force' option. =
If the local git "
>> +                                         "directory is not the =
correct repo\n"
>> +                                         "or if you are unsure what =
this means, choose "
>> +                                         "another name with the =
'--name' option.\n"),
>> +                                       info->realrepo);
>> +                               free(submod_gitdir_path);
>> +                               return 1;
>> +                       } else {
>> +                               printf(_("Reactivating local git =
directory for "
>> +                                        "submodule '%s'\n"), =
info->sm_name);
>> +                       }
>> +               }
>> +               free(submod_gitdir_path);
>> +
>> +               strvec_push(&clone_args, "clone");
>> +
>> +               if (info->quiet)
>> +                       strvec_push(&clone_args, "--quiet");
>> +
>> +               if (info->progress)
>> +                       strvec_push(&clone_args, "--progress");
>> +
>> +               if (info->prefix)
>> +                       strvec_pushl(&clone_args, "--prefix", =
info->prefix, NULL);
>> +
>> +               strvec_pushl(&clone_args, "--path", info->sm_path, =
"--name",
>> +                            info->sm_name, "--url", info->realrepo, =
NULL);
>=20
> Maybe this unconditional strvec_pushl(...) could be squashed into the
> strvec_push(&clone_args, "clone") above.

Got it.

>> +               if (info->reference_path)
>> +                       strvec_pushl(&clone_args, "--reference",
>> +                                    info->reference_path, NULL);
>> +
>> +               if (info->dissociate)
>> +                       strvec_push(&clone_args, "--dissociate");
>> +
>=20
> Blank lines since the above strvec_push(&clone_args, "clone") could
> perhaps be removed.

Will do.

>> [...]
>> +       const char *const usage[] =3D {
>> +               N_("git submodule--helper clone [--prefix=3D<path>] =
[--quiet] [--force] "
>=20
> s/clone/add-clone/
>=20
>> +                  "[--reference <repository>] [--depth <depth>] =
[-b|--branch <branch>]"
>> +                  "--url <url> --path <path> --name <name>"),
>=20
> The --progress and --dissociate options seem to be missing.

Thanks, will fix.

>> +               NULL
>> +       };

