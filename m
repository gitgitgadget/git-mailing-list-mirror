Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B32ECAAA1
	for <git@archiver.kernel.org>; Sun, 23 Oct 2022 20:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJWUHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Oct 2022 16:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJWUHh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2022 16:07:37 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CDE5C940
        for <git@vger.kernel.org>; Sun, 23 Oct 2022 13:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666555654; bh=f8cdcTIPc54W8KBhJtkvp9LuMG2pte8TIMr+Jl5Om8w=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=eXsULCMEMt1nzNDQmXObMabsQIzxAlxNzYBN42lpXDVouomjZCyu+BYYnGzsWOsQZ
         EjChlmDHgEVoE61lo8Go4hjgqhBeqlZQU8XmWl01yx4YwJ2brDqg3xbnq1nVjwwZoG
         jWBv/XE7/KRs5/ok+ujyNrVkrwNFj8VTniTWACILdxWdonb20pBkP+H1vTjWFUlu6v
         n/ilWSiueMYgN852s7YQfI/RI8m/j1dP/4oV8CAQVnla7cgcQQTDMrEKtWYs18McPC
         SaJmIDQ1Xsu46a37nKFhO/jMnN/I36giQECde+OoF/tmXUhZW9jjuDKkCU9kJdOgE3
         HeOq19F7+hHXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBB3s-1oxAVF1y5G-00D4RW; Sun, 23
 Oct 2022 22:02:23 +0200
Date:   Sun, 23 Oct 2022 22:02:22 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, alexander.s.m@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v5 1/1] diff.c: When appropriate, use utf8_strwidth()
Message-ID: <20221023200222.o6p7d6qor5sygdgb@tb-raspi4>
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
 <20220914151333.3309-1-tboegi@web.de>
 <xmqqpmfx52qj.fsf@gitster.g>
 <20220926184308.5oaaoopod36igq6i@tb-raspi4>
 <xmqq35bv1gu5.fsf@gitster.g>
 <20221020154608.jndql5sio3jyii3z@tb-raspi4>
 <xmqqy1tas85w.fsf@gitster.g>
 <20221021151909.z3nejpnnt2wmmkry@tb-raspi4>
 <xmqq35bgkfde.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqq35bgkfde.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:KWTGT/CMqoB0IykMG1GUxYEuY2Jd6DeVYBiEIuGYIDh+uWLop4C
 P6u80xH6L6ZskTDVsPjwDmaBBWeyc773RLH8lfzB4eUbOi5NYYH/a4UkPHJvIXo33bn//Ev
 BD63uTWKX5OjLhwx0yaD01L83BsiqkX0goTFori6YwhhmapnGTw5T1Rk8rXAFl5ZU5moFR+
 3LkBy7jb8nQtHEpVlDqBw==
UI-OutboundReport: notjunk:1;M01:P0:/tmgnK+LWY8=;VZGMdfU2TcSu161znUWWgpNmaTy
 Kp2R/r6QEr7z0akadn3mUc7nWTn7rx7QM8zqMEvnwRotmcv2QylQ3IPGnl6Ty5ILdjTvuoupG
 ZAcgIv8ydDzI559CBYK1nBPUfXWsUbav7Pd8JWRg1TuOFkKLyEbHwmGMTcHsfXaC14PRwwqW3
 E9DfWtwD0CesDU+RJzZPtWPYVO1CEL+bqGXBNrhbihPmPKN25srZOsAWPSk62Yxp2XUq8Pfpy
 8Xk8ctJq+R4m7A/Hb6K6YxEMDTUbN7uhtWnNkJn1xnRB5KI2V8Iz2jOoB3vXwlvZfIOZ11lMU
 PyD47bg+dhQDdDhD2kZjM1lhECwxVDjDBKMYgpAcriSJSqnQAykDLd07nwsxYUy5iNdE79KP7
 Q9yLFF0IEeC/lefv1VILTqqqnMnL7EWJjOiAbVztTUo6czCAle4UZanqFNFZ492X/25CrGVPS
 bo2J45a4N8KfkmNn4Ye5c7e7CJFo4zkfpeaR+tYMf7E3+oysQIf5xhno78t4AbzL0Wy7rgQVn
 uKUK/4ZeZWauDGWmUtTffffkfFUC+ZsyMNtM1XQbnN+w23p8cSAYGyBbp07+3WXCnilmMZ5gL
 rJywC4JJxc86ta3nyRGlxI3oax1beJFEnwwu70bOwQhs73DgzdzyEVjmN7Lmd+zTEyRfL/xOX
 52gouRvGOfbbBk8dDle5FXZcaiT9nWPI4JftvPspnWjWcmltcNg01Zwe7IbvpxovXqAYwUT7A
 xdXJ6rHQdvlR7u7NcQMYVGRy67breCS4VRrLtoTKttX43cR/E4mGVD032PrWs9i3rLmO3eIBC
 puoOoUPeNNNzyyjMeyd5zGD5/o0VUVpFRglBywVnE52NO2yg1GtT0GXTxkWPYuYy4YZ3UzqdD
 dHkoTzrLBkxswhMSplXGGDjrLiW6mMgIfrWaAmbXvhjns9IVBmvIgh8aZOFxMe0PU/EG5ov9+
 2deGcbQOdbfVUk1YMF+IyufzDq4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 02:59:09PM -0700, Junio C Hamano wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>
> > For the moment I don't have any spare time to spend on Git.
> > All your comments are noted, and I hope to get time to address them la=
ter.
> > If you kick out the branch from seen and the whats cooking list,
> > that would be fine with me.
>
> I'd rather not waste the efforts so far.  I am tempted to queue the
> following on top or squash it in.
>
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: [PATCH] diff: leave NEEDWORK notes in show_stats() function
>
> The previous step made an attempt to correctly compute display
> columns allocated and padded different parts of diffstat output.
> There are at least two known codepaths in the function that still
> mixes up display widths and byte length that need to be fixed.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  diff.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/diff.c b/diff.c
> index 2751cae131..1d222d87b2 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2675,6 +2675,11 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
>  	 * making the line longer than the maximum width.
>  	 */
>
> +	/*
> +	 * NEEDSWORK: line_prefix is often used for "log --graph" output
> +	 * and contains ANSI-colored string.  utf8_strnwidth() should be
> +	 * used to correctly count the display width instead of strlen().
> +	 */
>  	if (options->stat_width =3D=3D -1)
>  		width =3D term_columns() - strlen(line_prefix);
>  	else
> @@ -2750,6 +2755,16 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
>  			char *slash;
>  			prefix =3D "...";
>  			len -=3D 3;
> +			/*
> +			 * NEEDSWORK: (name_len - len) counts the display
> +			 * width, which would be shorter than the byte
> +			 * length of the corresponding substring.
> +			 * Advancing "name" by that number of bytes does
> +			 * *NOT* skip over that many columns, so it is
> +			 * very likely that chomping the pathname at the
> +			 * slash we will find starting from "name" will
> +			 * leave the resulting string still too long.
> +			 */
>  			name +=3D name_len - len;
>  			slash =3D strchr(name, '/');
>  			if (slash)


That looks good to me -
my preferred version would be a patch on it's own on top.
