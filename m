Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3D6C4332F
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 10:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiKLKmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 05:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiKLKmw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 05:42:52 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947B013F12
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 02:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1668249764; bh=VNXjwAGGux1OH23IBb3c3ixVmXjiuDafUXw87nvykjA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=mSnC0XwwFHI/TCRXhFUUWTS4dt7G24Mm0ZkrHEjdonBes0fpZxi21UWcLVXT9c1Yi
         a9PVh0J33qT5U1u/UhpMf8lLslZPjPhGY5VgP70o8SyfWjyn2xuTd+iGDXQRw54rdW
         6hA4QV39K9maFd7nZNdBZ7KPudMh+DsOXd27UTHNPmq7eN0uW8vQ9TFMVnccHmFA/w
         UyST0DdzN0uZ6oTEv3qb0XmRQ/tFXSP20YgGedGz3hGGojZv1dKIuwo2/ARTrxwwr+
         VU0mrSRw4877+lxWEnUMF+eXa1ZhXSPjbpfYevDK3sTDKltak5aWBy+EtbGfh26jop
         kbRK//m28NOTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.27.139]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQgl2-1oesQH3k74-00OBI3; Sat, 12
 Nov 2022 11:42:43 +0100
Message-ID: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
Date:   Sat, 12 Nov 2022 11:42:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Language: en-US
Subject: [PATCH 0/3] pack-objects: fix and simplify --filter handling
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kv/moNpNrw2ovQkoZmpObB599pWOfAo3LktZvDry85/IcWaVp0r
 ChsbdtaYrlf38RL4LM0POio0OihD0A65VGxRnBZPvbom4uxU5yRyJ11Ctpep2MfnnEF6Be/
 FpDpF1D9cCTZohyq1BjHsXjwr/9klnccWrT5o8629vOAEmHvgLZBwnn1OeOclP2OYAeArzo
 lxhrDt0N7T+/rZLtJ22OA==
UI-OutboundReport: notjunk:1;M01:P0:MpufmtCKHss=;WwG/UEeU3mR3YtiWovkGRicxlyk
 dI+PePBg96vg8jvdtqIPPbAK4Sf0Vu+aI7SYfonRUbg1R6vrCuKlmHK3FIeBa88sYTWbco+jh
 iQELVWeQ25rpI/QJHKFluo1l7kW1lsR6zGK2bxUYNspOjw2HSD0uMeONB+0GbsU9FXWYCM7Xt
 CiYt5nFHRgAuMo6eEBZbNYPPn0TSeTBgSaMgJfsbtv5jo042vtR6TggCCZH0xQlCSBeEtOJh5
 Cbk4P14+W1JfGMWVS+tRXXp665ve51Mr4odkQPgvQCCiEfaZ5KnQ5xtyqhoQpf92lhI7jmcQe
 2EO2syyTxbmXqPEasndmA204Fs3Fo58IY/2eIQTfrpph13SDr4oURR1j5TPMCp3AI0cXSKOO3
 Krewd0YTwsBiRGN4P7CPqfjhmJsYBoiAUo30qJWhczYXphyucsyg3WHZWTtwxk8RaxmEeJCkG
 ecrpGnx3SMyIcvxY1Vkhi637bhrdbsUDXorp3LcYKuCG4IpjXXP/aLC1cXbvlILi6Nn5ZRSg6
 9h9ppxKknBJM6s7YhJonGH8QHsec4GRkN7KaoDl7UUPLMZ54vd2l0bHUTcu3o+TgaG6NuuZEY
 wQRLTNaOFLqN9pgtpP6EdTjdYlLtmFWJ4SLYz8wxvoReS+SX2bpL8rDXieeXlc9QYo4IXndj+
 daxeamRdoWwFeaKASZMStgsb17pBWIjknZNcJ4o0BAylB0FhZ5cKnr1atXwZIOFLt3p60AJRT
 eLHsGjkAPgeHRrU0HbFzoS3L70OVeBBXT8N/Woy2v/am0h5t7Q32DgXddfg4NIOHljQY6kemx
 rTLK+NVdRV1Yp8fFYUPm7bMToa/Fnq5YqBAW21NwCovBJjc34E8+HWEftjjC6RQhjJUeq8sE5
 zKpCB092b8fLJN2OcWl6Wae7Dfp29pYXYqkIM69Mi6Lk1zF09OAX4faWEZCVWk4qlTMbQIq0L
 anHu++ox70oKDyG05tbj+2bq7D8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression that prevents using multiple --filter options, simplify
the option parsing code and avoid relying on undefined behavior in it.

Effectively almost reverts 5cb28270a1 (pack-objects: lazily set up
"struct rev_info", don't leak, 2022-03-28), which introduced these
shortcomings.

Patch 2 conflicts with cc/filtered-repack in seen, but not semantically.

  pack-objects: fix handling of multiple --filter options
  pack-object: simplify --filter handling
  list-objects-filter: remove OPT_PARSE_LIST_OBJECTS_FILTER_INIT()

 builtin/pack-objects.c                 | 27 ++++++--------------------
 list-objects-filter-options.c          |  4 ----
 list-objects-filter-options.h          | 18 ++---------------
 t/t5317-pack-objects-filter-objects.sh | 19 ++++++++++++++++++
 4 files changed, 27 insertions(+), 41 deletions(-)

=2D-
2.38.1
