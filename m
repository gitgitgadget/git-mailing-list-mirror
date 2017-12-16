Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5690F1F406
	for <e@80x24.org>; Sat, 16 Dec 2017 12:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756500AbdLPMMg (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 07:12:36 -0500
Received: from mout.web.de ([212.227.15.14]:60454 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752724AbdLPMMa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 07:12:30 -0500
Received: from [192.168.178.36] ([91.20.60.211]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LuIAZ-1f7ahT15aZ-011lIu; Sat, 16
 Dec 2017 13:12:24 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] p7519: improve check for prerequisite WATCHMAN
Message-ID: <fb8f1b3b-3668-db21-993c-087aee279936@web.de>
Date:   Sat, 16 Dec 2017 13:12:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Mctpnbja51P9+h6Lgw29UjXMez+DmZGwKIuz97XU76m53YAKGGf
 i+t6SFSwxpyPIk1YzrCdTA68OT904TgiRfRx0grk4GPW7reLOIfBs73R8e2BcLnPmEdMhEH
 hUCndmHCDedskF3qyjh7pdQxlgPZwuu92SbL84/98kagx0PV3oyiCj+5Z3nhSIKnZm8Qgnd
 3iqymuPv625llLHrGJk1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t3JbsCN2bgs=:1vPLBgzwkn+zTPoCVVsSMm
 LN3dLgCfiI7nkgCK36d6530aKfx0zN8qm0rRbuUpCOp5H0g1pTryYHh2KPJK/3EvJDHBjpfNn
 21fJ6nQEpgGy/9MCEyGX2HNEJGM/Tkbos6l0wXCgOSHETJwqLBLUOvzONdm/XiQWt5lxsYgB2
 b+JAPHNmtaAlakquFdz8JTw5tO/Cz4WEDqV4/QuQCDQpSaZhh87eUTNLeYpSvvKJWkBjUPAhN
 9ZDrM2DK6YGol3jm2zGLrPcktjxvHpNUBQUDx4NdkOrGKtletXV+ek3Kqu1WCSHvlDDROyTZw
 baLWo2uJ7aZedvHOglBB5qbOrCtShhARyqzm3P70qE6K/Y1qMYnSAnf6rG49Zbn6NLzSjgzqj
 qGCnsOHEkrl6vhPt7LxakRcaHZs2lbwtxwQEwG2Usp+DiLGOVBfgsodWoZXJSyFR8Z1EfdZPb
 kHmbVIoUWC3XEpAJtemuKYp+L9LXsbLvxoopeeBX23UClyacw2WexVSkfkgJUffpQN2SoMqkW
 6t0gvjhC7wXQwmbrzPBXiwbXLcpTQ1IOivOnoSgAzXmqLVbNxqL8B5EM4fKVc0ph25647aHPa
 /3N0dfzibKWwQ9tG7HQEFl6jMvcL3NzuVewSfbkgjQbQrXgrjG6P0lB8z6s4C55NS5uZDvzYj
 4QicwaJe+NR4dA1+NwamBHUoZM4dca+pUQoIeoY2NlH1wL9KjEvbQaPzlabA8EA4bvLgl7RRX
 2xfi5l+cp0/IoHU7EZDWWj9lWscsXUT/wuNRC98ficip4YBBqY8UtzrmJnpHlDTQ/dz+RQsUF
 /L8r2AQkPRmmt+AfClkqNW/oKxKQxdu4Dndn9smB/tVEWN26mQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The return code of command -v with a non-existing command is 1 in bash
and 127 in dash.  Use that return code directly to allow the script to
work with dash and without watchman (e.g. on Debian).

While at it stop redirecting the output.  stderr is redirected to
/dev/null by test_lazy_prereq already, and stdout can actually be 
useful -- the path of the found watchman executable is sent there, but
it's shown only if the script was run with --verbose.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/perf/p7519-fsmonitor.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 16d1bf72e5..65e145c02d 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -40,8 +40,7 @@ test_lazy_prereq UNTRACKED_CACHE '
 '
 
 test_lazy_prereq WATCHMAN '
-	{ command -v watchman >/dev/null 2>&1; ret=$?; } &&
-	test $ret -ne 1
+	command -v watchman
 '
 
 if test_have_prereq WATCHMAN
-- 
2.15.1
