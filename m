Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87434C433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 08:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A09C61167
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 08:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347747AbhIHIDj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 04:03:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:34063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235106AbhIHID1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 04:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631088137;
        bh=1ytoHv3GuQl7Cmz3M4rO0xuJBJIryKNyq83/4bH0ccE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QVJ4XZU+4vkzwbHoWDB51qc9IWbU98x+cv5B8gobfxMDsDVp3P+z6Q82KF0VsnjxC
         zDsQFc9seFoSvotb/OOM7T8zGC22mxjILN/nu4mmKU1EdC0ZLsoYC5Oiejha/d1c71
         drrCBWXlXaHfpDwR1OOE01SeURNuzOROSRVHZS38=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSc1B-1mUdv60wxt-00Sxpi; Wed, 08
 Sep 2021 10:02:17 +0200
Date:   Wed, 8 Sep 2021 10:02:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/3] stash: avoid feeding directories to update-index
In-Reply-To: <c7f5ae66a9204a4190b21bcb1338fd80fb907f33.1631065427.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109080959020.55@tvgsbejvaqbjf.bet>
References: <pull.1086.git.git.1631065426.gitgitgadget@gmail.com> <c7f5ae66a9204a4190b21bcb1338fd80fb907f33.1631065427.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:T5BOaRx+uKf+0D21A7b96yy6ruwdPQh2sutIqvI7AFpfp0jW2aR
 IIsQJT6iBE/uxvak3qN/p38pLTFOnZpc5EbwArX0pabxQOIhwoHHuGEoHP0SsruE+zhLpU6
 HGqlY55xlJMETfN1H2DFxsB1q7WIqDUPeaEa3qoxIchrWYiKOzqpG2KEa0ArQRLSs2hrXIV
 arGNeVbGSF4wvLeJJL/Kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vb4/ncFZoWQ=:xAs57612qjttwCYId8Ph52
 HiSNbfo6e1qO+KENIBPdm4SVd2zwI9zoZuyzE46GAQqxMVCtr88IlxZHABtZdDt34fuHUfzxf
 zvBYOjB7pJYSqKeaoC8XJchmX3OgN/TIjKK9aHTRMJquYjBlmfMjxtNn3eVFZ/KG5fBiVRaP0
 IIyOdcRn6JCl1t13j2SS4YOg1rV6zDM6gO2CWVJ9EzqUtvvbjMIcjMVxwsKP4G2QmHNfAoQeA
 UbJSp7fEAldvnA9YjcBcvxyj5OopYnSyuSiCuUf/aW+qHCztKuZcjgsG7ccuBaqC8xou7Q2qu
 +LGq5U36Q2Fwgsb7iNiFUET0t/kwhtkzv10aEESPiiMGw0UURPDMJqYxLU+DPpCqWCtYHWYdg
 RShfYesNgKQB3kQRWgywvlLdI19uws69vSofQ03/hzFZgB4DB/XocahppMlZY3CIbAS02yRpe
 FhbHF8Z8noS/5u8xZAx4qr5wnLhfBYi+xBQ3rjS9Brtkp5xANFwYMy7sovXsylyRISL1I3b0D
 YdZbLIQeRCq/TwMD9yyht4De6JkGBehDqhi2ald8VFjOTXhLhLPsmBR4rDdm5lSkanzphPyh3
 2K9/vc8KZhFqtXFHu/VRb23XbE5fb8we6c/gcSCyij43S4l+u6NYxAu7bP4uG53e3Nrxsh5Q7
 KV7FP7gBMdZFkH19CjONo5II8wlg7SjOPAbwi2nCO/eR2OwwNXJ4/ii05EzkDEIMjrLXrbckD
 b23msJquBmLor3qUiD3iyFpmCYge/zcpg4a42fS6OvUhPhETG0GamByBFHd2T8ObdK8uejPJ6
 LdjcZyHkduAN8F2k1G3wr3ReEzKxTO98scEFlQd+0UqsmGZG9BclbxkV/teDsVsX+/V3TXSfp
 TeQkc7ffcU9XFlAobl3DPNsvjvl5FsZVaghxXvzktFyZNPBKJ4e5da3A0Qfj7w1eZdkeEp+ny
 bcYrHVP3JZI6V43UwKe0uzi6QoHlLlWG4hov0X2pCE47Z47DeGBvqJPzEB+jbAYHoW212dHCW
 FOlBbRfk002hvC77eIZ1Mp7s671K5ZFadBObxtieUDIzo9pnyUpbG32TpaijIy50r0IDI0JaJ
 YSv8vLCmBOW25+wnd5CitWQo6cHqNDFDmORd/CTLRuCrFriNiNzspRUZQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 8 Sep 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> When a file is removed from the cache, but there is a file of the same
> name present in the working directory, we would normally treat that file
> in the working directory as untracked.  However, in the case of stash,
> doing that would prevent a simple 'git stash push', because the untracke=
d
> file would be in the way of restoring the deleted file.
>
> git stash, however, blindly assumes that whatever is in the working
> directory for a deleted file is wanted and passes that path along to
> update-index.  That causes problems when the working directory contains
> a directory with the same name as the deleted file.  Add some code for
> this special case that will avoid passing directory names to
> update-index.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/stash.c  | 9 +++++++++
>  t/t3903-stash.sh | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 8f42360ca91..b85cf9d267e 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -313,6 +313,12 @@ static int reset_head(void)
>  	return run_command(&cp);
>  }
>
> +static int is_path_a_directory(const char *path)
> +{
> +	struct stat st;
> +	return (!lstat(path, &st) && S_ISDIR(st.st_mode));
> +}

Git's API is unnecessarily confusing (because grown organically), so it is
easy to get confused by that `is_directory()` function that is declared in
`cache.h` and defined in `abspath.c`:

	/*
	 * Do not use this for inspecting *tracked* content.  When path is a
	 * symlink to a directory, we do not want to say it is a directory when
	 * dealing with tracked content in the working tree.
	 */
	int is_directory(const char *path)
	{
		struct stat st;
		return (!stat(path, &st) && S_ISDIR(st.st_mode));
	}

The difference I see is that you use an `lstat()`, which is kind of
important here.

Maybe you could add a paragraph pointing out that we cannot use
`is_directory()` here because it would follow symbolic links, which we
need to avoid here?

> +
>  static void add_diff_to_buf(struct diff_queue_struct *q,
>  			    struct diff_options *options,
>  			    void *data)
> @@ -320,6 +326,9 @@ static void add_diff_to_buf(struct diff_queue_struct=
 *q,
>  	int i;
>
>  	for (i =3D 0; i < q->nr; i++) {
> +		if (is_path_a_directory(q->queue[i]->one->path))
> +			continue;
> +
>  		strbuf_addstr(data, q->queue[i]->one->path);
>
>  		/* NUL-terminate: will be fed to update-index -z */
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 0727a494aa4..fc74918ccc0 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1307,7 +1307,7 @@ test_expect_success 'stash -c stash.useBuiltin=3Df=
alse warning ' '
>  	test_must_be_empty err
>  '
>
> -test_expect_failure 'git stash succeeds despite directory/file change' =
'
> +test_expect_success 'git stash succeeds despite directory/file change' =
'

Excellent!

Thanks,
Dscho

>  	test_create_repo directory_file_switch_v1 &&
>  	(
>  		cd directory_file_switch_v1 &&
> --
> gitgitgadget
>
>
