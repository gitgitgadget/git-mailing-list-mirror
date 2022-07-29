Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97DBC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 12:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiG2MLd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiG2MLc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 08:11:32 -0400
Received: from mail-108-mta94.mxroute.com (mail-108-mta94.mxroute.com [136.175.108.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523CF87F7D
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 05:11:29 -0700 (PDT)
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta94.mxroute.com (ZoneMTA) with ESMTPSA id 18249de65fc0000261.002
 for <git@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Fri, 29 Jul 2022 12:11:28 +0000
X-Zone-Loop: ef9a3632d87157ec560f37f03901bb6a80d5a2701666
X-Originating-IP: [140.82.40.27]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=that.guru;
        s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=G2iLDC73KbWEnT48jewhl1EsJMaEDhSWDwohUFDzNZ8=; b=bF2tJ4KfhKR+VAcWgP0m/IP1RX
        mu6ark1Aiv24CBiZtUyHKYa65vxvTzLVACWXxcUv46B7BR1rsd/h6Z+a9LuM1KOPQGFNlJ4WLb/gG
        qJkH+pJkVRp77LqOwwwU92JFET3Ay3h7FccZOhkM6K/U4mE95n+5rZn3Xhf2PhBRs68Nsmi7xY8+D
        dWaZnkHLun1Og1zDrqMaXFRXku0GPF4NMfMh65VWm/U5muEjWP1jAqyXNoa3NLvYTao8sPG4gyj3u
        1U/IenCQXkyK9z30XBluXsJWHjr7BOn+MsEEgsAmrlnDszVkcgwUnGAY4EjysQEzLr8oDOIIys1B0
        gVlezyIg==;
Message-ID: <bf871a430177ced6d628641eac9d478389fb6c2b.camel@that.guru>
Subject: Re: Feature request: provide a persistent IDs on a commit
From:   Stephen Finucane <stephen@that.guru>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Date:   Fri, 29 Jul 2022 13:11:24 +0100
In-Reply-To: <220719.86y1wpuy5o.gmgdl@evledraar.gmail.com>
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
         <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com>
         <61333be26339440d9bae8f12fd1a4faeb5e68ab6.camel@that.guru>
         <220719.86y1wpuy5o.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-AuthUser: stephen@that.guru
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2022-07-19 at 13:09 +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason w=
rote:
> On Tue, Jul 19 2022, Stephen Finucane wrote:
>=20
> > On Mon, 2022-07-18 at 20:50 +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on wrote:
> > > On Mon, Jul 18 2022, Stephen Finucane wrote:
> > >=20
> > > > ...to track evolution of a patch through time.
> > > >=20
> > > > tl;dr: How hard would it be to retrofit an 'ChangeID' concept =C3=
=A0 la the 'Change-
> > > > ID' trailer used by Gerrit into git core?
> > > >=20
> > > > Firstly, apologies in advance if this is the wrong forum to post a =
feature
> > > > request. I help maintain the Patchwork project [1], which a web-bas=
ed tool that
> > > > provides a mechanism to track the state of patches submitted to a m=
ailing list
> > > > and make sure stuff doesn't slip through the crack. One of our long=
-term goals
> > > > has been to track the evolution of an individual patch through mult=
iple
> > > > revisions. This is surprisingly hard goal because oftentimes there =
isn't a whole
> > > > lot to work with. One can try to guess whether things are the same =
by inspecting
> > > > the metadata of the commit (subject, author, commit message, and th=
e diff
> > > > itself) but each of these metadata items are subject to arbitrary c=
hanges and
> > > > are therefore fallible.
> > > >=20
> > > > One of the mechanisms I've seen used to address this is the 'Change=
-ID' trailer
> > > > used by Gerrit. For anyone that hasn't seen this, the Gerrit server=
 provides a
> > > > git commit hook that you can install locally. When installed, this =
appends a
> > > > 'Change-ID' trailer to each and every commit message. In this way, =
the evolution
> > > > of a patch (or a "change", in Gerrit parlance) can be tracked throu=
gh time since
> > > > the Change ID provides an authoritative answer to the question "is =
this still
> > > > the same patch". Unfortunately, there are still some obvious downsi=
de to this
> > > > approach. Not only does this additional trailer clutter your commit=
 messages but
> > > > it's also something the user must install themselves. While Gerrit =
can insist
> > > > that this is installed before pushing a change, this isn't an optio=
n for any of
> > > > the common forges nor is it something git-send-email supports.
> > >=20
> > > git format-patch+send-email will send your trailers along as-is, how
> > > doesn't it support Change-Id. Does it need some support that any othe=
r
> > > made-up trailer doesn't?
> >=20
> > It supports sending the trailers, sure. What it doesn't support is insi=
sting you
> > send this specific trailer (Change-Id). Only Gerrit can do this (server=
 side,
> > thankfully, which means you don't need to ask all contributors to insta=
ll this
> > hook if you want to rely on it for tooling, CI, etc.).
>=20
> Ah, it's still unclear to me what you're proposing here though. That
> send-email always (generates?) or otherwise insists on the trailer, that
> it can be configured ot add it?
>
> That send-email have some "pre-send-email" hook? Something else?
=20
(Apologies for the delayed response: I was on holiday).

I'm afraid I don't have the correct terminology to describe what I'm sugges=
ting
so I'll show an example instead.

I have configured the 'fuller' pretty formatter locally:

   $ git config format.pretty
   fuller

When I do git log on e.g. the openstack nova repo, I see:

   commit 2709e30956b53be1dca91eec801220f0efbaed93
   Author:     Stephen Finucane <sfinucan@redhat.com>
   AuthorDate: Thu Jul 14 15:43:40 2022 +0100
   Commit:     Stephen Finucane <sfinucan@redhat.com>
   CommitDate: Mon Jul 18 12:30:25 2022 +0100
  =20
       Fix compatibility with jsonschema 4.x
      =20
       This changed one of the error messages we depend on [1].
      =20
       [1] https://github.com/python-jsonschema/jsonschema/commit/641e9b8c
      =20
       Change-Id: I643ec568ee2eb2ec1a555f813fd2f1acff915afa
       Signed-off-by: Stephen Finucane <sfinucan@redhat.com>

(Side note: What *is the term for the "Author", "AuthorDate", "Commit" and
"CommitDate" fields? Commit header? Commit metadata? Something else?)

My thinking is there are two types of information here: information that re=
lates
to the "commiting" of this change and information that relates to the
"authorship" of the this change. The commit ID, 'Commit' and 'CommitDate' f=
ields
clearly form the commit parts. I'm arguing that it would be good to have an
equivalent to the commit ID field for the authorship-type metadata.
  =20
   commit 2709e30956b53be1dca91eec801220f0efbaed93
   Author:     Stephen Finucane <sfinucan@redhat.com>
   AuthorDate: Thu Jul 14 15:43:40 2022 +0100
   AuthorID:   I643ec568ee2eb2ec1a555f813fd2f1acff915afa
   Commit:     Stephen Finucane <sfinucan@redhat.com>
   CommitDate: Mon Jul 18 12:30:25 2022 +0100
  =20
       Fix compatibility with jsonschema 4.x
      =20
       This changed one of the error messages we depend on [1].
      =20
       [1] https://github.com/python-jsonschema/jsonschema/commit/641e9b8c
      =20
       Signed-off-by: Stephen Finucane <sfinucan@redhat.com>

At risk of repeating myself, I think this information would be valuable to =
allow
me to answer the question "is this the same[*] commit?". During code review=
,
this would allow me to track the evolution of an individual patch. Once a p=
atch
is merged, it would allow me to track the backporting or cherry-picking of =
that
patch between branches (in a more reliable fashion than the "cherry picked =
from"
trailer that one can add with the '-x' flag).

Now I do realize that there will be issues with this. As has been noted
elsewhere in the thread, people do split patches up or merge them together,=
 and
a patch can change so drastically during review that it doesn't resemble th=
e
original patch in any way. However, I'd argue that in both cases the presen=
ce of
these persistent IDs would at least leave a breadcrumb trail for either too=
ling
or humans to follow. Similarly, it is possible for users to mess things up =
by
resetting or reusing the persistent ID fields, but as has been noted elsewh=
ere
in this thread this is already an issue with the existing Author* fields (w=
hich
many users likely don't know about) yet I couldn't imagine anyone wanting t=
o get
rid of these. It's an education thing.

> I'd think for projects that care about this they're likely to have a
> centralized enough workflow that it can be checked on the remote side,
> whether that's some sanity check on the applier's "git am" pipeline, or
> a "pre-receive" hook.

Yeah, as above I'm hoping this would form part of the core metadata of a co=
mmit
rather than a trailer or something. Tools like Gerrit could of course do
validation on this but that's outside the scope of what I'm looking at.

> > > > I imagine most people working with mailing list based workflows hav=
e their own
> > > > client side tooling to support this while software forges like GitH=
ub and GitLab
> > > > simply don't bother tracking version history between individual com=
mits in a
> > > > pull/merge request.
> > >=20
> > > It's far from ideal, but at least GitLab shows a diff on a push to a =
MR,
> > > including if it's force-pushed. I'm not sure about GitHub.
> >=20
> > GitHub does not. Simply piling multiple additional "fix" commits onto t=
he PR
> > branch results in a less horrible review experience since you can maint=
ain
> > context, alas at the cost of a rotten git log. We don't need to debate =
the pros
> > and cons of the various forges though :)
>=20
> Yes, I'm only mentioning it because it's worth looking at existing
> "solutions" that are in use in the wild, however flawed those may be.
>=20
> > > > IMO though, it would be fantastic if third party tools
> > > > weren't necessary though. What I suspect we want is a persistent ID=
 (or rather
> > > > UUID) that never changes regardless of how many times a patch is ch=
erry-picked,
> > > > rebased, or otherwise modified, similar to the Author and AuthorDat=
e fields.
> > > > Like Author and AuthorDate, it would be part of the core git commit=
 metadata
> > > > rather than something in the commit message like Signed-Off-By or C=
hange-ID.
> > > >=20
> > > > Has such an idea ever been explored? Is it even possible? Would it =
be broadly
> > > > useful?
> > >=20
> > > This has come up a bunch of times. I think that the thing git itself
> > > should be doing is to lean into the same notion that we use for track=
ing
> > > renames. I.e. we don't, we analyze history after-the-fact and spot th=
e
> > > renames for you.
> >=20
> > Any idea where I'd find previous discussions on this? I did look, and t=
he only
> > proposal I found was an old one that seemed to suggest including the Ch=
ange-Id
> > commit-msg hook with git itself which is not what I'm suggesting here.
>=20
> At the time I was punting on finding the links, and just working off
> vague recollection, and hoping you'd go list spelunking.
>=20
> But I since recalled some details, I think the most relevant thing is
> this discussion about a "git evolve":
>=20
>     https://lore.kernel.org/git/CAPL8ZivFmHqS2y+WmNR6faRMnuahiqwPVYsV99Ni=
J1QLHOs9fQ@mail.gmail.com/
>=20
> Which I think you'll find useful, especially as mercurial has an
> existing implementation. The wider context for that "git evolve" is (I
> believe) people at Google who maintain Gerrit trying to "upstream" the
> Change-Id.
>=20
> Now, it hasn't landed in git.git, and it's been a few years, but going
> through the details of why it fizzled out will be useful to you, if
> you're interested in driving something like this forward.

Yeah to be clear I'm not suggesting tracking anything like this in Git core=
. My
main request is here is a persistent Author ID field. Commits as they are w=
ould
remain the same: we'd just be able to show the evolution of a "change" in
external tooling without the need for separate trailers.

> There's also these two proposals from Eric Raymond:
>=20
> 	https://lore.kernel.org/git/20190515191605.21D394703049@snark.thyrsus.co=
m/

This however, looks more similar to what I'm proposing. If understand this
correctly (I'm still reading the full thread), Eric is proposing allowing t=
wo
ways to reference a commit: the hash and a sort of alias. There would still=
 be a
1:1 mapping though, which is explicitly not what I want. I'm also not sugge=
sting
generating this stuff server-side. It should be part of the commit when
initially created, just like Author and AuthorDate.

> 	https://lore.kernel.org/git/20190521013250.3506B470485F@snark.thyrsus.co=
m/
>=20
> Which I'm linking to here not because I think they're viable, as you can
> see from my participation in those threads I think what he suggested is
> an architectural dead end as far as git is concerned.
>=20
> But rather because it's conceptually adjacent (you could in principle
> use nanosecond timestamps as a poor man's UUID), and much of the
> follow-up discussion is about format changes in general, and if/when
> those might be viable.
>=20
> > > We have some of that in git already, as git-patch-id, and more recent=
ly
> > > git-range-diff. Both are flawed in a bunch of ways, and it's easy to =
run
> > > into edge cases where they don't spot something that they "should"
> > > have. Where "should" exists in the mind of the user.
> >=20
> > That's a fair point and is of course what we (Patchwork) have to do cur=
rently.
> > Patchwork can track relations between individual patches but doesn't at=
tempt to
> > generate these relations itself. Instead, we rely on third-party toolin=
g. The
> > PaStA tool was one such example of a tool that could do this [1]. I can=
't
> > imagine a tool like Gerrit would ever work without this concept of an
> > authoritative (and arbitrary) identifier to track a patch's identity th=
rough
> > time, hence its reliance on the Change-Id trailer.
>=20
> I haven't used Gerrit or Patchwork, so much of this is from ignorance on
> that front, but I have spent a lot of time thinking about this in the
> context of git in general.
>=20
> I think as users of git go the git project itself makes very heavy use
> of this, i.e. sequences of patches are substantially rewritten, split,
> squashed etc. all the time, or even split into two or more sets of
> submissions.
>=20
> Having said all that I can't see how a Change-Id isn't a Bad Idea(TM)
> for all the same reasons that pre-git SCMs file formats that track
> renames explicitly were a bad idea.
>=20
> I.e. yes you can come up with cases where that's "better" than what git
> does, but they didn't handle splitting/merging files etc.
>=20
> Similarly what happens when you have 3 patches each with their own
> Change-Id and you split them into 4 patches. Is the Change-Id 1=3D1 or
> 1=3Dmany. I'm suggesting that you'd want a solution that can be many=3Dma=
ny.
>=20
> And also, that those many=3Dmany should be dynamically configurable and
> inferred after the fact. E.g. range-diff will commits that are similar
> enough that two authors with no knowledge of each other independently
> came up with.

I touched on the splitting/merging of changes above but just to reiterate, =
I
don't think this is an issue. I'm using Gerrit for OpenStack-related effort=
s nad
mailing lists (with Patchwork tracking submissions) elsewhere. Patches are
frequently split and merged as part of a review process and can often be me=
rged
as part of a backport (I've yet to see a patch split up when backporting bu=
t it
could happen too). If a patch is split, the original patch retains the 'Cha=
nge-
ID' as well as 'Author' and 'AuthorDate' fields while the split out patch(e=
s)
get new versions of these. If one or more patches are squashed, you get the
'Change-ID' and 'Author'/'AuthorDate' of the first patch in the series of
squashed patches. In both cases though, some Change-ID persists which means=
 you
can track the evolution of a patch or series through time. These are all
extremely helpful breadcrumbs for reviewers.

Regarding the rename issue, I agree that this isn't something Git should do
either. As you note, it's too hard to do 100% reliably, which would be expe=
cted
goal. I'm not looking for 100% reliability here. I just want a better bread=
crumb
than e.g. range-diff currently provides.

> I think that range-diff is still lacking in a lot of ways, in particular:
>=20
>  * It matches entire commits (log + diff) on a similarity score, I've
>    often wanted a way to "weigh" it, so e.g. a matching hunk would have
>    3x the matching score of a matching commit message.
>=20
>    Now it often "gives up", you can give it a higher --creation-factor,
>    but that's "global", so for a large range you'll often start
>    including irrelevant things as well.
>=20
>  * It only does 1=3D1 attribution, and e.g. currently can't find/represen=
t
>    a case where a commit with 3 hunks got split into two commits, with 2
>    and 1 hunks, respectively. It'll (usually) show a diff to the new 2
>    hunk commit, but the "new" 1 hunk will be shown as new.
>=20
>    We could continue to drill down and find such "unattributed" hunks.
>=20
> > Perhaps we could flip this on its head. What would be the _downsides_ o=
f
> > providing a persistent, arbitrary identifier on a commit similar to Aut=
hor and
> > AuthorDate fields? There's obviously some work involved in implementing=
 it but
> > assuming that was already done, what would break/be worse as a result?
>=20
> That "Repository formats matter", to borrow a phrase from a classic post
> about git[1]. Once you provide a way to do something it will be used,
> and when that something has inherent limitations (think SCM rename
> tracking) used to the exclusion of others.
>=20
> You can't provide something like that as an opt-in and "upstream" it
> without it inevetably trickling into a lot of areas of Git's UX.
>=20
> To continue the rename example, now you can just re-arrange your source
> tree and not worry about micro-managing it with "git mv" (in the "svn
> mv" sense), git will figure it out after the fact.
>=20
> That's a sinificant UX benefit, we can provide a *much simpler* UX as a
> result.
>=20
> What would be the harm of an optional "rename tracking" header? After
> all the heuristic sometimes "fails".
>=20
> The harm would be that if you really wanted to lean into that (even
> optionally) you'd be forced to add that to all sorts of tooling, not
> just the cheap convenience that is "git mv" currently.
>=20
> Likewise everything from "cherry-pick" to "rebase" to "commit" would
> inevitably have to learn some way to know about, carry forward and ask
> the user about Change-Id's and their preservation. Don't you think so?

These are all valid points. Hopefully my points above regarding the similar=
ity
to the Author and AuthorDate fields helps though.

> Otherwise they'd be much too easy to lose track of, and if they only
> reason we did all that is because we didn't think enough about the "work
> it out after" approach that would be a bad investment of time.
>=20
> But I may be wrong about all of that, I think one thing that would
> really help clarify this & similar proposals is if people pushing it
> forward came up with some basic tests for it, i.e. just something like
> a:
>=20
>     series-v1/
>     series-v2/
>=20
> Where those two directories would be the "git format-patch" output (or
> whatever) of two versions of a series that Gerrit or Patchwork are now
> managing, along with some (plain text?) manual mapping of which things
> in v1 correspond to v2.
>=20
> We could then compare how that manual attribution performs v.s. trying
> to find which things match (range-diff) afterwards.

I hope my examples above helped with this, but I can prepare a sample serie=
s
(including a sample 'git log' output) if you'd like. Just let me know where
you'd like it sent.

Cheers,
Stephen


>=20
> 1. https://keithp.com/blog/Repository_Formats_Matter/
>=20

