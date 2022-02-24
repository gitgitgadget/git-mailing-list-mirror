Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D51C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiBXQv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiBXQvy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:51:54 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022301986F8
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645721471;
        bh=KX2WN9d4FjnXltzCUoqLmO4spHlOawicpkz3ngcQUdo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UJN3X1DKeOnWKZCxez4NEMW/0EcCOcpvC+izsovKIQdhxqTsVXRDXKQfAhm/M7eKI
         OK13RAI+uxGV1Jc2hpilo0Mn/BdZ7M+eiM0eiVY4+zGIvWN6GlPhG0brB0gk5Zrs77
         xrE2JY7VdCI/Xb+XHJGxaVZiKlQZaXle3V1pzkI0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeMA-1nmbfe3b7s-00RZUK; Thu, 24
 Feb 2022 17:51:11 +0100
Date:   Thu, 24 Feb 2022 17:51:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 28/30] fsmonitor: force update index after large
 responses
In-Reply-To: <aec44a21afda7f058aca274dcb93c1eec442784a.1644612979.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202241749340.11118@tvgsbejvaqbjf.bet>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <aec44a21afda7f058aca274dcb93c1eec442784a.1644612979.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XVF/3lQhex9JLKWRf+A89nRylTAIGv09nSsyKV4pzIRPCTFEzgw
 oomqgbjJoKkPpjCkFzn5DcRDcY9kWNHfY7Vo7FA1JMDfJmeOMGvLAxMTZcUGWeSPgjS0xsL
 S6H6eIzboRYHkiZLWt/FMP+5k3VALRvdNZ8Fd+g95Ri08JJZwEwX0WOIV7KXwmXvnFuWDpf
 kISUQWGh0UW2BteFFd+IQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FlT/JKHwIaw=:P8+4K7ALHVXBeXVgZFmp0B
 CpC75AnifjMCsIRy6NNq1qhTpeB5K4bCnPuUkF9lKgxMy9sBODsyIgCtIqd6Tc+lkonFvnmdU
 NMoSBW4JaajtRbgwzIWkTZFEQVktmeTJoD/TFOu2H8LFyJ3Co74tP8RxwRFkmc6zrRHYS109P
 WqZ8VEm0/8LgeQAquU9Dg7uTyc9b/rJ0BVPYAVdz6TyjA/2d3165XMP8CAOqWdYZSIMw9uExc
 LvP+to/xaXoKJBRkTHzteVrnHYsrGfLrCVP72bulbzxJyaxUexfeVQsxKBQmKINoBXUiIS29W
 RiDeD6Ax99Wx+VB9Z1sge0pZV8cCm67T+EX3Ozn6ydVajVSryud2BBF6B8OMlx6uSZBm0WMJ6
 7af7AAGv2ri+MdnjXAyYcQtYvFXrv4J2Hfgb5AIjfV5ncENTaXNAFBbspFVMH9rAL3wqChGHd
 MkpxYBraIl22vl7sK860wHwiNIzAKDAciSSPbHC+kCjsc+WlvkeHoqQJpz/QHt+Bay0D9Meof
 x+7qSDGsHxiTcnvjN1k7v9NBcjggfGi6de9hjvIs5VZOQebBcIAGrVX7VncjR0stkksP7ZQZk
 doNdXz1+AyvR4JAeJYZLaswVfJS9BZ9jRiGa9FYdsXguWTT2LT04eey/AQkiM13dJHc/X7HGl
 nSuV75/Zdi7ZJFquOMaM/qiviGdpQVCSFBu4WHwO1/XMJfhlRTOlafNI6sPsBMyJbyr8/lzZB
 JFv1r3OgvSY1uyfk2MhMiwqHrWhsIBGhYFTEkd6xlPI8i/+LfcztCNOTSOq4roIICylk2i4Gb
 K+0wkSiD7r755nSTja31HvkzKSGLP9fLHS4rBN0LjP4RDvsANbAX0vUGf9r5fEaaz58XvSHer
 7ojeBnz5v9+SrZVl0SjAcAkJ86y9fKNr0keWsKXutCCjkKYtVj/hQgckPR+RBrdQp63HDYVzA
 AxSlspWpyxjOvJ2nlo64rM/RYTsnD6+nkQKACZAy4IwZZgYWQ+SX8U/8L6KgECsaId7Axi6FI
 KwuWCdnLpTNqn/rJAyZRsl7CYt5i/JHDe8LuzMhRV9jBPtydGd2n8Xi49GRPWu9XetrtrvGNm
 9Euvdv+5uQxqH8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:

> [...]
> + *
> + * NEEDSWORK: Does this need to be a config value?
> + */
> +static int fsmonitor_force_update_threshold = 100;
> +
>  void refresh_fsmonitor(struct index_state *istate)
>  {
>  	struct strbuf query_result = STRBUF_INIT;

We gave this ample opportunity to rise to a need, and no need arose, to
introduce a config option.

Therefore I am in favor of simply dropping the comment.

Ciao,
Dscho
