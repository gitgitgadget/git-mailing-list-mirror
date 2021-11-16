Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F61C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 07:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C0D61B71
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 07:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhKPHQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 02:16:09 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42128 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230232AbhKPHOK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 02:14:10 -0500
Received: from localhost (SCRUBBING-BUBBLES.MIT.EDU [18.9.64.11])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1AG7AvgW017069;
        Tue, 16 Nov 2021 02:10:58 -0500
Date:   Tue, 16 Nov 2021 02:10:57 -0500 (EST)
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v6 1/8] fetch: lowercase error messages
In-Reply-To: <xmqqczn0d6er.fsf@gitster.g>
Message-ID: <alpine.DEB.2.21.999.2111160206440.105644@scrubbing-bubbles.mit.edu>
References: <20211113033358.2179376-1-andersk@mit.edu> <20211113033358.2179376-2-andersk@mit.edu> <xmqqczn0d6er.fsf@gitster.g>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="152177472-673264739-1637046657=:105644"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--152177472-673264739-1637046657=:105644
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 16 Nov 2021, Junio C Hamano wrote:
> > Documentation/CodingGuidelines says =E2=80=9Cdo not end error messages =
with a
> > full stop=E2=80=9D and =E2=80=9Cdo not capitalize the first word=E2=80=
=9D.  Reviewers requested
> > updating the existing messages to comply with these guidelines prior to
> > the following patches.
>=20
> Thanks.  Whether reviewers requested or you thought of it on your
> own, separating such a preliminary clean-up into its own patch would
> be a good idea, especially if the later patches need to update (some
> of) them.

It was your request; I just mentioned it in case other reviewers wonder=20
why this belongs in this topic.

https://public-inbox.org/git/xmqq8rxvwp4b.fsf@gitster.g/

> The approach chosen (consistently) in this patch is to
>=20
>  (1) turn them into a (semi) single sentence, concatenated with ';'
>=20
>  (2) as a side effect of not being a free-standing sentence anymore,
>      the second and subsequent sentences in the original, that are
>      now just pieces in a single sentence separated with ';', do not
>      get capitalized, and
>=20
>  (3) the sentence as a whole lacks the full-stop, just like a single
>      sentence message.
>=20
> I think we are fine with these rules, especially given that these
> multi-sentence messages are not the main part of this topic touches
> and are not the primary focus of this topic anyway. =20

I guess I should add that there are a few messages I left alone:=20
refuse_unconfigured_deny_msg and=20
refuse_unconfigured_deny_delete_current_msg in builtin/receive-pack.c=20
(patch 2/8).  Not sure if they count as =E2=80=9Cerror messages=E2=80=9D, b=
ut these=20
multi-paragraph messages are too long to comfortably apply this approach.

Now I see that I missed a few others.  This could be squashed into the=20
first three patches:

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f373252490..f3c7c057d0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1783,7 +1783,7 @@ static int fetch_failed_to_start(struct strbuf *out, =
void *cb, void *task_cb)
 =09struct parallel_fetch_state *state =3D cb;
 =09const char *remote =3D task_cb;
=20
-=09state->result =3D error(_("Could not fetch %s"), remote);
+=09state->result =3D error(_("could not fetch %s"), remote);
=20
 =09return 0;
 }
@@ -1838,7 +1838,7 @@ static int fetch_multiple(struct string_list *list, i=
nt max_children)
 =09=09=09if (verbosity >=3D 0)
 =09=09=09=09printf(_("Fetching %s\n"), name);
 =09=09=09if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
-=09=09=09=09error(_("Could not fetch %s"), name);
+=09=09=09=09error(_("could not fetch %s"), name);
 =09=09=09=09result =3D 1;
 =09=09=09}
 =09=09=09strvec_pop(&argv);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d72058543e..70b4e23a26 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2495,9 +2495,9 @@ int cmd_receive_pack(int argc, const char **argv, con=
st char *prefix)
 =09argc =3D parse_options(argc, argv, prefix, options, receive_pack_usage,=
 0);
=20
 =09if (argc > 1)
-=09=09usage_msg_opt(_("Too many arguments."), receive_pack_usage, options)=
;
+=09=09usage_msg_opt(_("too many arguments"), receive_pack_usage, options);
 =09if (argc =3D=3D 0)
-=09=09usage_msg_opt(_("You must specify a directory."), receive_pack_usage=
, options);
+=09=09usage_msg_opt(_("you must specify a directory"), receive_pack_usage,=
 options);
=20
 =09service_dir =3D argv[0];
=20
diff --git a/branch.c b/branch.c
index 3a7d205fa4..0bea1335ae 100644
--- a/branch.c
+++ b/branch.c
@@ -64,7 +64,7 @@ int install_branch_config(int flag, const char *local, co=
nst char *origin, const
 =09if (skip_prefix(remote, "refs/heads/", &shortname)
 =09    && !strcmp(local, shortname)
 =09    && !origin) {
-=09=09warning(_("Not setting branch %s as its own upstream."),
+=09=09warning(_("not setting branch %s as its own upstream"),
 =09=09=09local);
 =09=09return 0;
 =09}
@@ -116,7 +116,7 @@ int install_branch_config(int flag, const char *local, =
const char *origin, const
=20
 out_err:
 =09strbuf_release(&key);
-=09error(_("Unable to write upstream branch configuration"));
+=09error(_("unable to write upstream branch configuration"));
=20
 =09advise(_(tracking_advice),
 =09       origin ? origin : "",

Anders
--152177472-673264739-1637046657=:105644--
