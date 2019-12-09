Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1660CC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 09:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDC92073D
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 09:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HZhGfZqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfLIJdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:33:39 -0500
Received: from mout.gmx.net ([212.227.15.18]:44965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbfLIJdi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 04:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575884015;
        bh=/wU3GfN5FmWabpZVtGUSdtPCP5xJRsSR//5Nm5ilUfs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HZhGfZqyhseQZsH7qjbCdGFOiJLoDb+rH1DmQz9Tifk9kPLjDLlIxhbNMJagg0WDa
         u3kmBEueDkszjKeXSAzE65m+SYYN1MyMEDEzHnSpGlzwfIi9UsP0NeCyPCaZOk4Sw5
         +a5/NvbuHNCca8IP7xRdlk1siBEKg+jaLuJcTvZ4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QsO-1hdEtd0bx8-011NyB; Mon, 09
 Dec 2019 10:33:35 +0100
Date:   Mon, 9 Dec 2019 10:33:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [Outreachy] [PATCH] bisect--helper: avoid free-after-use
In-Reply-To: <20191209084022.18650-1-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1912091030310.31080@tvgsbejvaqbjf.bet>
References: <20191209084022.18650-1-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ptaImewAMyHY2xN6LdqpnbhprTCuuLelKihc6TOYYX76hJHF0/Y
 PfyHbh/fNWD+OHqoUtAhYf8wGhu/LZlWi01aNF1IuPuUYIlgaiImXDP2E79zUOCzSy0vhsX
 rkdbA3+iVGDCJxUItsQFPv2DcbH5ZE9015HdzDwxGCcz3GI4AHggvu8xrdQ8DTGnG233Lp5
 Ro4AqyqHg4wQJzIG7Bdww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YC/TVsip/gI=:CXXQHdlP0Mj4GAlbpnrhAL
 Xb+SKdCNaNmHoyeneHTopsyoBuNJRJJvKqTSjffXNzPxW9w3zIjXit6hGNHiNIzkr2t6Bai45
 yFblf18veKxXLzucfZkouh4v2buR7/SI7ovb0X6toY4v2xjdYZKekSy/U3KZPO9eEZ+aDFFuJ
 Bc7lVQQssTQOFWwc6FwyeNSWpFe5+KXAaRPxn8MSum1Thdkm1emE2VxOcexfd1vmcZVCifZvr
 hN2+hn8eFIq+E10Is7YkPupJWkKR3/d5CvccxXDVpEejoBSABHOFaMa/y4/ma6hOeWLkwzdR/
 hjXXaSZ8/RrsBB1Lh/idPY6SuPWPDiisfUCiHugjUEy8eLg+JU7ztSsLSvawxaCle/5dX1lrn
 /rdt3guUywM+/EGLpqX11s5rlLou6BXGbNWxZJ+8kkGPOi8+YRn3n3A0Cq7dF/vYret7bCWfs
 s+5Ypa38TXP0I0bQuDrKysWU2tWgXocke1LSbYlWC/xE76qmL2kkvxwAPFvpStayMBBLaenbc
 MmoefUNXIxaxr6a6DavxEAvxzYcgjcWBt0BuTlcZZSLii0UzBNL8eCBIN4sFTh3OxTG7jZJqv
 +GQsNF9FC2FdoWXcHyvSlVe6jRvdatjmZYYDjoaRhRYlKL7RGLHG7eqCTMyRlQbvdh9Nkb7YQ
 Qr0qlg6aD4HtTjc43rtsqR9icQTZhPiBxp8jN2cq88VAX0hkQcl8J+4aZHlkWWEDoY4Tflsww
 IKutkHWPtPq6/9fEPdYps4+fKNpYj2qGM906i7LCt/DJif7BSZXFX3zonLrSzP7m8DgXHEYO5
 YkU/hr8HCBdYXQlFpGqt907GHdnCiIBtiJ0p7OritHjqqXtQxsLUu4OS1D76+2O5T7r46cfFi
 kB30ClMkSzzr9baQThJZVw8fQUWVJprk0nkLxnbRfEFhVUEOT3Kc0nlkAhI6LFKAJI6FfPEx7
 TlB2tDSEZFNjSZc90Q9fgesENhCAGsbUzv0qr1f2lZ26dKzSBJhoSpMY1jwpAJoQ5zRow41OT
 yjV0DfMVIw+Vz9ah1iIJ6AfybM/jcOsniksxUHdTRNJwqFZcCophlczxP5yd1Xs2G01Z+GCUl
 NqNqN/7YENG1MvqAE24C9SSv+uxBm12vjDCEZ217gdaWd2U6TE5z0CYeSmxGTDflRtVu4QxJw
 FnezyBBfO35vYgCSx/DzW5GNkr/rVopu1wkOJtyU9bkUFUCnzCskq584aNbjR+wWFrb+U5SYq
 KCWH5L3ctJuL8iqJmAyzM7RMcXLj70so37KgnoQDtw4xsHzEpDs5x+zKRNkc=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

just a little note on the process: the convention on the Git mailing list
is to use `[PATCH v2]`, `[PATCH v3]`, etc when sending revised patch
series. It is even available in `git format-patch`'s options: `-v 2` (see
https://git-scm.com/docs/git-format-patch#Documentation/git-format-patch.t=
xt--vltngt)

On Mon, 9 Dec 2019, Miriam Rubio wrote:

> From: Tanushree Tumane <tanushreetumane@gmail.com>
>
> In 5e82c3dd22a (bisect--helper: `bisect_reset` shell function in C,
> 2019-01-02), the `git bisect reset` subcommand was ported to C. When the
> call to `git checkout` failed, an error message was reported to the
> user.
>
> However, this error message used the `strbuf` that had just been
> released already. Let's switch that around: first use it, then release
> it.
>
> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---

ACK!

Thanks,
Dscho

>  builtin/bisect--helper.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 1fbe156e67..3055b2bb50 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -169,11 +169,12 @@ static int bisect_reset(const char *commit)
>
>  		argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
>  		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
> +			error(_("could not check out original"
> +				" HEAD '%s'. Try 'git bisect"
> +				" reset <commit>'."), branch.buf);
>  			strbuf_release(&branch);
>  			argv_array_clear(&argv);
> -			return error(_("could not check out original"
> -				       " HEAD '%s'. Try 'git bisect"
> -				       " reset <commit>'."), branch.buf);
> +			return -1;
>  		}
>  		argv_array_clear(&argv);
>  	}
> --
> 2.21.0 (Apple Git-122.2)
>
>
