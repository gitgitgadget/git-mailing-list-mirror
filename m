Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC63C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 10:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE4C2074D
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 10:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iAGdihGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgGAKBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:01:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:58181 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729486AbgGAKBt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 06:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593597704;
        bh=Lc+Kqia+7VCiIBzaooXzrHgNvgseUOwkMAw3GQxsHcE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iAGdihGeJOKZHAuFIyXevW4B/xGd5U2BS78bQea+GoG8UHgDYHMkm2sLWV5G+/Rc3
         PnQ0twj3svufIhXT6rzH3KrVlVrpDto5TaEvEeWQc3KwCgBLIJNYjMq0CAierREJIt
         GRiRNwwTT2sfmjuHIwCQCl7fMlhdiZsoHB9kkwsU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.116.87] ([213.196.213.153]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My36N-1iswCO3WEJ-00zTwc; Wed, 01
 Jul 2020 12:01:43 +0200
Date:   Wed, 1 Jul 2020 12:01:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: Re: [PATCH v4 2/2] difftool -d: ensure that intent-to-add files are
 handled correctly
In-Reply-To: <xmqqimff3tib.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2007011153040.56@tvgsbejvaqbjf.bet>
References: <pull.654.v3.git.1593010066.gitgitgadget@gmail.com> <pull.654.v4.git.1593107621.gitgitgadget@gmail.com> <9bb8d84ea956dcddefbe7b62baa3a5ff23b6b1e2.1593107621.git.gitgitgadget@gmail.com> <xmqqimff3tib.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6Q1KUDabFmm+mm8b1CXTHFOUHzV2+dS1bKg1vFHGtUABwx5LYIa
 nZhlT+Qww4V84xNlJgNPvVTYPOBtGwmPhtAp9OdYtZyxKZGW3FgIuiCpx6LiBZ0XYyJ22Eh
 gi0GQ6M+mC7wtW3FjlBf/vOhKaiqrjQ3w27GlUaHvmUJATBd2iJuHOwR76gPjMDhnAV5O4W
 7LXWRaAadMD77FKsEf3Tw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7m19J5+Px20=:aNGGH23MKdv1lfcH9ttFEx
 r5e6H0MEUg/cuLS3Ag6lr8JcGaqD77Khitb5OiKEepS3ZaTAF9YjOLRA9IYhNv5sYBD2VooKz
 gQ8IxA4+6vBUHDEG9mZ+HDY9Ta7kNqkevrqzVR8al9gPW5214jOSA4uOYwx4y0/ClFdFKdK6r
 8Yh1QMy5u02o3KaEAYU0swoYZzCTVWPPUOCAHHN2BSRb5NdcL6RoSTspsTKX34bF0bD2QTvVl
 XDe7mBpBZRF3/r2/CAAlvQ6ow8vMsCvNFw4gO0fmWlYZPQLPmpzWlpZY+wv36ZQDW6fo99y2m
 8SZ5oAA4ZXRLvAK9D7e9FarFs8+3EpI7lExxba+uzAkB/AyJLt11IWd6i/vqpdg9RD8ZpI0J1
 TgGPTvvPDMTJtkhevgT8eamU4XsPRNgk72GXjvGzFkuXYGBZtGI4o2xMwe8fH1ul8yq/hpcnk
 3nwwNPc18bPj5zjUk/q6mC3R6IwxzZOM6vBRVQkpeKA5za5zWhoqFyiwEbbsUVupmni/5fClz
 vS7HAeHngsrq4oQysLyVWxmPqnI7pjFqT5OKVGzZGfF5YXcyPZeFWigqOhWZRJendPkWJ/gCT
 k9cFMacxk5Ml5krewpyEIhA9LuVf3eqjZ6BAmHNiFFtJ9Gk4dDmXZG7qAqAgex1NW8WtHCBt+
 jEBNKLZpe1Vf1onv/+hJ2ox9iXp59jJS35C7vdGk26MK/PeBlEMQ6xsiTipIf/sEN/vfFkkUL
 vBvOaYuSkKtzrmeB38l7qr1hpQgtEbJxEXlVFT728DTLF9PIVkigGrbwAx+aCw2I8zD6mlTyH
 iNxfR+tJ91YuWFFsT0bWDuTGPVCIrjuxRKlYIQ1B/iOng3cxN5033+DLPS0/fLVWX2hOzCIgx
 MlnTd3g0zF5QH5DFfeIdXfkZYdla1xjQzV9amKtLlMKQCBxR+eh+jh7XY/u+1h3S2IRL+MaV+
 x6di4ULJ8Vz84KvKwLr2r6vin9GdH3KKNDW2EN1Rzsfj5DtX6n3ISYWAPpIMRzS5393oEF9TS
 4JE1p4HgcjVu8PDIPnuS7+MiyK2foQ4PpMBMNX3CjnjQjfZAmPIew0q/OzZPr/j+CH9PBP6km
 2jKGADBGABaxJrJa8dTEg7Btd4N221juhukIDa4nELs0ROTXHYjXoxJRo2ar3ch9M45E8fgFp
 5A/IUat1rM4dq15nc0flxM1ItrYb/wlLa1ywLtpFq26ayK8w+35HwNOaWjiwm4I7SGV0ZZ//I
 6j8NSWmxk+5Vfx8qc7Ppb/LOTBRExZx7Pd4JfCg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 25 Jun 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In https://github.com/git-for-windows/git/issues/2677, a `git difftool
> > -d` problem was reported. The underlying cause was a bug in `git
> > diff-files --raw` that we just fixed.
>
> That leaves a gap between "there is some unspecified problem" and
> "the problem was cased by such and such" that forces readers to
> either know the problem at heart (may apply to you and me right now,
> but I am not sure about me 3 months in the future) or go check the
> external website.
>
> Can we fill the gap by saying how seeing the object name of empty
> blob (or worse, tree) instead of 0{40} made "difftool -d" upset?

Sorry about catching this only now, after the commit hit `next`.

Filling the gap is a slightly more complicated.

And now that I looked at the code again, to make sure that I don't say
anything stupid, I realize that I just provided incorrect information in
my reply elsewhere in this thread: Srinidhi's fix is _not_ enough to fix
t7800 with this here patch.

Your guess was almost spot on: the empty blob would have worked (as in:
not caused an error, but it would have shown incorrect information). The
problem really is the attempt trying to read the empty tree as if it was a
blob. That results in something like this:

	error: unable to read sha1 file of /tmp/git-difftool.O8CoK9/right/intent-=
to-add (4b825dc642cb6eb9a060e54bf8d69288fbee4904)
	error: could not write 'intent-to-add'

And yes, it would have been good to adjust the commit message as you
suggested. Sorry for not getting to it in time before it hit `next`.

Do you want me to send out a v5 and drop v4 from `next` in favor of the
new iteration?

Ciao,
Dscho

>
> Thanks.
>
>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t7800-difftool.sh | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> > index 29b92907e2..524f30f7dc 100755
> > --- a/t/t7800-difftool.sh
> > +++ b/t/t7800-difftool.sh
> > @@ -720,6 +720,14 @@ test_expect_success SYMLINKS 'difftool --dir-diff=
 handles modified symlinks' '
> >  	test_cmp expect actual
> >  '
> >
> > +test_expect_success 'add -N and difftool -d' '
> > +	test_when_finished git reset --hard &&
> > +
> > +	test_write_lines A B C >intent-to-add &&
> > +	git add -N intent-to-add &&
> > +	git difftool --dir-diff --extcmd ls
> > +'
> > +
> >  test_expect_success 'outside worktree' '
> >  	echo 1 >1 &&
> >  	echo 2 >2 &&
>
