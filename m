Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F84C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 22:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349275AbiFCWML (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 18:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiFCWMK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 18:12:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8642BCD
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 15:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654294319;
        bh=9Y+6IPXF583Egl8vzI/UKmrTYXO+s9ahvofcfO+olao=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bTc13gsZYEd9Lmerpxnc8VLTbDsXMIZ8MwrMbP8sKSuEzQbxMkELmOraIMIPx7Gy/
         PRgAvzJxjZ6PZTI+6WW1hNPjE3LnE3eyChSryuCem7V/z6/RzQqOUcIm72X1Y76hNx
         8Um4GOoaMG0EHVt+cXoR+k5KXpXvT1ez+i2gZ3ek=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([213.196.213.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dwj-1nlP462u4j-015dXY; Sat, 04
 Jun 2022 00:11:59 +0200
Date:   Sat, 4 Jun 2022 00:11:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
In-Reply-To: <CABPp-BHQPrun3xhXBhbBnZ9cAy1sV7_r-kGsQhC-YsRMvoERmw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2206032359210.349@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com> <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org> <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet> <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com> <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet> <CABPp-BFG_05RyVVyiHzOkuoT8=9NftJGp_W+DXd7ktqC5UfvwQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202251726500.11118@tvgsbejvaqbjf.bet> <CABPp-BGnqXdFBNAyKRXgvCHv+aUZTMg-CgcQf95dKAR-e1zSjQ@mail.gmail.com> <nycvar.QRO.7.76.6.2203071718090.11118@tvgsbejvaqbjf.bet> <CABPp-BGW39_5r8Lbt3ymR+F_=hWJcf=2e7O75vFNJ=3CEL5s=g@mail.gmail.com>
 <nycvar.QRO.7.76.6.2203101546110.357@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2205131220200.352@tvgsbejvaqbjf.bet> <CABPp-BHQPrun3xhXBhbBnZ9cAy1sV7_r-kGsQhC-YsRMvoERmw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:J+sbcGxv5erM+/zeJO7qqaMlYDDmjWzRGPTCykD1SSTxQNZ8k38
 9LNMWdxGfInTBKENTIaNPLY9cFEQ4ADV+43F0Ujfl03ywwFJXDQCTs/Y85EjTy49QR1Aaax
 o7WAdDC5JlDlHp85HhAjSqmcmqofA5T73gBlYdCfHuUmE/fnfRBy3jtlLQhup53eZVjFL9N
 PBS2/pNJ0lcoUrsobq5zA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V3q5+cPs1kg=:3zMbCq2p16ZHPMawf/SAPd
 9jaD1An13A+TGmZcjgTUqhQniYuo6JevxAEBRercVDZkOUvYNa9Xhl2Z9wulZQSRdvcI6gIO1
 p0p94bkc4s5xYU+oAJJ3hGLHzLR958aNvUJ3sRF1vIt4tvcxv+NSjBTy9Skk8WT0CT1WVnZ4E
 UA2p0F8E1vcP8lbIm6ziUi5y1JDiwPJnJhpie8Oy+dr78uhiS5oL5DAayJMFLhjVqzF+b4u9u
 5DnxkXbXyeStHP/pgs9g0+vClgqYndDav64kN22Kyj9b3mS4BBT1OqJHJDpVgCSfAqfAklUUz
 X5Fpvq6dl/TLEIp7/UC78KKtLjLMelhcZsOnme2f37DhwSyctnlPtjAcs1E84+PHaVlZdOI2C
 se7AkPbL9j3efDnsQUlXEUZyrPTlOuURobngqTsTPNg1Ih0mxNa2xF5A9TiQrxOuA9icFtx4l
 RIQmMAKtYK5JZ2eyEURR2QOriPgSfWuJH1vOpQMtPXaG6cFyephr8Y40sanI+xIeBlxHeVFEv
 aitbSUYI80d5RExCflREy7LuMJrTD/VJlw1nse3S6NzAKfSqCKs7PCqZ8tHyEgxNPcJdtmcMf
 uJIztTwoC9T5q5J0p3S6EleRpRuAUEngFS5pOkrQKweVoRrj20BLMh8l6wkp+N8k1sgH9e5Qy
 YJFPTUkYqL9WlhS8mT93mPP3Ghxy5RYsWtFH61YdZKjw2Y0OjQrZcyKY+sDwupsRKTj3dzgq5
 Xf/2qmm53QEx126cTJPoRGUFObc6SPvqPw8sRu2a63ico4/aWUWF1s/me3rdI6ts6nayrB+q4
 C7YH78UUTsjP5qCKdwzXaFeQVuYcz+lH2dLjlVYQg+gjBfgeyN9JagwoUq/l0pLzkVT8Shxbl
 oQkekd9SEC65D4cy7Q+raUnbaTo8AOx+cZ60ssRJJ5J1m5nU38SrzmulhsUG1R4bsvC6UixLM
 Dc/7qfAHAeO+L1jZMJPxGShGai75+LrDfL2FDS6Dt8IPQdGYV/P3ZDMxy6DMYUClHuK3GRtqL
 DRPToJSq8Z+66h2o4c5XRzAd0G8busaz+NX7puHKbKspue0TLCptsSPMIxMbvlJR4r0houplq
 71aDhBkrKKrK4z65RqxjTwj2ubTmRcbbknmHGOuM0IHJ9RDyDRBbvlGUw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 17 May 2022, Elijah Newren wrote:

> On Fri, May 13, 2022 at 3:21 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Thu, 10 Mar 2022, Johannes Schindelin wrote:
> >
> > > On Tue, 8 Mar 2022, Elijah Newren wrote:
> > >
> > > > So, this is one series where even if everyone else says to merge i=
t
> > > > already, I'd like to wait a bit longer on it until I feel confiden=
t we
> > > > have a solution that handles at least the current usecases.
> > >
> > > Fair enough, you're in charge of this series, and I really like what=
 you
> > > came up with.
> > >
> > > My thinking was driven more by the users' side, as I am relatively e=
ager
> > > to integrate this into production, but am loathe to do that with an =
early
> > > iteration of `en/merge-tree` that might be substantially revamped, s=
till.
> >
> > I've been bogged down with things elsewhere, but should now have time =
to
> > help on this end.
> >
> > Elijah, _is_ there anything I can help with?
>
> Yeah, I've been bogged down with other things too; the little Git time
> I've had has been spent responding to review requests or other things
> folks manually were asking for my input on.
>
> I think I got a fair amount of this implemented about a month or so
> ago.  I just pushed up what I have to the wip-for-in-core-merge-tree
> branch of newren/git.

Thank you so much!

I worked a few hours on this and pushed up my changes under the same
branch name to dscho/git.

> Some notes:
>
>   * A big "WIP" commit that needs to be broken up

I did not yet start on that.

>   * The previous "output" member of merge_result, containing a strmap
> of conflict and informational messages (basically a mapping of
> filename -> strbuf) now needs to be replaced by a strmap "conflicts",
> which is now a mapping of primary_filename -> logical_conflicts, and
> logical_conflicts is an array of logical_conflict, and
> logical_conflict has a type, array of paths, and message.
>   * Since "output" is no longer part of merge_result, the new
> remerge-diff functionality is going to need to be modified since it
> used that field, and instead iterate on "conflicts" to get the same
> information

I punted on that for now, recreating an `output`-style strmap and storing
it as `path_messages` attribute.

>   * I have some FIXME comments in a couple places where I need to
> figure out how I want to pass the variable number of arguments (in a
> function already accepting a variable number of arguments for other
> reasons, making the function in a way have to variable length lists of
> arguments)

In my WIP fixups, I refactored this into a version that takes varargs and
another version that takes a string_list.

However, after getting all this to compile and t4301 to pass, I think we
actually only need a version that takes up to two "other" paths, and a
version that takes a string_list with those "other" paths, where the
former constructs a temporary string_list and then calls the latter.

>   * The new enums and structs I added to merge-ort.c really have to be
> added to merge-ort.h and become part of the API.  Feels a little
> unfortunate since it'll make the API _much_ more involved, but I don't
> see any other way to solve your usecase.

I agree, but I did not do that yet ;-)

Another thing I noticed is that we can probably ensure consistency between
the `conflict_and_info_types` enum and the `type_short_descriptions` array
by using the same C99 construct we're already using in the
`advice_setting` array in advice.c:

	static const char *type_short_descriptions[NB_CONFLICT_TYPES] =3D {
		/*** "Simple" conflicts and informational messages ***/
		[INFO_AUTO_MERGING] =3D "Auto-merging",
		[CONFLICT_CONTENTS] =3D "CONFLICT (contents)",
	[...]

> If you want to take a stab at the above, or even see if my changes
> make sense (sorry for it all being squashed into one big commit and
> not having good commit messages, but, you know...you did ask), that'd
> be great.

Yes, I did ask, and I did receive ;-)

Thank you so much! It would be great if you could have a quick look over
the commits I added on top of your branch, to see whether things make more
or less sense to you. But if you're too busy elsewhere, I am one of the
best persons to understand that, too.

Thanks!
Dscho
