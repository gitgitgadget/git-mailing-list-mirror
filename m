Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDD0C34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 22:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563D920801
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 22:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="d4UvX2/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgBQWBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 17:01:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:59615 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgBQWBP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 17:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581976872;
        bh=yFtqWl/Tx1sRt5zdRGEux6KoL40EpJFPBU8h6lgDbG0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=d4UvX2/psTqD44UTUwGzUzCXDXRhg3OMxcVsXFbPthbZjZoBU4KGchO/ku/lYIOtU
         VDSZSg8WVvB2sttNp0eF+D8KqVcoY8/HzKZFPJYgmAxG7HoHFWgeGYWG28Pt0+0E/Z
         UIVLM+WSkuTGl1+axssDPfGX9jQFqXVjV7nqzz3E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Msq6C-1jJPUl34O0-00tDXa; Mon, 17
 Feb 2020 23:01:11 +0100
Date:   Mon, 17 Feb 2020 23:00:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Miriam Rubio <mirucam@gmail.com>, git <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH 12/29] bisect--helper: reimplement `bisect_next` and
 `bisect_auto_next` shell functions in C
In-Reply-To: <CAP8UFD1UBPwYLUEdUJj3k1Yj0Y9dD6RyGh1dFL=wsSNihErqZQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002172245430.46@tvgsbejvaqbjf.bet>
References: <20200120143800.900-1-mirucam@gmail.com> <20200120143800.900-13-mirucam@gmail.com> <nycvar.QRO.7.76.6.2001301619340.46@tvgsbejvaqbjf.bet> <CAP8UFD1UBPwYLUEdUJj3k1Yj0Y9dD6RyGh1dFL=wsSNihErqZQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rZLqWqtDbOJvjj5fZFCK2tg7p6juS+uySQExSVnPTa9iYH3A2p9
 pkVSxUijwLq2H6Cgqarbb8c5BwKUr37ASfujJQWrXY/SKi9Wnma+6pEIh2Tr0blpClyGJER
 K7/NC0ajBDHTY74E5w18cOSdgVTwLQEmBysm3Zk1wniSFnoMFs/holWj1avELwfTt0fgiou
 Ehc5WmcoaL/AQIho7KAmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2QkeQa9pMWE=:7JfS8wNYs9Tb/mxXqGSVIC
 TxkYNEj9HwlV6hoZ3ZCdyTwW6eIdghc3mhqc+glAnEQXzkZ7fPObaYZbTSu2fYnTnA30pv9al
 7IPg9xOwycHNvtA1Y8tOJSfFsY0s1/RvfUyD+uNQ8vMVWXbBWQjkTbzJDmm2Eed0nfYpebL9x
 cWZbQom8IQ0+NQ7eHNHrcs6bxogVkeEXKD2u6oiITkkR9qhjIgwuYxBlc6Tv4vk7JKwlkCPNO
 wmannDdgVIxTaTuTp/2DtS+NEL9ozY8L9vMlVLiSzo1M6Tbh9211nltLHdxynITA1IqfU3GJx
 jTvvxrZawwar/id3lQdwLTBMtOzGD5zSJ4ePQv4cUUwV+rFvzBbyGAVOumymDbgIL0XHKtaMA
 tEfr6eom1iysAGlRqdzRcDNJfDkY7JakFYDvl0ov5X6Loq48wQKWOP7qxnoEqx9ZLR1D+RWj7
 E3QovFq+ehZxeOAqHx4T+sNvrMqL6NPNNpXA/Cg2PZdZMFqlvwUaoKUMuFYUnRraQ4H3uhNC+
 imgYMSTu19Vf6c3KSxKNggmgPugtWFnBvFZQIGEuNyTfHcSO/PzjGys0T23iCwluATM2/jJ2O
 xCY06J3ViIN/G3N3fAKmrB+IvMshxs2KMkpTROM96vqxvHYF/rxEyWMH/+7WtT92MQQzzUKfL
 P0OtY75gVdDF0PwUn17Uy0w8koflIwRElz6YoUDZYFhqOl+K/u/+8YlDa9ORpgHdzolz/Ye7k
 R8TlP7xUj1YUpej3uUN1ZWHdck4Y0re3B/oFztDr+h4JbYMYxwSPXlCi6HcQoIwIWJSWMSuyN
 PABOI3+oY598+WCGNnZrHpO4QUpnpWquY6jG+vaYEADrjRb9vnPesIiFK+su+0PF4uO5kInr6
 Gdkm38Os+JJ++OtAJtdw2OfRx8BQ5uvuYf+wCRti8XAlYeQsLcXPtKs6wIBNfnQsfHXSNcN4E
 TyBNg7y1xo/W8wISvwCjZvOHciV1VEU3aptub11G7a1KY1DwQ0C2t8XirkOP6LzS8sMrn2+fR
 B9HEi4ETvwPOI9VzA7T72XxvLNPpJ8fxhBhfcBVsq3KQRjb5bgTzoSgXwzzzemZbuoVc4Y0Rz
 U9I64/RNSiPTyTGlvlZ3UZ+Y/DHToXb9hxs5YJ3BXZoEeZ43sgMUzJEMd616JB873qTQu/jNa
 h6c489e44rUc+wtfcpv1Q5wXEeRROQHCukrKOteX/RAJJDZ+SNmw88DrptJsNmQ/qJUw2EvlC
 +Cu0la8m5cDXqi+rV
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

On Mon, 17 Feb 2020, Christian Couder wrote:

> On Thu, Jan 30, 2020 at 11:47 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 20 Jan 2020, Miriam Rubio wrote:
>
> > > +static void prepare_rev_argv(struct bisect_terms *terms, struct arg=
v_array *rev_argv)> > +{
> > > +     struct string_list good_revs =3D STRING_LIST_INIT_DUP;
> > > +     char *term_good =3D xstrfmt("%s-*", terms->term_good);
> > > +
> > > +     for_each_glob_ref_in(register_good_ref, term_good,
> > > +                          "refs/bisect/", &good_revs);
> > > +
> > > +     argv_array_pushl(rev_argv, "skipped_commits", "refs/bisect/bad=
", "--not", NULL);
> > > +     for (int i =3D 0; i < good_revs.nr; i++)
> > > +             argv_array_push(rev_argv, good_revs.items[i].string);
> > > +
> > > +     string_list_clear(&good_revs, 0);
> > > +     free(term_good);
> > > +}
> >
> > Maybe we should fold that into `prepare_revs()`? We could then render =
the
> > arguments directly into `revs` (via `add_pending_object()`, after sett=
ing
> > obj->flags |=3D UNINTERESTING`) rather than formatting them into a str=
ing
> > list, then deep-copy them into an `argv_array` only to parse them back
> > into OIDs that we already had in the first place.
>
> The current code is a straightforward port from shell. If we do what
> you suggest, yeah, it will be less wasteful, but on the other hand it
> will be less easy to see that we are doing a good job of properly
> porting code from shell.

If you reason that way, you will have to use tons of `run_command()` calls
to translate the shell code as verbatim as possible.

However, as you can see from our commit history, we do not do that.
Instead, we use the more powerful expressiveness of C to come up with more
elegant code than to slavishly convert shell code to inelegant C code.

> I suggest we try to focus on the later rather than the former right now,
> especially as performance is not very important here.

Oh, but my comment was totally not about performance, and pretty much
exclusively about readability.

If Miriam goes with my suggestion, it will result in more readable code
that is easier to review and therefore much more likely to be free of
unintentional bugs.

> Using small functions also makes it easy to see that we are properly
> releasing memory. A previous version of this code had everything into
> a big function that used goto statements and it was less clear that we
> released everything.

If you want to make it easier to avoid double-free()s and memory leaks, I
am a bit puzzled how you want to claim that the current "we're copying the
strings so often that pretty much everybody loses track of them" approach
should be superior to adding the strings once, and once only, to a string
array.

> > > +static int bisect_skipped_commits(struct bisect_terms *terms)
> > > +{
> > > +     int res =3D 0;
> > > +     FILE *fp =3D NULL;
> > > +     struct rev_info revs;
> > > +
> > > +     fp =3D fopen(git_path_bisect_log(), "a");
> > > +     if (!fp)
> > > +             return error_errno(_("could not open '%s' for appendin=
g"),
> > > +                               git_path_bisect_log());
> > > +
> > > +     res =3D prepare_revs(terms, &revs);
> > > +
> > > +     if (!res)
> > > +             res =3D process_skipped_commits(fp, terms, &revs);
> > > +
> > > +     fclose(fp);
> > > +     return res;
> > > +}
> >
> > This is again a very short wrapper around another function, so it will
> > probably make sense to merge the two, otherwise the boilerplate might =
very
> > well outweigh the actual code doing actual work.
>
> Yeah, there is perhaps a significant amount of boiler plate, but the
> code is much easier to check for leaks than when everything was in the
> same big function and there were goto statements, so I think it's a
> reasonable trade-off

Given this snippet, I would strongly disagree with this assessment:

    fp =3D fopen(git_path_bisect_log(), "a");
    if (!fp)
            res =3D error_errno(_("could not open '%s' for appending"),
                              git_path_bisect_log());
    else
            res =3D prepare_revs(terms, &revs);

    if (!res)
            res =3D process_skipped_commits(fp, terms, &revs);

    if (fp)
            fclose(fp);

There is positively no need for a `goto` whatsoever.

> > > +             fclose(fp);
> > > +     } else {
> > > +             res =3D error_errno(_("could not open '%s' for "
> > > +                                 "appending"),
> > > +                               git_path_bisect_log());
> > > +     }
> >
> > This pattern of opening a file, writing something into it, and then re=
turn
> > success, otherwise failure, seems like a repeated pattern. In other wo=
rds,
> > it would be a good candidate for factoring out into its own function.
>
> Yeah, but it seems that in this patch series we use the pattern only
> once. So I think it's fair to leave that for another patch series with
> cleanups and performance improvements or perhaps for microprojects.

Sure, we could repeat past mistakes in this patch series, too.

If, on the other hand, we use this patch series as "an excuse" to
introduce such a helper, no future patch series will have to use the same
kind of argument as you just offered. Instead, we will have an improved
API that will help not only this patch series, but many more to come.

There is tons of precedent for this kind of thing, where we add an
introductory patch at the beginning of a patch series, factoring out
already-existing code into a more reusable shape, and then use it.

So why not repeat that pattern and do the same thing here?

Ciao,
Johannes
