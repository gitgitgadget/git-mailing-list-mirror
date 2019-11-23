Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23615C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 21:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9464206D4
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 21:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EjucJAWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKWVP0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 16:15:26 -0500
Received: from mout.gmx.net ([212.227.15.15]:53639 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfKWVP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 16:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574543715;
        bh=U63CdHzBh1AFN5e6yPZgXqccoaVr3/ZCqHlygi9rC3U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EjucJAWt5X4hq2v1pfEMLr0Ef7rALf9hdqQsMdV5c6OCDsKGJ5qSASNiOSQSedKei
         Y3IgK7BSfkh97IS9yFNL/QYU8czvxQlN+CF4wF2ORGZvNb48EHPGIWQdaAORkBvBRZ
         vcTOHO0loKq3pdM84H3ykxT1QLg94j4OrFklRcDg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MysRk-1hdvd23Lhi-00vwTx; Sat, 23
 Nov 2019 22:15:15 +0100
Date:   Sat, 23 Nov 2019 22:14:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] sequencer: don't re-read todo for revert and
 cherry-pick
In-Reply-To: <20191123172046.16359-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1911232214080.31080@tvgsbejvaqbjf.bet>
References: <e7c01e0f-8466-c2c5-b53a-a93f941dfb1c@gmail.com> <20191123172046.16359-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2120616068-1574543717=:31080"
X-Provags-ID: V03:K1:hgg+D1xKjHY0NVwaCOABu1SO/2es7Aban8UDyvX2SjS2Nlfijff
 xFvVBBpAGPMc5efnkvESgby7IlFsGoRc58YZ7VvHISlgFqzoSyJWEE4lMFNqVT+yfxCdkoG
 5JKzD2ntBP/K2UlACGJw9H35Tqza9ZX4PfygWizeWJdKVfrOYnONs/Il5+pgEowtCt2kFxG
 yDRvUPW2UVMEkqf3beb/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e5RLds52UwQ=:sAuZveE3vfhDp72NinjlIn
 OxDqhAk0aWDtpHQ7pSN2CB4T13gi6tcopbTNvNO+gqXQhbDsPLLm1osERfzKFDmMZE2Rj8+4g
 gOMlod8bhxVhMEO6rZOYV7JOGEf7SaX/zibWfAiU2JoPU7R+NnO3Oc8r6V/om2s2UohKqLoPT
 GWF1LE9daDjThAqyz+RJkKrVdpxuXORBVKGEYhqr3FJ+RP5e3EIiOZnnQEe+6U3MP+zOcfwcC
 YUlUsS/8W0MFHMom+4aPFK6wfuJ9c70u2bu/zgqnwvPZJpT5vKoz3aHKht4J1wRJog2Um/r5w
 VQNNKcsFuNs+pEebXLce5TtCWyjcJ2QVD8WEkMP5GQ6LveQ0SFYO3HSrRzgT+sMuu75tO2avs
 e1V4AexCSRDBcfOb9xvSRvTPfxddYrgx+lEEBjVMmhNNnPJ80DECE7ZwAkrzcxXUwu9WxqZVv
 V1wDY3o7R7yTWMTBbGfjNOQFJM+Jwxa1e3t9pkwvZNN44cS1912MLOI4k/sgzaCGGYhn+v83W
 wDCCSs/KDO0sCnX3U0dit874QVfLf7bLw0ABFP7vZzsncVLWFnGPURAnxZpSNt5jo59UCqqJ6
 LkEyHi22EHrE3rxSo008E3mKM+MSl4tbQbtGyISql7yfPVzjBzsDG0SP7WTYfk/ta2PLVgbwR
 0fVtq+cs+CK70v1ZT0Fcuq0xonQo4QO44mEVDRt+6yb12Gk/mlfD94oIYo7DfyRWeE1nH08Fr
 cj/FjK3Cn1Tn/2vnZBMxA5eRSj3GvgJQ4ts4RBCeb9v6RgU1f1lr/CoIZC/5gt3soGilFpZTj
 IjB5rEuj/4rCyHj1bxMKa6ytYXLoJaZj+Qtrl6j8ckIMJO6+EnC4d+3qvdxS9V3wMAtE3DcVb
 GirVR0XLrYDR2cEsZUMmIlceHRR2flMT0WV97pkCwMayYl/WtAMGaq/5WV1pRhfCITyGsVYnH
 wcpsBYa8zZKRa48X/wd8cP7oF60DBY2W3kLfCCIqHaKj9ZJCxvTbLvr1mVkkQJl1HLrMkOOZw
 6bXmFJsaKbgTrl9IF2niC3K/nlwnglb990VqoXV3jePPrRNegx3U3X/LC6E/HL2C7hhqcJKXg
 eBJFGrV5dO9v5Bu9uFV/UNjKA2JTs4Z/M1Al+568lezpCQp8MpPDSHByYd1gpJMtcW5aSP/q3
 dqIDJGEXsDB2Ol6TqU5mEcnTha43fCW0Ws6IdwijYaGq4Lwyys5FnoN+5zElBiBNfbe/1+/dD
 F9oKdA5kIt6qQwOZcpeCUFMPTJUsuwirKu+HXcgiR5YqFdVeHD5J24qxs7Q4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2120616068-1574543717=:31080
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, 23 Nov 2019, SZEDER G=C3=A1bor wrote:

> When 'git revert' or 'git cherry-pick --edit' is invoked with multiple
> commits, then after editing the first commit message is finished both
> these commands should continue with processing the second commit and
> launch another editor for its commit message, assuming there are
> no conflicts, of course.
>
> Alas, this inadvertently changed with commit a47ba3c777 (rebase -i:
> check for updated todo after squash and reword, 2019-08-19): after
> editing the first commit message is finished, both 'git revert' and
> 'git cherry-pick --edit' exit with error, claiming that "nothing to
> commit, working tree clean".
>
> The reason for the changed behaviour is twofold:
>
>   - Prior to a47ba3c777 the up-to-dateness of the todo list file was
>     only checked after 'exec' instructions, and that commit moved
>     those checks to the common code path.  The intention was that this
>     check should be performed after instructions spawning an editor
>     ('squash' and 'reword') as well, so the ongoing 'rebase -i'
>     notices when the user runs a 'git rebase --edit-todo' while
>     squashing/rewording a commit message.
>
>     However, as it happened that check is now performed even after
>     'revert' and 'pick' instructions when they involved editing the
>     commit message.  And 'revert' by default while 'pick' optionally
>     (with 'git cherry-pick --edit') involves editing the commit
>     message.
>
>   - When invoking 'git revert' or 'git cherry-pick --edit' with
>     multiple commits they don't read a todo list file but assemble the
>     todo list in memory, thus the associated stat data used to check
>     whether the file has been updated is all zeroed out initially.
>
>     Then the sequencer writes all instructions (including the very
>     first) to the todo file, executes the first 'revert/pick'
>     instruction, and after the user finished editing the commit
>     message the changes of a47ba3c777 kick in, and it checks whether
>     the todo file has been modified.  The initial all-zero stat data
>     obviously differs from the todo file's current stat data, so the
>     sequencer concludes that the file has been modified.  Technically
>     it is not wrong, of course, because the file just has been written
>     indeed by the sequencer itself, though the file's contents still
>     match what the sequencer was invoked with in the beginning.
>     Consequently, after re-reading the todo file the sequencer
>     executes the same first instruction _again_, thus ending up in
>     that "nothing to commit" situation.
>
> The todo list was never meant to be edited during multi-commit 'git
> revert' or 'cherry-pick' operations, so perform that "has the todo
> file been modified" check only when the sequencer was invoked as part
> of an interactive rebase.
>
> Reported-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---

The patch and the commit message (thank you so much for the detail!) look
very good to me.

> On Sat, Nov 23, 2019 at 09:53:51AM +0000, Phillip Wood wrote:
> > Thanks, I suspect it's missing an 'if (is_rebase_i(opts))' I'll take a=
 look
> > later and come up with a fix
>
> That missing condition was my hunch yesterday evening as well, and
> while it did fix my tests and didn't break anything else, it took some
> time to wrap my head around some of the subtleties that are going on
> in the sequencer.  That's why the commit message ended up this long as
> it did.
>
> In the end I decided to add the new tests to
> 't3429-rebase-edit-todo.sh', because, though these new tests don't
> actually check 'rebase', that is the one test script focusing on
> (re-)reading the todo file in particular.

Yup, makes sense.

Thanks,
Dscho

>
>  sequencer.c                 |  2 +-
>  t/t3429-rebase-edit-todo.sh | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 2adcf5a639..3b05d0277d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3791,7 +3791,7 @@ static int pick_commits(struct repository *r,
>  							item->commit,
>  							arg, item->arg_len,
>  							opts, res, 0);
> -		} else if (check_todo && !res) {
> +		} else if (is_rebase_i(opts) && check_todo && !res) {
>  			struct stat st;
>
>  			if (stat(get_todo_path(opts), &st)) {
> diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
> index 8739cb60a7..1679f2563d 100755
> --- a/t/t3429-rebase-edit-todo.sh
> +++ b/t/t3429-rebase-edit-todo.sh
> @@ -52,4 +52,34 @@ test_expect_success 'todo is re-read after reword and=
 squash' '
>  	test_cmp expected actual
>  '
>
> +test_expect_success 're-reading todo doesnt interfere with revert --edi=
t' '
> +	git reset --hard third &&
> +
> +	git revert --edit third second &&
> +
> +	cat >expect <<-\EOF &&
> +	Revert "second"
> +	Revert "third"
> +	third
> +	second
> +	first
> +	EOF
> +	git log --format=3D"%s" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 're-reading todo doesnt interfere with cherry-pick =
=2D-edit' '
> +	git reset --hard first &&
> +
> +	git cherry-pick --edit second third &&
> +
> +	cat >expect <<-\EOF &&
> +	third
> +	second
> +	first
> +	EOF
> +	git log --format=3D"%s" >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.24.0.532.ge18579ded8
>
>

--8323328-2120616068-1574543717=:31080--
