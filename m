Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B001AC433E0
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 02:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84CFD208FE
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 02:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX2e3iuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgGNCmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 22:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGNCmM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 22:42:12 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40807C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 19:42:12 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id u12so11711448qth.12
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 19:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eq5Ew07heHM8eb0J4SWb4d5dy1uDLMP8tpekNBxk+t4=;
        b=ZX2e3iuKbeZw6XiTRvBZlvMmANrhAYtU1PuaG8VRCgLWLUI6q8apQkLLd2jpOQ+O3P
         TqbeUZ5vBqGgTlgt6YyhqMm+a0q5+T3q7FIAL/MJkTIgqR8lAKyrThQ02LDcBIpECGnC
         llTVn69n5OT9hPs1W/BE7dHdhsxSSae/QxyVgoglgNmYkEk64RCuHfMZgrAOq8vfGh++
         bnuklLdPpsX8vuEK/n4tTrj9hA7+2mLf3DaDcxDQXkpfDDzcPr6d4zd/0DzeBJIQDKy3
         N8EVzLaMAQ0VJpN25N2/kXMO+ssqDSMMZ1woLnzygHKc490UO8osX66guJIYQc/E4tA7
         hnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eq5Ew07heHM8eb0J4SWb4d5dy1uDLMP8tpekNBxk+t4=;
        b=S5UchqrYc0/gZQSfMR+yKy3bZbzDhCGN+l6WU7BtMXsFEwJT3bNLEqVbRS6y/CijEn
         u+5w7oAAMd19Acbg8XN9wR2+Rd976LW1+3z14jQvVR4SwrMmHmSjHgVINtRLHU02LWuq
         qqDiAcdfSidxMiNsVDRHQDwgDnV3a9Tbg+QdRathC3PRlD5A46VdzreQbQl3/oXIdgf4
         vf3j/YIo3x6ktp31zNCRxrgFQSSUrAr9EI7rkwQEgK1OrxZvtcfW7nlZmcpi/DOhrkru
         MtKn68JBHNE3bWxeFW5UMaj8WE458Hxmv67vh2fm+lvlq6aiy29RDOPr3mdo0ueZnowQ
         TcsA==
X-Gm-Message-State: AOAM533GC3ysObAzfOZUoPUdzgg/ogYEatU/+yzRFwgYxU7wuIq/m0a8
        H2TN4Lily7xyOufiv4HHyyrQ1SY+
X-Google-Smtp-Source: ABdhPJxHn9IJowhCo5jf/vG464Ev+joD37TlJ3vQsq3jC6Ss38cQ35p/+KC4lFAMfYTQs6NcvuI2dg==
X-Received: by 2002:ac8:3ff9:: with SMTP id v54mr2566002qtk.352.1594694531419;
        Mon, 13 Jul 2020 19:42:11 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id k194sm20688879qke.100.2020.07.13.19.42.10
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 13 Jul 2020 19:42:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: rebase - "fixup!" conflict applied at the wrong code location, why ?
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <CABPp-BEu=7xSLk5AE8sQX+S-vvYXxgn+avQ8+9ttdSKDjikb9w@mail.gmail.com>
Date:   Mon, 13 Jul 2020 22:42:07 -0400
Cc:     git <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D99E27A0-04BC-40B7-A073-66E1301FFE5D@gmail.com>
References: <7A30EA48-72E3-47E1-9792-136D7B96DC84@gmail.com> <CABPp-BEu=7xSLk5AE8sQX+S-vvYXxgn+avQ8+9ttdSKDjikb9w@mail.gmail.com>
To:     Elijah Newren <newren@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

> Le 9 juil. 2020 =C3=A0 00:07, Elijah Newren <newren@gmail.com> a =
=C3=A9crit :
>=20
> On Wed, Jul 8, 2020 at 5:07 PM Philippe Blain
> <levraiphilippeblain@gmail.com> wrote:
>>=20
>> Hello,
>>=20
>> I've been working on a branch for a while. I've been using `git =
commit --fixup`  and `git commit --squash`
>> when I noticed that I had forgotten to add something to a previous =
commit.
>> Today I did `git rebase --autosquash` to clean up my history, and the =
rebase failed at the
>> first 'fixup!' commit with a conflict. However, the conflict is not =
located at the right place
>> in the code (it's not in the right subroutine!). This is very =
surprising to me, and I would
>> like to understand why it happens.
>>=20
>> Steps to reproduce:
>>=20
>> git clone -b branch-to-be-rebased =
https://github.com/phil-blain/CICE.git cice
>> cd cice
>> git rebase -i --autosquash my-first-commit
>> # save the todo list without modifications
>>  Auto-merging <file>
>>  CONFLICT (content): Merge conflict in <file>
>>  error: could not apply e8bfa55... fixup! <commit message of f4e1ae6>
>> # the rebase stops at f4e1ae6
>> git diff
>> # tangential question : for some reason the hunk header does not =
appear here, I don't know why...
>> git diff -2  # but it appears here
>> git grep -p -e '<<<<<<< HEAD' -e '>>>>>>> e8bfa55...'  # or here
>> # ok, the conflict appears in subroutine 'picard_solver'
>> git show REBASE_HEAD -U5
>> # but the original "fixup!" commit only modifies the subroutine =
'anderson_solver' !!
>>=20
>> I would have expected that the conflict be created around lines =
1118-1132
>> (line numbers in f4e1ae6), in the 'anderson_solver' subroutine.
>>=20
>> I don't know if this plays a part here, but commit f4e1ae6 (where the =
rebase stops)
>> is the commit where the 'anderson_solver' subroutine is added to the =
code...
>>=20
>> Thanks,
>>=20
>> Philippe.
>=20
> If you take a look where the rebase stops, you see:

First, thanks a lot for your answer. I have a few questions.

>=20
> $ git ls-files -u
> 100644 ee4377f1ec6836fa05573976a473373906c37d9f 1
> cicecore/cicedynB/dynamics/ice_dyn_vp.F90
> 100644 30c699ac371c2a751052fa98d04317e84a96ec47 2
> cicecore/cicedynB/dynamics/ice_dyn_vp.F90
> 100644 276f224e9048fe0bbd7c25822695049547362c87 3
> cicecore/cicedynB/dynamics/ice_dyn_vp.F90
>=20
> The difference from the merge base to "other" (index 3) is pretty
> tiny, you just moved one line in the "anderson_solver" subroutine
> about 10 lines down. =20

Yes, the output from=20
$ git diff :1:cicecore/cicedynB/dynamics/ice_dyn_vp.F90 =
:3:cicecore/cicedynB/dynamics/ice_dyn_vp.F90

seems to be the same as the one from
$ git show REBASE_HEAD

This is a little confusing to me, in the sense that I don't understand =
why=20
the merge-base is what it is. At this point, I do

$ git merge-base HEAD REBASE_HEAD=20
f4e1ae67b7d6ca36c6f3ea7c9da43d81caf24067

Ok, so 'git merge-base' finds that the merge-base between HEAD and
REBASE_HEAD is HEAD; this makes sense to me (no previous commits
have been rewritten so far, so REBASE_HEAD is directly ahead of HEAD).
But, if I try to find the commit that contains
the blob ee4377f1ec6836fa05573976a473373906c37d9f (index 1), I find
REBASE_HEAD's parent:

$ git log --all --find-object=3Dee4377f1ec6836fa05573976a473373906c37d9f =
--format=3D'commmit %H%ntree %T%nparent %P%n%n    %s%n'
commmit e8bfa557d3c81b75116d6557784b0439b792a308
tree f6fecb8193c3b877f22bcb8f4d8d2c203e17f06f
parent 7a8d5a82984dfedd7fac1d7ed7c7fbd1781c1f61

    fixup! Add Anderson acceleration for Picard iteration

commmit 7a8d5a82984dfedd7fac1d7ed7c7fbd1781c1f61
tree 11fd096851015c0c16b793d9bbb5db039776483b
parent 63d4c73c1dd973f620307833bd363a1d5069d090

    ice_dyn_vp: introduce 'CICE_USE_LAPACK' preprocessor macro

$ blob=3Dee4377f1ec6836fa05573976a473373906c37d9f
$ parent=3D7a8d5a82984dfedd7fac1d7ed7c7fbd1781c1f61
$ git ls-tree -r $parent^{tree} | grep $blob
100644 blob ee4377f1ec6836fa05573976a473373906c37d9f	=
cicecore/cicedynB/dynamics/ice_dyn_vp.F90

I don't understand why at this point of the rebase, Git=20
determines that the merge-base between HEAD and=20
REBASE_HEAD is REBASE_HEAD's parent... this commit
is not even an ancestor of HEAD (or maybe I don't understand
what the "merge-base" is in this context?)...

> The more interesting difference is from the
> merge base to "ours" (index 2), seen with:
>=20
> $ git diff :1:cicecore/cicedynB/dynamics/ice_dyn_vp.F90
> :2:cicecore/cicedynB/dynamics/ice_dyn_vp.F90
>=20
> If you search for "anderson_solver" in that diff, you see that the
> reconstructed diff looks like "subroutine anderson_solver" is renamed
> to "subroutine picard_solver" with similar but slightly different
> arguments.  The diff routine successfully finds lots of lines common
> between these two subroutines so it seems quite logical as a way of
> representing the changes, especially since they occur near each other
> in the order of the file.  If you keep looking further in the diff, it
> says that a few hundred lines later there's another subroutine rename,
> this time from "subroutine calc_zeta_Pr" to "subroutine
> anderson_solver".  Looking at it this way, it's quite natural to apply
> the change from the rebased commit to the picard_solver since the
> other side of history "renamed" anderson_solver to picard_solver.
>=20
> This might not make as much sense to you, since you tend to think in
> terms of parse trees and "subroutines" are a high level unit.  But
> diffs work in terms of lines and have no knowledge of any kind of file
> structure or semantics.  If you have a string of functions A,B,C and
> insert a new function Z on one side of history somewhere in a file
> that happens to look a lot like existing functions (meaning several
> identical lines between the two), then diffs won't necessarily treat
> it as a contiguous block of inserted lines but instead compare
> function Z on one side to function B on the other, then function B on
> the first side to function C on the second, etc.
>=20
> There are alternative diff algorithms that try to minimize the number
> of changed lines shown by the diff, such as --histogram and
> --patience, and they do shrink this particular diff, but they both
> yield the same treatment of comparing "subroutine anderson_solver" to
> "subroutine picard_solver" essentially treating it as a rename.  To
> get a merge like you want, you'd need some kind of higher level
> semantic merge, or at least need functions to not have so many lines
> in common between them.

Thanks for these explanations. The behaviour makes sense.

>=20
> This kind of problem also causes big issues when reordering functions
> in a file.  line-by-line diffs and the diff3 merge algorithm tend to
> really struggle with those.  (See e.g.
> https://www.cis.upenn.edu/~bcpierce/papers/diff3-short.pdf if you want
> to read up more on these.)

Thanks for the pointer!=20

>=20
> Hope that helps,
> Elijah

Thanks,
Philippe.

