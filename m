Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B461C2BA19
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545A520736
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHrzaX3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgDWHSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWHSU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 03:18:20 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589C5C03C1AB
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:18:20 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id b18so4600256ilf.2
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Aa44Z7dFIEDosfpEkqCujBLFLoKdAdIR6226e5iNq8c=;
        b=ZHrzaX3vTieQ4UdThpgGNgmyxgkLAE2oXOPQpmFavgGwbGt3aFUuy9iEhWVOfwHE0y
         HiO0zW8JwNLxfFWn28tmEb9CfCVlMo4GdK4qSHfV6YWrlntTvHoLtkzyO7wbdcvGvN22
         +BrwfB778RKBEJgqCEd56uyPsPSCMGn0jfYwSqQ38Ls0/NSbO1R9kTeiHbci3TkComcE
         sqkblYMgdypXkpSwuWfboHOgLZYUKm2wcu3MWMG+Mrrhff8+ODw414agjA84CJ40KZ03
         8fmCIsIXLMcn2PGs9RBE7Beo/4K5RpcofxC8gfSlkadLIDWfl8jwK4GcDhZt/TFspfJO
         KtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Aa44Z7dFIEDosfpEkqCujBLFLoKdAdIR6226e5iNq8c=;
        b=IBYsHI9H0wPhIWDtuCkdyZ3vurVQJ+obpGGCjuQC0+agEZHl94Bc1i1dsREldHphH1
         1cdO+wBKZI9Y81MvzsTAbjuaMhHmmM8km4uMtSoE07CWZy6gH2MmborTeSjCrBOjKEE7
         74FjkxyKUteW6Aci+p7BctpbdKkFK8IocuO001pXHtOXKqZvv++b184xSLE0V8+3UBYq
         xIldYo0DhNqQyyFICoW0ByEfinfYjgTXBfxXH9RmzdQARGDpwDvCp+4AK1MrgnkCCrK/
         AruNjKHM3+/6qlDgBk4qXfUK5/cWlN9JdhSDNiHri+4dtWxLYTJITCsXgQkQYb/2wKI/
         8Hmg==
X-Gm-Message-State: AGi0Pubugt4JqedYIn/aytoPiRHaQ/29x89d+J05MHhw9Z6YL2cLPnYa
        Skr6Lhnge8pF/hcjrCJ9hV/rqRbDf0Qf5cfKk50fJRD7aD4=
X-Google-Smtp-Source: APiQypI8g7DoESw2DC9BQi72b+ka16akKEW0ZTcmpTTXKznLosP7VCpzH7/C3IsitHIbq6pADcBAi//6WQZ0ftsBa0s=
X-Received: by 2002:a92:2c0d:: with SMTP id t13mr1944761ile.127.1587626299466;
 Thu, 23 Apr 2020 00:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200321161020.22817-1-mirucam@gmail.com> <20200321161020.22817-4-mirucam@gmail.com>
 <xmqq4ku0z2r0.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq4ku0z2r0.fsf@gitster.c.googlers.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Thu, 23 Apr 2020 09:18:08 +0200
Message-ID: <CAN7CjDDcqZO=Mh9-Hjj6kgMGcfg2o6=7F4iPAc68JWpnWMFMGQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] bisect--helper: reimplement `bisect_next` and
 `bisect_auto_next` shell functions in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,
thank you very much for reviewing, I have just sent the new version of
this patch series with your suggestions.

El vie., 3 abr. 2020 a las 23:19, Junio C Hamano (<gitster@pobox.com>) escr=
ibi=C3=B3:
>
> Miriam Rubio <mirucam@gmail.com> writes:
>
> > diff --git a/bisect.c b/bisect.c
> > index 9154f810f7..a50278ea7e 100644
> > --- a/bisect.c
> > +++ b/bisect.c
> > @@ -635,6 +635,11 @@ static void bisect_rev_setup(struct repository *r,=
 struct rev_info *revs,
> >       struct argv_array rev_argv =3D ARGV_ARRAY_INIT;
> >       int i;
> >
> > +     /*
> > +      * `revs` could has been used before.
> > +      * Thus we first need to reset it.
> > +      */
> > +     reset_revision_walk();
> >       repo_init_revisions(r, revs, prefix);
>
> I don't have enough time and concentration to follow all the
> codepaths in "bisect" that walk the commit graph starting here, but
> seeing one codepath, e.g. check_ancestors(), after calling this and
> walking with bisect_common(), uses clear_commit_marks_many() to
> clear ALL_REV_FLAGS, not just the ones that reset_revision_walk()
> clears, I am not sure what value this addition has.
>
> To put it differently, what codepath are you protecting the revision
> walk that is about to happen against with this "reset"?  Who are the
> callers that could have used `revs` before calling this function and
> touched only SEEN, ADDED, SHOWN, etc. without touching other bits
> like COUNTED, TREESAME, UNINTERESTING that matter to the correct
> operation of "bisect"?
>
> The rest of the patch looks quite reasonably done.  Let me comment
> on the patch out of order (in other words, I'll rearrange the
> functions in the order I read them).  I am realizing that I feel it
> easier to understand to read the code in a bottom-up fashion.
>
> > +static enum bisect_error bisect_auto_next(struct bisect_terms *terms, =
const char *prefix)
> > +{
> > +     if (bisect_next_check(terms, NULL))
> > +             return BISECT_OK;
>
> The bisect_next_check() function returns what decide_next() returns,
> which is either 0 or error() which is -1.  So this says "if
> nect-check says there was an error, we return OK".  For the purpose
> of not proceeding to bisect_next(), returning is perfectly correct,
> but is the value returned correct?  The scripted original does
>
>   git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD && bisect_n=
ext || :
>
> meaning "try next-check and go on to bisect_next if check succeeds;
> either way, ignore all errors from them".  So it probably is more
> faithful conversion to make the returned value from auto_next()
> void.
>
> > +
> > +     return bisect_next(terms, prefix);
> > +}
>
> In any case, this conversion of auto_next looks like a good one,
> with or without fixing its type.  The caller in cmd_bisect__helper()
> seems to store the returned value in 'res' and uses it for the exit
> status, but for this to be a faithful conversion, it should ignore
> the returned value from here and always exit with success (and if we
> do so, it is one more reason why we would want to update the type of
> this function to return void).
>

I cannot change bisect_auto_next()  to return void because
in shell the bisect_next() function used "exit $res" , so the following cod=
e:

git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD && bisect_next =
|| :

can result that whole `git bisect` exits with an error code when
bisect_next() does an "exit $res" with $res !=3D 0.

So errors from bisect_next() are not ignored and I cannot make
bisect_auto_next() return void.

Best,
Miriam.


> > +static enum bisect_error bisect_next(struct bisect_terms *terms, const=
 char *prefix)
> > +{
> > +     int no_checkout;
> > +     enum bisect_error res;
> >
> > +     if (bisect_next_check(terms, terms->term_good))
> > +             return BISECT_FAILED;
>
> The original makes sure it does not get any argument, but that is
> done in cmd_bisect__helper(), so it is OK.
>
> The next thing the original does is to call bisect_autostart, before
> doing the next-check.  Was it a dead code that wasn't necessary, or
> is its loss a regression during the conversion?
>
> > +
> > +     no_checkout =3D !is_empty_or_missing_file(git_path_bisect_head())=
;
> > +
> > +     /* Perform all bisection computation, display and checkout */
> > +     res =3D bisect_next_all(the_repository, prefix, no_checkout);
>
> Looking good.  We've already converted next_all() in the previous
> series, and we call it the same way as the original by checking if
> $GIT_DIR/BISECT_HEAD is there.  The original said "if BISECT_HEAD
> exists as a file, use '--no-checkout'" and did not care if its empty
> or not, but the updated code seems to care.  Does the difference
> matter (i.e. is it more correct to ignore an empty BISECT_HEAD and
> pretend as if it did not exist)?
>
> > +     if (res =3D=3D BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
> > +             res =3D bisect_successful(terms);
> > +             return res ? res : BISECT_INTERNAL_SUCCESS_MERGE_BASE;
>
> It is unclear why "1st bad commit found" is turned into "success
> merge base" here.  bisect_successfull() returns an error when it
> cannot append to the log, and otherwise we would want to relay "we
> are done successfully" back to the caller, no?  Puzzled....
>
> > +     } else if (res =3D=3D BISECT_ONLY_SKIPPED_LEFT) {
> > +             res =3D bisect_skipped_commits(terms);
> > +             return res ? res : BISECT_ONLY_SKIPPED_LEFT;
> > +     }
> > +     return res;
> > +}
> > +
>
> This side, I can understand what it wants to do to the "we only have
> skipped ones so we cannot continue" status.
>
> What is done in bisect_skipped_commits() is dubious, though (we'll
> see it later).
>
>
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
> > +
>
> Opens the log to append to, or returns if we cannot.  Calls
> prepare_revs() and process() if successfully prepared, and then
> close.  No resource leak, and the returned value is the result code
> from the last function that matters.  Looks good.
>
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
> > +      * sets up a revision walk.
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
>
> Unlike the one in rev_setup() above, the only codepath this thing is
> used is quite limited (i.e. after doing all the bisection
> computation including walking the graph and counting the weights
> with various bits in bisect_next) and we know all that is left to do
> is to run a single rev-list call, so it is clear to see that
> reset_revision_walk() is sufficient here.
>
> > +static void prepare_rev_argv(struct bisect_terms *terms, struct argv_a=
rray *rev_argv)
> > +{
> > +     char *term_good =3D xstrfmt("%s-*", terms->term_good);
> > +
> > +     argv_array_pushl(rev_argv, "skipped_commits", "refs/bisect/bad", =
"--not", NULL);
> > +     for_each_glob_ref_in(register_good_ref, term_good, "refs/bisect/"=
, rev_argv);
> > +
> > +     free(term_good);
> > +}
> > +
>
> This sets up to find commits that can be reached by BAD that cannot
> be reached by any GOOD revs, which is a quite faithful translation
> from the original one.
>
> > +static int process_skipped_commits(FILE *fp, struct bisect_terms *term=
s, struct rev_info *revs)
> > +{
> > +     struct commit *commit;
> > +     struct pretty_print_context pp =3D {0};
> > +
> > +     if (fprintf(fp, "# only skipped commits left to test\n") < 1)
> > +             return -1;
>
> What's that comparison with "< 1" doing?  That's a 36-byte message,
> and you are saying that it is OK if we showed only 10-byte from it,
> but it is not OK, even if the function did not report an output error
> by returning a negative value, if it returned that it wrote 0 bytes?
>
> I can understand it if it were
>
>         if (fprintf(fp, "...") < 0)
>                 return error_errno(_("failed to write to ..."));
>
> though.
>
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
> Again, this is a faithful translation of the rev-list that appears
> in the original, provided that &revs was set up correctly, and
> relevant object flags cleared correctly before we start the
> traversal, both of which seem to be the case.
>
> > +     /*
> > +      * Reset the flags used by revision walks in case
> > +      * there is another revision walk after this one.
> > +      */
> > +     reset_revision_walk();
> > +
> > +     return 0;
> > +}
> > +
>
> So, overall, this step was a quite pleasant read, except for the
> very first bit above.
>
> Thanks.
>
> > +static int register_good_ref(const char *refname,
> > +                          const struct object_id *oid, int flags,
> > +                          void *cb_data)
> > +{
> > +     struct argv_array *rev_argv =3D cb_data;
> > +
> > +     argv_array_push(rev_argv, oid_to_hex(oid));
> > +     return 0;
> > +}
> > +
> > +static int bisect_successful(struct bisect_terms *terms)
> > +{
> > +     struct object_id oid;
> > +     struct commit *commit;
> > +     struct pretty_print_context pp =3D {0};
> > +     struct strbuf commit_name =3D STRBUF_INIT;
> > +     char *bad_ref =3D xstrfmt("refs/bisect/%s",terms->term_bad);
> > +     int res;
> > +
> > +     read_ref(bad_ref, &oid);
> > +     printf("%s\n", bad_ref);
> > +     commit =3D lookup_commit_reference(the_repository, &oid);
> > +     format_commit_message(commit, "%s", &commit_name, &pp);
> > +
> > +     res =3D write_in_file(git_path_bisect_log(), "a", "# first %s com=
mit: [%s] %s\n",
> > +                         terms->term_bad, oid_to_hex(&oid),
> > +                         commit_name.buf);
> > +
> > +     strbuf_release(&commit_name);
> > +     free(bad_ref);
> > +     return res;
> > +}
> > +
