Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C04C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 10:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D28961051
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 10:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbhIIKqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 06:46:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:45941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233979AbhIIKqK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 06:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631184297;
        bh=7wGVfTxK68zp88IRGzAE/I8uzDnkYTJ/BsABMCaSgdE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ecC+yH6tyDlNxCG8JRMSniKpGDgH1TB5vC/jKvhT52KW35oHdTq0xlH0/hIshpGzj
         R3CP40TDDJTgZGeO1nHLapAPwtQ+08hdq3ew4SYSBrFx69Rco2hy3Ufk6UZOLIlq5S
         bb7dYMxGNnhGxBQQ7gP49AhcrnDG5ow5TbCEh/PI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnJhO-1mpbTg3gjk-00jIEm; Thu, 09
 Sep 2021 12:44:56 +0200
Date:   Thu, 9 Sep 2021 12:44:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/5] sequencer.c: factor out a function
In-Reply-To: <53cde4825b408e5fb893bbd9a222e7387d69a408.1631108472.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109091241270.59@tvgsbejvaqbjf.bet>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com> <53cde4825b408e5fb893bbd9a222e7387d69a408.1631108472.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0cFo3ge0bEaBtSfb8ck3FFhAOB9WG3BKZnF1PhafFyUsg9jTDIy
 1ey96d0rEZyDhvKaCsJRBrM7/L0EK7C6Pz/bXffdNy3ia4rhbNWbNRq2NVkJrNF45zavBI3
 oa86D/3L/3aJIP0mGjaUYZRTIY1MhDlDNBt+EehANi50wtw5zronCcb4dRV9v/csFJthxG/
 ZQTDApx57esAFAik+MW1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hcfiOACL5Oc=:/n13Cu2blsEfFfRmhNh2nw
 NBU/vYPJIq1qyqRnXCdnmheDPe0lqZHpDghxF3sv5viBf+CMfAppuQQQjSBnN4vkNiN1Iu2YT
 Gbybopv52Z1V5b2iQq3LA+0/lZKaZS6RHdVvMnrElIO/f5h7VDzBS/D9Jqe/dWD046+3Ygg60
 sbROuRXBlIWSE1v7ANZsT+FuDeY0ZNDklP5yDKFu/ag2PEfxI4eUlleqr59dPS2v3UJ9u8OJ9
 KgZ6HjGqIxSeR1WjvGkmT1baiifT71/M8kUp4LG3B72eXTSRPk4kDHRJL3ojjkDCRBrd3OxdQ
 LiTafAr/1PsdbEtgaXRvjtoMaclrjGB6IqJ5K0bwG3dOUpkdVD9Y6YpCNoh4PkNGplVV6w7Rp
 lqinMTVgNCX2CLRxdkKohtS9UQBhidhRBc5VlPlLzHP/hWwKXOev02zbB05CLqU5e85ORkXM4
 AWTRejdC62CHqOF5/CyaLdhh2isidInwVQgtkgXKt0Gph6Efp+Ma6jELdg+Zy3YdRsHqrbSaK
 qpxa1Yr40PG0GYlCGPYqpJ4u4wcFhuZNOeWPrAV/NJXq9SkCNLdBbpQtn4+dea59T4etZirRU
 OX45Dr1Z2n3r43O7cG7FYxIb8GLy2o09+d0k7B4jgaqeFd1qJzhXRrJo6r3elN5hib/qDkYlX
 MtR54BsvKIG7bk3Aq00tVOQPmMZQ2Vf7a3pvP6EYdmg9nd6UDQ6p6hxSY1mkXfly1juXLYVqD
 eipOVViu26T8SXRAKdF4UkH8KLiFpMahdGnUCir/ok2IxYvciGfcp5nhk8qtEs+RB9uNUB+Uv
 gLVApUhXBzrKCLinCpCn3ohUEm3gXiM/1B+LrpDwFg3P8vDRmC5xtWV7Xz82pMxTLwQMovKru
 oWiDIOrgyFv4muNY8tSkYNuK08Ii0ffeqSr7JYR9Ufq8p6vbcMTc0cvTzzpaj2mVlfT7EDkf4
 aOwhz5pRDcfXByCTlrOJtQD0PegAyfE/hA+fhf6pgSF5G5wRfe1v0NeMhk3XKfCVsUQJ65xMQ
 an1qcowtpi9BUyPKgkMsmPEbg8A4zm905/EGVobDHNUEBCV44x3UUcbLAqjTq6eaGByHWZGFH
 8iZapwft44rtfQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 8 Sep 2021, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This code is heavily indented and obscures the high level logic within
> the loop. Lets move it to its own function before modifying it in the
> next commit.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c | 38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 7f07cd00f3f..a248c886c27 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4254,6 +4254,27 @@ static int stopped_at_head(struct repository *r)
>
>  }
>
> +static int reread_todo_if_changed(struct repository *r,
> +				  struct todo_list *todo_list,
> +				  struct replay_opts *opts)
> +{
> +	struct stat st;
> +
> +	if (stat(get_todo_path(opts), &st)) {
> +		return error_errno(_("could not stat '%s'"),
> +				   get_todo_path(opts));
> +	} else if (match_stat_data(&todo_list->stat, &st)) {
> +		/* Reread the todo file if it has changed. */
> +		todo_list_release(todo_list);
> +		if (read_populate_todo(r, todo_list, opts))
> +			return -1; /* message was printed */
> +		/* `current` will be incremented on return */
> +		todo_list->current =3D -1;
> +	}
> +
> +	return 0;
> +}
> +
>  static const char rescheduled_advice[] =3D
>  N_("Could not execute the todo command\n"
>  "\n"
> @@ -4433,20 +4454,9 @@ static int pick_commits(struct repository *r,
>  							item->commit,
>  							arg, item->arg_len,
>  							opts, res, 0);
> -		} else if (is_rebase_i(opts) && check_todo && !res) {
> -			struct stat st;
> -
> -			if (stat(get_todo_path(opts), &st)) {
> -				res =3D error_errno(_("could not stat '%s'"),
> -						  get_todo_path(opts));
> -			} else if (match_stat_data(&todo_list->stat, &st)) {
> -				/* Reread the todo file if it has changed. */
> -				todo_list_release(todo_list);
> -				if (read_populate_todo(r, todo_list, opts))
> -					res =3D -1; /* message was printed */
> -				/* `current` will be incremented below */
> -				todo_list->current =3D -1;
> -			}
> +		} else if (is_rebase_i(opts) && check_todo && !res &&
> +			   reread_todo_if_changed(r, todo_list, opts)) {
> +			return -1;

It definitely looks like a good refactoring, but it does subtly change the
behavior. If the `todo` file could not be found, we previously continued
after printing out an error, but now we return with an error.

Likewise, if the `todo` file existed but had a parse error, we would
print that error _but continue_. This is definitely a bug, if you ask me.

Now, this might be a desirable change in the first place: if an `exec`
command removed the `todo` file, changes are that the user wanted to
abort, right? And the bug needs to be fixed, too.

It does need to be called out in the commit message, though.

Thank you,
Dscho

>  		}
>
>  		todo_list->current++;
> --
> gitgitgadget
>
>
