Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77099C35240
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 04:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456A022522
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 04:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="wQzgU2KX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgA1EDT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 23:03:19 -0500
Received: from st43p00im-ztfb10071701.me.com ([17.58.63.173]:43006 "EHLO
        st43p00im-ztfb10071701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726191AbgA1EDT (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Jan 2020 23:03:19 -0500
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jan 2020 23:03:17 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1580183810; bh=RyJelee/DT68jmWfx8iJXoSpzxQjZY2c9AxzUj2Ww/E=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=wQzgU2KXvbvv8563A0xCd4WR/atcna58hLK8SlMj3RAbzDfUss0zBLOK4NQ8aXLBN
         Ue2g2s+Qm1UV+XYkshSasK1u4dlherHh75R4aLnF4vM32S7NmOcqpWZkMKBK/y5eym
         eCCFg9NasX8TMCThjWnFbix9DRshdcO2M24dISbyWkwH1rv6F8cXbkT4yHAW+e4kYi
         enVr1zeVYKIeccS3dfIwxEeo7CD9uAvALw2HKNWs1MCzTjfFbzZK2UokZK0RbJzMP3
         hCimRpj4EdjVwurp/llo1mc6eN9SQ2SiQ22mfWpIfjuZczOiaqqVTpNjsy8omAi8rT
         9wjr5wgXjvXoA==
Received: from [192.168.1.127] (unknown [192.222.216.4])
        by st43p00im-ztfb10071701.me.com (Postfix) with ESMTPSA id 3ABDDAC0E3E;
        Tue, 28 Jan 2020 03:56:50 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Submodules & worktree
From:   Philippe Blain <philippe.blain@me.com>
In-Reply-To: <CAKQS2dqx9Nux11ot7a-Wxd2qpcdAAWw-e7Li+X3bw7TxJS=Kyw@mail.gmail.com>
Date:   Mon, 27 Jan 2020 22:56:48 -0500
Cc:     Git List <git@vger.kernel.org>, mateusz@loskot.net,
        Peter Kaestle <peter.kaestle@nokia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <746427B4-5B64-492F-A69E-908D6A1F5308@me.com>
References: <CAKQS2drF+CQTiKtXD6Kx1ZbH9ZTekWmbfiiHTCJV_BrT5-gAFQ@mail.gmail.com> <CAKQS2dqx9Nux11ot7a-Wxd2qpcdAAWw-e7Li+X3bw7TxJS=Kyw@mail.gmail.com>
To:     Ole Pinto <olepinto@gmail.com>
X-Mailer: Apple Mail (2.3124)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-27_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=726 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2001280030
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ole,

> Le 1 f=C3=A9vr. 2019 =C3=A0 09:00, Ole Pinto <olepinto@gmail.com> a =
=C3=A9crit :
>=20
> Adding a worktree from a working copy with submodules doesn't work.
>=20
> In the config file I have
>    [submodule]
>        recurse =3D true
>=20
> It that's not present, I don't find the problem.

I also stumbled upon this bug and fixed it in 4782cf2ab6 (worktree: =
teach "add" to ignore submodule.recurse config, 2019-10-27), which was =
merged in 05fc6471e3 (Merge branch =
'pb/no-recursive-reset-hard-in-worktree-add', 2019-12-01) and made it to =
Git 2.25.
`git worktree add` now works correctly in a project with submodules, and =
cd-ing to the new worktree directory and issuing `git submodule update` =
inits and clones the submodule(s) to =
.git/worktrees/<worktree-name>/modules/<submodule-name>, as it should.

I must warn you however that I discovered another bug that can happen =
with the submodule.recurse config when using worktrees with projects =
that have submodules. In short, issuing `git checkout` (or `git reset` =
or `git read-tree`) in one of the worktrees will leave the .git file in =
the submodule incorrectly pointing to the repository of the submodule in =
the main worktree, i.e. .git/modules/<submodule-name> instead of =
.git/worktrees/<worktree-name>/modules/<submodule-name>. I also fixed =
this bug [1], my patch series for this is currently in next.=20

[1] https://github.com/gitgitgadget/git/pull/523

> # Problem 2 (submodule status seems not to detect some cases)
>=20
> $ pwd
> /tmp/main_repo
>=20
> $ git submodule status
> ebc9325f7b19164c9bdfd05263481ded66d7bd7d submod (heads/master)
>=20
> $ rm submod/file.txt submod/.git
>=20
> $ git submodule status
> ebc9325f7b19164c9bdfd05263481ded66d7bd7d submod
>=20
> So, I have a plain, empty directory where the submodule should be. Not
> having any 'first char', I'd expect it to be checked out and up to
> date. Is this expected?
This is indeed not expected, and used to work correctly (the hash should =
be prefixed with a =E2=80=98-=E2=80=98) in Git 2.12. This bevaviour =
regressed when `git submodule status` was ported to C in a9f8a37584 =
(submodule: port submodule subcommand 'status' from shell to C, =
2017-10-06).
Another user reported this regression to the list recently and a patch =
series is in the works to fix it [2].

[2] =
https://lore.kernel.org/git/xmqqv9owbw5o.fsf@gitster-ct.c.googlers.com/

Cheers,
Philippe.

