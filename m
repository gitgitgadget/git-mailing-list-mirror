Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D62FC433E0
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 12:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 517F0206FA
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 12:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Et3Z832B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgFVMSB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:18:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:50941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgFVMSA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 08:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592828277;
        bh=vkbsL5VI7QtBkYuGCF7B+THOppRyk/nUK6xoel6d/dc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Et3Z832BQahPJmIn4/J7x2kKe5B9MlU9LzXj3qL5tXPsOeMyeyXbpbiXgkbhqWgkK
         B1GiEOoEUhOE81EzoqvrokT542Sr/EuHuJmWnGPuzL9dgebIfg4TPfJpTN6OCpfcdA
         R+Cl3tNZMAkNX40vjQVmunLik0rjpaDMZNOXW3VQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.213.251]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6sn1-1inOw60X67-018GVa; Mon, 22
 Jun 2020 14:17:57 +0200
Date:   Fri, 19 Jun 2020 15:57:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Miriam R." <mirucam@gmail.com>
cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH v3 09/12] bisect--helper: reimplement `bisect_state` &
 `bisect_head` shell functions in C
In-Reply-To: <CAN7CjDAnksyerW_sEDLFS=GT0g7rLt53dUA09a8jAqnZb9P_8w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2006191555170.54@tvgsbejvaqbjf.bet>
References: <20200423070704.39872-1-mirucam@gmail.com> <20200423070704.39872-10-mirucam@gmail.com> <nycvar.QRO.7.76.6.2005222311120.56@tvgsbejvaqbjf.bet> <CAN7CjDAnksyerW_sEDLFS=GT0g7rLt53dUA09a8jAqnZb9P_8w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2031935800-1592575062=:54"
X-Provags-ID: V03:K1:BR1YnnEWwG43oPf2xYPGB8xIBHQp7OBihvtkak1cDZJ3PZT2GIQ
 fvu/UNUfvBS2/lkCwzueD4Y8ylMyIbuBN0BEwjHFUCTiBNKrUnqPa1b64ArwkjAOAnygr+E
 5XmWSS7oVXlHyytjyFjkaUtPM7In/NaMRV6KAM2lvCwnK0jrCZBF65qafegHYjKxzMmuDcX
 k5DQ4H1ObT3wuAWtCfnVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NVEafYMWLMs=:ry+ScpyBLBerIs02LTlYS/
 6oF7BTh5toBhUdt0c/PdnS8j6b/7cnGdKKd4h43sq5ZnaPf64fYNIwmb5z42fgz+pi34grA9X
 mscmjJccg1G9R9o4Apc6b4ec8Gx05VHw3C3qePYFS61arhKT9EwdqZTKWUtUext9i1ZD+Himv
 vfmLNWifssJsK0OvI3N7yo9acG5XIsSDYBN2WvqCBoKDiCr9BpglHyfNPLZFx7o8JcoMvEl+8
 9s6pGPsXVb6QHE1jN+ixqxRGlMy/vzSdJAmZUjmoqdZ1cneOv+3UKQCbKvZWslVjYjNu2ARl8
 7osG3v2+wDFyBPKgltRgYUFyTRoJul6t2RSD6gOjMR4rs1lvXxEbSWVIqXVyHBccvjz5QDmvh
 DocGHIGgtMuWjCqe6tnyM7aCOXRGhjeYPLcOBcdOX7QVUEYQwjV5Evop8X8aRdQux9QMP90pg
 flxn+BXa7FcdNsEAtp/mva6yakN4btkvaq98b0+/Nuh77mgFxOJCkZGg/KNoGIrlkemFQD45h
 /bR6FSAaapJEUrE3x/c3tgX3sHmzO5smNbDii9oQxSnd0wZjPaTlu5aBMW3oxtAc5x0+kmUTP
 PomCJSV6LCa3WkDcbNZWUEk1a+Gzf0Rj4OjEWAbqkM/t9dC0nHeq/zqyYAVtTSlBLnuJLRjFD
 Lqw079CFkTgbZIYb8QQQuii/15jw8Y3mvk6TA2p6irv6Lc5y8ZK7U9IDSlbWDXOmuUHWBCl4Q
 UgJtg42lsdbuHeL79s6Ut/OknMCg1X19yuPRN7RieTu/ytImujL0ZmzJ6H0FcJ4O85/OM/jtl
 h4/xlDVfRzhGFhjoKYamhrGLaZ+g3oYB3Y+nhNWWk8WtDt82fU+oAK4DYr3sFbLppq/9euqTO
 M1OLV1XCz9ro+6X+zMwoaXUtB3zrx9+0LqOvP1inPYjWclcxBD/SOCDyBBRs13dxDWwjihBhu
 nY079rljxZWcRZsWOLwSpDa1B1r/J3XwfkJxkrV8GIaFOX5M24cF/ebvuWUr3InbUbe7U5I37
 wj8z6F1xXCVWBW4JFaaXrX1I3MzBjSTWk78d+n8OovKpicwpbClidrMiWzqayUtcWJSSdMROS
 9ju3+A/9ZMw9ypFzbXZjemxRzbfunhS+gNi86c/6+PlaP+9ZdzchzO22AYDptaRv44O1KAvNs
 U4ya2BxGq2jzO8lRHdS2VveJ9agwUf2QNVzxcJAmoAvkW0CLa3+9eXesvuoBFd0BxbcKW84PJ
 ADWtsB/tbpHKM+sUk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2031935800-1592575062=:54
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Miriam,

On Sat, 20 Jun 2020, Miriam R. wrote:

> Hi Johannes,
> I'm finishing the next patch series version and I have an issue about
> one of your suggestions:
>
> El s=C3=A1b., 23 may. 2020 a las 0:06, Johannes Schindelin
> (<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
> >
> > Hi Miriam,
> >
> > On Thu, 23 Apr 2020, Miriam Rubio wrote:
> >
> > > From: Pranit Bauva <pranit.bauva@gmail.com>
> > >
> > > Reimplement the `bisect_state()` shell functions in C and also add a
> > > subcommand `--bisect-state` to `git-bisect--helper` to call them fro=
m
> > > git-bisect.sh .
> > >
> > > Using `--bisect-state` subcommand is a temporary measure to port she=
ll
> > > function to C so as to use the existing test suite. As more function=
s
> > > are ported, this subcommand will be retired and will be called by so=
me
> > > other methods.
> > >
> > > `bisect_head()` is only called from `bisect_state()`, thus it is not
> > > required to introduce another subcommand.
> > >
> > > Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> > > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > > Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > > Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> > > Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> > > Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> > > ---
> > >  builtin/bisect--helper.c | 70 +++++++++++++++++++++++++++++++++++++=
++-
> > >  git-bisect.sh            | 55 +++----------------------------
> > >  2 files changed, 73 insertions(+), 52 deletions(-)
> > >
> > > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> > > index 2d8660c79f..9db72f5891 100644
> > > --- a/builtin/bisect--helper.c
> > > +++ b/builtin/bisect--helper.c
> > > @@ -31,6 +31,8 @@ static const char * const git_bisect_helper_usage[=
] =3D {
> > >       N_("git bisect--helper --bisect-next"),
> > >       N_("git bisect--helper --bisect-auto-next"),
> > >       N_("git bisect--helper --bisect-autostart"),
> > > +     N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
> > > +     N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
> > >       NULL
> > >  };
> > >
> > > @@ -834,6 +836,64 @@ static int bisect_autostart(struct bisect_terms=
 *terms)
> > >       return bisect_start(terms, 0, NULL, 0);
> > >  }
> > >
> > > +static int bisect_head(struct object_id *oid)
> > > +{
> > > +     if (!file_exists(git_path_bisect_head()))
> > > +             return get_oid("HEAD", oid);
> > > +
> > > +     return get_oid("BISECT_HEAD", oid);
> >
> > This can be easily reduced to
> >
> >         return get_oid(file_exists(git_path_bisect_head()) ?
> >                        "BISECT_HEAD" : "HEAD", oid);
> >
> > At the same time, it is wrong, just like the shell script version was
> > wrong: in particular in light of the `hn/reftable` effort, we do _not_
> > want to assume that all refs are backed by files!
> >
> > So really, what this should do instead is this:
> >
> >         enum get_oid_result res =3D get_oid("BISECT_HEAD", oid);
> >
> >         if (res =3D=3D MISSING_OBJECT)
> >                 res =3D get_oid("HEAD", oid);
> >
> > Given that this is still only three lines long, the overhead of having=
 it
> > in its own function for just a _single_ call seems excessive. I'd pref=
er
> > it to be inlined in `bisect_state()`.
> >
> > > +}
> > > +
> > > +static enum bisect_error bisect_state(struct bisect_terms *terms, c=
onst char **argv,
> > > +                     int argc)
> > > +{
> >
> > I offered a lengthy discussion about this function in
> > https://lore.kernel.org/git/nycvar.QRO.7.76.6.2002272244150.9783@tvgsb=
ejvaqbjf.bet/
> >
> > It does not look, however, as if v3 benefitted from the entirety of my
> > analysis: All the `check_expected_revs()` function does is to verify t=
hat
> > the passed list of revs matches exactly the contents of the
> > `BISECT_EXPECTED_REV` file.
> >
> > That can be done in a much simpler way, though, by first reading the f=
ile
> > and parsing the contents into an OID, and then comparing to that parse=
d
> > OID instead.
> >
> > Besides, `check_expected_revs()` is only used to check one rev at a ti=
me.
> >
> > In other words, it could be simplified to something like this:
> >
> > static void check_expected_rev(struct object_id *oid)
> > {
> >         struct object_id expected;
> >         struct strbuf buf =3D STRBUF_INIT;
> >
> >         if (strbuf_read_file(&buf, git_path_bisect_expected_rev(), 0)
> >               < the_hash_algo->hexsz ||
> >             get_oid_hex(buf.buf, &expected) < 0)
> >                 return; /* Ignore invalid file contents */
> >
> >         if (!oideq(oid, &expected)) {
> >                 ... unlink ...
> >                 return;
> >         }
> > }
> >
> > But even that would be wasteful, as we would read the file over and ov=
er
> > and over again.
> >
> > The good news is that we do not even _need_ `check_expected_rev()`.
> > Because we do not need to have two call sites, we can simplify the cod=
e
> > much further. See below:
> >
> > > +     const char *state;
> > > +     const char *hex;
> > > +     int i;
> > > +     struct oid_array revs =3D OID_ARRAY_INIT;
> > > +     struct object_id oid;
> > > +
> > > +     if (!argc)
> > > +             return error(_("Please call `--bisect-state` with at l=
east one argument"));
> > > +     state =3D argv[0];
> > > +     if (check_and_set_terms(terms, state) ||
> > > +         !one_of(state, terms->term_good,terms->term_bad, "skip", N=
ULL))
> > > +             return BISECT_FAILED;
> > > +     argv++;
> > > +     argc--;
> > > +     if (!strcmp(state, terms->term_bad) && (argc > 1))
> > > +             return error(_("'git bisect %s' can take only one argu=
ment."),terms->term_bad);
> > > +     if (argc =3D=3D 0) {
> > > +             if (bisect_head(&oid))
> > > +                     return error(_("Bad bisect_head rev input"));
> > > +             hex =3D oid_to_hex(&oid);
> > > +             if (bisect_write(state, hex, terms, 0))
> > > +                     return BISECT_FAILED;
> > > +             check_expected_revs(&hex, 1);
> > > +             return bisect_auto_next(terms, NULL);
> > > +     }
> > > +
> > > +     /* Here argc > 0 */
> > > +     for (; argc; argc--, argv++) {
> > > +             struct object_id oid;
> > > +             if (get_oid(*argv, &oid))
> > > +                     return error(_("Bad rev input: %s"), *argv);
> > > +             oid_array_append(&revs, &oid);
> > > +     }
> >
> > It really does not make sense to parse the arguments into an OID array=
,
> > _then_ iterate over the array once, and then immediately releasing it.
> > That OID array is not needed at all.
> >
> > So we'll end up with this loop in case `argc > 0` (where we now call
> > `get_oid()`, too), and note how the loop body looks _eerily_ similar t=
o
> > the conditional `argc =3D=3D 0` code block above?
> >
> > > +
> > > +     for (i =3D 0; i < revs.nr; i++) {
> > > +             hex =3D oid_to_hex(&revs.oid[i]);
> > > +             if (bisect_write(state, hex, terms, 0)) {
> > > +                     oid_array_clear(&revs);
> > > +                     return BISECT_FAILED;
> > > +             }
> > > +             check_expected_revs(&hex, 1);
> > > +     }
> > > +
> > > +     oid_array_clear(&revs);
> > > +     return bisect_auto_next(terms, NULL);
> > > +}
> >
> > So really, this function pretty much _wants_ to look this way (modulo
> > bugs, as I did not even test-compile the code):
> >
> > static enum bisect_error bisect_state(struct bisect_terms *terms,
> >                                       const char **argv, int argc)
> > {
> >         const char *state;
> >         int i, verify_expected =3D 1;
> >         struct object_id oid, expected;
> >         struct strbuf buf =3D STRBUF_INIT;
> >
> >         if (!argc)
> >                 return error(_("Please call `--bisect-state` with at l=
east one argument"));
> >
> >         state =3D argv[0];
> >         if (check_and_set_terms(terms, state) ||
> >             !one_of(state, terms->term_good, terms->term_bad, "skip", =
NULL))
> >                 return BISECT_FAILED;
> >
> >         argv++;
> >         argc--;
> >         if (argc > 1 && !strcmp(state, terms->term_bad))
> >                 return error(_("'git bisect %s' can take only one argu=
ment."), terms->term_bad);
> >
> >         if (strbuf_read_file(&buf, git_path_bisect_expected_rev(), 0) =
< the_hash_algo->hexsz ||
> >             get_oid_hex(buf.buf, &expected) < 0)
> >                 verify_expected =3D 0; /* Ignore invalid file contents=
 */
> >
> >
> >         for (i =3D 0; i < argc + !argc; i++) {
> >                 if (argc) {
> >                         if (get_oid(argv[i], &oid)) {
> >                                 error(_("Bad rev input: %s"), *argv);
> >                                 return BISECT_FAILED;
> >                         }
> >                 } else {
> >                         enum get_oid_result res =3D get_oid("BISECT_HE=
AD", &oid);
> >
> >                         if (res =3D=3D MISSING_OBJECT)
> >                                 res =3D get_oid("HEAD", &oid);
> >                         if (res) {
> >                                 error(_("Bad bisect_head rev input"));
> >                                 return BISECT_FAILED;
> >                         }
> >                 }
> >
> >                 if (bisect_write(state, oid_to_hex(&oid), terms, 0))
> >                         return BISECT_FAILED;
> >
> >                 if (verify_expected && !oideq(&oid, &expected)) {
> >                         unlink_or_warn(git_path_bisect_ancestors_ok())=
;
> >                         unlink_or_warn(git_path_bisect_expected_rev())=
;
> >                         verify_expected =3D 0;
> >                 }
> >         }
> >
> >         return bisect_auto_next(terms, NULL);
> > }
> >
> > There, not bad, is it?
> >
>  After implementing this solution some tests failed. After debugging
> them, I found that with Pranit's solution, that arguments were parsed
> into an OID array, if bisect received some junk rev the function
> returned and bisect_write() was not executed.

That's a good point, and should be turned into a code comment lest
overzealous developers would attempt the simplification I proposed in the
future.

> With the new solution, if junk rev is received after a valid rev,
> bisect_write() was executed for the valid and the function returned with
> the junk rev.
> So, there is garbage in the file and when for example bisect-porcelain
> test number 5 - 'bisect fails if given any junk instead of revs'
> executes 'test -z' fails.
>
> Should I keep the original patch and add a comment in the code that
> explains why we use an oid array?.

I still think that the `check_expected_revs()` function is not needed, and
unnecessarily complex.

If you _want_ to keep Pranit's original implementation, then I would _at
least_ want you to forward-port the `verify_expected` changes I suggested.

>
> (I also have implemented an alternative solution that when some junk
> rev is found, I delete all refs written, but maybe is too complicated
> or not totally correct:
> https://gitlab.com/mirucam/git/-/commit/93f669877b87d09a30a5d07f0967667b=
22026511
> )

You seem to share my preference for not writing out bogus revs in the
first place.

Thanks,
Johannes

>
>
> > > +
> > >  int cmd_bisect__helper(int argc, const char **argv, const char *pre=
fix)
> > >  {
> > >       enum {
> > > @@ -847,7 +907,8 @@ int cmd_bisect__helper(int argc, const char **ar=
gv, const char *prefix)
> > >               BISECT_START,
> > >               BISECT_NEXT,
> > >               BISECT_AUTO_NEXT,
> > > -             BISECT_AUTOSTART
> > > +             BISECT_AUTOSTART,
> > > +             BISECT_STATE
> > >       } cmdmode =3D 0;
> > >       int no_checkout =3D 0, res =3D 0, nolog =3D 0;
> > >       struct option options[] =3D {
> > > @@ -873,6 +934,8 @@ int cmd_bisect__helper(int argc, const char **ar=
gv, const char *prefix)
> > >                        N_("verify the next bisection state then chec=
kout the next bisection commit"), BISECT_AUTO_NEXT),
> > >               OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
> > >                        N_("start the bisection if BISECT_START is em=
pty or missing"), BISECT_AUTOSTART),
> > > +             OPT_CMDMODE(0, "bisect-state", &cmdmode,
> > > +                      N_("mark the state of ref (or refs)"), BISECT=
_STATE),
> > >               OPT_BOOL(0, "no-checkout", &no_checkout,
> > >                        N_("update BISECT_HEAD instead of checking ou=
t the current commit")),
> > >               OPT_BOOL(0, "no-log", &nolog,
> > > @@ -945,6 +1008,11 @@ int cmd_bisect__helper(int argc, const char **=
argv, const char *prefix)
> > >               set_terms(&terms, "bad", "good");
> > >               res =3D bisect_autostart(&terms);
> > >               break;
> > > +     case BISECT_STATE:
> > > +             set_terms(&terms, "bad", "good");
> > > +             get_terms(&terms);
> > > +             res =3D bisect_state(&terms, argv, argc);
> > > +             break;
> > >       default:
> > >               BUG("unknown subcommand %d", (int)cmdmode);
> > >       }
> > > diff --git a/git-bisect.sh b/git-bisect.sh
> > > index 049ffacdff..2da0810b1a 100755
> > > --- a/git-bisect.sh
> > > +++ b/git-bisect.sh
> > > @@ -39,16 +39,6 @@ _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
> > >  TERM_BAD=3Dbad
> > >  TERM_GOOD=3Dgood
> > >
> > > -bisect_head()
> > > -{
> > > -     if test -f "$GIT_DIR/BISECT_HEAD"
> > > -     then
> > > -             echo BISECT_HEAD
> > > -     else
> > > -             echo HEAD
> > > -     fi
> > > -}
> > > -
> > >  bisect_skip() {
> > >       all=3D''
> > >       for arg in "$@"
> > > @@ -61,43 +51,7 @@ bisect_skip() {
> > >               esac
> > >               all=3D"$all $revs"
> > >       done
> > > -     eval bisect_state 'skip' $all
> > > -}
> > > -
> > > -bisect_state() {
> > > -     git bisect--helper --bisect-autostart
> > > -     state=3D$1
> > > -     git bisect--helper --check-and-set-terms $state $TERM_GOOD $TE=
RM_BAD || exit
> > > -     get_terms
> > > -     case "$#,$state" in
> > > -     0,*)
> > > -             die "Please call 'bisect_state' with at least one argu=
ment." ;;
> > > -     1,"$TERM_BAD"|1,"$TERM_GOOD"|1,skip)
> > > -             bisected_head=3D$(bisect_head)
> > > -             rev=3D$(git rev-parse --verify "$bisected_head") ||
> > > -                     die "$(eval_gettext "Bad rev input: \$bisected=
_head")"
> > > -             git bisect--helper --bisect-write "$state" "$rev" "$TE=
RM_GOOD" "$TERM_BAD" || exit
> > > -             git bisect--helper --check-expected-revs "$rev" ;;
> > > -     2,"$TERM_BAD"|*,"$TERM_GOOD"|*,skip)
> > > -             shift
> > > -             hash_list=3D''
> > > -             for rev in "$@"
> > > -             do
> > > -                     sha=3D$(git rev-parse --verify "$rev^{commit}"=
) ||
> > > -                             die "$(eval_gettext "Bad rev input: \$=
rev")"
> > > -                     hash_list=3D"$hash_list $sha"
> > > -             done
> > > -             for rev in $hash_list
> > > -             do
> > > -                     git bisect--helper --bisect-write "$state" "$r=
ev" "$TERM_GOOD" "$TERM_BAD" || exit
> > > -             done
> > > -             git bisect--helper --check-expected-revs $hash_list ;;
> > > -     *,"$TERM_BAD")
> > > -             die "$(eval_gettext "'git bisect \$TERM_BAD' can take =
only one argument.")" ;;
> > > -     *)
> > > -             usage ;;
> > > -     esac
> > > -     git bisect--helper --bisect-auto-next
> > > +     eval git bisect--helper --bisect-state 'skip' $all
> > >  }
> > >
> > >  bisect_visualize() {
> > > @@ -185,8 +139,7 @@ exit code \$res from '\$command' is < 0 or >=3D =
128" >&2
> > >                       state=3D"$TERM_GOOD"
> > >               fi
> > >
> > > -             # We have to use a subshell because "bisect_state" can=
 exit.
> > > -             ( bisect_state $state >"$GIT_DIR/BISECT_RUN" )
> > > +             git bisect--helper --bisect-state $state >"$GIT_DIR/BI=
SECT_RUN"
> > >               res=3D$?
> > >
> > >               cat "$GIT_DIR/BISECT_RUN"
> > > @@ -201,7 +154,7 @@ exit code \$res from '\$command' is < 0 or >=3D =
128" >&2
> > >               if [ $res -ne 0 ]
> > >               then
> > >                       eval_gettextln "bisect run failed:
> > > -'bisect_state \$state' exited with error code \$res" >&2
> > > +'git bisect--helper --bisect-state \$state' exited with error code =
\$res" >&2
> >
> > This is not your fault, of course, but it does make me shudder to see =
such
> > an obvious implementation detail in a user-facing error message.
> >
> > Maybe something to fix up in a follow-up?
> >
> > Ciao,
> > Dscho
> >
> > >                       exit $res
> > >               fi
> > >
> > > @@ -242,7 +195,7 @@ case "$#" in
> > >       start)
> > >               git bisect--helper --bisect-start "$@" ;;
> > >       bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
> > > -             bisect_state "$cmd" "$@" ;;
> > > +             git bisect--helper --bisect-state "$cmd" "$@" ;;
> > >       skip)
> > >               bisect_skip "$@" ;;
> > >       next)
> > > --
> > > 2.25.0
> > >
> > >
> Best,
> Miriam.
>

--8323328-2031935800-1592575062=:54--
