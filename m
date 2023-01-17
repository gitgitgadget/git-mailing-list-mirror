Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA279C3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 21:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjAQVhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 16:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjAQVez (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 16:34:55 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF314E531
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1673985507; bh=NAwP8EfcORM8oQ9fSDU3ZD61v+/Z1zuCyVkDO/eK2ww=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=P5n7E/zsSsswe8PzNnTaxfNKaDxEvNY8LeOUpeDO2BU+ou26MuLN7HeK/fWafsJ4P
         2JD+M9QC8lFNkrksL82kuxGNWnncfi6x7MEFQmVoTAch0k16pkgl78mpZwMV1KOrx7
         HG5pC654ggFiNe+dC2/6s2VCdTGaOjUNrlCNwMVlQcVC4itXC1wpKFwCFAhVx/oUS2
         j0ivWj1SdFPWA3tAZNaoW84OtVxlbprpBqRTrSoqGiDyjmfg3QE5rIIo49jAtSpr6W
         6Z5nOVUrGRo19zZrLZX6UNCqBQyvG4ksjRL6BOtgDW/Kl+sZnAU6vdNiKtYNfM97jq
         MF1HDPJLWTZOg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.69]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDdyH-1pPG561rxH-00Aj2w; Tue, 17
 Jan 2023 20:58:27 +0100
Message-ID: <c0c07b89-7eaf-21cd-748e-e14ea57f09fd@web.de>
Date:   Tue, 17 Jan 2023 20:58:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 19/19] push: free_refs() the "local_refs" in
 set_refspecs()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
 <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
 <patch-v4-19.19-b3aee41d0b4-20230117T151202Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-v4-19.19-b3aee41d0b4-20230117T151202Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kBoue2Ry7/+PE68CXjglD0mT1Ou7Js0LXcm4geqZPkz8fq3XxjG
 xK5NgiPm6/zrNd37Y7vBzChX6CimOY/SYDOC5WA4QW+QEIcFBvQI7lgXBrqQNaPquW4/Z5D
 vRm/q2VLdbO49ZMtg6P2va1WGd0Vt1njqYLdDWXTlzbEW6j9Rm1Qs7/6nlzy4Fg8Q6pqzTI
 CUxj3oXdS6Qn8kq57inww==
UI-OutboundReport: notjunk:1;M01:P0:eTVHZcEg8dM=;YORFdQBlq8W4Z3UeTf5opsCi1b7
 4Iy4gNiHDL4966uXLSITbAZvRN+VmddnACq2TYsQsqMhX9zitfCt3xF6gMHshynAD3tFvXzUS
 kper4McCqfniAlfYyriyvz5MfArQA2/Wc7xlYnLmc9YpQaO6a2e7UGB3pQz6LtVHg9ovQhjfg
 81Mo2sjV/O1RTCfH4lhJJMfC39DhUQV5e6dun84b3bjKcucntGYavK4nTACF85IN8dplXZMXQ
 Vr2JicYQtz1gDzwYDKMNGVKf5DBd3PioS6alaM8Q2fqtKTztA16qGlHRSilzYa2u9LZWdwqIC
 LpHl43gn+CU3ejX7/Gh0WOmJ6U+ZxJIFpK+353dXdabRMgxc8+xNiIEMJeEUUYQsMTaoIxv5+
 cELnTH+qPAmxByBn0EWWt9EBrYJMgNOtfG2pre/CfbvVVYw4m7vObxF/ob8Xit1c69ywrTknW
 pR14073TA3EzFoyss2bKojDQ6Vwn4GNTY3tuE7Plx6stxYK46y4xMF99TFK5PYVhrYrt6lphO
 +CQGHQyXPyA49VQLws2/to9cdEPU+Z4qw+7CwPqtSnDO45wuqYMVARt3t1WrmwEO8gn1dnhBj
 owDqL1y6nAsVXOj+k5SAzYubNATGHbi8BX/V+v0ajWPblZZ+JSkF5PSabpORLPAs1fFBySkPJ
 XNfiCygGgXJvyYAgXXffnIpMHo9+FQxJnM+53WP0AFVnQdtXvFfXENj9OF+iSs9QM2KZSOD+1
 kJsNYQuYh9WgzF8/Bx63IAFvqVN/jIbpYHGh3vLb3LAqNSohNyzf1sVrF+yr/djPEZiglSDSI
 JBRPnfF5m5DXkJLP0DmVWv08bnHfP8XVidtZ0ykQpUb/MXQhJg1Oe71OdYik6JPLMUyH8oxkb
 OG90HzqkV2kKkaC1EK0OK2CV8VOStQlEetD/sovF4nBOsr7gToR++Dih4seU0yV3C2qDGHBPb
 VCKDJtsHcN8LxuYo2QfhPhYad2k=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.01.23 um 18:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Fix a memory leak that's been with us since this code was added in
> ca02465b413 (push: use remote.$name.push as a refmap, 2013-12-03).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/push.c                          | 1 +
>  t/t1416-ref-transaction-hooks.sh        | 1 +
>  t/t2402-worktree-list.sh                | 1 +
>  t/t5504-fetch-receive-strict.sh         | 1 +
>  t/t5523-push-upstream.sh                | 1 +
>  t/t5529-push-errors.sh                  | 2 ++
>  t/t5546-receive-limits.sh               | 2 ++
>  t/t5547-push-quarantine.sh              | 2 ++
>  t/t5606-clone-options.sh                | 1 +
>  t/t5810-proto-disable-local.sh          | 2 ++
>  t/t5813-proto-disable-ssh.sh            | 2 ++
>  t/t7409-submodule-detached-work-tree.sh | 1 +
>  t/t7416-submodule-dash-url.sh           | 2 ++
>  t/t7450-bad-git-dotfiles.sh             | 2 ++
>  14 files changed, 21 insertions(+)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 60ac8017e52..f48e4c6a856 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -129,6 +129,7 @@ static void set_refspecs(const char **refs, int nr, =
const char *repo)
>  		} else
>  			refspec_append(&rs, ref);
>  	}
> +	free_refs(local_refs);

OK.

This can still leak local_refs if remote_get() returns NULL and lazy-
loading is done over and over.  Unlikely to occur in the wild, I bet --
who pushes without a remote?  Does it make sense to also check
local_refs for NULL already in this patch or is it worth its own series?
Not sure.

remote is still leaked if it isn't NULL, though.  We'd need to export
remote_clear() to release it properly, no?  And shouldn't
remotes_remote_get_1() call remote_clear() itself before returning
NULL?  Not simple, separate series.

>  }
>
>  static int push_url_of_remote(struct remote *remote, const char ***url_=
p)
> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-=
hooks.sh
> index 27731722a5b..b32ca798f9f 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -5,6 +5,7 @@ test_description=3D'reference transaction hooks'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success setup '
> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
> index 79e0fce2d90..9ad9be0c208 100755
> --- a/t/t2402-worktree-list.sh
> +++ b/t/t2402-worktree-list.sh
> @@ -5,6 +5,7 @@ test_description=3D'test git worktree list'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success 'setup' '
> diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-str=
ict.sh
> index ac4099ca893..14e8af1f3b7 100755
> --- a/t/t5504-fetch-receive-strict.sh
> +++ b/t/t5504-fetch-receive-strict.sh
> @@ -4,6 +4,7 @@ test_description=3D'fetch/receive strict mode'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success 'setup and inject "corrupt or missing" object' '
> diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
> index fdb42920564..c9acc076353 100755
> --- a/t/t5523-push-upstream.sh
> +++ b/t/t5523-push-upstream.sh
> @@ -4,6 +4,7 @@ test_description=3D'push with --set-upstream'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-terminal.sh
>
> diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
> index ce85fd30ad1..0247137cb36 100755
> --- a/t/t5529-push-errors.sh
> +++ b/t/t5529-push-errors.sh
> @@ -1,6 +1,8 @@
>  #!/bin/sh
>
>  test_description=3D'detect some push errors early (before contacting re=
mote)'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success 'setup commits' '
> diff --git a/t/t5546-receive-limits.sh b/t/t5546-receive-limits.sh
> index 0b0e987fdb7..eed3c9d81ab 100755
> --- a/t/t5546-receive-limits.sh
> +++ b/t/t5546-receive-limits.sh
> @@ -1,6 +1,8 @@
>  #!/bin/sh
>
>  test_description=3D'check receive input limits'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  # Let's run tests with different unpack limits: 1 and 10000
> diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
> index 1876fb34e51..9f899b8c7d7 100755
> --- a/t/t5547-push-quarantine.sh
> +++ b/t/t5547-push-quarantine.sh
> @@ -1,6 +1,8 @@
>  #!/bin/sh
>
>  test_description=3D'check quarantine of objects during push'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success 'create picky dest repo' '
> diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> index cf221e92c4d..27f9f776389 100755
> --- a/t/t5606-clone-options.sh
> +++ b/t/t5606-clone-options.sh
> @@ -4,6 +4,7 @@ test_description=3D'basic clone options'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success 'setup' '
> diff --git a/t/t5810-proto-disable-local.sh b/t/t5810-proto-disable-loca=
l.sh
> index c1ef99b85c2..862610256fb 100755
> --- a/t/t5810-proto-disable-local.sh
> +++ b/t/t5810-proto-disable-local.sh
> @@ -1,6 +1,8 @@
>  #!/bin/sh
>
>  test_description=3D'test disabling of local paths in clone/fetch'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY/lib-proto-disable.sh"
>
> diff --git a/t/t5813-proto-disable-ssh.sh b/t/t5813-proto-disable-ssh.sh
> index 3f084ee3065..2e975dc70ec 100755
> --- a/t/t5813-proto-disable-ssh.sh
> +++ b/t/t5813-proto-disable-ssh.sh
> @@ -1,6 +1,8 @@
>  #!/bin/sh
>
>  test_description=3D'test disabling of git-over-ssh in clone/fetch'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY/lib-proto-disable.sh"
>
> diff --git a/t/t7409-submodule-detached-work-tree.sh b/t/t7409-submodule=
-detached-work-tree.sh
> index 374ed481e9c..574a6fc526e 100755
> --- a/t/t7409-submodule-detached-work-tree.sh
> +++ b/t/t7409-submodule-detached-work-tree.sh
> @@ -13,6 +13,7 @@ TEST_NO_CREATE_REPO=3D1
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success 'setup' '
> diff --git a/t/t7416-submodule-dash-url.sh b/t/t7416-submodule-dash-url.=
sh
> index 3ebd9859814..7cf72b9a076 100755
> --- a/t/t7416-submodule-dash-url.sh
> +++ b/t/t7416-submodule-dash-url.sh
> @@ -1,6 +1,8 @@
>  #!/bin/sh
>
>  test_description=3D'check handling of disallowed .gitmodule urls'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success 'setup' '
> diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
> index ba1f569bcbb..0d0c3f2c683 100755
> --- a/t/t7450-bad-git-dotfiles.sh
> +++ b/t/t7450-bad-git-dotfiles.sh
> @@ -12,6 +12,8 @@ Such as:
>
>    - symlinked .gitmodules, etc
>  '
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-pack.sh
>
