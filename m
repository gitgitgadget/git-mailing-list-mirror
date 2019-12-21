Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AB4C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40F2206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fr1cbUA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfLUVUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 16:20:01 -0500
Received: from mout.gmx.net ([212.227.15.18]:48295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfLUVUB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 16:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576963194;
        bh=Z3tmI6q4rH3lPw7R9lQS0gr7Ei0OJTZBdRsijgNbfTo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fr1cbUA8QuBUaJbWueMnHV2hLqQQdTg3gUktEfsFlw5PcLD2IGnLXR14Yleow3MFn
         Ck5pahCV3BoyXamA7uz2AAcZyx3+5SK/a6hR7vEsXk69BDYtkr4gf6QUIqqXWb/w3q
         Lw+E8hRFkEC34RVbj1YNqEKbtAWippMIaINW0BDs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXGrE-1iAElQ11Z8-00YgC6; Sat, 21
 Dec 2019 22:19:54 +0100
Date:   Sat, 21 Dec 2019 22:19:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/7] built-in add -p: prepare for patch modes other than
 "stage"
In-Reply-To: <xmqq36dihhfj.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912212118390.46@tvgsbejvaqbjf.bet>
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>        <8f6139f94debb9b3bfb9c9e8b8e18e3c2fb46a06.1576579264.git.gitgitgadget@gmail.com> <xmqq36dihhfj.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:F87ZEE2Fy1q0daU2JaKRoiyLsxyNRMCWvOORbvOszFE4pHCz9JZ
 Ixy2G7YBb1M9xFdexmJQmM9sYkJyQJHIXaBHKlNPoXdkG/1DnbfVlWZO8Y52fYy+c8j+kfy
 JrDcgel2vHFNoI+oR5i3eb1l52zhR4+vIOtQKVAkAcmcXOD4alLud+EV+Y2eiYGY2fe7a4c
 cdEg6VwsIUCje39VhTtkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lIIm3Wutdvk=:gH0ebM3CbxqgLj7iKHE4TC
 vjYlJRHtXMZ/G0NtuIYNsKgG8aEdRd9DUdlvIz6poys5DDrbvaY1/QZFlO7Jcv9i18L9R3txz
 U4CT0Or9r+u1GAHkonZXoM4IwQOEDBdClgOcNCQexmffl49Y/bT+Wohet7UAnRZwQkn8+8nlK
 JFDqSng4GiNmzSadCuomoQi6/Xb0sTtcAvgec/cov1xuBi9jmWJavpOT7oJ+rHltyI0Qarb8J
 P+DeRGh/QVeCiSc7KSw0H2pn1Mny5ScCWP/xFFVi1cSTv4XJVj99x+1BYuKBrtXVfFCY0zuC1
 zbRsZLiJ5Tu6l0h7PExnwpaDm44BySPWMFqHpwJGZx/N6zz5p16dpU4SazD3Fi35bJKQLBxF3
 ltU0UBwrZDlVDrj1NsB7Wtdbeyo4YSg72a2JZoiTCOTvkKq0/h3utEdg//m4dYqnIeeg/+BSW
 IfpUTddwElafwlauhCn9IZ6lSLrMXo1TLlh1pi5yZl+xyUZdxsf0SlVcNxeNOyPfLzdOiMl1y
 4K9irHuDo4uNCOgKn0hu5k/qTMTYat2KQ6B9K4G9fJOf/UajSPNq5AAtUxWBVer1WlVgkekK9
 qUA07KTr5sr93G+UrDwSoMzPUFmbee5QuTjKyYliuKzUUx8thu+p8zcnCgJziz4s+S5tVGE5R
 wdb3RYpVHS9YAyPGr2M5vZiYNgY6pUq5MeC2KY6BBiSs3RBVxqJDYque9qywf/NgkJnAhaWJ7
 g1c4zLlxFqwlDch/1zAuZx9mP3lHlu8FgKY8v8oeWsEHHSc0kvTfsBKpWJXRQb+G5Du+arHun
 s94QzRHLAMgv9L9mFjfnR2bfv2N8glShaXMrYdP+0YZS5DNPazgjLaeHbXDSozSsVRdaWVIY2
 zZugSQSEblr2upKvt3qsnnMpKc0h/M2c6E6/e0vWelRYBQQkIUxx3V4jWu6Jj7c9HVZyA+6sJ
 9T3ib/WXlclfN2jhQXsa0Vgnies1X+20L0R/oEkrSJfWlGnD1WP3IEG26o9p02tI7Mg96Bv98
 zf6YqttllsPzpmowx0bUBCEN5fAIQOm0cB95oXK/nhGB/rKc/7rH5e4OmttyRDIVpgY8nlYg3
 XIkKm3SmdC7BOHD+EaQ8ddG88n5BQVawubF3aP9A81t9GN8sdhPjYKAg6NYY1h0h6nSS0sJDS
 v0O+H+Ta4tnFpjZgpzqo50EvEAN96Vqy2FAOfHUnWu4JwqhZrbLbPsYu8lTepsVEmtCG+qK1b
 b0UjYB1n2bXVXSGBja1waosfrn4OVCIp2KxFf20gMVlyuvpOb6g8inEB4sFQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 17 Dec 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > +int run_add_p(struct repository *r, enum add_p_mode mode,
> > +	      const char *revision, const struct pathspec *ps);
>
> This makes readers wonder if "const struct object_id *" is more
> appropriate; "const char *revision" that holds human-readable name
> is better when the internal machinery uses it for reporting, so that
> may be what is going on here (so is the new field in add_p_state
> structure).

The main reason why this is a string instead of an object ID is to be able
to discern between the `HEAD` vs `non-HEAD` versions.

A secondary consideration was that we will want to keep the scripted
version of `add -p` as the default for now, and that needs the value as
the original string, not as the parsed object ID.

> >  #endif
> > diff --git a/add-patch.c b/add-patch.c
> > index 2c46fe5b33..8a691f07da 100644
> > --- a/add-patch.c
> > +++ b/add-patch.c
> > @@ -11,10 +11,33 @@ enum prompt_mode_type {
> >  	PROMPT_MODE_CHANGE =3D 0, PROMPT_DELETION, PROMPT_HUNK
> >  };
> >
> > -static const char *prompt_mode[] =3D {
> > -	N_("Stage mode change [y,n,a,q,d%s,?]? "),
> > -	N_("Stage deletion [y,n,a,q,d%s,?]? "),
> > -	N_("Stage this hunk [y,n,a,q,d%s,?]? ")
> > +struct patch_mode {
> > +	const char *diff[4], *apply[4], *apply_check[4];
>
> Hardcoded "4" and not-quite descriptive names puzzle readers at the
> first glance.  Let's read on to see if they need any further
> improvement.

Good point. I added a code comment.

> > +	unsigned is_reverse:1, apply_for_checkout:1;
> > +	const char *prompt_mode[PROMPT_HUNK + 1];
>
> This relies on the enum value assignment (or listing) order to
> ensure that PROMPT_HUNK always comes at the end.  Perhaps that
> deserves a comment before "enum prompt_mode_type", e.g.
>
> 	+/* Keep PROMPT_HUNK at the end */
> 	 enum prompt_mode_type {
> 	 	PROMPT_MODE_CHANGE =3D 0, ...
> 	 };

I agree, and introduced `PROMPT_MODE_MAX` for that purpose.

>
> > +	const char *edit_hunk_hint, *help_patch_text;
> > +};
> > +
> > +static struct patch_mode patch_mode_stage =3D {
> > +	.diff =3D { "diff-files", NULL },
>
> Nice to see designated initializers used ;-)
>
> Mental note: the "diff" field is (probably) for "the command line
> to be used to generate the patch"
>
> > +	.apply =3D { "--cached", NULL },
> > +	.apply_check =3D { "--cached", NULL },
>
> Mental note: these "apply" and "apply_check" fields are (probably)
> not for the command line; unlike the "diff" field, these only have
> arguments.
>
> Mental note: if the three field names become confusing, perhaps we
> can clarify them by either (1) calling diff as diff_cmd[], or (2)
> calling the other as apply_args[] and apply_check_args[], or (3)
> rename both.

I renamed all three.

> > +	.is_reverse =3D 0,
>
> Wouldn't it be sufficient to apply the default initialization, just
> like it is done for apply_for_checkout bitfield?

Yep, I dropped those unnecessary initializations.

> > @@ -1310,6 +1345,9 @@ int run_add_p(struct repository *r, const struct=
 pathspec *ps)
> >
> >  	init_add_i_state(&s.s, r);
> >
> > +	s.mode =3D &patch_mode_stage;
> > +	s.revision =3D revision;
>
> The phrase "mode_stage" may become problematic, as other modes that
> will be introduced, like "reset", "checkout" all will stage
> different contents to the index.  The only mode the machinery knows
> at this point in the series is how "add" stages contents to the
> index, so "patch_mode_add" might turn out to be a better choice of
> the phrase as we read the series along.  We'll see.
>
> > +		if (!strcmp(patch_mode, "--patch"))
> > +			mode =3D ADD_P_STAGE;
>
> The same comment applies to this enum token.

I renamed both to the `*_add` and `*_ADD` version, respectively.

Thanks,
Dscho
