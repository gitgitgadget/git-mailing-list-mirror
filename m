Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C2BC43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 21:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiFRV6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 17:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFRV6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 17:58:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1401A18A
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 14:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655589487;
        bh=j1DogbP3KzBDjXAFmY0fAO7TBBkVvfiM4wJxKKE/w0g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EnFtyjZywbffE2OntIrxCGWrdsADm0gJA2embdwTDyYlETe1w3G5S/izsGpvO5mSN
         vdOTXunlUeWqGDRijJrjGVksOTscZbRfLLYUTnHYUuvRAAKWldjOu+51lK9j2t2Ofr
         hgyR22ghVuarY3vGXrcNynTY5y68jifYWvLewifw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.60.234] ([89.1.215.185]) by mail.gmx.net (mrgmx104
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfHEJ-1nVYYu0kix-00gmGd; Sat, 18
 Jun 2022 23:58:07 +0200
Date:   Sat, 18 Jun 2022 23:58:02 +0200 (CEST)
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
In-Reply-To: <CABPp-BFfRGQybYManC6LfFTaAd3mweBxL=APCGP_vRF-WQxGSw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2206182357180.349@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <CABPp-BFG_05RyVVyiHzOkuoT8=9NftJGp_W+DXd7ktqC5UfvwQ@mail.gmail.com> <nycvar.QRO.7.76.6.2202251726500.11118@tvgsbejvaqbjf.bet> <CABPp-BGnqXdFBNAyKRXgvCHv+aUZTMg-CgcQf95dKAR-e1zSjQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2203071718090.11118@tvgsbejvaqbjf.bet> <CABPp-BGW39_5r8Lbt3ymR+F_=hWJcf=2e7O75vFNJ=3CEL5s=g@mail.gmail.com> <nycvar.QRO.7.76.6.2203101546110.357@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2205131220200.352@tvgsbejvaqbjf.bet>
 <CABPp-BHQPrun3xhXBhbBnZ9cAy1sV7_r-kGsQhC-YsRMvoERmw@mail.gmail.com> <nycvar.QRO.7.76.6.2206032359210.349@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2206051733040.349@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2206060019510.349@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2206062325020.349@tvgsbejvaqbjf.bet> <CABPp-BF3JwBGugN25RKxwTUQ6BDZL6OUwgLPVZQdj3d1mFdBgQ@mail.gmail.com> <CABPp-BFfRGQybYManC6LfFTaAd3mweBxL=APCGP_vRF-WQxGSw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1035979352-1655589486=:349"
X-Provags-ID: V03:K1:9OykerEisNeKDB+VlScuNvFT2Za9Znfeow0Okq0jd2eM9UoWGAe
 6pUUxeNq1OL/sg7pEZcDELOYDqa8kOsmLbX7oGjQCYgF8wBrvCjAhgHd+MDLQ4eoHVY+/tP
 0ZXwmDCG+e/z2S21wXlYPt7dqKdsKBaMfkv7Afr84BrL1+z11i0dBG3chBbLD151UAa+L1L
 4sMQEA8aCQDdyZQ98zfeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q700Y8E3Xkk=:N6XBS8lI5pkzoNxTYm/d6h
 xhya4EcEk//COJfCwjU9xdiS0yfMLPtCJXGiRGatzjkjg2rhU3AFL21e2TsRUkquQzvW9mVQr
 P/rVgiq4Srx4aPXEmz66/SuEtO5bp++nJJtJYHKe5c343Qk348kVFjyEChp/A7jIytbX0mHs7
 ujhjWhPlaMoR7+Jy5usa8n330yrqI12i1m8r/pFuaHdAcrNT4ypwdlJWhRdl/88/fvgt9ko8x
 zA3GB/+63ROIeQzkY0kMS0psEdvTAt2aUi0vsu/Nq1qHck2Z0tlshcTizpjMxrUcsRLO17K1E
 wW4ltnHqUI4Z7lrB/vlBngPkipch2i5ph9Wmx7POBRF4J8tzTvIz22HHrrlCx2hgvx97znYVX
 0xme17GOND99lP52GnGCWmGPoPWaofNYCzc4lj3wEd2PA7LTChhkfEZwS9vujg2vVVl8sqEp9
 A7NuTyn1rQt71C/Zny5xbF9uNA0qbpLZj2/ZZA6H1qSLz4QeiDr9dePSF7fHMF8tAqDnIHLNi
 JvHn4W1/cnZ0AX6JJKiuh2U6HZ6NRosjPSlzetWh9Wjj7nbrr8n03szjvLteujFpgT7x8jbqF
 RpC/XzOuFONkzMmvxk83JBLMFSYIBFjxgaPypApCzW9MNPAA8S0btWXgHSYYZCCMh8kmHbGQE
 lgeO1BNEVQ+WsqL5WdqWageFtuI1oCD30yAWUXZS7eqB24qVW54fcEXGmSJy7ZuYV26CBoueH
 f0aeWpdKcbWEu/QjbaINzFCeP7p3ku/ZN3tvkUPylVVfM7uKrS/5Sdg2xDKCtNgCuUF86CkmK
 lJhGH9M2wFCSJ3/IZsXb4ffMWfyPtbwWTCK9NUorx0ojIjAZ+EXOJ162kW2nYCFP6IJyp6RkL
 EPUwi5B3G3lsAmmNAGyAQ0wIYdETJGlYi2VfyYksEMx9YtgzuhRxL8OIK3t4D/IE+yu+atNYu
 5de15KjBQ/SlE3DbGhdiIDfsGNrPJG65AdcVoOj13tH4AgwsW0oZ0KzhuFQj4Y4t/QfFStIwC
 NBSzxehLUdg6qRNfdMgP72t7aRJjsnMB7dfmxHFy5z23yYA9VAJQWricZbJGsYbU4aGl8oFiN
 fc134M4GUXrKXZPLvLiY23LdMUcXpGoXcPqr7sF8+pLGvR9RMuyNVe0ow==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1035979352-1655589486=:349
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Elijah,

On Fri, 17 Jun 2022, Elijah Newren wrote:

> On Tue, Jun 7, 2022 at 12:38 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Mon, Jun 6, 2022 at 2:37 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > [after this update, I will shut up until you chime in, promise!]
> > >
> > > On Mon, 6 Jun 2022, Johannes Schindelin wrote:
> > >
> > > > On Sun, 5 Jun 2022, Johannes Schindelin wrote:
> > > >
> > > > > On Sat, 4 Jun 2022, Johannes Schindelin wrote:
> > > > >
> > > > > > It would be great if you could have a quick look over the comm=
its I
> > > > > > added on top of your branch, to see whether things make more o=
r less
> > > > > > sense to you. But if you're too busy elsewhere, I am one of th=
e best
> > > > > > persons to understand that, too.
> > > > >
> > > > > Hopefully I will get this into a reviewable shape before you get=
 to
> > > > > looking at it, so that your time is spent more wisely than what =
I
> > > > > asked for ;-)
> > > >
> > > > I hope to find some time to work on this more tomorrow; If not, I =
will
> > > > get back to the project on Wednesday and push it further.
> > >
> > > I did get a chance, and polished the patch series a bit. I also reba=
sed it
> > > onto the current tip of Git's main branch, mainly to address some me=
rge
> > > conflicts preemptively. The result is pushed up to
> > > https://github.com/dscho/git/tree/js/in-core-merge-tree. This is the
> > > range-diff relative to `newren/wip-for-in-core-merge-tree`:
> >
> > This is so awesome; thanks for working on this.  Sorry I haven't had
> > time to review yet, but I'm hoping to be able to near the end of this
> > week.  I'm excited to see how it looks.  :-)
> >
> > > -- snip --
> > >  1:  cccb3888070 <  -:  ----------- tmp-objdir: new API for creating=
 temporary writable databases
> > >  2:  4e44121c2d7 <  -:  ----------- tmp-objdir: disable ref updates =
when replacing the primary odb
> > >  3:  0b94724311d <  -:  ----------- show, log: provide a --remerge-d=
iff capability
> > >  4:  f06de6c1b2f <  -:  ----------- log: clean unneeded objects duri=
ng `log --remerge-diff`
> > >  5:  8d6c3d48f0e <  -:  ----------- ll-merge: make callers responsib=
le for showing warnings
> > >  6:  de8e8f88fa4 <  -:  ----------- merge-ort: capture and print ll-=
merge warnings in our preferred fashion
> > >  7:  6b535a4d55a <  -:  ----------- merge-ort: mark a few more confl=
ict messages as omittable
> > >  8:  e2441608c63 <  -:  ----------- merge-ort: format messages sligh=
tly different for use in headers
> > >  9:  62734beb693 <  -:  ----------- diff: add ability to insert addi=
tional headers for paths
> > > 10:  17eccf7e0d6 <  -:  ----------- show, log: include conflict/warn=
ing messages in --remerge-diff headers
> > > 11:  b3e7656cfc6 <  -:  ----------- merge-ort: mark conflict/warning=
 messages from inner merges as omittable
> > > 12:  ea5df61cf35 <  -:  ----------- diff-merges: avoid history simpl=
ifications when diffing merges
> > > 13:  4a7cd5542bb =3D  1:  8fb51817ed4 merge-tree: rename merge_trees=
() to trivial_merge_trees()
> > > 14:  4780ff6784d =3D  2:  8e0a79fa1ad merge-tree: move logic for exi=
sting merge into new function
> > > 15:  60253745f5c =3D  3:  baf0950bcb6 merge-tree: add option parsing=
 and initial shell for real merge function
> > > 16:  f8266d39c1b =3D  4:  697470e50ae merge-tree: implement real mer=
ges
> > > 17:  6629af14919 =3D  5:  069af1ecc30 merge-ort: split out a separat=
e display_update_messages() function
> > > 18:  17b57efb714 =3D  6:  53c92a5d8d9 merge-tree: support including =
merge messages in output
> > > 19:  4c8f42372dd =3D  7:  67a728d35f0 merge-ort: provide a merge_get=
_conflicted_files() helper function
> > > 25:  8fe5be07cd0 !  8:  6419487e26b merge-ort: remove command-line-c=
entric submodule message from merge-ort
> > >     @@ merge-ort.c: static int merge_submodule(struct merge_options =
*opt,
> > >                 strbuf_release(&sb);
> > >                 break;
> > >         default:
> > >     +
> > >     + ## t/t6437-submodule-merge.sh ##
> > >     +@@ t/t6437-submodule-merge.sh: test_expect_success 'merging sho=
uld conflict for non fast-forward' '
> > >     +   (cd merge-search &&
> > >     +    git checkout -b test-nonforward b &&
> > >     +    (cd sub &&
> > >     +-    git rev-parse sub-d > ../expect) &&
> > >     ++    git rev-parse --short sub-d > ../expect) &&
> > >     +     if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
> > >     +     then
> > >     +           test_must_fail git merge c >actual
> > > 20:  7b1ee417f3d !  9:  c92b81e7366 merge-tree: provide a list of wh=
ich files have conflicts
> > >     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree=
_options *o,
> > >      +          string_list_clear(&conflicted_files, 1);
> > >      +  }
> > >         if (o->show_messages) {
> > >     -           printf("\n");
> > >     +-          printf("\n");
> > >     ++          putchar(line_termination);
> > >                 merge_display_update_messages(&opt, &result);
> > >     +   }
> > >     +   merge_finalize(&opt, &result);
> > >      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const cha=
r **argv, const char *prefix)
> > >
> > >         /* Do the relevant type of merge */
> > > 21:  f1231a8fbc8 =3D 10:  d7360f58f16 merge-tree: provide easy acces=
s to `ls-files -u` style info
> > >  -:  ----------- > 11:  b53ef9c2116 merge-ort: store messages in a l=
ist, not in a single strbuf
> > >  -:  ----------- > 12:  b16d570d248 merge-ort: make `path_messages` =
a strmap to a string_list
> > >  -:  ----------- > 13:  b575a6b5f8a merge-ort: store more specific c=
onflict information
> > >  -:  ----------- > 14:  4f245cc28ae merge-ort: optionally produce ma=
chine-readable output
> > > 22:  22297e6ce75 ! 15:  6a369f837be merge-tree: allow `ls-files -u` =
style info to be NUL terminated
> > >     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree=
_options *o,
> > >         if (!result.clean) {
> > >                 struct string_list conflicted_files =3D STRING_LIST_=
INIT_NODUP;
> > >                 const char *last =3D NULL;
> > >     -@@ builtin/merge-tree.c: static int real_merge(struct merge_tre=
e_options *o,
> > >     -           string_list_clear(&conflicted_files, 1);
> > >     -   }
> > >     -   if (o->show_messages) {
> > >     --          printf("\n");
> > >     -+          putchar(line_termination);
> > >     -           merge_display_update_messages(&opt, &result);
> > >     -   }
> > >     -   merge_finalize(&opt, &result);
> > >      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const cha=
r **argv, const char *prefix)
> > >                             N_("do a trivial merge only"), MODE_TRIV=
IAL),
> > >                 OPT_BOOL(0, "messages", &o.show_messages,
> > >     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Check =
conflicted oids and
> > >      +
> > >      +  test_expect_code 1 git merge-tree --write-tree -z tweak1 sid=
e2 >out &&
> > >      +  anonymize_hash out >actual &&
> > >     ++  printf "\\n" >>actual &&
> > >      +
> > >      +  # Expected results:
> > >      +  #   "greeting" should merge with conflicts
> > >     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Check =
conflicted oids and
> > >      +
> > >      +  EOF
> > >      +
> > >     -+  cat <<-EOF >>expect &&
> > >     -+  Auto-merging greeting
> > >     -+  CONFLICT (content): Merge conflict in greeting
> > >     -+  CONFLICT (file/directory): directory in the way of whatever =
from tweak1; moving it to whatever~tweak1 instead.
> > >     -+  CONFLICT (modify/delete): whatever~tweak1 deleted in side2 a=
nd modified in tweak1.  Version tweak1 of whatever~tweak1 left in tree.
> > >     -+  Auto-merging =CE=91=CF=85=CF=84=CE=AC =CE=BC=CE=BF=CF=85 =CF=
=86=CE=B1=CE=AF=CE=BD=CE=BF=CE=BD=CF=84=CE=B1=CE=B9 =CE=BA=CE=B9=CE=BD=CE=
=AD=CE=B6=CE=B9=CE=BA=CE=B1
> > >     -+  CONFLICT (content): Merge conflict in =CE=91=CF=85=CF=84=CE=
=AC =CE=BC=CE=BF=CF=85 =CF=86=CE=B1=CE=AF=CE=BD=CE=BF=CE=BD=CF=84=CE=B1=CE=
=B9 =CE=BA=CE=B9=CE=BD=CE=AD=CE=B6=CE=B9=CE=BA=CE=B1
> > >     ++  q_to_nul <<-EOF >>expect &&
> > >     ++  1QgreetingQAuto-mergingQAuto-merging greeting
> > >     ++  Q1QgreetingQCONFLICT (contents)QCONFLICT (content): Merge co=
nflict in greeting
> > >     ++  Q2Qwhatever~tweak1QwhateverQCONFLICT (file/directory)QCONFLI=
CT (file/directory): directory in the way of whatever from tweak1; moving =
it to whatever~tweak1 instead.
> > >     ++  Q1Qwhatever~tweak1QCONFLICT (modify/delete)QCONFLICT (modify=
/delete): whatever~tweak1 deleted in side2 and modified in tweak1.  Versio=
n tweak1 of whatever~tweak1 left in tree.
> > >     ++  Q1Q=CE=91=CF=85=CF=84=CE=AC =CE=BC=CE=BF=CF=85 =CF=86=CE=B1=
=CE=AF=CE=BD=CE=BF=CE=BD=CF=84=CE=B1=CE=B9 =CE=BA=CE=B9=CE=BD=CE=AD=CE=B6=
=CE=B9=CE=BA=CE=B1QAuto-mergingQAuto-merging =CE=91=CF=85=CF=84=CE=AC =CE=
=BC=CE=BF=CF=85 =CF=86=CE=B1=CE=AF=CE=BD=CE=BF=CE=BD=CF=84=CE=B1=CE=B9 =CE=
=BA=CE=B9=CE=BD=CE=AD=CE=B6=CE=B9=CE=BA=CE=B1
> > >     ++  Q1Q=CE=91=CF=85=CF=84=CE=AC =CE=BC=CE=BF=CF=85 =CF=86=CE=B1=
=CE=AF=CE=BD=CE=BF=CE=BD=CF=84=CE=B1=CE=B9 =CE=BA=CE=B9=CE=BD=CE=AD=CE=B6=
=CE=B9=CE=BA=CE=B1QCONFLICT (contents)QCONFLICT (content): Merge conflict =
in =CE=91=CF=85=CF=84=CE=AC =CE=BC=CE=BF=CF=85 =CF=86=CE=B1=CE=AF=CE=BD=CE=
=BF=CE=BD=CF=84=CE=B1=CE=B9 =CE=BA=CE=B9=CE=BD=CE=AD=CE=B6=CE=B9=CE=BA=CE=
=B1
> > >     ++  Q
> > >      +  EOF
> > >      +
> > >      +  test_cmp expect actual
> > > 23:  db73c6dd823 =3D 16:  47146dd59dd merge-tree: add a --allow-unre=
lated-histories flag
> > > 24:  d58a7c7a9f6 ! 17:  3ce28f6fd97 git-merge-tree.txt: add a sectio=
n on potentional usage mistakes
> > >     @@ Documentation/git-merge-tree.txt: with linkgit:git-merge[1]:
> > >      +<<IM,Informational messages>> section has the necessary info, =
though it
> > >      +is not designed to be machine parseable.
> > >      +
> > >     ++Do NOT assume that each paths from <<CFI,Conflicted file info>=
>, and
> > >     ++the logical conflicts in the <<IM,Informational messages>> hav=
e a
> > >     ++one-to-one mapping, nor that there is a one-to-many mapping, n=
or a
> > >     ++many-to-one mapping.  Many-to-many mappings exist, meaning tha=
t each
> > >     ++path can have many logical conflict types in a single merge, a=
nd each
> > >     ++logical conflict type can affect many paths.
> > >     ++
> > >      +Do NOT assume all filenames listed in the <<IM,Informational m=
essages>>
> > >      +section had conflicts.  Messages can be included for files tha=
t have no
> > >      +conflicts, such as "Auto-merging <file>".
> > > 26:  78e1243eca1 <  -:  ----------- WIP
> > > -- snap --
> > >
> > > I am pretty happy with the current state of the patches, and hope th=
at we
> > > can push this patch series over the finish line.
> > >
> > > If you can think of anything I can do to help with this, please do l=
et me
> > > know, I am _very_ interested in getting this done, and finally am in=
 a
> > > position to help.
> >
> > Very much appreciated.  Looks like you're now blocking on my review,
> > so I'll try to make some time by end of week to look over things.
>
> Sorry for the delay.  However, I have looked over the changes in
> detail.  Well done!  I very much like this version.  Thanks for taking
> the time to break up my WIP patches, fix my bugs, address all the
> FIXMEs, and then going and adding some nice cleanups and improvements
> on top!  I'll add my Signed-off-by on a couple patches and have
> gitgitgadget submit this round.

That's great news, thank you so much!

Ciao,
Dscho

--8323328-1035979352-1655589486=:349--
