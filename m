Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF88C4167B
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 17:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiL3RfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 12:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiL3RfS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 12:35:18 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3EE165A9
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 09:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672421708; bh=HyQgc15TMc0Xr9mpajE7PvH9aoxhtzjeILuUTWSRDOw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=avfVDk89P1ZZII8wG0jy3LvhqQBwIT/9aXRAPiC2elcxNyIyy/SQPqBJvKZM++Zov
         nhqyJ9utodnwqSFhj5i2iV5ODoAwcNIi2ivuM/ow/HoccxGrzaXic1RdZUOaW9BeDl
         SLK4/su6b4vZFR7H7QDF7qhxRJ5EQxYS8hD7LFA2Hgq0hdo4wFLyb9AVMrjY+E13uL
         hyGKjwdW+ky6iZfgipohsx0FEltrNnaHxSBks0UH/bvsWLpMTF0BEgfdsCx7TbdV5u
         zLbliDhr64ihtPbvH8SHbBxBhp7Yt2hj5UGyIn3VYhT7YQdtTk/RmEQ5LM6jnOc3VL
         Cl2oPiwl9+rxg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDv9a-1p1NfM1lA4-00APXs; Fri, 30
 Dec 2022 18:35:08 +0100
Message-ID: <efa1d3d9-03a8-6558-fdfa-ff2d776cdacb@web.de>
Date:   Fri, 30 Dec 2022 18:35:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 02/10] sequencer.c: split up sequencer_remove_state()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
 <patch-02.10-4994940a0a9-20221230T071741Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-02.10-4994940a0a9-20221230T071741Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i/BriRONLbmyEuNyHzQjeQaoNgwradFQ9k0DFQ6MKPRiGU2CGN0
 x2rse0z7aEW98pZgyyVLfRNPzKhNkezjRU5Km2uETXgVbWurfwkxDGaaNz0EBp8RpJBbRxb
 AHjY2xOQ8a7gn0RPkFLERtbTHEk+nWcBGfPjcttnB9uxyqsp4Ymenkg7ntOlBfALn9vfBvM
 xu3vksUnht9pGwzO9OOZQ==
UI-OutboundReport: notjunk:1;M01:P0:xHVrqevEMaw=;tTHu1y5H8h0yC/5eBtFzRNQqJDX
 Zr2QHIpXUctv5EzclHwBPniveGJbOOjdmaZBXjik1ToltZ+NYbCbScEtFVLG7ZAKual3u9Adg
 hO+XLoXceZO2n3GSaNlqGCyXIXgdPHrpm2y4YMJJ/9qBrGGo++klGmLXBGCwA6Ka/Zai7hQ65
 SCXugCsA/LIes79gHxNUTFyH2pT1QyI4XUhwRR7duFo4aWdjllcyTLO9LZs1dVxSyuwxC8fJA
 rkjPHX2giJDm8UZJu2FOqNq1jPvl/7fHkkfBGEomgkYghokYvlVGsGm61/puYWpTOcOH+9j59
 C274nCV/dQRB0M+JdKSAj34pDXtxv42VSolaQ4Fy0mYcb9cy35kK0EpbSonwZksufEMtd3jf8
 VHNMvT3thkG1KOUuhsgTyWx0a87d3mHw4DWRs1gvP3xS4WwDLsFl7zSmicmmR/MG7jF13rTLF
 sd91V4YwyypmnbfZF2FIjJT2QAJ49m/e9hkvhfC40A1/J/U9z/ouTISmWApRYaFbTCYYxg3BS
 N2U6W6wVUm71tjt4WqDTHsmywSz7EDUehxdXKQEcGo0coKa1GS2lTYNEvvjoF64YZCcGr7Rol
 qyGJOKD+Ty2LPUheizgsS2hsl+gq7OKZhrkUG4iCNryoD8wF2NNn5hAsDxSJVtVVockPMKZ/L
 qPb9TMg2eoqDJHONl6XniJGZzehAO3LwzUy4duWovWl0kyMhqypRX0O9EUhv/SQvoqqY719eb
 DvjLKLKH5V2aJsNnPgenf2uMlA/Vq4W/DgagzsdZfm2V8yHd+dizEyzej/uNhoOAp9qIFaT5J
 J4dn708gZlfAZf9L0hhqKdIuXVm5KMhv63lWirLl9Dy7KSGJfKUC9vGQmROjdOQQbrudAId/v
 qqZIj0rQttgMTGkYam6+nKBWRsUegHE03/kuhDTvI4b47PG3MKMFhiYglNx9ACyQEYRbcpN+R
 kWiujw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.12.22 um 08:28 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Split off the free()-ing in sequencer_remove_state() into a utility
> function, which will be adjusted and called independent of the other
> code in sequencer_remove_state() in a subsequent commit.
>
> The only functional changes here are:
>
>  * Changing the "int" to a "size_t", which is the correct type, as
>    "xopts_nr" is a "size_t".

Good, and you declare it in the for statement, which we can do now!

>
>  * Calling the free() before the "if (is_rebase_i(opts) && ...)",
>    which is OK, and makes a subsequent change smaller.

It's true that is_rebase_i() can be called after all that free()ing;
here is its definition:

	static inline int is_rebase_i(const struct replay_opts *opts)
	{
		return opts->action =3D=3D REPLAY_INTERACTIVE_REBASE;
	}

But why?  Making a subsequent change smaller is just a trivial fact if
you do a part if it earlier, but that in itself is not a valid reason
for the reordering.

And I can't find that patch -- sequencer_remove_state() is not touched
again in this series.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  sequencer.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index bcb662e23be..655ae9f1a72 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -351,10 +351,24 @@ static const char *gpg_sign_opt_quoted(struct repl=
ay_opts *opts)
>  	return buf.buf;
>  }
>
> +static void replay_opts_release(struct replay_opts *opts)
> +{
> +	free(opts->gpg_sign);
> +	free(opts->reflog_action);
> +	free(opts->default_strategy);
> +	free(opts->strategy);
> +	for (size_t i =3D 0; i < opts->xopts_nr; i++)
> +		free(opts->xopts[i]);
> +	free(opts->xopts);
> +	strbuf_release(&opts->current_fixups);
> +}
> +
>  int sequencer_remove_state(struct replay_opts *opts)
>  {
>  	struct strbuf buf =3D STRBUF_INIT;
> -	int i, ret =3D 0;
> +	int ret =3D 0;
> +
> +	replay_opts_release(opts);
>
>  	if (is_rebase_i(opts) &&
>  	    strbuf_read_file(&buf, rebase_path_refs_to_delete(), 0) > 0) {
> @@ -373,15 +387,6 @@ int sequencer_remove_state(struct replay_opts *opts=
)
>  		}
>  	}
>
> -	free(opts->gpg_sign);
> -	free(opts->reflog_action);
> -	free(opts->default_strategy);
> -	free(opts->strategy);
> -	for (i =3D 0; i < opts->xopts_nr; i++)
> -		free(opts->xopts[i]);
> -	free(opts->xopts);
> -	strbuf_release(&opts->current_fixups);
> -
>  	strbuf_reset(&buf);
>  	strbuf_addstr(&buf, get_dir(opts));
>  	if (remove_dir_recursively(&buf, 0))
