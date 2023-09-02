Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEC2CA0FFC
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 06:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351652AbjIBGU5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 02:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjIBGU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 02:20:56 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C679D10FB
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 23:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1693635644; x=1694240444; i=l.s.r@web.de;
 bh=lmJNiWixoAmM0y0l4JtljxEVY/aFgRxpJVvh7vsRGBk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=mzuu53gZPSddpTWkL1YHN6CQ7FdHBQSXQcvTxd5pqy5iTSEKdAkhAadg/L846TIxvxGxBxJ
 bMm25zMmwfTq08A1mZR1zex1CkRVpYaygigpQWCafg2AxNNLrBjDl8bUFRnauKL33djeoGOn7
 ZsE+7C6+dd+L86XWtRRQVf1RX5ksXftSN2dzxD0L7xCuPtE2JLRM2GgKmy/5OyU4Lwrt0l0r8
 wbH46lBNon85yJKrC1QPSvwNRR2yvbE+ryTUVBa3A3Ot/mQnGWl8KuCri825zJhxOb88Ewhzl
 gkb0CJTAbZ4TF3Rn0OquOuuAx2CeFOGpzlQg70Z9AKETjRl1Yx9A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.152.246]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MmQYd-1puUv71wBN-00iWeL; Sat, 02
 Sep 2023 08:20:44 +0200
Message-ID: <c7855b08-46ee-5df0-4b0f-67ea57d84b18@web.de>
Date:   Sat, 2 Sep 2023 08:20:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 04/10] checkout-index: delay automatic setting of
 to_tempfile
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20230831211637.GA949188@coredump.intra.peff.net>
 <20230831212051.GD949469@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230831212051.GD949469@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wkoZAVV2UD1H5/RpBx1nFK4bClKwa9UqAB707nH7eiqAoiHr2Co
 jqHnTER3bwaElf1AKcHEVuh4cFZGOTKAI8Zy8bkobbu3TPe6ImL1CjWn5cFYnLHlf4v+huD
 14up1ql5LM9vCHVMh0GeY/IfFkTqM5vDfmYyHqGGvzLb0VShYqzjBx0eF2z9kqBNN1G5fvY
 SnmpIszsZq7+EDeHga46w==
UI-OutboundReport: notjunk:1;M01:P0:jEu4OvPPBTc=;WHejJlCwJtyK6wx495/+DVJxz+g
 xz6Qu2sxNiO4FzxrzXWdcTHW1OQNZ59W+Le4oOpXJ4jIhuHB5xZ/KXTaPLAuuku7x87MrhTjU
 WiY0Zy42BmE6S+9pKy7q46p8vVStiRS/+P/E1WFD6nQfXGi9mdlCOa8aBifCg6d3vSJmGChuF
 rPVJRfz9ZzGKtLQF9sqTsbrmhMrKCC71tY+pEaGl1IvQhqMy9FjaIwewTYJNZnvrwa1Q/WV4L
 Lr1v5RpM0XoLN0Nf9zP62Q8B2hBBNw2sKkuNhsUzQrGoW9vtd3Pmb08rob4eofW6TyzPQ9a96
 aJbWUxu+DVBeM/6HVFKeSui5/rp19emlC0iFkYCmHV/HSmKHeU3AffM8lQYz+L6E/FVB8ft8n
 /Hl62/xp9KKEhRsCu/XgFdic48p7ajjk+p1et3TOQUKi04PQpk60GUs8IAOZzlMrOuj9R/zZu
 trxB87B/gz6VoJLznYKd7YVwaWB/1SxfrMTbaxyjK93u+ynS5H6nDawCdQ03MSc3s1eBhJb7H
 WVaQZ5/CsBAozxdNAgbhCwRaRcRIQ/4c7Dmjq4kKDFz0gQw9c1NRVXjIOn0jg8HgnJWDHIaUi
 Q3I/yW4hPb/wCb0YlrptkzEg+PVMhv3qrOCPrqZ6iw9+DWVbQkNfBEqkPCU/Y5t3nO1xqhA2o
 UvqOmuI6Nu+TLA8XSVmz/FlREFDVj3DKbIYqA7Nt4Pg7sUosbAWw/PBvCZuoVoRvaxJGyw8Z8
 7en91bL5aMSpd78E9ht8K3CeDqvCbLZ098IAt+egmyHBnycBV2zFd8VBKMRj1L+kLDemUT+Wg
 j4Ck6qR8Qw4ZYW8qT4VZ3lCJ17PytjdDbM/tbdpdd1Q/XU2jIMd1wDr6UEUkGkhIsMOlqFYvR
 pkSfarIHSSewufrhHZAMeD2oghV2A17MczuQebkRXiMPGxuOQYaCjqQcJkamBhy4V1WhS6LxS
 PoToDveBDcxG4b1mrnPmUj/mpHk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.08.23 um 23:20 schrieb Jeff King:
> @@ -269,6 +268,11 @@ int cmd_checkout_index(int argc, const char **argv,=
 const char *prefix)
>  		state.base_dir =3D "";
>  	state.base_dir_len =3D strlen(state.base_dir);
>
> +	if (to_tempfile < 0)
> +		to_tempfile =3D (checkout_stage =3D=3D CHECKOUT_ALL);
> +	if (!to_tempfile && checkout_stage =3D=3D CHECKOUT_ALL)
> +		die("--stage=3Dall and --no-temp are incompatible");

How about making this message translatable from the start and following
the convention from 12909b6b8a (i18n: turn "options are incompatible"
into "cannot be used together", 2022-01-05) to reuse the existing
translations?

Ren=C3=A9
