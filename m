Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A480C3DA7C
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 23:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbiL3XiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 18:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbiL3XiB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 18:38:01 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08FC1DDF0
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 15:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672443469; bh=lmCSiW5aVJSnleE8v3FJ2TCSvdWwNjHOuDWNA9oIyqE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=m/O7NtUU3njF3FlBOFcaI7OL8uxhNV5JMGqSEocKgqCazggXq2SuudJ8Br0Jbpgr9
         LG0jWbl4OnlNe2tU3fLZR6UzoaT+4KBQTJiOClsAQjz2tn+bf/Qc99SmEWhdHxMfrr
         Qi2Q0PggFcUpyUZFfb7bc0YLw6I8QEVFBUQwQn4UO8VseF3ix3VqzYc57dcLO9oBhN
         xQAdhsj2xLgR2ou4PVQqB2KaRfINHIZpjNGGwx5503WYhEldF+/h2aEzMwKGjKhyQZ
         FEk8OKPDV9nGXymwcM4fhq+OeHq2GOG77yfJp4xg3v36EWpFm9GWsYlQssyWuTWuie
         ibmNbJWaQblfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mpl4x-1oUJyC24a5-00plvT; Sat, 31
 Dec 2022 00:37:49 +0100
Message-ID: <3a823d76-9ea3-d6a0-c9ed-9e84fe57042c@web.de>
Date:   Sat, 31 Dec 2022 00:37:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 05/10] builtin/revert.c: fix common leak by using
 replay_opts_release()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
 <patch-05.10-e2895bb9795-20221230T071741Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-05.10-e2895bb9795-20221230T071741Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JKylImxZI9pT3pijkmNMH1W3x0yx3iVhZc5xaoI19/ZojRmNJ2F
 lW2PW2Bgcobw173QlO1zY6i/65cDWZHaRDqn8innytbas6Ljz3npdLjEYF2gva8QtM5Lwg+
 6fC6MpMCsxjs8fwg1/ytioQMdwukEgQE/LQXCWyD1AE9WBjed6sZ/x5wHoixXg9QAxF/lw8
 KuQyB43/5Uj3j2mfiz8/g==
UI-OutboundReport: notjunk:1;M01:P0:DLpcg/MbEPA=;rLy8j2sxY6X3/0I+x1Ypl3Jrvhd
 1R3Sz3r5qg88T3YW/NThlL6qsJV1NvU0TYbA3OsvsssBi/fcVMBHU6mMccOTJAkHqn855hOEp
 gCgs9pKMbXNTUStOKPdoiZIDS82TpDShTphaTgh3PLQ9tVkosQfXt2W15nV+rrjrre63oN0DZ
 HkmgURdQJunOeJW/O/DlFCTwkn/Om/R9NlVtU7Xcoije0nW8b2IRbX9laAqTywoAy3Ou8a5bz
 DAYoQMiSZC0YARMta7zN19kjKbu6Dqraex+tcYHTOzTMJG5Dl78PuUgsXgn4Ih+rpBAqeaHDR
 9+Lt6i7eHEDlQ1eOwZOtBgMvFR2CbD4+LwUL5SSJCsgXmVPFSnXmCgfCx1varEPS5JunPpNcA
 NhMIDJnQ3zv1U1zXTTQI34/KRswcGBjvQrsQiQYaDqxscnR9weCtkIbUYwHL++oX+N0V8fgst
 2BY4Gdbcs3Rg7qGAzfz3/KDYLL9l8Eca6isGsK7sgVsWi1SeBoaxYe071+FFzqvp98IY4PaEF
 ldLqsNwjelcJH6KdP8GW3sjhtn4G3E01S0JN6SpGg0Ivys2+TFnO25f+ohAKin6gPEVRiyCnO
 QW2Bk//b8sDSqj+A2UkBa19+ERjcLDyYr6eA4y9oD7uSZ2bkR/ScoWc+bKIVTviHSCxmpOmJR
 cjr8h8u4q98maymANemTjkls5qRVaCuPTaY7XNn71RfzcGE0eDxD4iNta1mvhxmvUY4/+R3VJ
 XFIKY/HvFd4596KoGbNswBeCWa4oXbEC3hHR1WB9gbVxflC+ZqeVcCKxSvRK6FDzrY6dHjLWu
 5cZ/A4s9GZnWeOyXrh5xvUNVJqlcEW0ZfBplqRwJbuUC/NgZhxayFPrAzYEx95WFPTOzjlUCm
 f/FNY8uUBNjeTrWUVY5w7GLNWCBSZLXYhp9qtk0ZHY7vVWVqEbQf6IKzXdIEaXKJG/XSvQ+Et
 NulzRg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.12.22 um 08:28 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Use the replay_opts_release() function introduced in a preceding
> commit to fix a memory leak in run_sequencer().
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/revert.c                  | 1 +
>  t/t3419-rebase-patch-id.sh        | 1 +
>  t/t3425-rebase-topology-merges.sh | 2 ++
>  t/t3501-revert-cherry-pick.sh     | 1 +
>  t/t3502-cherry-pick-merge.sh      | 1 +
>  t/t3503-cherry-pick-root.sh       | 1 +
>  t/t3506-cherry-pick-ff.sh         | 1 +
>  t/t3511-cherry-pick-x.sh          | 1 +
>  8 files changed, 9 insertions(+)
>
> diff --git a/builtin/revert.c b/builtin/revert.c
> index e956d125a2b..2f656b25619 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -240,6 +240,7 @@ static int run_sequencer(int argc, const char **argv=
, struct replay_opts *opts)
>  		cmd =3D=3D 's' ? sequencer_skip :
>  		sequencer_pick_revisions;
>  	ret =3D cbfun(the_repository, opts);
> +	replay_opts_release(opts);

Is this the right place for this call?  opts is passed in by this function=
's
two callers.  They should clean it up instead, no?  That would add one lin=
e,
but avoid the need for patch 4.  Would make patch 6 easier to read as well=
.

>  	return ret;
>  }
>
> diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
> index 7181f176b81..6c61f240cf9 100755
> --- a/t/t3419-rebase-patch-id.sh
> +++ b/t/t3419-rebase-patch-id.sh
> @@ -5,6 +5,7 @@ test_description=3D'git rebase - test patch id computati=
on'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  scramble () {
> diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology=
-merges.sh
> index 63acc1ea4da..a16428bdf54 100755
> --- a/t/t3425-rebase-topology-merges.sh
> +++ b/t/t3425-rebase-topology-merges.sh
> @@ -1,6 +1,8 @@
>  #!/bin/sh
>
>  test_description=3D'rebase topology tests with merges'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-rebase.sh
>
> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.=
sh
> index 1f4cfc37449..2f3e3e24169 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -13,6 +13,7 @@ test_description=3D'test cherry-pick and revert with r=
enames
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success setup '
> diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
> index 5495eacfec1..1b2c0d6aca6 100755
> --- a/t/t3502-cherry-pick-merge.sh
> +++ b/t/t3502-cherry-pick-merge.sh
> @@ -11,6 +11,7 @@ test_description=3D'cherry picking and reverting a mer=
ge
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success setup '
> diff --git a/t/t3503-cherry-pick-root.sh b/t/t3503-cherry-pick-root.sh
> index 95fe4feaeee..76d393dc8a3 100755
> --- a/t/t3503-cherry-pick-root.sh
> +++ b/t/t3503-cherry-pick-root.sh
> @@ -5,6 +5,7 @@ test_description=3D'test cherry-picking (and reverting) =
a root commit'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success setup '
> diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
> index 7e11bd4a4c5..b71bad17b85 100755
> --- a/t/t3506-cherry-pick-ff.sh
> +++ b/t/t3506-cherry-pick-ff.sh
> @@ -5,6 +5,7 @@ test_description=3D'test cherry-picking with --ff option=
'
>  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  test_expect_success setup '
> diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
> index 84a587daf3a..dd5d92ef302 100755
> --- a/t/t3511-cherry-pick-x.sh
> +++ b/t/t3511-cherry-pick-x.sh
> @@ -2,6 +2,7 @@
>
>  test_description=3D'Test cherry-pick -x and -s'
>
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
>
>  pristine_detach () {

