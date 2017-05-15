Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5354201A7
	for <e@80x24.org>; Mon, 15 May 2017 15:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966151AbdEOPXy (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 11:23:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:59636 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965928AbdEOPXw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 11:23:52 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfSeH-1dlJhg2qCH-00p3AT; Mon, 15
 May 2017 17:23:45 +0200
Date:   Mon, 15 May 2017 17:23:44 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/2] Demonstrate and partially work around a gitattributes
 problem
Message-ID: <cover.1494861793.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aZcRm4L4UJiw413kmmjUQgTTVQciWGCMu+9+S7mXUn3eRFCSfrO
 UwpESZT3JTOm+mAJ7VC+jPhPF7fabGd2mVAyijQvGAS8pN8A+YD4IaesM9TaPP9scEvSAWS
 bn9K6D23gECGlHy88GBf9ih0NtHYxBMxH7kzdRCIBj/DLZy8WiA8/CipYESsXHY3981kirC
 +5/AxwjK1fc4htawmBvfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tCYS9vmUaLs=:UZhVXmxFaCIILJI7/UlHCR
 fUlAWuxs4EBWpNiml/jgrKsdBJqhtdHIIUP+IMV0pM7kroP6hj8fRDsJfBh7prjS9acRaCj8H
 7NRvpnY8cTAB/u5Ap/OvQyH50lNxZ7U+MiEw95c1FeRw9JDXzZ29qF7IUodXxbkaTw1dAid/R
 ENy2CY1l05XlZFZU7yzBoxaXJW8ljgKY/lX1DlXm8LlRze0hJm6i896qeYpT4XJN1dgUNJryl
 na2hKC+5am0h/n+T6s4iDlWPiJpKx9MFi1fOcLh3Zxw/6P0PVF0f/5XAZH/z+GrVrANAoCJGP
 UHUnu9hpTmSu0wHbo2+CKWX/k3MsQQRNKMkZlPkR5qqhx713jnxu8s5R3TgSI790ZxZaWJPSh
 zTnTgWD5C8NrU6p31+Ah9GdPKUqd5w0qrLxcwPvlFBVIWSIATAQMmbg8N7utgVAMm6hiZHSYU
 uJHE9JJxriFLBwy2IWtAMh6E3b/vd1PD6UW409Ua64gTcLZSs47P/5vQo4f94o3wPti6XzPGh
 5GyMoAIzeEvOSKx1nhd+4qnLuvcGd2C3s2CyDQm4Qtem8ZcktPZQGp1JWvysqhHmnoQJlI6sR
 xW5L7XiYvJY9hgBqrfX0z6rV5hxDswjhehduWwzM0Vbk3KicDSzlkusWD5lvwDk4f4abvDMt1
 00/bbdUTdCQ0VkCzxj1Ch0vO6JcRH3uh3syMs1/I2JRImL9N7c4ubVmy8WYHxt4eftJnurby+
 T29pzauqvYcKXP6a9eWJpaaEsm8zcvetz3cN5ijl26Psvk0zAg9rKutpKS9F58w6mfDN77pa/
 X7puSuQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Granted, it is a bit of a less common use case to call

	git diff <commit1>:<file1> <commit2>:<file2>

There are valid scenarios for such calls, of course.

And sometimes, one may want to compare even files that are stored in
subdirectories instead of the top-level directory. Example:

	git diff cafebabe:t/README bee7e55:t/README

Now, the surprising part is that Git tries to read a .gitattributes
files interpreting the *entire* prefix `cafebabe:t/` as a *directory
path*. I.e. it will try to read the *file* (not the blob)
`cafebabe:t/.gitattributes`.

A remarkable side effect prevents this from happening for files in the
top-level directory: there is no slash in the argument, therefore the
top-level .gitattributes (which have been read from the index/worktree
already) is used.

Unless, of course, one specifies the commit via a ref whose name
contains slashes.

As mentioned in the commit message of the patch demonstrating the
problem, I fear that this issue is *really* hard to fix. Certainly too
complicated for me alone.

Side note: I was really, really surprised, in a very positive way, that
Git handled the scenario gracefully where I *created* files with the
actual file paths <commit1>:<file1> and <commit2>:<file2>, i.e. where
`git diff <commit1>:<file1> <commit2>:<file2>` is ambiguous because it
could refer to two objects or to two files. In this case, Git warns
about the ambiguity (it is *slightly* misleading that it says to
separate *revisions* using `--`, as we do not want to compare
revisions... but it is definitely better than picking one side of the
ambiguity and running with it).

Git for Windows carries the second patch for ages already, and I would
have contributed it much earlier if I had not been busy with other
patches. The reason I submit it now is that it conflicts with Duy's
fopen_or_warn() patch series.


Johannes Schindelin (2):
  gitattributes: demonstrate that Git tries to read a bogus file
  mingw: Suppress warning that <commit>:.gitattributes does not exist

 attr.c                |  2 +-
 t/t0003-attributes.sh | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)


base-commit: b06d3643105c8758ed019125a4399cb7efdcce2c
Published-As: https://github.com/dscho/git/releases/tag/no-commit-colon-gitattributes-v1
Fetch-It-Via: git fetch https://github.com/dscho/git no-commit-colon-gitattributes-v1
-- 
2.13.0.windows.1

