Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630B2C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 14:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E7F56112F
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 14:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhKJOgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 09:36:41 -0500
Received: from mout.gmx.net ([212.227.15.15]:39563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231703AbhKJOgl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 09:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636554815;
        bh=dvMSxqKU7lBxZiAmLNF9Z0/lvR3jBEI48QS+YtqjFyk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jFtAJSdxukeTcURDKlXvnbEnL1zUKd6p4yaFaEFlzLzGKHQtIW9IEKEipQODoR8iK
         p2Ul44mJEUCLUJkBB4Q5pNW3CGKeJ7bFv/PJJ00yjd9W6lgVJWG2W/Ivy4WcaJaXVC
         6a8oPFqiWywUVbOUAVBr4/o2bFWLrGPhrjHBefAw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.212.10]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MS3ir-1n89Mj45lL-00TTWD; Wed, 10
 Nov 2021 15:33:35 +0100
Date:   Wed, 10 Nov 2021 15:33:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Patrick Steinhardt <ps@pks.im>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 1/3] wrapper: handle EINTR in `git_fsync()`
In-Reply-To: <0c8e98295e91b656a89e1db53bfe02e7c7fc8432.1636544377.git.ps@pks.im>
Message-ID: <nycvar.QRO.7.76.6.2111101530490.21127@tvgsbejvaqbjf.bet>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im> <cover.1636544377.git.ps@pks.im> <0c8e98295e91b656a89e1db53bfe02e7c7fc8432.1636544377.git.ps@pks.im>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4J5iSIpJzQ3zKCNsqnaXn07vTZkWcOWxOKQ2N8XuTmC+k3tGIA8
 0/mtrft6hZl/1GquzPpoAizWFEfo8eS+UyJapXZJhyF7H8SZGZO8rOuERO1hv6BeeZkUzLM
 3j/DQydBYM92h/tL20yB1iF0QTdcsluMRUFq2bL+z8ywUHHCfRQZlN96cD2vx7HR5C0KS2C
 yAu7FwKPuvG42tbIcroRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iBLR5imn3zw=:vNTtJuzrzSKRREdskSwN39
 tQ4d5t5rMN4PzMy1ik3KZdeaKYjQNko7icRmQWPXMN3pcF7q8Z+ehjO0lmDLi+grheczXLTtY
 0XG5U2kRXuzjPkOWrUCU2/ksu3LKr+irKmVal4B/HXH5e0/wBLg1TmfppLoJFH3q2pVhca8Pj
 GSOSLJ2HFvMasvlYBEhwQdjcySC4orttWEMkERCcbtUOr9UzkZYg4R7q9jHfN6NvOtb5RGjQt
 OqaeClmC72Ic6HkUUX4sv2HvOTxzr9YFrZ6EDudNzJ74ivD/UYm6HVPDWL6FH77k4ZcA9OR3m
 PD6sHJlUXfBgQymS93fZ3FqarvYJzc9kruTZjRQot9nRtMLTbxWk4HbNhtVn7vAzfbvaqqTE7
 NBoBJ70W3Qj9/+SMvP2sz+DT9kYb6BHDsRtw9624STYbn53OL/VJnqj71SaVrVFupihKU8NV8
 C+Ebh8bZd/ncULDyqmXqTIDXUfRK/m9Xc08xp8S7etbl6Ax9Ptky76DwtfVg8KaJVY890+p8L
 HvSCblioH8ytfHAS7uUMwII0nSsPle+iPpw3Y44bQwyIXfsogF6v9kHAgEUTq7K3/4cvLL0yK
 bt7cDP+Jc47RmNr7gCgEJRGNmUkOm3riY3TxVMsOphj8614xp4eRN2bk4e5cDGMihAl3yDD2e
 zbXI5PAGn16Q0n3W8jgWroGrm6feD/WB9q6b55OlxJvLq5YaRxeMfuu9Zhf2nDugsnCspY+4q
 1ILAQwyaqmSKI61oGrX9FLDUEPDpOv2yze1aNYcqy+tMcEatiwNh6RcpXtfmXfwNapCB8zJct
 Z5MwnxiqsPbT1//n7ecesvgCYdG+q00jQaEn0xfBF10kTQUfs8HGd3DURN9r9kLQQNxT4X4RS
 Nkj09qJ0p3ga7IG1Oq26a4el7hh+KpKuGXarsldVHr7PZhO9LxWokwegIbQ0FOEVEiUFN+ytD
 d0NL8scldJ1xJFRk/tpO2MjrelI+ATvDEQwDxPHOXwMNUENV/xU3KRZw4tquJ/iZKMAp+Pr6i
 HXWYZYS6MlLuRN8biRqbB0LZyEY28piHiW/DjHDkE2tnUJIwFWPNksq36dSDwkpAMCv2kKPc9
 XMIlZUB+xvZRRo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Patrick,

just one observation, below.

On Wed, 10 Nov 2021, Patrick Steinhardt wrote:

> diff --git a/wrapper.c b/wrapper.c
> index ece3d2ca10..e20df4f3a6 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -546,7 +546,7 @@ int xmkstemp_mode(char *filename_template, int mode)
>  	return fd;
>  }
>
> -int git_fsync(int fd, enum fsync_action action)
> +static int git_fsync_once(int fd, enum fsync_action action)
>  {
>  	switch (action) {
>  	case FSYNC_WRITEOUT_ONLY:
> @@ -591,7 +591,14 @@ int git_fsync(int fd, enum fsync_action action)
>  	default:
>  		BUG("unexpected git_fsync(%d) call", action);
>  	}
> +}
>
> +int git_fsync(int fd, enum fsync_action action)
> +{
> +	while (git_fsync_once(fd, action) < 0)
> +		if (errno !=3D EINTR)
> +			return -1;
> +	return 0;
>  }

My immediate reaction was: why not fold `git_fsync_once()` into
`git_fsync()`?

And then I had a look at the function (which is sadly not in the diff
context of this email, one of the occasions when I would prefer a proper
UI for reviewing), and I agree that indenting the code even one level
would make it harder to read.

All this is to say: I agree with the approach you took here.

Ciao,
Dscho
