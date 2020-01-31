Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937D8C33CB2
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 10:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401BF20705
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 10:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzHrfear"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgAaKxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:53:44 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:46322 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgAaKxo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 05:53:44 -0500
Received: by mail-il1-f196.google.com with SMTP id t17so5728412ilm.13
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 02:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wFdfEZPHQmXILSQXACbCzkCNihCJAOTc+Fjfg5kCNlY=;
        b=lzHrfear3hmQJ7WgSUK7WdpfyuU9XzhkD2tnWNtX1OFbDoHyvOE98yorKEyeA/l23H
         tULV82NDB8cqL0LIe9KioNoAk2LEMKVoswXfVUO4dAaGFNDTexrG3DFVE990C5prz7k/
         C1Xrhxga5RKccvXJmRUdIXqBoICZNqy6EnKuXJ6ks9ZAnbZMVXpFSihv32I+eQYhoRFC
         ovVOaUaB2Z9o6YMy+fEbKmizPO6/VU5V8aF1TUYHx60qkOOJA/v1N4GKu3bndIZPTrEs
         ieVEuS8tMoSWk7+kZ/LXqt2N0xxlKHUQ04J6liurif29EfvdCWVze5eVQGVwlluNDU5g
         iPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wFdfEZPHQmXILSQXACbCzkCNihCJAOTc+Fjfg5kCNlY=;
        b=qcqrUCVbQHwGOwuMq4TXBwouocM9JljTPqg0Ky69l4jKW7xt1af2OTIEYhxnJeBzg2
         +Vzll9UOWohyfA0LYMEEnEmX/30L+2mGZP256FEC2OBRHEeykdyndnVsqn1mf6if7R8M
         4V8aAWSfs3zm6SXIDuYINOQdGUgyy/psGED7ccxOiw/auRGtUKqrxO0/52JV4MJn+h2p
         Ljp2Hc6dESRPoHHZcmOzx1yLz1pfOvmlqXmVOkUYV5rRHuijqk5+hwg22uP6m9cNzS3L
         ERshjNFuhMYr7dK6NwJD3efNX/JYL4Mbk75lw/et6ieozOKChsq3ej7Fwdzl5vyFo48F
         Sv0A==
X-Gm-Message-State: APjAAAXmNeT+H+G7NYOaPJ+SiKy8I3MDZTOIXAK+gZWnsHb+1B3FEuwM
        5FHEmjdri+I/WNCClSNY+y8n68so5lbC4ggdnTs=
X-Google-Smtp-Source: APXvYqyZbe1BIBzhfkxEh2JsNP94XUFkLIyq6ggMVIzXrUMIJgruC2ajODQwSXBYHwJlUeUQn6kYQcvcFkdi0DVb4Ec=
X-Received: by 2002:a92:ca8b:: with SMTP id t11mr2185411ilo.227.1580468021456;
 Fri, 31 Jan 2020 02:53:41 -0800 (PST)
MIME-Version: 1.0
References: <20200120143800.900-1-mirucam@gmail.com> <20200120143800.900-13-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2001301619340.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001301619340.46@tvgsbejvaqbjf.bet>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Fri, 31 Jan 2020 11:53:30 +0100
Message-ID: <CAN7CjDCX6ohY4HHGe2EOFWf-U8wpM=xxRsPG8N7z4RjiQT0Qzg@mail.gmail.com>
Subject: Re: [PATCH 12/29] bisect--helper: reimplement `bisect_next` and
 `bisect_auto_next` shell functions in C
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


El jue., 30 ene. 2020 a las 23:47, Johannes Schindelin
(<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
>
> Hi Miriam,
>
> I started looking at this patch, and will just send the comments, but
> please note that I would not mind at all leaving the review for later,
> when the libifying patches that you kept in v2 (and probably will send ou=
t
> a v3 for) made it into `next` and you send the remainder as a new patch
> series.

Yes, sure. Thank you, Johannes.

>
> On Mon, 20 Jan 2020, Miriam Rubio wrote:
>
> > From: Pranit Bauva <pranit.bauva@gmail.com>
> >
> > Reimplement the `bisect_next()` and the `bisect_auto_next()` shell func=
tions
> > in C and add the subcommands to `git bisect--helper` to call them from
> > git-bisect.sh .
> >
> > Using `--bisect-next` and `--bisect-auto-start` subcommands is a
> > temporary measure to port shell function to C so as to use the existing
> > test suite. As more functions are ported, `--bisect-auto-start`
> > subcommand will be retired and will be called by some other methods.
>
> This still sounds clear enough.
>
> > Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> > Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> > Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> > ---
> >  bisect.c                 |  10 +++
> >  builtin/bisect--helper.c | 174 ++++++++++++++++++++++++++++++++++++++-
> >  git-bisect.sh            |  47 ++---------
> >  3 files changed, 188 insertions(+), 43 deletions(-)
> >
> > diff --git a/bisect.c b/bisect.c
> > index 33f2829c19..1c13da8a28 100644
> > --- a/bisect.c
> > +++ b/bisect.c
> > @@ -635,6 +635,12 @@ static void bisect_rev_setup(struct repository *r,=
 struct rev_info *revs,
> >       struct argv_array rev_argv =3D ARGV_ARRAY_INIT;
> >       int i;
> >
> > +     /*
> > +      * Since the code is slowly being converted to C, there might be
> > +      * instances where the revisions were initialized before. Thus
> > +      * we first need to reset it.
> > +      */
>
> This comment sounds good right now, but is prone to get stale rather
> quickly.
>
> But that's actually remedied rather easily: if the comment is reworded
> only slightly, to avoid talking about the conversion process, and to
> mention instead that `revs` could have been used before, then we're
> golden.
Ok
>
> > +     reset_revision_walk();
> >       repo_init_revisions(r, revs, prefix);
> >       revs->abbrev =3D 0;
> >       revs->commit_format =3D CMIT_FMT_UNSPECIFIED;
> > @@ -971,6 +977,10 @@ void read_bisect_terms(const char **read_bad, cons=
t char **read_good)
> >   * finished successfully.
> >   * In this case the calling function or command should not turn a -10
> >   * return code into an error or a non zero exit code.
>
> I'd like to have an empty line here (well, a line that only contains an
> indented `*`).
Noted.
>
> > + * This returned -10 is checked in bisect_helper::bisect_next() and
> > + * eventually transformed to 0 at the end of
> > + * bisect_helper::cmd_bisect__helper().
>
> This says _what_ it does. But not why. I would contend that it is much
> more important to know what role the `-10` serves than explaining where
> the role is acted out.
Aha.
>
> > + *
> >   * If no_checkout is non-zero, the bisection process does not
> >   * checkout the trial commit but instead simply updates BISECT_HEAD.
> >   */
> > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> > index 5e0f759d50..29bbc1573b 100644
> > --- a/builtin/bisect--helper.c
> > +++ b/builtin/bisect--helper.c
> > @@ -8,6 +8,7 @@
> >  #include "run-command.h"
> >  #include "prompt.h"
> >  #include "quote.h"
> > +#include "revision.h"
> >
> >  static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
> >  static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_RE=
V")
> > @@ -29,6 +30,8 @@ static const char * const git_bisect_helper_usage[] =
=3D {
> >       N_("git bisect--helper --bisect-terms [--term-good | --term-old |=
 --term-bad | --term-new]"),
> >       N_("git bisect--helper --bisect-start [--term-{old,good}=3D<term>=
 --term-{new,bad}=3D<term>]"
> >                                            "[--no-checkout] [<bad> [<go=
od>...]] [--] [<paths>...]"),
> > +     N_("git bisect--helper --bisect-next"),
> > +     N_("git bisect--helper --bisect-auto-next"),
> >       NULL
> >  };
> >
> > @@ -421,6 +424,157 @@ static int bisect_append_log_quoted(const char **=
argv)
> >       return res;
> >  }
> >
> > +static int register_good_ref(const char *refname,
> > +                          const struct object_id *oid, int flags,
> > +                          void *cb_data)
> > +{
> > +     struct string_list *good_refs =3D cb_data;
> > +     string_list_append(good_refs, oid_to_hex(oid));
> > +     return 0;
> > +}
> > +
> > +static void prepare_rev_argv(struct bisect_terms *terms, struct argv_a=
rray *rev_argv)
> > +{
> > +     struct string_list good_revs =3D STRING_LIST_INIT_DUP;
> > +     char *term_good =3D xstrfmt("%s-*", terms->term_good);
> > +
> > +     for_each_glob_ref_in(register_good_ref, term_good,
> > +                          "refs/bisect/", &good_revs);
> > +
> > +     argv_array_pushl(rev_argv, "skipped_commits", "refs/bisect/bad", =
"--not", NULL);
> > +     for (int i =3D 0; i < good_revs.nr; i++)
> > +             argv_array_push(rev_argv, good_revs.items[i].string);
> > +
> > +     string_list_clear(&good_revs, 0);
> > +     free(term_good);
> > +}
>
> Maybe we should fold that into `prepare_revs()`? We could then render the
> arguments directly into `revs` (via `add_pending_object()`, after setting
> obj->flags |=3D UNINTERESTING`) rather than formatting them into a string
> list, then deep-copy them into an `argv_array` only to parse them back
> into OIDs that we already had in the first place.
>
> > +
> > +static int prepare_revs(struct bisect_terms *terms, struct rev_info *r=
evs)
> > +{
> > +     int res =3D 0;
> > +     struct argv_array rev_argv =3D ARGV_ARRAY_INIT;
> > +
> > +     prepare_rev_argv(terms, &rev_argv);
> > +
> > +     /*
> > +      * It is important to reset the flags used by revision walks
> > +      * as the previous call to bisect_next_all() in turn
> > +      * setups a revision walk.
> > +      */
> > +     reset_revision_walk();
> > +     init_revisions(revs, NULL);
> > +     rev_argv.argc =3D setup_revisions(rev_argv.argc, rev_argv.argv, r=
evs, NULL);
> > +     if (prepare_revision_walk(revs))
> > +             res =3D error(_("revision walk setup failed\n"));
> > +
> > +     argv_array_clear(&rev_argv);
> > +     return res;
> > +}
> > +
> > +static int process_skipped_commits(FILE *fp, struct bisect_terms *term=
s, struct rev_info *revs)
> > +{
> > +     struct commit *commit;
> > +     struct pretty_print_context pp =3D {0};
> > +
> > +     if (fprintf(fp, "# only skipped commits left to test\n") < 1)
> > +             return -1;
> > +
> > +     while ((commit =3D get_revision(revs)) !=3D NULL) {
> > +             struct strbuf commit_name =3D STRBUF_INIT;
> > +             format_commit_message(commit, "%s",
> > +                                   &commit_name, &pp);
> > +             fprintf(fp, "# possible first %s commit: [%s] %s\n",
> > +                     terms->term_bad, oid_to_hex(&commit->object.oid),
> > +                     commit_name.buf);
> > +             strbuf_release(&commit_name);
> > +     }
>
> In the interest of allowing further revision walks, we will probably need
> to re-set the flags via `clear_commit_marks()`, just like
> `check_ancestors()` does.
>
> > +
> > +     return 0;
> > +}
> > +
> > +static int bisect_skipped_commits(struct bisect_terms *terms)
> > +{
> > +     int res =3D 0;
> > +     FILE *fp =3D NULL;
> > +     struct rev_info revs;
> > +
> > +     fp =3D fopen(git_path_bisect_log(), "a");
> > +     if (!fp)
> > +             return error_errno(_("could not open '%s' for appending")=
,
> > +                               git_path_bisect_log());
> > +
> > +     res =3D prepare_revs(terms, &revs);
> > +
> > +     if (!res)
> > +             res =3D process_skipped_commits(fp, terms, &revs);
> > +
> > +     fclose(fp);
> > +     return res;
> > +}
>
> This is again a very short wrapper around another function, so it will
> probably make sense to merge the two, otherwise the boilerplate might ver=
y
> well outweigh the actual code doing actual work.
>
> > +
> > +static int bisect_successful(struct bisect_terms *terms)
> > +{
> > +     FILE *fp =3D NULL;
> > +     struct object_id oid;
> > +     struct commit *commit;
> > +     struct pretty_print_context pp =3D {0};
> > +     struct strbuf commit_name =3D STRBUF_INIT;
> > +     char *bad_ref =3D xstrfmt("refs/bisect/%s",
> > +                             terms->term_bad);
> > +     int res =3D 0;
> > +
> > +     read_ref(bad_ref, &oid);
> > +     printf("%s\n", bad_ref);
> > +     commit =3D lookup_commit_reference(the_repository, &oid);
> > +     format_commit_message(commit, "%s", &commit_name, &pp);
> > +
>
> There is a trailing tab here. Maybe it would make sense to check the
> patches via `git log --check`?
These extra trailing tabs are removed in my working branch :)
This is my last branch:
https://gitlab.com/mirucam/git/commits/git-bisect-work3.3.1.
>
> > +     fp =3D fopen(git_path_bisect_log(), "a");
> > +     if (fp) {
> > +             if (fprintf(fp, "# first %s commit: [%s] %s\n",
> > +                         terms->term_bad, oid_to_hex(&oid),
> > +                         commit_name.buf) < 1)
> > +                     res =3D -1;
>
> This would probably do with an error message, i.e. `res =3D
> error_errno(...);`
>
> > +             fclose(fp);
> > +     } else {
> > +             res =3D error_errno(_("could not open '%s' for "
> > +                                 "appending"),
> > +                               git_path_bisect_log());
> > +     }
>
> This pattern of opening a file, writing something into it, and then retur=
n
> success, otherwise failure, seems like a repeated pattern. In other words=
,
> it would be a good candidate for factoring out into its own function.
>
> > +     strbuf_release(&commit_name);
> > +     free(bad_ref);
> > +     return res;
> > +}
> > +
> > +static int bisect_next(struct bisect_terms *terms, const char *prefix)
> > +{
> > +     int res, no_checkout;
> > +
> > +     if (bisect_next_check(terms, terms->term_good))
> > +             return -1;
> > +
> > +     no_checkout =3D !is_empty_or_missing_file(git_path_bisect_head())=
;
> > +
> > +     /* Perform all bisection computation, display and checkout */
> > +     res =3D bisect_next_all(the_repository, prefix, no_checkout);
> > +
> > +     if (res =3D=3D -10) {
> > +             res =3D bisect_successful(terms);
> > +             return res ? res : -11;
> > +     } else if (res =3D=3D -2) {
> > +             res =3D bisect_skipped_commits(terms);
> > +             return res ? res : -2;
> > +     }
>
> I know exactly what I'll think if I see those constants six months from
> now, when I forgot most of the details of our conversation over here. A
> -10 means.. wait, what?
>
> Seriously, it is quite bad to keep those constants unexplained.
>
> In contrast, look at this here code:
>
>         enum scld_error {
>                 SCLD_OK =3D 0,
>                 SCLD_FAILED =3D -1,
>                 SCLD_PERMS =3D -2,
>                 SCLD_EXISTS =3D -3,
>                 SCLD_VANISHED =3D -4
>         };
>         enum scld_error safe_create_leading_directories(char *path);
>
> What do you think? Will any reader stumble over this and say "what the
> heck is going on? What are these return values even _supposed_ to mean?"?
>
> Even better, it seems as if modern debuggers can figure out that a value
> -4 returned from `safe_create_leading_directories()` actually mean
> `SCLD_VANISHED` and display that to the user.
>
> So armed with this example, you could of course go back to your mentor an=
d
> ask for permission to change the bisect code accordingly.
>
> You could also just decide on your own that this is what you want to do
> because it is so much more elegant, anyway.
>
> > +     return res;
> > +}
> > +
> > +static int bisect_auto_next(struct bisect_terms *terms, const char *pr=
efix)
> > +{
> > +     if (!bisect_next_check(terms, NULL))
> > +             return bisect_next(terms, prefix);
> > +
> > +     return 0;
>
> A common pattern in Git's source code is to present the early return
> first, i.e.
>
>         if (bisect_next_check(terms, NULL))
>                 return 0;
>
>         return bisect_next(terms, prefix);
>
> I do find it easier to read that way, too.
>
> > +
> >  static int bisect_start(struct bisect_terms *terms, int no_checkout,
> >                       const char **argv, int argc)
> >  {
> > @@ -625,7 +779,9 @@ int cmd_bisect__helper(int argc, const char **argv,=
 const char *prefix)
> >               CHECK_AND_SET_TERMS,
> >               BISECT_NEXT_CHECK,
> >               BISECT_TERMS,
> > -             BISECT_START
> > +             BISECT_START,
> > +             BISECT_NEXT,
> > +             BISECT_AUTO_NEXT,
> >       } cmdmode =3D 0;
> >       int no_checkout =3D 0, res =3D 0, nolog =3D 0;
> >       struct option options[] =3D {
> > @@ -649,6 +805,10 @@ int cmd_bisect__helper(int argc, const char **argv=
, const char *prefix)
> >                        N_("print out the bisect terms"), BISECT_TERMS),
> >               OPT_CMDMODE(0, "bisect-start", &cmdmode,
> >                        N_("start the bisect session"), BISECT_START),
> > +             OPT_CMDMODE(0, "bisect-next", &cmdmode,
> > +                      N_("find the next bisection commit"), BISECT_NEX=
T),
> > +             OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
> > +                      N_("verify the next bisection state then checkou=
t the next bisection commit"), BISECT_AUTO_NEXT),
> >               OPT_BOOL(0, "no-checkout", &no_checkout,
> >                        N_("update BISECT_HEAD instead of checking out t=
he current commit")),
> >               OPT_BOOL(0, "no-log", &nolog,
> > @@ -710,6 +870,18 @@ int cmd_bisect__helper(int argc, const char **argv=
, const char *prefix)
> >               set_terms(&terms, "bad", "good");
> >               res =3D bisect_start(&terms, no_checkout, argv, argc);
> >               break;
> > +     case BISECT_NEXT:
> > +             if (argc)
> > +                     return error(_("--bisect-next requires 0 argument=
s"));
> > +             get_terms(&terms);
> > +             res =3D bisect_next(&terms, prefix);
> > +             break;
> > +     case BISECT_AUTO_NEXT:
> > +             if (argc)
> > +                     return error(_("--bisect-auto-next requires 0 arg=
uments"));
> > +             get_terms(&terms);
> > +             res =3D bisect_auto_next(&terms, prefix);
> > +             break;
> >       default:
> >               return error("BUG: unknown subcommand '%d'", cmdmode);
> >       }
> > diff --git a/git-bisect.sh b/git-bisect.sh
> > index efee12b8b1..7531b74708 100755
> > --- a/git-bisect.sh
> > +++ b/git-bisect.sh
> > @@ -87,7 +87,7 @@ bisect_start() {
> >       # Check if we can proceed to the next bisect state.
> >       #
> >       get_terms
> > -     bisect_auto_next
> > +     git bisect--helper --bisect-auto-next || exit
> >
> >       trap '-' 0
> >  }
> > @@ -140,45 +140,7 @@ bisect_state() {
> >       *)
> >               usage ;;
> >       esac
> > -     bisect_auto_next
> > -}
> > -
> > -bisect_auto_next() {
> > -     git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD && bi=
sect_next || :
> > -}
> > -
> > -bisect_next() {
> > -     case "$#" in 0) ;; *) usage ;; esac
> > -     bisect_autostart
> > -     git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD $TERM=
_GOOD|| exit
> > -
> > -     # Perform all bisection computation, display and checkout
> > -     git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" &&=
 echo --no-checkout)
> > -     res=3D$?
> > -
> > -     # Check if we should exit because bisection is finished
> > -     if test $res -eq 10
> > -     then
> > -             bad_rev=3D$(git show-ref --hash --verify refs/bisect/$TER=
M_BAD)
> > -             bad_commit=3D$(git show-branch $bad_rev)
> > -             echo "# first $TERM_BAD commit: $bad_commit" >>"$GIT_DIR/=
BISECT_LOG"
> > -             exit 0
> > -     elif test $res -eq 2
> > -     then
> > -             echo "# only skipped commits left to test" >>"$GIT_DIR/BI=
SECT_LOG"
> > -             good_revs=3D$(git for-each-ref --format=3D"%(objectname)"=
 "refs/bisect/$TERM_GOOD-*")
> > -             for skipped in $(git rev-list refs/bisect/$TERM_BAD --not=
 $good_revs)
> > -             do
> > -                     skipped_commit=3D$(git show-branch $skipped)
> > -                     echo "# possible first $TERM_BAD commit: $skipped=
_commit" >>"$GIT_DIR/BISECT_LOG"
> > -             done
> > -             exit $res
> > -     fi
> > -
> > -     # Check for an error in the bisection process
> > -     test $res -ne 0 && exit $res
> > -
> > -     return 0
> > +     git bisect--helper --bisect-auto-next
>
> Beautiful.
>
> >  }
> >
> >  bisect_visualize() {
> > @@ -232,7 +194,7 @@ bisect_replay () {
> >                       die "$(gettext "?? what are you talking about?")"=
 ;;
> >               esac
> >       done <"$file"
> > -     bisect_auto_next
> > +     git bisect--helper --bisect-auto-next
> >  }
> >
> >  bisect_run () {
> > @@ -329,7 +291,8 @@ case "$#" in
> >               bisect_skip "$@" ;;
> >       next)
> >               # Not sure we want "next" at the UI level anymore.
> > -             bisect_next "$@" ;;
> > +             get_terms
>
> I vaguely remember that we talked about this, or at least about a similar
> scenario. It needs to be explained in the commit message why we need to
> call `get_terms` here when previously, we did not.
>
> Of course, after thinking about this and looking around for a couple of
> minutes, I know why. My point is that I, or for that matter, any reader o=
f
> this commit, should not need to repeat that analysis.
>
> Other than that, the patch looks good.
>
For the rest of your suggestions I haven't answered, I will wait to my
mentor opinion first. :)
Thank you.

> As I said, I will stop reviewing the remainder of this patch series, as i=
t
> has been removed from v2 and will probably be presented as a follow-up
> patch series soon.
>
Yes, they will be sent as soon as the part1 is in `next`:).

Best,
Miriam
> Thanks,
> Dscho
>
> > +             git bisect--helper --bisect-next "$@" || exit ;;
> >       visualize|view)
> >               bisect_visualize "$@" ;;
> >       reset)
> > --
> > 2.21.1 (Apple Git-122.3)
> >
> >
