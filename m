Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08666C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 15:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC46613B4
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 15:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhFEPcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 11:32:02 -0400
Received: from mout.web.de ([212.227.17.12]:37079 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhFEPcA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 11:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1622907007;
        bh=NUI3WkhHGYCjh4m6mVcfKLLllxP3IItASRhj1AlejfI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=auuSeHnhWVrmJ7antp863KR5loN/LXZvwWV3ZFRfbHf7U6s02FBYpQpdkRT6w1R7J
         /lc+VKqLLYYyQc0hg0Iq6zsxz+WI5oVKYxFnwhz1JEqveY6Aj0NmyI1zLrblSiiPkj
         XUXemUd8W6bz7eL5Ix4WD6cplk0WvsIVXGQpx9CI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MovjQ-1l1Nlx30O6-00qVHe; Sat, 05 Jun 2021 17:30:07 +0200
Subject: Re: [PATCH] parallel-checkout: use grep -c to count workers in tests
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <eb4bcd4c-e6d2-cbeb-8951-cf22b9d3d5fe@web.de>
 <CAHd-oW7f0rfRaTyvJJMt7uNiLS4F9c=D3oKYc5v+unzxPPxjCw@mail.gmail.com>
 <a946daaa-6aa8-8527-5b55-ccf86de2a9d7@web.de>
Message-ID: <eb8e938f-1308-6200-5484-e009f6e4c625@web.de>
Date:   Sat, 5 Jun 2021 17:30:06 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a946daaa-6aa8-8527-5b55-ccf86de2a9d7@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vj4pSuPTvrMdmnG5jBCO/3vN+XqTAicdcNXwIkbNJOBAVRRVKUv
 MfSFseWDTqdv0Bbv6xVIesrrZrMZYxvpVoNGNT6RstWwIdy56eh0yRMp7B/637jlpq+4iQ+
 yoabejjW4AWehPbwnA4u5g0/tJ9Aqkx2gBnMMXCxavSQKe9ZgYw+yVCjMPTSwqjUFi3lxwC
 ZrTpLmb5cSbUAjUMMj+wA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bWb2dLbq+zU=:mE750596rOSIZZe9OHOd1e
 NIn/zYYDMhd6Pup5Y5YK08O/NY3uQGtIVtlmENXjr/EXr1XUoYQOnflHHVsAZFv3dTxuCWZ8D
 ec4GJyXcUo+Us3bhTtLi7962Klvzl33UkAXGZ3QytjC1+z88mX7C+bv3u/rZRM3bTKHM6UN6U
 FDpYuIDAQPYtUCV0Up/751pSjqowBbZPyyKbB0rSNrBZT3NfoI1RDpsBHLZh7CvBvoigmpfSe
 kIFolrMskbb9lAD+dSz4iz38fSrPG4LS8KsM4q7HYNr5e7rwVEshE1MBZU7CDoYWqFaV2YoAP
 65LuyjEmEvUTKiXxRBrrI3OUbrzlZQfwiQsM/sqsFeCZQeoA1CeoKKvPD2lTnwM1yWx0sQ15X
 dgqmLY83ph2K/4LmGPgzO65/0c+KWLnPF5ZEcK8TxlL/ca3Nc1b+ftez4odqDN/wl245jYzbh
 A4xP0voDImcE/8tT+qRRm9oCZGdMGK/JxiER+GgBYh2k6iCBDbMSLL0nKyeIstt85frpTGVs1
 KvSqg91I7dUVIrJXdJ9wl4LHJdEjHNG/SHeBwHQ1W02Sv/UmGNk3xyv6Avpm7cJqW4EGrBt6+
 1wEXWu30AjkkzDZirj/t9raZmSr2IDcAcGjdXiX/T0FSNdsGu4wVu/AU9PyMSWTUtFdH+qy7f
 W/pbchpP85NRSZNHzazrGhCN3HG6adlNXZand8CFGTPOnqVbU/kxR/719/iHXIfQqY6Pl2uHq
 4Pi0g3TwHu2v50Y7RKKoOnDGUpXk5fi8mpZyDIT//6idzcx6u7XQ7kzy8D6DZ2xpCz/ivy1h9
 WUmnM9nOyM+pDFN7fE7D5kVADc9PhyTFVYFIi9uRzBygDqOe2ppcNrmlHaJ3xNBRL9zJOfYZV
 yVI+nDer0u/NVDGvgfuUtxVJnrUe9IluzEuqtJRB3alFTM6ho+U5cL67UsoaT+1YmuvSkJ5g0
 +X7bb5i5eFHO8D6Ax/OPpA6//xzCr42scKWQbtw0a6OLF7m9nzWc/sdmEBFOSYpH4+clw3HLF
 Ds8XHCYPytu7D0xcsmNUkkDKzXtSgC8M1fWdvcsiQYzabEU/nL1r1ET6XLCh4fAv4a739f6FM
 SQuf8AQ/t8XyjprCihj7L2XPMEDoDr7z29r
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.06.21 um 17:20 schrieb Ren=C3=A9 Scharfe:
> Am 05.06.21 um 16:31 schrieb Matheus Tavares Bernardino:
>> On Sat, Jun 5, 2021 at 9:27 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>> Just one
>> minor nit: I think we could drop the redirection as grep can take the
>> file name as an argument.
>
> I'm not sure if there's a grep out there that prints the filename before
> the count even if it deals with a single file.  git grep does that, at
> least.  POSIX[3] implies the lack of filename prefix for the single file
> case, but I don't know if we can rely on that everywhere.
>
> [3] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html

Except we got plenty of "grep -c" calls with a single filename and no
redirection in t/ already.  Adding one more should be fine.

Ren=C3=A9
