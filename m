Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E89C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 11:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA482082E
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 11:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AMrdPS9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLQLSi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:18:38 -0500
Received: from mout.gmx.net ([212.227.17.20]:44687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfLQLSi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 06:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576581508;
        bh=3YBUdJ2yzcV3k5lHuutbnoRE4hT0QgkpY8SAXS6dkgk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AMrdPS9+RQourm+l+ZrA39852CCfwvQuO5sNQhnnkm+08hm+1yySPNu4ZyjvZ625k
         VCMDdynkLtTmUBua4bhiS6njuC4upqhAiIbf7/PXgVA3rYD1WKgFFj/6/pxzusdhsL
         dZeY5D4WpCYmmpoQ7L9+zudjbnKllMQCOrNJdyUM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N49hB-1hhkUn2kLZ-0106rS; Tue, 17
 Dec 2019 12:18:28 +0100
Date:   Tue, 17 Dec 2019 12:18:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, blees@dcon.de,
        Junio C Hamano <gitster@pobox.com>, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] Directory traversal bugs
In-Reply-To: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1912171217000.46@tvgsbejvaqbjf.bet>
References: <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com> <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bNTp6xyzXMFYiX2ewVaz+YN17r6TrVlzB0hvcXuK3Y1YzgueBli
 H98vPRIH6CfblV8o9sbHoZlYLF80GNq/87H3K/EsJrqf8cjdzqgag6ny3u6XUH7iX9Dq+4L
 Qfan+IYPKCEp39DMRN56Nm5Q9wBiyF9ooCFj1aPIVWhVSx3QdjDcKuTqsbZ8xvII5mMs1gE
 +X1XzHZygE+LLRFqMH1oQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GZYRJJyWrQo=:AxkqlxVeO4RmysJCTZKKFI
 yS3RKMNh96wc/uYXwA6z1MSasBPLZZv3XpdbkX2n5B9hl3QItMtaSmbKVUslIexHagEdcr3w8
 nx5+ABgWL4z6f6BiRD2Ayk3Bv44mMzBkFK7GX2B/AXBsFSEnrMmX8fO0YTB2vqrylMLZ9GDXr
 q6FX/BZI6xDj62vrhGbHGMLJf0BhtpkPoa+pUtonwxZVld8btJ1WG3P+9+pFiUKZttXVR/Shp
 OkcIIXNb0bjmpodW+ZNE989DFxYaa7oDZJoXaqZVODmSkknTpjwUnss0qVtbD7sqc1IsXjF4W
 JPQBDBFJtdVn3NPh9Y5XWwIZ8yNUHNFgq/zCHd2nR2ElUC0pprNkvzI38ByDnTHgyAsdOtO6m
 zsyRW5Zsg7AYUJfDO8TJxHiddz9C7s+MMhnzZgfQ6IsHID07fmKSLkXPsIQjihRvVXhQfU9sU
 irm++pfdafNcLnrSefxDytVOF+En9FVk4aPNT+RvzlaU4kyfkrnqsrdJwNAh9k3c8ro1FO5xW
 zVGvgpCC4nwXYtIl8NmmZUQ24N7q69jOuFe/M8a1PDs2UPzN5H5AtrDpZ8y2zDaK0QHo7VROB
 XB0dm1/J3EnI1LFgQ/RmSURbK1WRfOXzEQTxYOO0It+IZwSyfP1U7hl7esSaZw+wipDK5WY2O
 /MD9NNUqFrcGeVztSbTojhThOmZJQRKASwnQwdAxLb8ugrZRp0AjcPsToodiiF7IMl0T7y8VM
 uTQt9G5ym4kByyKcKIqGfzfJBwiV/GogBZpubjtMmB5wG4AGP8phLrP5sJDsGYNw5PcP1RrRK
 iK2ESDMlNRYKuV5AWW8kKc7TxtspyelF9drQg5MczJlezZHACm0XTNC8XwZyXKzjfiGqFPkET
 Aml4kryaUPbdHCmYD15Lpe116qQzkCRZxH2K/WyvhetyVU/npa0FLp2HzuByS+1+7joQiEx1G
 Kss9jktIh2qSnkJzPA2J25KoqPmg57pqbbqIi/AMnigcMVeTqjAePz8GMvApSfuJvaNqGhozz
 X/kSR0qsSBrNiYFmld3QQacWMh1OlhBC1+DGRO7JKo65gDOQv9ootu0bNkPON5Wg42/1f+g67
 1bt0fw/JaWFzTGRQNJkeiya0sEwYIb4+EMKxLv7m1nZrqbD66ntPUE40Wl54SREftlQFfis2W
 Ji4VVyJBfOQtRvlTa/YyeUmDxD1JB/QI37JmzDRzXIX8hemZnjuK/eFhsK99QHjNIHWgONzjU
 AinXgX3ORtQI3IZvrmAur+VEV8HFdbBIBZYQXxDnVRpg77jtFnWLokQJA5YY=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 17 Dec 2019, Elijah Newren via GitGitGadget wrote:

> This series documents multiple fill_directory() bugs, and fixes the one =
that
> is new to 2.24.0 coming from en/clean-nested-with-ignored-topic, the res=
t
> having been around in versions of git going back up to a decade.
>
> Changes since v2:
>
>  * gutted the series of most the fixes, dropping the patch count from 8 =
to
>    3, due to incompatibility with git-for-windows (which interestingly h=
as a
>    different compat/win32/dirent.h than git.git does). The only bugs
>    reported by a user are fixed by patch 3, and fixing the remaining bug=
s
>    (which I found while investigating the one fixed bug) would require a
>    major refactor that I don't have the time for currently.

I am really sorry that I caused you so much work.

As I said elsewhere, if Git for Windows' FSCache hack is the only thing
that is broken by this patch series, in light of the bugs that it _does_
fix I would rather adjust the FSCache patches to accommodate v2.

What do you think?

Ciao,
Dscho

> Elijah Newren (3):
>   t3011: demonstrate directory traversal failures
>   dir: remove stray quote character in comment
>   dir: exit before wildcard fall-through if there is no wildcard
>
>  dir.c                                         |   9 +-
>  ...common-prefixes-and-directory-traversal.sh | 209 ++++++++++++++++++
>  2 files changed, 217 insertions(+), 1 deletion(-)
>  create mode 100755 t/t3011-common-prefixes-and-directory-traversal.sh
>
>
> base-commit: da72936f544fec5a335e66432610e4cef4430991
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-67=
6%2Fnewren%2Fls-files-bug-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-676/n=
ewren/ls-files-bug-v3
> Pull-Request: https://github.com/git/git/pull/676
>
> Range-diff vs v2:
>
>  1:  6d659b2302 ! 1:  61d303d8bd t3011: demonstrate directory traversal =
failures
>      @@ -14,6 +14,18 @@
>           of the en/clean-nested-with-ignored-topic); the other 5 also f=
ailed
>           under git-2.23.0 and earlier.
>
>      +    The old failing tests can be traced down to the common prefix
>      +    optimization in dir.c handling paths differently than
>      +    read_directory_recursive() and treat_path() would, due to inco=
mplete
>      +    duplication of logic into treat_leading_path() and having that
>      +    function call treat_one_path() rather than treat_path().  Fixi=
ng
>      +    that problem would require restructuring treat_path() and its =
full
>      +    call hierarchy to stop taking a dirent; see
>      +       https://lore.kernel.org/git/xmqqzhfshsk2.fsf@gitster-ct.c.g=
ooglers.com/
>      +    and the thread surrounding it for details.
>      +
>      +    For now, simply document the breakages.
>      +
>           Signed-off-by: Elijah Newren <newren@gmail.com>
>
>        diff --git a/t/t3011-common-prefixes-and-directory-traversal.sh b=
/t/t3011-common-prefixes-and-directory-traversal.sh
>  2:  79f2b56174 < -:  ---------- Revert "dir.c: make 'git-status --ignor=
ed' work within leading directories"
>  3:  d6f858cab1 =3D 2:  49b0b628db dir: remove stray quote character in =
comment
>  4:  8d2d98eec3 =3D 3:  47814640e4 dir: exit before wildcard fall-throug=
h if there is no wildcard
>  5:  d2f5623bd7 < -:  ---------- dir: break part of read_directory_recur=
sive() out for reuse
>  6:  9839aca00a < -:  ---------- dir: fix checks on common prefix direct=
ory
>  7:  df7f08886a < -:  ---------- dir: synchronize treat_leading_path() a=
nd read_directory_recursive()
>  8:  77b57e44fd < -:  ---------- dir: consolidate similar code in treat_=
directory()
>
> --
> gitgitgadget
>
