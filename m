Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C61ECAAD5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 09:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiIBJDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 05:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbiIBJDx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 05:03:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5F0A2205
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 02:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662109425;
        bh=pbgk/jgwFxLQewsGsDEXKU3gvKINZILG+/X2vJii9ho=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=I5neSuqVsZZABFPeW4dHujRXaEfhrorI79HCIaGicT0+w0rV+EGY/zZmuCkEZW8z7
         kf50Q4wrG/dmZ1sJxfhnfs0yHJxtCqYjSujcHfvZnzPGrkR6djKa5nCgJRTFNPe20O
         iVHEPVJRdpyRYNyOcTyeyXbXjIyFvmEGi3eDoksE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgNh7-1p2IPO39ln-00hwXb; Fri, 02
 Sep 2022 11:03:45 +0200
Date:   Fri, 2 Sep 2022 11:03:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, shaoxuan.yuan02@gmail.com, gitster@pobox.com,
        derrickstolee@github.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] unpack-trees: fix sparse directory recursion check
In-Reply-To: <pull.1344.git.1662066153644.gitgitgadget@gmail.com>
Message-ID: <70537543-n1ns-657s-245n-p4n563q9rsrs@tzk.qr>
References: <pull.1344.git.1662066153644.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:T+gBwpOnIi9yNQQaqfuHTmjPUXDv43Tq/cLchRe1JKsKpZJU6Ja
 mhIeXstoCy6jC1wyYVNMpyfguQOyY+VqXAvfXS5ivxwSKPhARXewer9SqsEZs/gIds5nNpq
 c45f6Qutw5U6h7dI4ug36hBrLAeXM8CxyIwzIhJ/yvKMmMWxDmdMr4dq1Yk+SVPA76Ed2CO
 OsQd28WXqmKTZU7thqJ/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m6cuPCDwyoU=:AQDzRZ/a7OVJOP8XkK4nxS
 5hbOqK0VhRAMji4lnIzHWP4pVwW6DagLdk+2OzSSVIwKxAg7w4Z0oHveb67pfDCS3gimru9KX
 HxnJPuZC7VnojZ9w25FhoBeaPjry5In7ju6BYhxk9qTPNszR+F3yMjrlOFl+WEpvqCxBLbnt8
 Q+vusNeROStKsslaZjpPFR47RFeQbxhEVHRQXQqgmBgdOn1R+dQyaUuLfCx7LFt5rn5wUU3uh
 z31sN2qlC0nERNSN+b0K5Gxtgjel6DkiHaqqTm2dOph5oGvR+2szomDtsOUsvxk6BYXwrFGoU
 KS21YQXY7ImwWPHJpOYQQwLbaJLjNqhd7KhVex0XgJpzsE54oFY2mJweLO2GelrqR8v1TWTMq
 R5Fjt08oim/h3kkekaIZd6R+RSr8ft+4DblLAQbiW32iI5jY+IXDjHGtD3c/GoYgD4JnWQiRK
 jJnxVbbkers5dpq9WBzbZcZYsyQGunZGE7X5vwFYTGkVmV3CpHX81HwLypL6ZD/t2Htjctzy8
 muaAFZsy/5/m00DeBmc7903RCL+3lwhPwXWAQV9wcN9StqEM/Q2F2nucry88fWsNV+rdBLLMe
 +6zNn8WjiD+qCovkd/Q3+JwQ6mrYO0/l1i7DJ+XV79/kjAMGm0HooF/afm4bSO0QC3HO1EEYO
 8Xct61fz76nHdfFUkRWBqmjQ/EZd93F4eWho+oeQN8j95UCeRyf/A7Vdx66VMTbSpZC0l1WTf
 xAD/nPMBaMwJu1VBQRIpF8Vksh0ykTkObV92UcCvWJeq0TFJuWfZ+lXM0WPTQLB3YMCqFXmGC
 PUZKKwzyfG6c9/25Zx4V4XaNyXfRKozpJpp5dDfVelxXEG12co+emUujLMwzbu2Sd6a7k/+JX
 yCbHtSD4TtRPDuDF0lXOpRw0v1M6su77h9PeIhdDw+qXCi2wmi76gx9D9H+tHwM9RTn3zYpWR
 3H3rcqQJEzy+Qz8V5HxOkJCSOAj0TXsM3ClhggL675cNpSC8oVEakbVn7ZZ7/H6eKQYPb8lJT
 5A3oiLwroF3us3jZxRSDv2emtoFkDAtAajuGJUfTKQ04McB8rBBZWX1Bsr1in2hxq+RuuFgC4
 Y34hdewS5Vhn5EXiIhEBzA9xHY+5aQGkY1leXol0N1h1yOki0v6iFiTiQfKxJuILq7HP+VfrE
 mA5/tZCdJP7uUEFm6oJpcbiKt1
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

On Thu, 1 Sep 2022, Victoria Dye via GitGitGadget wrote:

> From: Victoria Dye <vdye@github.com>
>
> Ensure 'is_sparse_directory_entry()' receives a valid 'name_entry *' if =
one
> exists in the list of tree(s) being unpacked in 'unpack_callback()'.
>
> Currently, 'is_sparse_directory_entry()' is called with the first
> 'name_entry' in the 'names' list of entries on 'unpack_callback()'. Howe=
ver,
> this entry may be empty even when other elements of 'names' are not (suc=
h as
> when switching from an orphan branch back to a "normal" branch). As a
> result, 'is_sparse_directory_entry()' could incorrectly indicate that a
> sparse directory is *not* actually sparse because the name of the index
> entry does not match the (empty) 'name_entry' path.
>
> Fix the issue by using the existing 'name_entry *p' value in
> 'unpack_callback()', which points to the first non-empty entry in 'names=
'.
> Because 'p' is 'const', also update 'is_sparse_directory_entry()'s
> 'name_entry *' argument to be 'const'.
>
> Finally, add a regression test case.
>
> Reported-by: Derrick Stolee <derrickstolee@github.com>
> Signed-off-by: Victoria Dye <vdye@github.com>

A delightful commit message. Thank you!

The explanation makes perfect sense to me, and with that explanation the
diff becomes obvious, too.

Thanks,
Dscho

> ---
>     unpack-trees: fix sparse directory recursion check
>
>     This issue was found when the updates from v2.37.3 introduced a test
>     failure in a downstream test suite.
>
>     The issue stems from the fact that, before v2.37.3, 'unpack_callback=
()'
>     could previously "assume" that 'names[0]' was non-empty if a cache e=
ntry
>     was unpacked as a sparse index. When b15207b8cf (unpack-trees: unpac=
k
>     new trees as sparse directories, 2022-08-08)) was introduced, it
>     invalidated that assumption by allowing sparse directories to be
>     unpacked based on the contents of other 'names' entries, rather than
>     unnecessarily recursing into them and unpacking files individually. =
As a
>     result, certain scenarios could cause a sparse directory to be unpac=
ked
>     then also recursively unpacked via 'traverse_trees_recursive()',
>     creating duplicate index entries.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1344%2=
Fvdye%2Fbugfix%2Fsparse-index-orphan-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1344/vdye=
/bugfix/sparse-index-orphan-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1344
>
>  t/t1092-sparse-checkout-compatibility.sh | 9 +++++++++
>  unpack-trees.c                           | 4 ++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-c=
heckout-compatibility.sh
> index 0302e36fd66..b9350c075c2 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -380,6 +380,15 @@ test_expect_success 'checkout with modified sparse =
directory' '
>  	test_all_match git checkout base
>  '
>
> +test_expect_success 'checkout orphan then non-orphan' '
> +	init_repos &&
> +
> +	test_all_match git checkout --orphan test-orphan &&
> +	test_all_match git status --porcelain=3Dv2 &&
> +	test_all_match git checkout base &&
> +	test_all_match git status --porcelain=3Dv2
> +'
> +
>  test_expect_success 'add outside sparse cone' '
>  	init_repos &&
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 90b92114be8..bae812156c4 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1423,7 +1423,7 @@ static void debug_unpack_callback(int n,
>   * from the tree walk at the given traverse_info.
>   */
>  static int is_sparse_directory_entry(struct cache_entry *ce,
> -				     struct name_entry *name,
> +				     const struct name_entry *name,
>  				     struct traverse_info *info)
>  {
>  	if (!ce || !name || !S_ISSPARSEDIR(ce->ce_mode))
> @@ -1562,7 +1562,7 @@ static int unpack_callback(int n, unsigned long ma=
sk, unsigned long dirmask, str
>  			}
>  		}
>
> -		if (!is_sparse_directory_entry(src[0], names, info) &&
> +		if (!is_sparse_directory_entry(src[0], p, info) &&
>  		    !is_new_sparse_dir &&
>  		    traverse_trees_recursive(n, dirmask, mask & ~dirmask,
>  						    names, info) < 0) {
>
> base-commit: d42b38dfb5edf1a7fddd9542d722f91038407819
> --
> gitgitgadget
>
