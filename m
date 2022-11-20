Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8CAC433FE
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 11:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiKTLBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 06:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKTLBC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 06:01:02 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6788C081
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 03:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1668942053; bh=Ktk351e5pogQ3H+CVgd1PAmL65q6mRI0V3HBJBlTtYI=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=V/xh6WZgipbqPZ2QN5RXGVfjrrqyPIFuzYrDnCH1fLCaUxEJ5M/j/OptX1sJ1swX4
         S3IOjhjI0B1jGqa9ufTCjrBg7TOAkTpPZ5A89UT62UA13jjTNoEL9u4lIC0QKUeaEg
         U7xE8TU4lwKTXSxkxRYWdWm2gL03VIZHQQMyDwmxxZqzDRtB1b0OJtMKxXBiw2pvAz
         tLmkR548rheNG+qe3K3HQeavDYQj59YgJy0vGeAusZ9UkKMLfiHoaG4Ks45lLQIGj9
         DtmtXDD96XWP1zxsK8itp+/YnO+KMDOYgZtl+GYA9etgQJBe8GXBisydkGlJggMVpA
         Dl9wSzkfAqmrg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McIga-1pUwMD3MDc-00ckJR; Sun, 20
 Nov 2022 12:00:53 +0100
Message-ID: <bc25ac8c-ce9a-2385-be0d-0c72798d319d@web.de>
Date:   Sun, 20 Nov 2022 12:00:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] list-objects-filter: plug combine_filter_data leak
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:clwR9fGcnPIjOJ2Vd7bXP9eGxltoIsHMBebN00XMyIITUHrkAkF
 gVaPeyhFafFdCPtPpaxk0+6AeOSz25dm1opxCILEbfWNmylm8lY0XG0740DT4VkWpIASoQA
 9KL0G9jR0avaGFD6wgSDn6xuis74Nx1k917rQe6U52bcoub4mijxA3gz2QuQWL5cPcFB/Xt
 dQWy0UlneHQl/J/aH0bRg==
UI-OutboundReport: notjunk:1;M01:P0:J5tMK/EVH1g=;Xig2tZMaWBVXpwDkicJ5BHR7iCm
 Td3NyZmFcip33YyF5bn+dIUwKdIxfUJiwoH1aLUMaYXiLTe7bs0zlVRDxPHdUTzE4KPkOwLNL
 PkWvx4MnwzpWb84c2vL/2DrvVMbyH8bRYyOuLbnuIeM+wz3msXHfG+7T/VjGgW0a3D4wRLK+L
 Uq2Dbjkx6HvVKXa+0TUV5VbnWcWVb0w9B41SfoSzIFvax0WeLmTXh3+ApZMfP2tdB9SHG4TM3
 iOCXAcSRoy+sRG2JhNZeStNLbb+WLWS2NjINfvfZJREPNre2rZV77+vDZI7hSmGlvsruSiO3w
 /C/FW8ifcOmhgAJha8Yp437wN2noX+OObDoNrdJOxbazl9fD26UeyhR0Due5uPtFAZBrqE4g6
 4wE+xVkdCZexcb19yb+AmymWO+6ZxYM1fYKm8kl6lUslPpnNpJdHXhN8gaSdX31WrcIrzWvIa
 MQJDn9XvTUIS3i/4S7DfqXlysO6CaX81hPTBm9EKTNuedWJ+mtYDnWshNJATM8vN1L0UxPsXN
 KkFsLdAqXglE/mNS2JqgwEcH2bpwpgsoc8jmCqHDnGEip2hcgPjcxRAG1fKbT2wJiCibFI4RC
 MgFWeMFH9ONEyha/4W3asPqZi9J0heUHOCx/U0phmcS4XpaVL9mWC+4hMe5OZpu7aiKbSn83y
 cjlVWNFGIAYsNysbu/4s1IAV7Zr3WLK3qQuL6oxchvs9USGAB4xD7IGfL/hjpK+eQ7e81amVv
 h3p6f85ZwsR+VgqiDipAbu1xy7PTBvkD1GtjnOL+J9Vk9aCYbWQoy7FPveF7L8IjjmQYMSh1L
 CmMIeDqAcHvtUXvqLauS1jqYm6VbNiru6Yv4lcM8idwQOIMPRHMKZnsHz4iwan5ezfMicB9YA
 WeIYedsHvrOiMUBWckXKQ4xb+LHN3pEwoKT7Fvd6YPe1duQYSYevvfnhiIR1YwXl19QXBUt+y
 ZXBoPBQpV9dKwFL02p4rMvpNqwk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

filter_combine__init() allocates a struct combine_filter_data object and
assigns it to the filter_data member of struct filter_options.  Release
it in the complementing filter_combine__free().

Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Reported in https://lore.kernel.org/git/221112.86bkpcmm6i.gmgdl@evledraar.=
gmail.com/

 list-objects-filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 1c1ee3d1bb..b9543545ca 100644
=2D-- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -709,6 +709,7 @@ static void filter_combine__free(void *filter_data)
 			BUG("expected oidset to be cleared already");
 	}
 	free(d->sub);
+	free(d);
 }

 static void add_all(struct oidset *dest, struct oidset *src) {
=2D-
2.38.1
