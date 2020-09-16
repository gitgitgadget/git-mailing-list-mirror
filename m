Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E0AC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 21:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E92206D4
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 21:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JdSL7y+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgIPVJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 17:09:32 -0400
Received: from mout.gmx.net ([212.227.15.19]:52825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbgIPPzd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 11:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600271700;
        bh=RE2oeKY+MybggPVwX+Wg+w96q2V4qplyK9efAnEawkg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JdSL7y+ruh/RbLn7ae/RVasp745BxUwndL8Mt02qM2K0ekfclF53Aqg/mfY96xLVo
         Q5Efl03U0iLmrjcgHrzRMcyaadimxpWBpc4EhnaOB4mNajSXVPdsD0bwhQ8smUF7/g
         NxN5o+XNtVpaOnKM+R9SaWB8A04XY4TwrzMlHgYo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.239.213] ([213.196.213.124]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6lpM-1kQjl533PS-008NrE; Wed, 16
 Sep 2020 13:55:01 +0200
Date:   Wed, 16 Sep 2020 13:55:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
In-Reply-To: <20200908165900.GC40807@mail.clickyotomy.dev>
Message-ID: <nycvar.QRO.7.76.6.2009161221210.56@tvgsbejvaqbjf.bet>
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com> <nycvar.QRO.7.76.6.2009072119350.56@tvgsbejvaqbjf.bet> <20200908165900.GC40807@mail.clickyotomy.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:O/luj+lFQHvnokAGZD1/s6fbInEaVKZwpHcK8ZwGb+QfRmgf+zV
 UqoBdF/yMBhmDgU+W7MW7/Ic3jWyzzhzl/VCWaeZvljNV7SXe5bpOxkz7UWWm1myHVsfEuK
 vjTmnoBkG6smG/jbf+L9RnmdyBSayJE+kXXO9Y0+/XXQ1LY5h4UsSLgbMfjNvZw+Np35ZW7
 T1Mbf45mXBp7GbzfgVU1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eul3AoYhQNU=:L+eekloOxDxp7fZWOMJ9zx
 VCCbfs/9A1ZfKSDTCp/4dq+Ng3nH4juG2X1jY9K1o3199+nVTZmXxg3601Ifgy0DfyOZGO+tb
 WRUg5dtFZkpq4GbB7umIBqB78KSGL+a2yh/uBWuNCOMj2SbwXD6wLUR3ukHcshyBwmePylYGE
 3tBrVljLTnZvPJhKDheZkn64tQRnQ++1T/4dJpA+g1xncPNeqP7W0FZJ8nPVxPrnyrDQGcgB7
 mEfZwHw6shjKIKz+iY08iUQDJfrHYiSI8jmVPSlUIoW3P53gfw8A4FFMY7hWMnFAhZi+nccHu
 qU9iTCvdGJy2jdpu/ACJ74XazqGACaEtue5V9uHINGWOwHqat7HCLcP5YT9A2JeLBWg8zgDW1
 FyzHkrgS5xvNfnehr5WO7zgWMwKHryxEIDPlci3lpYvOGK+SdwhgxRBD6ETEpCbZPsZRIXrmF
 7Bm+Sz/NUy6VeHdET/8xkX397fn0UWBh5FuFC0k/OiKAcuvPRJ8Bm8Bu86IALBRSNgtU1LMQG
 Bf90OMI2vSTBOoIMCf0f8sEjUuW39VbLuauTSoo+sZUswicmtYZKCRjI/Dsz9+WxlK7efaj2q
 SndpOj3r9QngdTqkXh1ya1jIzbD0QfQNIR0kOyjfI8easfPWrPBg0CcFWSdITAazp0aJJ/b8p
 yxT/J16dc9jju+gB4IWMoIBEt3FpxFQahIVZqHXtuOnh2F4gzN0oUkknaBafusiAnM83g5x5G
 OFMKz9i4qcxViDO7HJpjBcEu0e//n7C9h6BCyW54uZe1XSbbShuT4cUWm6vuoUnWcTJTY4LOW
 A3m/j8d7xuVdbHn4g7qMgAfKQL5mQqqzlEMubNGUDU+iScv6jtWCJmW4WSdz4kB8uBT0uQIH4
 WeZeIK+xIYb4fSpsFJ8Nz0AUXSs2aDDu0yKR+s7xwPD2quLfr1ocv4V9GB/jCeuvQOvRFsGg7
 YpfofwuHRyOihQscGWxnThXgXNip9DMkNgtdMXRvsIPj/nusGznKKWm6nyeBpSOtDLhihBVli
 ezSoPrAaaGN7wq1h3yShL/Yp3zipdjaa0v+hIf0dIIl6KLhhjO5YkrrycvgJNN008H/PIBiaj
 NkhbyziC3P2nK/Y0FeQ2pLTJ/AodukN5UC39ej0Z5GCJ5Z+IpiF3G678GECclHfMRxagPhhZV
 pXM8NztY6+6Y5OgWrToGUeWgE/j1GWaN7H+XtEjhWFvTBvEBTMU+horrRl1Nsjkf6sJoFP6eb
 p3dUgbDPrY24wq7I6L5J1T/bfhx6Pt5VrVoa4nw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Srinidhi,

On Tue, 8 Sep 2020, Srinidhi Kaushik wrote:

> On 09/07/2020 21:45, Johannes Schindelin wrote:
> >> [...]
>
> > Now, to be honest, I thought that this mode would merit a new option
> > rather than piggy-backing on top of `--force-with-lease`. The reason i=
s
> > that `--force-with-lease` targets a slightly different use case than m=
ine:
> > it makes sure that we do not overwrite remote refs unless we already h=
ad a
> > chance to inspect them.
> >
> > In contrast, my workflow uses `git pull --rebase` in two or more separ=
ate
> > worktrees, e.g. when developing a patch on two different Operating
> > Systems, I frequently forget to pull (to my public repository) on one
> > side, and I want to avoid force-pushing in that case, even if VS Code =
(or
> > I, via `git remote update`) fetched the ref (but failing to rebase the
> > local branch on top of it).
> >
> > However, in other scenarios I very much do _not_ want to incorporate t=
he
> > remote ref. For example, I often fetch
> > https://github.com/git-for-windows/git.wiki.git to check for the
> > occasional bogus change. Whenever I see such a bogus change, and it is=
 at
> > the tip of the branch, I want to force-push _without_ incorporating th=
e
> > bogus change into the local branch, yet I _do_ want to use
> > `--force-with-lease` because an independent change could have come in =
via
> > the Wiki in the meantime.
>
> I realize that this new check would not be helpful if we deliberately
> choose not to include an unwanted change from the updated remote's tip.
> In that case, we would have to use `--force` make it work, and that
> defeats the use of `--force-with-lease`.

I would characterize it as "somewhat stricter" than `--force-with-lease`.
The check would not make sense without the lease.

> > So I think that the original `--force-with-lease` and the mode you
> > implemented target subtly different use cases that are both valid, and
> > therefore I would like to request a separate option for the latter.
>
> OK. So, I am assuming that you are suggesting to add a new function that
> is separate from `apply_push_cas()` and run the check on each of the
> remote refs. Would that be correct?

Oh, I don't really know the code well enough to make a suggestion. I guess
if it is easy enough to modify the existing code path (e.g. extend the
function signature in a minimal manner), then that's what I would go for,
rather than a completely separate code path.

> If that's the case, how does it work along with `--force-with-lease`?

In my mind, the new mode implies `--force-with-lease`.

Thanks,
Dscho

> On one hand we have `--force-with-lease` to ensure we rewrite the remote
> that we have _already_ seen, and on the other, a new option that checks
> reflog of the local branch to see if it is missing any updates from the
> remote that may have happened in the meantime. If we pass both of them
> for `push` and if the former doesn't complain, and the latter check
> fails, should the `push` still go through?
>
> I feel that this check included with `--force-with-lease` only when
> the `use_tracking` or `use_tracking_for_rest` options are enabled
> would give a heads-up the the user about the background fetch. If
> they decide that they don't need new updates, then supplying the
> new "<expect>" value in the next push would imply they've seen the
> new update, and choose to overwrite it anyway. The check would not
> run in this case. But again, I wonder if the this "two-step" process
> makes `push` cumbersome.
>
> > However, I have to admit that I could not think of a good name for tha=
t
> > option. "Implicit fetch" seems a bit too vague here, because the local
> > branch was not fetched, and certainly not implicitly, yet the logic
> > revolves around the local branch having been rebased to the
> > remote-tracking ref at some stage.
>
> The message "implicit fetch" was in context of the remote ref. But yes,
> the current reject reason is not clear and implies that local branch
> was fetched, which isn't the case.
>
> > Even if we went with the config option to modify `--force-with-lease`'=
s
> > behavior, I would recommend separating out the `feature.experimental`
> > changes into their own patch, so that they can be reverted easily in c=
ase
> > the experimental feature is made the default.
>
> Good idea!
>
> > A couple more comments:
> >
> >> @@ -1471,16 +1489,21 @@ void set_ref_status_for_push(struct ref *remo=
te_refs, int send_mirror,
> >>                * If the remote ref has moved and is now different
> >>                * from what we expect, reject any push.
> >>                *
> >> -              * It also is an error if the user told us to check
> >> -              * with the remote-tracking branch to find the value
> >> -              * to expect, but we did not have such a tracking
> >> -              * branch.
> >> +              * It also is an error if the user told us to check wit=
h the
> >> +              * remote-tracking branch to find the value to expect, =
but we
> >> +              * did not have such a tracking branch, or we have one =
that
> >> +              * has new changes.
> >
> > If I were you, I would try to keep the original formatting, so that it
> > becomes more obvious that the part ", or we have [...]" was appended.
>
> Alright, I will append the new comment in a new line instead.
>
> >
> >>               if (ref->expect_old_sha1) {
> >>                       if (!oideq(&ref->old_oid, &ref->old_oid_expect)=
)
> >>                               reject_reason =3D REF_STATUS_REJECT_STA=
LE;
> >> +                     else if (reject_implicit_fetch() && ref->implic=
it_fetch)
> >> +                             reject_reason =3D REF_STATUS_REJECT_IMP=
LICIT_FETCH;
> >>                       else
> >> -                             /* If the ref isn't stale then force th=
e update. */
> >> +                             /*
> >> +                              * If the ref isn't stale, or there was=
 no
> >
> > Should this "or" not be an "and" instead?
>
> D'oh, you are right. It should have been an "and".
>
> >
> >> +                              * implicit fetch, force the update.
> >> +                              */
> >>                               force_ref_update =3D 1;
> >>               }
> >> [...]
> >>  static void apply_cas(struct push_cas_option *cas,
> >>                     struct remote *remote,
> >>                     struct ref *ref)
> >>  {
> >> -     int i;
> >> +     int i, do_reflog_check =3D 0;
> >> +     struct object_id oid;
> >> +     struct ref *local_ref =3D get_local_ref(ref->name);
> >>
> >>       /* Find an explicit --<option>=3D<name>[:<value>] entry */
> >>       for (i =3D 0; i < cas->nr; i++) {
> >>               struct push_cas *entry =3D &cas->entry[i];
> >>               if (!refname_match(entry->refname, ref->name))
> >>                       continue;
> >> +
> >>               ref->expect_old_sha1 =3D 1;
> >>               if (!entry->use_tracking)
> >>                       oidcpy(&ref->old_oid_expect, &entry->expect);
> >>               else if (remote_tracking(remote, ref->name, &ref->old_o=
id_expect))
> >>                       oidclr(&ref->old_oid_expect);
> >> -             return;
> >> +             else
> >> +                     do_reflog_check =3D 1;
> >> +
> >> +             goto reflog_check;
> >
> > Hmm. I do not condemn `goto` statements in general, but this one makes=
 the
> > flow harder to follow. I would prefer something like this:
> >
> > -- snip --
> >               else if (remote_tracking(remote, ref->name, &ref->old_oi=
d_expect))
> >                       oidclr(&ref->old_oid_expect);
> > +             else if (local_ref && !read_ref(local_ref->name, &oid))
> > +                     ref->implicit_fetch =3D
> > +                             !remote_ref_in_reflog(&ref->old_oid, &oi=
d,
> > +                                                   local_ref->name);
> >               return;
> > -- snap --
>
> Adding this condition looks cleaner instead of the `goto`. A similar
> suggestion was made in the other thread [1] as well; this will be
> addressed in v2.
>
> > Again, thank you so much for working on this!
>
> Thanks again, for taking the time to review this.
>
> [1]: https://public-inbox.org/git/624d9e35-29b8-4012-a3d6-e9b00a9e4485@g=
mail.com/
> --
> Srinidhi Kaushik
>
