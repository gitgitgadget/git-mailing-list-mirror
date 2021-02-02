Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59E9C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 22:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87C864F66
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 22:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbhBBW5s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 17:57:48 -0500
Received: from mout.gmx.net ([212.227.17.21]:59045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235960AbhBBW5n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 17:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612306566;
        bh=bKpjoC5H8W+bbeoIFwXFXGxfvNhKYHtVM0WlxF61m5Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LNrRTx5qI5J4aubFyQEh4CpQaLwGyXJzw0QVGniGwtRa9rNqN7abdQ+3haoGSMEvC
         r3DR2BWu9OJDymj5waiOO4I0Kxc4x7dSoFuRIfBhcpuEaOqrpgGnFxt1Ugx9yXvmaD
         XQd81TJCFPI4LjCXLpPST1YS4OJug8blRfJHTKTI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([89.1.214.8]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAwXh-1lDQOF1QW9-00BHHB; Tue, 02
 Feb 2021 23:56:06 +0100
Date:   Tue, 2 Feb 2021 23:56:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 04/14] pkt-line: optionally skip the flush packet in
 write_packetized_from_buf()
In-Reply-To: <YBkf/KOv+YBZ5hQF@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2102022355590.54@tvgsbejvaqbjf.bet>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com> <pull.766.v2.git.1612208747.gitgitgadget@gmail.com> <0832f7d324da643d7a480111d693ff5559c2b7a7.1612208747.git.gitgitgadget@gmail.com> <YBkf/KOv+YBZ5hQF@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SBL2TZBHYzJbPRTjfUActUi8f+y5jLIyjYlCW/3K/zDsh9agTIA
 Hsc4Jpqo5ZrusvQ1JJLRTIMrPKzT6vkMw9E9slLny9iUhSJgYmmskoa/J3c+TQv/WwUs3zX
 OmwFXj7Ce5v9TnlDkx76zf4hY2c+Tjf9r04sviUv2zvdAOOeZw1o9q79TIMUwImmNxpJs2W
 bXTSXb2QB3gERriRR0ZeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hvvv23MCMG4=:/DSadMdqizQfVrJsqHjmkW
 2T0fdERgs0ZgG84Etz4qFfgvM3D1uZ0Ke+xrNNmnZBaozQ9YKl0+xLL8NdvCoo+RmIsrmioq0
 TGTu3Xd6TrDfFXNSaWPymVJDsxCHoNGzCMti+EVoVS6GspnS/4kDNT8umAD8Pvg4EcQYYiDZf
 rj0lwoZoQBTybwArClI1r9Nu90J+gueMqoszQRokUi02U+/EfAKkI6RApntIbYjtQQ9jOnEsO
 yWITNqI26RVDSzPKlxpvwyc8forq8s28KjsFOsim6u1kuU89jDgNC35Vz65eUldM2U1w0isVq
 1fAh1hnkZyTiTjQAuXhqzNeztvU+jCAArJKFyNVZd28HcsNF8tk0plL8enRvxzlngAFiPQ7Ai
 bffa0SIyTo4tfqEncVTPIvEkLqVILD1FeQ41WXVlAvf9TZU4q0JuhsjfnWOgJddWYujE8rzeV
 gVv9bTv63dzCAKIOwGgC9lXt48VUA7kfuDvYnDN7GgVVmgvO9ZwUfAZU5GEwCSZ5FD5zoBcKJ
 dvggna5DYZs+uhXnaV88blWUTVcvXRLGAurV/Avr771WIUANQ2qUaoA3BS0DuPzs628kO0CCe
 7wCV2lqtkHXn5vltR90P6SUnnGKU8xaz64RaMr4J0LtLgxrCF8iJ4Dp8DIyUHwIqzVH3LHh6f
 64LGEvbbhLmwFk0fOrx8XrSMGez3ALsaU9pIzQxguPpKUpAm8NhBB5zEfy0NG/qBHSDEv2fTr
 L7W2BY+qsCyHAgRRYKRRgdnOuYSLkFbLmc/JtkTi4EUgl3z+CPqEHn3cMuqmSUpett4/By8P4
 EToMnZD83yqgJm/yxSBmxNk4dQ9943TV+epaGTpinFznobC3Ako72i0GdP4OtvGB4nWMXgcDI
 s1+LpjVEE2Oez5YmjUu1vF3w33GAT/Nf5K/TfarEE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,


On Tue, 2 Feb 2021, Jeff King wrote:

> On Mon, Feb 01, 2021 at 07:45:37PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This function currently has only one caller: `apply_multi_file_filter(=
)`
> > in `convert.c`. That caller wants a flush packet to be written after
> > writing the payload.
> >
> > However, we are about to introduce a user that wants to write many
> > packets before a final flush packet, so let's extend this function to
> > prepare for that scenario.
>
> I think this is a sign that the function is not very well-designed in
> the first place. It seems like the code would be easier to understand
> overall if that caller just explicitly did the flush itself. It even
> already does so in other cases!
>
> Something like (untested):

Fine by me.

Thanks,
Dscho

>
>  convert.c  | 4 ++++
>  pkt-line.c | 4 ----
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/convert.c b/convert.c
> index ee360c2f07..3968ac37b9 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -890,6 +890,10 @@ static int apply_multi_file_filter(const char *path=
, const char *src, size_t len
>  	if (err)
>  		goto done;
>
> +	err =3D packet_flush_gently(process->in);
> +	if (err)
> +		goto done;
> +
>  	err =3D subprocess_read_status(process->out, &filter_status);
>  	if (err)
>  		goto done;
> diff --git a/pkt-line.c b/pkt-line.c
> index d633005ef7..014520a9c2 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -256,8 +256,6 @@ int write_packetized_from_fd(int fd_in, int fd_out)
>  			break;
>  		err =3D packet_write_gently(fd_out, buf, bytes_to_write);
>  	}
> -	if (!err)
> -		err =3D packet_flush_gently(fd_out);
>  	return err;
>  }
>
> @@ -277,8 +275,6 @@ int write_packetized_from_buf(const char *src_in, si=
ze_t len, int fd_out)
>  		err =3D packet_write_gently(fd_out, src_in + bytes_written, bytes_to_=
write);
>  		bytes_written +=3D bytes_to_write;
>  	}
> -	if (!err)
> -		err =3D packet_flush_gently(fd_out);
>  	return err;
>  }
>
>
> -Peff
>
