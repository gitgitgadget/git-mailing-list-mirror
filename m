Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B33B21F463
	for <e@80x24.org>; Wed, 11 Sep 2019 10:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfIKK5i (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 06:57:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:35875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbfIKK5i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 06:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568199444;
        bh=IbeyrmHrB/va/+G4lpo/4H+sqprpBBZ0N4Fq1tNzJdw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KflDT9Qgo3g9jU+c21s/tqmqpA9XDk3/u2XaKxvmR/uBrK0YF243fKgt56ejOR1qw
         pAYrIFvf2s81V5z+uUhFP6d0p+4TldEhwdOAEIvCsEmhYfa4/mssAXsttYcYJql9UP
         OWUmaNCCFXMcxdzG3dMvjszKFK4tHKneRBYda9o8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3DM-1hsdB60V32-00FQGa; Wed, 11
 Sep 2019 12:57:24 +0200
Date:   Wed, 11 Sep 2019 12:57:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Joel Teichroeb <joel@teichroeb.net>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 1/3] factor out refresh_and_write_cache function
In-Reply-To: <20190906141812.GA128436@cat>
Message-ID: <nycvar.QRO.7.76.6.1909111155540.5377@tvgsbejvaqbjf.bet>
References: <20190829182748.43802-1-t.gummerer@gmail.com> <20190903191041.10470-1-t.gummerer@gmail.com> <20190903191041.10470-2-t.gummerer@gmail.com> <xmqqwoemo131.fsf@gitster-ct.c.googlers.com> <20190906141812.GA128436@cat>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Dm7dS1Vj+TzNAcDNjgi/WWLhrrFVGaoH+sMX4pDjodadJMHywxd
 WjJpGvtc+As3ba8pUWzbkFRy5i6IVWBZI3AdBc+5rLiSYnW5sIZaC1LuH9YcIT63ErcqwLE
 Wtn2iBtoLwRwugYXcspfGuXK1yonUcksAafKWDMsAc8evu9EGTyCadq4vpMXiPsQeyrwBz1
 m9Dqmc7x3rczFOqxFD9Iw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C+kvTufFdEw=:m199eONwasXn+Dib/dK5tS
 WiD5ROVMrIHaHmdoewp+6mral+H3DhAWDeEmaDfJAMbqlNzTCk76AVTxzPVV6w2tHT43sacXW
 qn0lwwGbCW8UiNJ3B4sYVASn9kAow6IXMn3mtULGsfBLFQOrTqirEUDl86KYjJP5ullGSgFaJ
 k5E73idXNAgNLAqe4pasIhci3IAPXcJG5njZSybP88pkZExDxFQ9wmGPYdfUYRa7/SU/PKlQn
 z9DSgwpeExPEafaCTQu2b6u6wARDym9WX8vtbWANBX3PsBirsXZbbTRBXjx3yDjn1mjkwcaW5
 Go68ly9U1u/OQwyrW3tGgPj9y7MMX5MDbUg5rLNARs8WVHmIA8v2LpcB3e4v46VZODVgmGi6y
 y2+Va2FjC+5Ktl6c2EF0+eTc14KIYohDgl1MWhyrW3retZOTI5OAJLDPOvz6qISBAxfNJw+cN
 ZlHk258UwU1PZITApIWFqKiH3LBr+LXQTBePKiZ/6rpWiDzPByU0UjXnmEoeCGn+38vT70Alf
 neAVopjpGyn7J7j6iNz41QTVyqa3w4rk9CpQJodyF3PA9b8Asnxn0RYwgaZ2mNuiHWb//ImhN
 Fs5wmPkD1BcB+qECdc9Gz8U94Fk2uSVnF1JCY3f8+vCbpb1eCHbAy3Iqy0B/u+3WD4rMzIvHf
 8CKyoyrtwEXyMb0Hl4B4a7hhGUDMj35zhbhAl97/NT+369WOWlDqMHWDIuIn07wFLS6pGsvGM
 bUpWLmutHLXvdYo67ckp06jqrJjjRcKgcHQf5Ut4BWcxL/KvZQr0gn2PrEDX/6S2RGOiDPO7o
 dVcYyTutrZgUjkauW9LjyOn8B4lgYFEi4NJlQfFFFSzkrCmF6TI27sPckmsW060veg5i8n7Zd
 BaNhpEaf2KyK4p0bvj9OKgfEqhLv78AWRlWZ12tAtf9ODC0yIsKEnLEn57VIiidPTwKtOme39
 29bAyMCrcvbSDt/D89BBLjKlE5wDtXzIm8jOfUwScvntWXQUdwQnzDL3EoIrlvFHb7Yq+FX9o
 wX4qXGtfr1gUcs6ios/gueEs8BNYjKaeeZwXdm71EtTrk7s7ieDTGyX+oeEUUX7XkU7DLlxfI
 xeBWMjIp/wYHBqUhHHcxpMGIdq7ssg///rL69AQywxfmD/sWprd7IYBS108QLojv7+WBwI55w
 Lw5BAyiD44BAy7cmJ7o6VmH0U3ia04BhVhFd8kY5VcHy1Mm/37VVQN3MkKhkv1oeGX2uA9NGm
 fyRMee6VeN+NBop3Q
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Fri, 6 Sep 2019, Thomas Gummerer wrote:

> On 09/05, Junio C Hamano wrote:
> > Thomas Gummerer <t.gummerer@gmail.com> writes:
> >
> > > Getting the lock for the index, refreshing it and then writing it is=
 a
> > > pattern that happens more than once throughout the codebase, and isn=
't
> > > trivial to get right.  Factor out the refresh_and_write_cache functi=
on
> > > from builtin/am.c to read-cache.c, so it can be re-used in other
> > > places in a subsequent commit.
> > >
> > > Note that we return different error codes for failing to refresh the
> > > cache, and failing to write the index.  The current caller only care=
s
> > > about failing to write the index.  However for other callers we're
> > > going to convert in subsequent patches we will need this distinction=
.
> > >
> > > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > > ---
> > >  builtin/am.c | 16 ++--------------
> > >  cache.h      | 16 ++++++++++++++++
> > >  read-cache.c | 19 +++++++++++++++++++
> > >  3 files changed, 37 insertions(+), 14 deletions(-)
> >
> > I think this goes in the right direction, but obviously conflicts
> > with what Dscho wants to do in the builtin-add-i series, and needs
> > to be reconciled by working better together.
>
> Oops, I didn't realize there was another series in flight that also
> introduces 'repo_refresh_and_write_index'.  Probably should have done
> a test merge of this with pu.

Yep, our patches clash. I would not mind placing my patch series on top
of yours, provided that you can make a few changes that I need ;-)

> > For now, I'll eject builtin-add-i and queue this for a few days to
> > give it a bit more exposure, but after that requeue builtin-add-i
> > and discard these three patches.  By that time, hopefully you two
> > would have a rerolled version of this one and builtin-add-i that
> > agree what kind of refresh-and-write-index behaviour they both want.
> >
> > The differences I see that need reconciling are:
>
> Thanks for writing these down.
>
> >  - builtin-add-i seems to allow 'gentle' and allow returning an
> >    error when we cannot open the index for writing by passing false
> >    to 'gentle'; this feature is not used yet, though.
>
> Right, and if gentle is set to false, it avoids writing the index,
> which seems fine from my perspective.

This also suggests that it would make sense to avoid
`LOCK_DIE_ON_ERROR`, _in particular_ because this is supposed to be a
library function, not just a helper function for a one-shot built-in
(don't you like how this idea "it is okay to use exit() to clean up
after us, we don't care" comes back to bite us?).

> >  - This version allows to pass pathspec, seen and header_msg, while
> >    the one in builtin-add-i cannot limit the part of the index
> >    getting refreshed with pathspec.  It wouldn't be a brain surgery
> >    to use this version and adjust the caller (there only is one) in
> >    the builtin-add-i topic.
>
> 'pathspec', 'seen' and 'header_msg' are not used in my version either,
> I just implemented it for completeness and compatibility.  So I'd be
> fine to do without them.

Oh, why not keep them? I'd rather keep them and adjust the caller in
`builtin-add-i`.

> >  - This version does not write the index back when refresh_index()
> >    returns non-zero, but the one in builtin-add-i ignores the
> >    returned value.  I think, as a performance measure, it probably
> >    is a better idea to write it back, even when the function returns
> >    non-zero (the local variable's name is has_errors, but having an
> >    entry in the index that does not get refreshed is *not* an error;
> >    e.g. an unmerged entry is a normal thing in the index, and as
> >    long as we refreshed other entries while having an unmerged and
> >    unrefreshable entry, we are making progress that is worth writing
> >    out).
>
> I'm happy with writing the index back even if there are errors.
> However I think we still need the option to get the return code from
> 'refresh_index()', as some callers where I'm using
> 'refresh_and_write_index()' in this series behave differently
> depending on its return code.
>
> There's two more differences between the versions:
>
>  - The version in my series allows passing in write_flags to be passed
>    to write_locked_index, which is required to convert the callers in
>    builtin/merge.c.

I can always pass in 0 as `write_flags`.

>  - Dscho's version also calls 'repo_read_index_preload()', which I
>    don't do in mine.  Some callers don't need to do that, so I think it
>    would be nice to keep that outside of the
>    'repo_refresh_and_write_index()' function.

Agreed.

> I can think of a few ways forward here:
>
>  - I incorporate features that are needed for the builtin-add-i series
>    here, and that is rebased on top of this series.

I'd prefer this way forward. The `builtin-add-i` patch series is
evolving more slowly than yours.

>  - We drop the first two patches of this series, so we only fix the
>    problems in 'git stash' for now.  Later we can have a refactoring
>    series that uses repo_refresh_and_write_index in the places we
>    converted here, once the dust of the builtin-add-i series settled.
>
>  - I rebase this on top of builtin-add-i.
>
> I'm happy with either of the first two, but less so with the last
> option.  I was hoping this series could potentially go to maint as it
> was a bugfix, which we obviously can't do with that option.
>
> Dscho, what do you think? :)

See above ;-)

Thank you!
Dscho

>
> > Thanks.
> >
> > > +int repo_refresh_and_write_index(struct  repository *repo,
> > > +				 unsigned int refresh_flags,
> > > +				 unsigned int write_flags,
> > > +				 const struct pathspec *pathspec,
> > > +				 char *seen, const char *header_msg)
> > > +{
> > > +	struct lock_file lock_file =3D LOCK_INIT;
> > > +
> > > +	repo_hold_locked_index(repo, &lock_file, LOCK_DIE_ON_ERROR);
> > > +	if (refresh_index(repo->index, refresh_flags, pathspec, seen, head=
er_msg)) {
> > > +		rollback_lock_file(&lock_file);
> > > +		return 1;
> > > +	}
> > > +	if (write_locked_index(repo->index, &lock_file, COMMIT_LOCK | writ=
e_flags))
> > > +		return -1;
> > > +	return 0;
> > > +}
> > > +
> > > +
> > >  int refresh_index(struct index_state *istate, unsigned int flags,
> > >  		  const struct pathspec *pathspec,
> > >  		  char *seen, const char *header_msg)
>
