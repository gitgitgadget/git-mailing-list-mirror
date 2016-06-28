Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16D891FE4E
	for <e@80x24.org>; Tue, 28 Jun 2016 06:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbcF1GOf (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 02:14:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35752 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbcF1GOf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 02:14:35 -0400
Received: by mail-wm0-f67.google.com with SMTP id a66so2880819wme.2
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 23:14:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Pt1FOvBzFSYpC3YNbO5pPdJ3p6c65zKWpKUfnEM8ofs=;
        b=j6kBdPLQQFmQw9GJUiK2wxxcgLxu6A0sas3L1Dx6CXBVIUUrSwzJAzEA3q0qu0qEYh
         kTafKU4aSo3deffwzHE5qkn9sln6BmtCcKIJEatYqbQ3D0mK3iDwfLSFWKw2Y7xkaMpX
         pRb2zi2YWnOd0bTSOJ/YDDhIXnavh7TeWpR8MzCuNqxN7uUqaRSYlxMzX0h06/8SCnqA
         lHoOR9Qp2nG6MGVRGDF85LHpQLODnfz6TCzX7+pww7LAQ8Oq6bPaRnl3zOSCAKhxegv8
         uSlqeDfzh9L9xr3TQZxxaSw9NGSSTIjlzfZm5EpEZ5h+Da1p58LS+aGmRXkMnvHt6FJO
         zkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Pt1FOvBzFSYpC3YNbO5pPdJ3p6c65zKWpKUfnEM8ofs=;
        b=HCsHuucSzBJIaEfBS+AunJ+Yh93F9g1oWLgG0s4489LqbxJ+L5qo2hMDv2rq8KTwhX
         w8mGu/R+J8OUQg6cxvavRx6IpQ7YHEfCR1jsyy6AuQXtjatIfyrjfuLEPD9/l0Vz9jCh
         L7O3BgIP+dNiYCQjCiu8NAWS1YDWiQm3cHvnSdgbtgYFJTSN6TIfylv8NNncm5CrLpAG
         R/zMIpTPPvnhSfPJO+EqYRsNsmJ9OGEkgZw4TjmSme70QAy1gU8iNhJ1+IYqhkDjLOGk
         Uwm7I/in3K34DeS988VayR2clR8uIeFNJu6XHN4pyGBPzJpZlbpHZAPTfF2CHMb/8yTr
         o/9g==
X-Gm-Message-State: ALyK8tLYBqE+5W2dpuddtsmT59tr40bftoJVz8/hhQ9tv5SflyJr4DFCzHNyjcj+ZtIXSeFywTAHeIXdSBzIqQ==
X-Received: by 10.194.109.199 with SMTP id hu7mr1179459wjb.6.1467094473499;
 Mon, 27 Jun 2016 23:14:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.107.170 with HTTP; Mon, 27 Jun 2016 23:13:54 -0700 (PDT)
In-Reply-To: <20160628001559.29204-1-sbeller@google.com>
References: <20160628001559.29204-1-sbeller@google.com>
From:	Bart Bogaerts <bartbogaerts@gmail.com>
Date:	Tue, 28 Jun 2016 09:13:54 +0300
Message-ID: <CAOG-3G+xAZQV8rPgdxz8S8bqzJfm1fFNg2Y4suC-a--tbCWXow@mail.gmail.com>
Subject: Re: [PATCH] submodule: test moving recursive submodule
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The only thing I still see that might cause the bug is that there is no

git submodule update --recursive

present in your test cases .
This command creates the .git file in the nested subsubmodule
It is that .git file that is not correctly updated in the move.

So after the line
+       git submodule add ./outer_sub ./deep/outer_sub &&
I would add
+       git submodule update -- recursive &&

2016-06-28 3:15 GMT+03:00 Stefan Beller <sbeller@google.com>:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> This tries to reproduce the error as pointed out in
> http://stackoverflow.com/questions/32782382/git-moving-submodules-recursively-nested-submodules
> but the tests pass. This still seems to be missing a detail.
>
> Bart any idea how this setup may be different than what you have?
> Instead of applying the patch, you can also checkout
> https://github.com/stefanbeller/git/tree/submodule_recursive_mv_test
> which is the patch below applied on top of Junios (the maintainer) master branch.
> To look around on the filesystem, you can drop "test_pause &&" in a test and
> then run the test with `(cd t && ./t7001-mv.sh -v)` (more info how to run tests
> in the Git test suite in t/README, maybe -i -v -x are interested)
>
> Thanks,
> Stefan
>
>  t/t7001-mv.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index 4a2570e..404e5bd 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -295,6 +295,28 @@ test_expect_success 'setup submodule' '
>         mkdir -p deep/directory/hierachy &&
>         git submodule add ./. deep/directory/hierachy/sub &&
>         git commit -m "added another submodule" &&
> +       mkdir inner_sub &&
> +       (
> +               cd inner_sub &&
> +               git init &&
> +               test_commit initial
> +       ) &&
> +       mkdir outer_sub &&
> +       (
> +               cd outer_sub &&
> +               git init &&
> +               test_commit initial &&
> +               git submodule add ../inner_sub &&
> +               git commit -a -m "add an inner submodule"
> +       ) &&
> +       git submodule add ./outer_sub ./deep/outer_sub &&
> +       git commit -a -m "add outer sub" &&
> +       git -C deep ls-tree HEAD |cut -f 2 >actual &&
> +       cat >expect <<-EOF &&
> +       directory
> +       outer_sub
> +       EOF
> +       test_cmp expect actual &&
>         git branch submodule
>  '
>
> @@ -488,6 +510,27 @@ test_expect_success 'moving a submodule in nested directories' '
>                 git config -f ../.gitmodules submodule.deep/directory/hierachy/sub.path >../actual &&
>                 echo "directory/hierachy/sub" >../expect
>         ) &&
> +       test_cmp actual expect &&
> +       git commit -a -m "mv a submodule in nested dir"
> +'
> +
> +test_expect_success 'moving a submodule with a nested submodule' '
> +       git mv deep/outer_sub outer_sub_moved &&
> +       # git status would fail if the update of linking git dir to
> +       # work dir of the submodule failed.
> +       git status &&
> +       git config -f .gitmodules submodule.deep/outer_sub.path >actual &&
> +       echo "outer_sub_moved" >expect &&
> +       test_cmp actual expect
> +'
> +
> +test_expect_success 'moving back the submodule with a nested submodule' '
> +       git mv outer_sub_moved deep/outer_sub &&
> +       # git status would fail if the update of linking git dir to
> +       # work dir of the submodule failed.
> +       git status &&
> +       git config -f .gitmodules submodule.deep/outer_sub.path >actual &&
> +       echo "deep/outer_sub" >expect &&
>         test_cmp actual expect
>  '
>
> --
> 2.9.0.4.g35eb263.dirty
>



-- 
Bart Bogaerts
