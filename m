Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6B1C433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 21:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiFFVhh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 17:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiFFVhf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 17:37:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B4F25E9B
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 14:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654551447;
        bh=v19MmZ1n0Au1+z/axJ/IylLeyGIXHkSNwBxNNsDCyK4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Wd+S1474ODOg56O8e/AGsTGEx4aFT/2Ze3aIt2ov0neznsMR7no/8BF/xqIBwZl7R
         31trO+PXaB4wWLLkwTIRYQ2LFVN6tFkVaLfFNyGUdMv79rhMMKl/f2VgRqaN4DKdTJ
         3BO4Qv9sqIn5Fu1KSDdvqIhzv51D1ficloPO93GY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([213.196.213.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6UZv-1nrzgd3fR3-006wwD; Mon, 06
 Jun 2022 23:37:26 +0200
Date:   Mon, 6 Jun 2022 23:37:25 +0200 (CEST)
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
In-Reply-To: <nycvar.QRO.7.76.6.2206060019510.349@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2206062325020.349@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet> <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com> <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet>
 <CABPp-BFG_05RyVVyiHzOkuoT8=9NftJGp_W+DXd7ktqC5UfvwQ@mail.gmail.com> <nycvar.QRO.7.76.6.2202251726500.11118@tvgsbejvaqbjf.bet> <CABPp-BGnqXdFBNAyKRXgvCHv+aUZTMg-CgcQf95dKAR-e1zSjQ@mail.gmail.com> <nycvar.QRO.7.76.6.2203071718090.11118@tvgsbejvaqbjf.bet>
 <CABPp-BGW39_5r8Lbt3ymR+F_=hWJcf=2e7O75vFNJ=3CEL5s=g@mail.gmail.com> <nycvar.QRO.7.76.6.2203101546110.357@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2205131220200.352@tvgsbejvaqbjf.bet> <CABPp-BHQPrun3xhXBhbBnZ9cAy1sV7_r-kGsQhC-YsRMvoERmw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2206032359210.349@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2206051733040.349@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2206060019510.349@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1449981176-1654551447=:349"
X-Provags-ID: V03:K1:fYH/ifhOEpQdwK5Qoom4j5wNirgBUiNRW1Zk3ue+t6zFlM9r0s0
 UkxE9tK9hEFqohxClkwWtjbeHK3D8NDnm7g6S8jRyreU8CbmDa7AG+XJQg465oAi82ag6UT
 8wTdvYEquSRm1cuq7xW/HGo/n+kj9zTdxnpAYxN7v7SPPGI8Ht8yuK96JhCHfudzW7Ux+qc
 5yS/91KgyAvR36t5/Y6TA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MmquuUnG77M=:jDcR7sWxgOiYhBxJ8M0aIp
 eTKyxVdHyfkR/TOcWThWDdgYfZCyDzukV9nLh5SmKQqQ0xZYg1Q2q2EAI4buYA5n7fbbFYusE
 A3MNw733PRZIlABC5wywtiIS0Ljz8C5ewsfnbauGMws0PPKzmCRYeEI7tf5W5vYdoPW/3qT4Y
 h1aOCSv/QnX9M2DkAZO7MNEeYPy9IZJkddWi0qnmxP0ssSK1yQYAPfC5t/BOdD+DGyf2nE7b/
 lWsiLXfun3eVhNB7DrLazjugABSxMMiBtwIt1+SYt63QlTKbjt1EP9r4aAQTTR/UXlgbtI/vk
 e/l2qCcPQGh8z/C2eNuYZNJ5y5obbI+XBgZLz8d5NEymPexbXF3pUuvz95YQz2MmHs6rDXl24
 fU6a8aO3DHZvBU/8CSB7eMmLCzuEzJhdA5x4XOqheTnjCdcEFtmzwKzcXDXuInsmpxsaLFr/x
 oUi+bYRKRqlhAjZmhm0EE/xM/ot6Myb0p2MreVXXHYUgALAYv9K3RMnf5T5rknqdVmEAW4ATM
 9PWMo9LgoV0LN3bcRHag/QqO8hmlCOqIlH4+Y9Mgrxg8N3qIe/pG3TzOIx6hgDsNzhATI6Bcl
 VYzhbr+rzHEcCZ0DiXAVjyNGpxsQ3Z6j0+Q9/ssdqWLTys6wkmDifpeaumORhSO6jN7lJKc4I
 wZSMjCSgPK0melIAfl04f6lcMWNVMdQIJtEh8R0e0ItJGpViaMA3qxFU+eQEz9hWHLwMgdA70
 bubnqtpEBTdeN5sFi/7WDc/LqocIdH5wVLgeo1iykgW2OrwKpBQxSQW/8T99IisSS+yHn/a5P
 5aNHtvEBJ3SwH+4gVv15rEIt/oIRUWtRN7pKr4BAUaakMFj8yXebs/VMnRJlSGsX8ZUh08/64
 Ycltqn2cKBSJPH07KzWQbmOgUpOlscZKmIUuituKYKAMgBNJOgYWLYEoHpR+Ces5vvEWGu5RV
 EWv1JiiHmXqV802oMLEmQdLHZY7qHxFLDy/zc9miQkPa25ZWFtnAUN+w7oPp2fkM9MZcO+G/j
 sDjqXl7GvoUEP5cxfxqn72wJRJ8N6P31Oc0e0rYwLB9xlV7liCTJC9EhCy3WlQ5trrVbMM22x
 KFTg2wJ3LKMjo14YacFc9U7TWN2SX6/Qfy0kKMzUWOGo0XLPmTY4joalNt8XXWY7ZRnF9mjme
 G+qeg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1449981176-1654551447=:349
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Elijah,

[after this update, I will shut up until you chime in, promise!]

On Mon, 6 Jun 2022, Johannes Schindelin wrote:

> On Sun, 5 Jun 2022, Johannes Schindelin wrote:
>
> > On Sat, 4 Jun 2022, Johannes Schindelin wrote:
> >
> > > It would be great if you could have a quick look over the commits I
> > > added on top of your branch, to see whether things make more or less
> > > sense to you. But if you're too busy elsewhere, I am one of the best
> > > persons to understand that, too.
> >
> > Hopefully I will get this into a reviewable shape before you get to
> > looking at it, so that your time is spent more wisely than what I
> > asked for ;-)
>
> I hope to find some time to work on this more tomorrow; If not, I will
> get back to the project on Wednesday and push it further.

I did get a chance, and polished the patch series a bit. I also rebased it
onto the current tip of Git's main branch, mainly to address some merge
conflicts preemptively. The result is pushed up to
https://github.com/dscho/git/tree/js/in-core-merge-tree. This is the
range-diff relative to `newren/wip-for-in-core-merge-tree`:

=2D- snip --
 1:  cccb3888070 <  -:  ----------- tmp-objdir: new API for creating tempo=
rary writable databases
 2:  4e44121c2d7 <  -:  ----------- tmp-objdir: disable ref updates when r=
eplacing the primary odb
 3:  0b94724311d <  -:  ----------- show, log: provide a --remerge-diff ca=
pability
 4:  f06de6c1b2f <  -:  ----------- log: clean unneeded objects during `lo=
g --remerge-diff`
 5:  8d6c3d48f0e <  -:  ----------- ll-merge: make callers responsible for=
 showing warnings
 6:  de8e8f88fa4 <  -:  ----------- merge-ort: capture and print ll-merge =
warnings in our preferred fashion
 7:  6b535a4d55a <  -:  ----------- merge-ort: mark a few more conflict me=
ssages as omittable
 8:  e2441608c63 <  -:  ----------- merge-ort: format messages slightly di=
fferent for use in headers
 9:  62734beb693 <  -:  ----------- diff: add ability to insert additional=
 headers for paths
10:  17eccf7e0d6 <  -:  ----------- show, log: include conflict/warning me=
ssages in --remerge-diff headers
11:  b3e7656cfc6 <  -:  ----------- merge-ort: mark conflict/warning messa=
ges from inner merges as omittable
12:  ea5df61cf35 <  -:  ----------- diff-merges: avoid history simplificat=
ions when diffing merges
13:  4a7cd5542bb =3D  1:  8fb51817ed4 merge-tree: rename merge_trees() to =
trivial_merge_trees()
14:  4780ff6784d =3D  2:  8e0a79fa1ad merge-tree: move logic for existing =
merge into new function
15:  60253745f5c =3D  3:  baf0950bcb6 merge-tree: add option parsing and i=
nitial shell for real merge function
16:  f8266d39c1b =3D  4:  697470e50ae merge-tree: implement real merges
17:  6629af14919 =3D  5:  069af1ecc30 merge-ort: split out a separate disp=
lay_update_messages() function
18:  17b57efb714 =3D  6:  53c92a5d8d9 merge-tree: support including merge =
messages in output
19:  4c8f42372dd =3D  7:  67a728d35f0 merge-ort: provide a merge_get_confl=
icted_files() helper function
25:  8fe5be07cd0 !  8:  6419487e26b merge-ort: remove command-line-centric=
 submodule message from merge-ort
    @@ merge-ort.c: static int merge_submodule(struct merge_options *opt,
      		strbuf_release(&sb);
      		break;
      	default:
    +
    + ## t/t6437-submodule-merge.sh ##
    +@@ t/t6437-submodule-merge.sh: test_expect_success 'merging should co=
nflict for non fast-forward' '
    + 	(cd merge-search &&
    + 	 git checkout -b test-nonforward b &&
    + 	 (cd sub &&
    +-	  git rev-parse sub-d > ../expect) &&
    ++	  git rev-parse --short sub-d > ../expect) &&
    + 	  if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
    + 	  then
    + 		test_must_fail git merge c >actual
20:  7b1ee417f3d !  9:  c92b81e7366 merge-tree: provide a list of which fi=
les have conflicts
    @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_optio=
ns *o,
     +		string_list_clear(&conflicted_files, 1);
     +	}
      	if (o->show_messages) {
    - 		printf("\n");
    +-		printf("\n");
    ++		putchar(line_termination);
      		merge_display_update_messages(&opt, &result);
    + 	}
    + 	merge_finalize(&opt, &result);
     @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **ar=
gv, const char *prefix)

      	/* Do the relevant type of merge */
21:  f1231a8fbc8 =3D 10:  d7360f58f16 merge-tree: provide easy access to `=
ls-files -u` style info
 -:  ----------- > 11:  b53ef9c2116 merge-ort: store messages in a list, n=
ot in a single strbuf
 -:  ----------- > 12:  b16d570d248 merge-ort: make `path_messages` a strm=
ap to a string_list
 -:  ----------- > 13:  b575a6b5f8a merge-ort: store more specific conflic=
t information
 -:  ----------- > 14:  4f245cc28ae merge-ort: optionally produce machine-=
readable output
22:  22297e6ce75 ! 15:  6a369f837be merge-tree: allow `ls-files -u` style =
info to be NUL terminated
    @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_optio=
ns *o,
      	if (!result.clean) {
      		struct string_list conflicted_files =3D STRING_LIST_INIT_NODUP;
      		const char *last =3D NULL;
    -@@ builtin/merge-tree.c: static int real_merge(struct merge_tree_opti=
ons *o,
    - 		string_list_clear(&conflicted_files, 1);
    - 	}
    - 	if (o->show_messages) {
    --		printf("\n");
    -+		putchar(line_termination);
    - 		merge_display_update_messages(&opt, &result);
    - 	}
    - 	merge_finalize(&opt, &result);
     @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **ar=
gv, const char *prefix)
      			    N_("do a trivial merge only"), MODE_TRIVIAL),
      		OPT_BOOL(0, "messages", &o.show_messages,
    @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Check confli=
cted oids and
     +
     +	test_expect_code 1 git merge-tree --write-tree -z tweak1 side2 >out=
 &&
     +	anonymize_hash out >actual &&
    ++	printf "\\n" >>actual &&
     +
     +	# Expected results:
     +	#   "greeting" should merge with conflicts
    @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Check confli=
cted oids and
     +
     +	EOF
     +
    -+	cat <<-EOF >>expect &&
    -+	Auto-merging greeting
    -+	CONFLICT (content): Merge conflict in greeting
    -+	CONFLICT (file/directory): directory in the way of whatever from tw=
eak1; moving it to whatever~tweak1 instead.
    -+	CONFLICT (modify/delete): whatever~tweak1 deleted in side2 and modi=
fied in tweak1.  Version tweak1 of whatever~tweak1 left in tree.
    -+	Auto-merging =CE=91=CF=85=CF=84=CE=AC =CE=BC=CE=BF=CF=85 =CF=86=CE=
=B1=CE=AF=CE=BD=CE=BF=CE=BD=CF=84=CE=B1=CE=B9 =CE=BA=CE=B9=CE=BD=CE=AD=CE=
=B6=CE=B9=CE=BA=CE=B1
    -+	CONFLICT (content): Merge conflict in =CE=91=CF=85=CF=84=CE=AC =CE=
=BC=CE=BF=CF=85 =CF=86=CE=B1=CE=AF=CE=BD=CE=BF=CE=BD=CF=84=CE=B1=CE=B9 =CE=
=BA=CE=B9=CE=BD=CE=AD=CE=B6=CE=B9=CE=BA=CE=B1
    ++	q_to_nul <<-EOF >>expect &&
    ++	1QgreetingQAuto-mergingQAuto-merging greeting
    ++	Q1QgreetingQCONFLICT (contents)QCONFLICT (content): Merge conflict =
in greeting
    ++	Q2Qwhatever~tweak1QwhateverQCONFLICT (file/directory)QCONFLICT (fil=
e/directory): directory in the way of whatever from tweak1; moving it to w=
hatever~tweak1 instead.
    ++	Q1Qwhatever~tweak1QCONFLICT (modify/delete)QCONFLICT (modify/delete=
): whatever~tweak1 deleted in side2 and modified in tweak1.  Version tweak=
1 of whatever~tweak1 left in tree.
    ++	Q1Q=CE=91=CF=85=CF=84=CE=AC =CE=BC=CE=BF=CF=85 =CF=86=CE=B1=CE=AF=
=CE=BD=CE=BF=CE=BD=CF=84=CE=B1=CE=B9 =CE=BA=CE=B9=CE=BD=CE=AD=CE=B6=CE=B9=
=CE=BA=CE=B1QAuto-mergingQAuto-merging =CE=91=CF=85=CF=84=CE=AC =CE=BC=CE=
=BF=CF=85 =CF=86=CE=B1=CE=AF=CE=BD=CE=BF=CE=BD=CF=84=CE=B1=CE=B9 =CE=BA=CE=
=B9=CE=BD=CE=AD=CE=B6=CE=B9=CE=BA=CE=B1
    ++	Q1Q=CE=91=CF=85=CF=84=CE=AC =CE=BC=CE=BF=CF=85 =CF=86=CE=B1=CE=AF=
=CE=BD=CE=BF=CE=BD=CF=84=CE=B1=CE=B9 =CE=BA=CE=B9=CE=BD=CE=AD=CE=B6=CE=B9=
=CE=BA=CE=B1QCONFLICT (contents)QCONFLICT (content): Merge conflict in =CE=
=91=CF=85=CF=84=CE=AC =CE=BC=CE=BF=CF=85 =CF=86=CE=B1=CE=AF=CE=BD=CE=BF=CE=
=BD=CF=84=CE=B1=CE=B9 =CE=BA=CE=B9=CE=BD=CE=AD=CE=B6=CE=B9=CE=BA=CE=B1
    ++	Q
     +	EOF
     +
     +	test_cmp expect actual
23:  db73c6dd823 =3D 16:  47146dd59dd merge-tree: add a --allow-unrelated-=
histories flag
24:  d58a7c7a9f6 ! 17:  3ce28f6fd97 git-merge-tree.txt: add a section on p=
otentional usage mistakes
    @@ Documentation/git-merge-tree.txt: with linkgit:git-merge[1]:
     +<<IM,Informational messages>> section has the necessary info, though=
 it
     +is not designed to be machine parseable.
     +
    ++Do NOT assume that each paths from <<CFI,Conflicted file info>>, and
    ++the logical conflicts in the <<IM,Informational messages>> have a
    ++one-to-one mapping, nor that there is a one-to-many mapping, nor a
    ++many-to-one mapping.  Many-to-many mappings exist, meaning that each
    ++path can have many logical conflict types in a single merge, and eac=
h
    ++logical conflict type can affect many paths.
    ++
     +Do NOT assume all filenames listed in the <<IM,Informational message=
s>>
     +section had conflicts.  Messages can be included for files that have=
 no
     +conflicts, such as "Auto-merging <file>".
26:  78e1243eca1 <  -:  ----------- WIP
=2D- snap --

I am pretty happy with the current state of the patches, and hope that we
can push this patch series over the finish line.

If you can think of anything I can do to help with this, please do let me
know, I am _very_ interested in getting this done, and finally am in a
position to help.

Ciao,
Dscho

--8323328-1449981176-1654551447=:349--
