Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346EEC433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 19:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiJNTWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 15:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiJNTWd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 15:22:33 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A25A1B6C87
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 12:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1665775293; bh=ejDipqeaNrfgbJkYE5yDFhpVn9z+oGXRGPXovKEfV4E=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=G9BuQ0Pn9TLZPq2UGt6q2GAf+/5nrj1gsOIAvGdWycra3ZdmeCcw4hxkZXmI12iGI
         beZtID9GHaFP+IAX2WAPjm1ob+bWfQLHG6VWhg+dj8VDnEG7yJRVWZlya6jq7L41he
         9IWebs1dJnWfFqyM9+CYPuLj+hCmuQbSOKjyO+MqLO12Fst+RXU30G6hDVcB1AvjQP
         bQp8TVEOAvugNa79TYaoxsxiooRfXmzHb1Gog4yHUXWilylqyHndMjULHLoB1dE9SB
         lrYxoisAKUzRrLg/OSZMV2WtFq1O/C5PlQkHUhBbH3e94SiD7LZAMegKjvYnc4MtEz
         L4hVE1N2ZaXIQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.161]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOUtg-1oVj8t1sEg-00QODx; Fri, 14
 Oct 2022 21:21:33 +0200
Message-ID: <2afd907d-5d9c-4968-901a-e88e3c0d4729@web.de>
Date:   Fri, 14 Oct 2022 21:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH 10/10] run-command API: add and use a run_command_sv_opt()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
 <patch-10.10-874cb72c2f4-20221014T153426Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-10.10-874cb72c2f4-20221014T153426Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KfWZ7Zn5HpzQtKuoxDv43+L83ndNjJiEnZRL28rpqFT949gymAi
 9AbOhVgtDmC1wwZKoWshWMzxZeTeaKaC4BBJ7eYxtHDA2Mf+6U4YpnHXKYd1jzXdNLXivpc
 1qpKMreh/DGxB0RXlY7hT8ZucgzHxNgzk/TP4uCzLQbdUElwcDbPWlEesuwgDMFi3Nzsz5X
 mzfYUcg0pcM73LVuni9gA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5TMrxjB+kis=:8pczPAWYvqDqAYkuRAycrL
 WIhGAbug2vgtQzvEmUFIdF4b2EwHf51UsO05nzS5ws7QJxiCfbzCvarurtf31rymrQHcNHDEp
 2cH5HK/XT3DqfRW8+wmg1AfTWGB+ub4I3raAk9cgqjf5f/GnRTSNKBVTOkGdQdNURbt5vDwuX
 R76znuNaNL6GxCuqczf+hHHoSfyq0yys7KIBYjl/sbU5Z2ufXDegwCMPpBmhBypobt9Myg8ZZ
 rwjkUVSsLjPIlAwD0inmcF1gUq4LYDI45QOSoGiQuGI4rheEbKEwTFZqNuDS03k6bJ9vXydKJ
 exAf+R2wGTzfgPIfA2sCFA0DJwQicSvgibYdbrHCghmjQ/BGyC4gsX+jUYh2MraDLfo5ES3TQ
 E72Jt091SRDd/BT9Ho4DH4QDnZBUEBNjyNRS++bus+siB/rUfJ5FhqOjoigfcz72RBoHnZd11
 EU4Lw5WUm+Vqm5eghz39mZ6OxWP8cQLNvfPfdyUXBHhsz2gLibqwQM9gT4LfEHPG+daVuXs2n
 kg24soD4JCDOrnT0Jq8CgAR9EspH3uhBpZdw4yW7/Xs9PfKOcdnru0/MonB8ZT0EpmCm9aXlR
 BKNFoHS8QSVY3Qb9UGAxdgdR1nYKQfcn+8IIIogvJ9b9YE1rESIWslCcRRi6P1FKcNXQYAbFs
 J/36NuxSsKhz/atWGGtdABjW00+egpEz+xPM9ll06wQJUkMycerhT15dnkup9P6tgGXlb3iUq
 63lJIofMLCzgnAUDYs5NXVW5px3VObhR0g2XK8Z6zlvVLTos8YTVYYyd+rEWzQjwjdqbU0jXi
 TwJ9KX99OluWi351m/nI4uF5B4uzXhNafq2SQ6LyB5J5LlSWMZ4qf7XWeRUD1Luh8mm6v4yP4
 hYll3KHtRq79O0DJfV4bZ3F6cBXdH4Fe+GGkNAkdPOcE33Y6TByz/m9dbJD8c8k+5HaF0ABSB
 FD8ApnsQcByJMACz3op+1EBfKQWMq1RMrf+SDcGL/emik4rTCbtTaes+B4ZmfEGamjQWYslm6
 bAe0AZQUIFUVkAhSuHuBkaZmoYevFBE/c1rLn+2PHZwROTKSxZBlba47/DoMSi5/58UMkwXQE
 apSeIF7lUeNuNWfMmC0XI7PPXzOkLQRBHC2MsfRGwXPIZJX+iM+Z3H0EjuPyA90Wqpcu68H8l
 KCYFA/dLJs6NUwqHWJu5pDuZn8eJIFEiPNLLCql5OYAY9qBheeIwn1smL9hdkhHYF8oEa8dSq
 77qOQ9gvBnvzlth+YIpO95HQTo1JXyRuEZz41+mBCbZNws2eBROZdb+oHe1xC/c2VQqg1GAW3
 NTYX+hMhCAQZYxWSa9CkgVUo4lopI7Who9143qoIuroFplQOKv/uH9G1P7NvBMRyrZccGEktG
 gUK5el9rw/Ix82AkFLl4ohLAfFB3XIqSFwqMMHWv2nj0z6fZI7Pm2sWvHpi99ys8BZb9870VU
 ffr61dCiI+omAyLGpRklxHiPSb/f7Uv2BrmRdnMmNOaWdXQNKa4f7k3NvY6dgi1Pn/23J/dAD
 2CJqdsArCAtcjDVgbqPJConisqhhMbLMhKnEin1L2mzGQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.10.22 um 17:40 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Add a run_command_sv_opt() convenience wrapper for
> run_command_v_opt(), as noted in the API documentation this is for the
> common case of wanting to construct a "struct strvec" to pass to
> run_command_v_opt(), and as it's a one-shot to strvec_clear() it
> afterwards.

Interesting idea.  It wastes memory by allocating the argument vector
twice, but for most call-sites this won't be noticeable.  I suspect it
might fit at least some of the use cases for run_command_l_opt() better,
e.g. those that previously used a strvec or that need some flexibility.

> diff --git a/run-command.h b/run-command.h
> index 2b1fe3cde5c..639cee4f4fb 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -151,7 +151,7 @@ struct child_process {
>
>  /**
>   * The functions: child_process_init, start_command, finish_command,
> - * run_command, run_command_l_opt, run_command_v_opt,
> + * run_command, run_command_l_opt, run_command_v_opt, run_command_sv_op=
t,
>   * child_process_clear do the following:
>   *
>   * - If a system call failed, errno is set and -1 is returned. A diagno=
stic
> @@ -262,6 +262,24 @@ int run_command_v_opt(const char **argv, int opt);
>  LAST_ARG_MUST_BE_NULL
>  int run_command_l_opt(int opt, ...);
>
> +/**
> + * The run_command_sv_opt() function is a wrapper for
> + * run_command_v_opt(). It takes a "struct strvec *args" which
> + * similarly to run_command() (but not run_command_sv_opt()) will be
                                          ^^^^^^^^^^^^^^^^^^^^
Do you mean run_command_v_opt()?

Ren=C3=A9
