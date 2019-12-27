Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188BBC2D0C3
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 22:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CAD20838
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 22:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcLEC7Zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfL0WqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 17:46:04 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:46785 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfL0WqE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 17:46:04 -0500
Received: by mail-ot1-f49.google.com with SMTP id k8so20781563otl.13
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 14:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cjA0jSvaJqSLqUd2HwnKMgVseYM5MVGcFCDtcYR2h10=;
        b=YcLEC7Zpfmc+caTQmEvXaMVX3pSbmyry5j4Rwtq9VIlJo1O6vTCuTG4CHsAWV2ET0U
         QrFIII3OUamlcCI6+jkV2cazBP3CGQKxiCA1RZzDpGhs7OSIhtjqMMpgmBikX7tIVqeq
         CGkrrdyVOKCF2zprYJ9Cl3nMHAvP1dXY3DE0mSkvUYNYeQ9yqTZy/hRGsXUkm0VqG/Af
         1klYhhCc7ILmgLqv40YpDmsr9F4/kAc3jwFM0ceegRbGtu7duDa7U73Fup+sf/BDuLk9
         1Ju+44lzhPnKWWb/7nTR96WHDDhbUkZiR7ini3Ev1w9pQrX2FUflbbP2TMZ1DsIt1r6x
         4HPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cjA0jSvaJqSLqUd2HwnKMgVseYM5MVGcFCDtcYR2h10=;
        b=NjPo+zAe9DegKCrEFN0lJ8xYu4CBqjb4K844A4hP7z3auR102QrTVr8a4Fe/LfCBfG
         qOIxnYV4VBycD205yRK1oXyFFK3imEPbpnYG/ts05cMjPCZHT5dKzrzqS8gPNX9z77Cu
         QEDMo6DA8gfsb5DNxKrmmkpH0UPCr74vz2+NIR46X8mkcjMSj5MhzPUF39BV7NmTld4j
         pDhgtAiHkE8ARcMZ5CNCqrAjzeQXHcyDHxYNtIyQXMqGF8r8YJ8oIP9fx4MQHFrxGqKK
         e8uXd8fmwvImznNFQ+Xl9ExnJO+/n+BYP3wTxY2eTvaTVHUWL1UEBA6uQl/dyUb+zHJ4
         uGXA==
X-Gm-Message-State: APjAAAUEyD3Scu86BwmZBJVaOiaz195IQAqw7Ifah8CzgkckD1f6uejt
        AgQs6sDV++Y5jZwz3BSwJE9+jOwWpOhjMjCqt6U=
X-Google-Smtp-Source: APXvYqymG41z1DMEtpAqb0jzyhESGasjl7f1JhExfCZ0s6mb8GCgNav4CMGvXwLjgVTkEINynOA6aYe7qwElpracrDo=
X-Received: by 2002:a9d:6f07:: with SMTP id n7mr57493833otq.112.1577486762837;
 Fri, 27 Dec 2019 14:46:02 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.1901312310280.41@tvgsbejvaqbjf.bet> <a00e1689-ec7c-4039-a2e9-f72d452ae4ff@gmail.com>
In-Reply-To: <a00e1689-ec7c-4039-a2e9-f72d452ae4ff@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Dec 2019 14:45:55 -0800
Message-ID: <CABPp-BGCQR+MLVTDoaXDmPrE4SCu+dQ794X6Kvx1PpiQ=6D7KQ@mail.gmail.com>
Subject: Re: Comparing rebase --am with --interactive via p3400
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Fri, Dec 27, 2019 at 1:11 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>
> Hi Johannes & Elijah,
>
> Le 01/02/2019 =C3=A0 07:04, Johannes Schindelin a =C3=A9crit :
> > Hi Elijah,
> >
> > as discussed at the Contributors' Summit, I ran p3400 as-is (i.e. with =
the
> > --am backend) and then with --keep-empty to force the interactive backe=
nd
> > to be used. Here are the best of 10, on my relatively powerful Windows =
10
> > laptop, with current `master`.
> >
> > With regular rebase --am:
> >
> > 3400.2: rebase on top of a lot of unrelated changes             5.32(0.=
06+0.15)
> > 3400.4: rebase a lot of unrelated changes without split-index   33.08(0=
.04+0.18)
> > 3400.6: rebase a lot of unrelated changes with split-index      30.29(0=
.03+0.18)
> >
> > with --keep-empty to force the interactive backend:
> >
> > 3400.2: rebase on top of a lot of unrelated changes             3.92(0.=
03+0.18)
> > 3400.4: rebase a lot of unrelated changes without split-index   33.92(0=
.03+0.22)
> > 3400.6: rebase a lot of unrelated changes with split-index      38.82(0=
.03+0.16)
> >
> > I then changed it to -m to test the current scripted version, trying to
> > let it run overnight, but my laptop eventually went to sleep and the te=
sts
> > were not even done. I'll let them continue and report back.
> >
> > My conclusion after seeing these numbers is: the interactive rebase is
> > really close to the performance of the --am backend. So to me, it makes=
 a
> > total lot of sense to switch --merge over to it, and to make --merge th=
e
> > default. We still should investigate why the split-index performance is=
 so
> > significantly worse, though.
> >
> > Ciao,
> > Dscho
> >
>
> I investigated a bit on this.  From a quick glance at a callgrind trace,
> I can see that ce_write_entry() is called 20 601[1] times with `git am',
> but 739 802 times with the sequencer when the split-index is enabled.

Sweet, thanks for digging in and analyzing this.

> For reference, here are the timings, measured on my Linux machine, on a
> tmpfs, with git.git as the repo:
>
> `rebase --am':
> > 3400.2: rebase on top of a lot of unrelated changes             0.29(0.=
24+0.03)
> > 3400.4: rebase a lot of unrelated changes without split-index   6.77(6.=
51+0.22)
> > 3400.6: rebase a lot of unrelated changes with split-index      4.43(4.=
29+0.13)
> `rebase --quiet':

--quiet?  Isn't that flag supposed to work with both backends and not
imply either one?  We previously used --keep-empty, though there's a
chance that flag means we're not doing a fair comparison (since 'am'
will drop empty commits and thus have less work to do).  Is there any
chance you actually ran a different command, but when you went to
summarize just typed the wrong flag name?  Anyway, the best would
probably be to use --merge here (at the time Johannes and I were
testing, that wouldn't have triggered the sequencer, but it does now),
after first applying the en/rebase-backend series just to make sure
we're doing an apples to apples comparison.  However, I suspect that
empty commits probably weren't much of a factor and you did find some
interesting things...

> > 3400.2: rebase on top of a lot of unrelated changes             0.24(0.=
21+0.02)
> > 3400.4: rebase a lot of unrelated changes without split-index   5.60(5.=
32+0.27)
> > 3400.6: rebase a lot of unrelated changes with split-index      5.67(5.=
40+0.26)
>
> This comes from two things:
>
> 1. There is not enough shared entries in the index with the sequencer.
>
> do_write_index() is called only by do_write_locked_index() with `--am',
> but is also called by write_shared_index() with the sequencer once for
> every other commit.  As the latter is only called by
> write_locked_index(), which means that too_many_not_shared_entries()
> returns true for the sequencer, but never for `--am'.
>
> Removing the call to discard_index() in do_pick_commit() (as in the
> first attached patch) solve this particular issue, but this would
> require a more thorough analysis to see if it is actually safe to do.

I'm actually surprised the sequencer would call discard_index(); I
would have thought it would have relied on merge_recursive() to do the
necessary index changes and updates other than writing the new index
out.  But I'm not quite as familar with the sequencer so perhaps
there's some reason I'm unaware of.  (Any chance this is a left-over
from when sequencer invoked external scripts to do the work, and thus
the index was updated in another processes' memory and on disk, and it
had to discard and re-read to get its own process updated?)

> After this, ce_write() is still called much more by the sequencer.
>
> Here are the results of `rebase --quiet' without discarding the index:
>
> > 3400.2: rebase on top of a lot of unrelated changes             0.23(0.=
19+0.04)
> > 3400.4: rebase a lot of unrelated changes without split-index   5.14(4.=
95+0.18)
> > 3400.6: rebase a lot of unrelated changes with split-index      5.02(4.=
87+0.15)
> The performance of the rebase is better in the two cases.

Nice.  :-)

> 2. The base index is dropped by unpack_trees_start() and unpack_trees().
>
> Now, write_shared_index() is no longer called and write_locked_index()
> is less expensive than before according to callgrind.  But
> ce_write_entry() is still called 749 302 times (which is even more than
> before.)
>
> The only place where ce_write_entry() is called is in a loop in
> do_write_index().  The number of iterations is dictated by the size of
> the cache, and there is a trace2 probe dumping this value.
>
> For `--am', the value goes like this: 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4,
> 4, 4, 5, 5, 5, 5, =E2=80=A6 up until 101.
>
> For the sequencer, it goes like this: 1, 1, 3697, 3697, 3698, 3698,
> 3699, 3699, =E2=80=A6 up until 3796.
>
> The size of the cache is set in prepare_to_write_split_index().  It
> grows if a cache entry has no index (most of them should have one by
> now), or if the split index has no base index (with `--am', the split
> index always has a base.)  This comes from unpack_trees_start() -- it
> creates a new index, and unpack_trees() does not carry the base index,
> hence the size of the cache.
>
> The second attached patch (which is broken for the non-interactive
> rebase case) demonstrates what we could expect for the split-index case
> if we fix this:
>
> > 3400.2: rebase on top of a lot of unrelated changes             0.24(0.=
21+0.03)
> > 3400.4: rebase a lot of unrelated changes without split-index   5.81(5.=
62+0.17)
> > 3400.6: rebase a lot of unrelated changes with split-index      4.76(4.=
54+0.20)
> So, for everything related to the index, I think that=E2=80=99s it.
>
> [1] Numbers may vary, but they should remain in the same order of magnitu=
de.

Unfortunately, this patch as-is breaks some important things even if
it only shows up in a few testcases.  merge-recursive needs to know
both what the index looked like before the merge started, as well as
what it looks like after unpack-trees runs; see commits 1de70dbd1a
(merge-recursive: fix check for skipability of working tree updates,
2018-04-19) and a35edc84bd (merge-recursive: fix was_tracked() to quit
lying with some renamed paths, 2018-04-19), and maybe a few others
from that series.

But, noting that it comes from the differences in the index as
unpack_trees runs is useful info.  I might be restructuring this code
somewhat significantly but it helps to have this in mind; I may spot
opportunities to do something with it while I'm digging in...

Elijah
