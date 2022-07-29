Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D902FC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 12:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbiG2Mt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiG2Mt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 08:49:56 -0400
X-Greylist: delayed 536 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 Jul 2022 05:49:54 PDT
Received: from mail2.pdinc.us (mail2.pdinc.us [67.90.184.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FF14E625
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 05:49:54 -0700 (PDT)
Received: from lovegrove (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 26TCepdg013517
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Jul 2022 08:40:51 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 26TCepdg013517
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1659098451; bh=jTE3TnixVmOlY8fqUI0jJ+4LKLPmTrHhg89d9Olphds=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=KWVNosvLf2pRIyepSDfiludroEBS1BPR01/GcAORB521MX7WTOYPWWkA+PRSsDBcG
         odpcKe6lGYQ6MSNTRY3Mcox0COMS3IgzNu9EE1wZgGxweksVXkn7ouSC9McuYpN4Hi
         HtjylfZGtgglzuIaqxi9XEzbFCcHMeCEK/2ij8+nrYDTPRcztjQFA6BgEeEzPE/mZM
         RYU3KNeLtH9u+IoMYDuiqbMCycA40G3aPuN+dVWNVUMIgBeWOFjBcoOOIkf1EESmgE
         WDXctKl2wXs8WtYnKaqjKA4C8TpRSgr7DUUF+Jqq8u+Yc672MkkDyexjhDx7PaiR9Y
         1si+QibAy2qKw==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     "'Stephen Finucane'" <stephen@that.guru>,
        "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     <git@vger.kernel.org>
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>         <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com>         <61333be26339440d9bae8f12fd1a4faeb5e68ab6.camel@that.guru>         <220719.86y1wpuy5o.gmgdl@evledraar.gmail.com> <bf871a430177ced6d628641eac9d478389fb6c2b.camel@that.guru>
In-Reply-To: <bf871a430177ced6d628641eac9d478389fb6c2b.camel@that.guru>
Subject: RE: Feature request: provide a persistent IDs on a commit
Date:   Fri, 29 Jul 2022 08:40:38 -0400
Message-ID: <1f2c01d8a348$68701ba0$395052e0$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQDvwrzvAPdFCj2NSOHkuCFedIHIRwHKatJBAf8UZtMBpEikCgIg5dnjryqUcxA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Stephen Finucane
> Sent: Friday, July 29, 2022 8:11 AM
>=20
> On Tue, 2022-07-19 at 13:09 +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> > On Tue, Jul 19 2022, Stephen Finucane wrote:
> >
> > > On Mon, 2022-07-18 at 20:50 +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> > > > On Mon, Jul 18 2022, Stephen Finucane wrote:
> > > >
> > > > > ...to track evolution of a patch through time.
> > > > >
> > > > > tl;dr: How hard would it be to retrofit an 'ChangeID' concept =
=C3=A0 la the 'Change-
> > > > > ID' trailer used by Gerrit into git core?
> > > > >
> > > > > Firstly, apologies in advance if this is the wrong forum to =
post a feature
> > > > > request. I help maintain the Patchwork project [1], which a =
web-based tool that
> > > > > provides a mechanism to track the state of patches submitted =
to a mailing list
> > > > > and make sure stuff doesn't slip through the crack. One of our =
long-term goals
> > > > > has been to track the evolution of an individual patch through =
multiple
> > > > > revisions. This is surprisingly hard goal because oftentimes =
there isn't a whole
> > > > > lot to work with. One can try to guess whether things are the =
same by inspecting
> > > > > the metadata of the commit (subject, author, commit message, =
and the diff
> > > > > itself) but each of these metadata items are subject to =
arbitrary changes and
> > > > > are therefore fallible.
> > > > >
> > > > > One of the mechanisms I've seen used to address this is the =
'Change-ID' trailer
> > > > > used by Gerrit. For anyone that hasn't seen this, the Gerrit =
server provides a
> > > > > git commit hook that you can install locally. When installed, =
this appends a
> > > > > 'Change-ID' trailer to each and every commit message. In this =
way, the evolution
> > > > > of a patch (or a "change", in Gerrit parlance) can be tracked =
through time since
> > > > > the Change ID provides an authoritative answer to the question =
"is this still
> > > > > the same patch". Unfortunately, there are still some obvious =
downside to this
> > > > > approach. Not only does this additional trailer clutter your =
commit messages but
> > > > > it's also something the user must install themselves. While =
Gerrit can insist
> > > > > that this is installed before pushing a change, this isn't an =
option for any of
> > > > > the common forges nor is it something git-send-email supports.
> > > >
> > > > git format-patch+send-email will send your trailers along as-is, =
how
> > > > doesn't it support Change-Id. Does it need some support that any =
other
> > > > made-up trailer doesn't?
> > >
> > > It supports sending the trailers, sure. What it doesn't support is =
insisting you
> > > send this specific trailer (Change-Id). Only Gerrit can do this =
(server side,
> > > thankfully, which means you don't need to ask all contributors to =
install this
> > > hook if you want to rely on it for tooling, CI, etc.).
> >
> > Ah, it's still unclear to me what you're proposing here though. That
> > send-email always (generates?) or otherwise insists on the trailer, =
that
> > it can be configured ot add it?
> >
> > That send-email have some "pre-send-email" hook? Something else?
>=20
> (Apologies for the delayed response: I was on holiday).
>=20
> I'm afraid I don't have the correct terminology to describe what I'm =
suggesting
> so I'll show an example instead.
>=20
> I have configured the 'fuller' pretty formatter locally:
>=20
>    $ git config format.pretty
>    fuller
>=20
> When I do git log on e.g. the openstack nova repo, I see:
>=20
>    commit 2709e30956b53be1dca91eec801220f0efbaed93
>    Author:     Stephen Finucane <sfinucan@redhat.com>
>    AuthorDate: Thu Jul 14 15:43:40 2022 +0100
>    Commit:     Stephen Finucane <sfinucan@redhat.com>
>    CommitDate: Mon Jul 18 12:30:25 2022 +0100
>=20
>        Fix compatibility with jsonschema 4.x
>=20
>        This changed one of the error messages we depend on [1].
>=20
>        [1] =
https://github.com/python-jsonschema/jsonschema/commit/641e9b8c
>=20
>        Change-Id: I643ec568ee2eb2ec1a555f813fd2f1acff915afa
>        Signed-off-by: Stephen Finucane <sfinucan@redhat.com>
>=20
> (Side note: What *is the term for the "Author", "AuthorDate", "Commit" =
and
> "CommitDate" fields? Commit header? Commit metadata? Something else?)
>=20
> My thinking is there are two types of information here: information =
that relates
> to the "commiting" of this change and information that relates to the
> "authorship" of the this change. The commit ID, 'Commit' and =
'CommitDate' fields
> clearly form the commit parts. I'm arguing that it would be good to =
have an
> equivalent to the commit ID field for the authorship-type metadata.
>=20
>    commit 2709e30956b53be1dca91eec801220f0efbaed93
>    Author:     Stephen Finucane <sfinucan@redhat.com>
>    AuthorDate: Thu Jul 14 15:43:40 2022 +0100
>    AuthorID:   I643ec568ee2eb2ec1a555f813fd2f1acff915afa
>    Commit:     Stephen Finucane <sfinucan@redhat.com>
>    CommitDate: Mon Jul 18 12:30:25 2022 +0100
>=20
>        Fix compatibility with jsonschema 4.x
>=20
>        This changed one of the error messages we depend on [1].
>=20
>        [1] =
https://github.com/python-jsonschema/jsonschema/commit/641e9b8c
>=20
>        Signed-off-by: Stephen Finucane <sfinucan@redhat.com>
>=20
> At risk of repeating myself, I think this information would be =
valuable to allow
> me to answer the question "is this the same[*] commit?". During code =
review,
> this would allow me to track the evolution of an individual patch. =
Once a patch
> is merged, it would allow me to track the backporting or =
cherry-picking of that

We have been toying with this. We are looking at a field (behaves like =
parent) to track "original commit".

This value would be set on first rebase, amend, cherry-pick, etc.

The bonus for us will be when we patch gerrit to consume it and git log =
--graph --somenewoption to use it.

It would be nice if git core did add such value.

-Jason

