Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20609207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967206AbdDZUTl (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:19:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:62041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967201AbdDZUTj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:19:39 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MB1C4-1dDPZa1CCK-009wxV; Wed, 26
 Apr 2017 22:19:26 +0200
Date:   Wed, 26 Apr 2017 22:19:26 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/26] winansi: avoid buffer overrun
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <2299a84fff0232d90bdd4802bc7be15ff510a168.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ToeXe7+E2jKxDGS1WqoG+v/xfHpoFku+eCuzAGjYCdbLfckJOSE
 qIIJjJBDc/KxqFwhzx7XbiHEbukTqssiMi8/sMiMwaiTvoFGpW3AYCap6jlGTpAhhvF8Oqt
 iuMigBAktmUQT95kEz+B09E8Rk6wkTBBic33oHUqYXL0fzhkSfoZSVGB5p88m15RPAEe3Oo
 R5UdJ6TMXnH8dIFzCPVOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jWtSa6rZJoA=:qDpFqfEwa9Tmwqa7CIOYc/
 FGiiPtAopfSa9Z9PGnrdCpvEuVec2WYV+BeygxxB21pNbEj1bj4NezTYADrzm0A3pxDLkGXwW
 gIm6gOeM6zrFDUeJCYxUzfatzH6OlxyqFvtFn9wpQdg/5BrbM6saiczWMqhekPi1dYWYUUcSD
 eCA5ukxCdPX6EDjN7N9+bKMj2qm4S3lSsi1lveMAQ+vBDtPDGR7kB6vmnevuL3g0f5zYCDTuM
 C2nDuK4jg+2TQ1jWZE3cBVV4sfTJmWyQ6ev2gdHHho4N46iktP008rr4imH6Mh/AZY0ziEUu+
 F1hARD5bZzROgf7+RAaBxhVMfPNEz0/8kX3a8uamsq56iONbJRWhyhiucOmTcnl8EmY9jFN2F
 gQ+dDBkEJBML2j/Wqv5vj+17ioSi/aUKWd/5PFrYC+toWw5OYfwbvxfF9soh/BfMWD8tbFqkr
 kAPW9GgSu5Xaca79Qcdy8gN+CzvSp7q4C9dt//8otr/WllLrEjKt8r0gINacj1NBcWPQp2ByF
 s2WnSXVfpBZdIvzP4qqQUiJ+Dss5LlVHXfebl06dGjNUNDfEU+iUggF3oia/UkqGZMeTRGoqu
 clOgZtH6rD2cKRbpxBB+gULOKT+ghz+I2ghJs9rxCThgnVFlW+wrzP/M0ATUWgcbcf2VnBHrx
 Fa5W//2aYyHY0gdlx3d8/gz0kR9JFzDRKPRKe6Np64oWUYPKlw6wmAZ9fjx8q2E1KyV9lg7SM
 hm6AFcFToLBZwcMgbtYO4BjsbqghG1UtSIMD+e0smphwHQroeC5wO5ywp9KRGsRh1FDQFBWOA
 Db+7KCq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we could not convert the UTF-8 sequence into Unicode for writing to
the Console, we should not try to write an insanely-long sequence of
invalid wide characters (mistaking the negative return value for an
unsigned length).

Reported by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/compat/winansi.c b/compat/winansi.c
index fd6910746c8..861b79d8c31 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -135,6 +135,11 @@ static void write_console(unsigned char *str, size_t len)
 
 	/* convert utf-8 to utf-16 */
 	int wlen = xutftowcsn(wbuf, (char*) str, ARRAY_SIZE(wbuf), len);
+	if (wlen < 0) {
+		wchar_t *err = L"[invalid]";
+		WriteConsoleW(console, err, wcslen(err), &dummy, NULL);
+		return;
+	}
 
 	/* write directly to console */
 	WriteConsoleW(console, wbuf, wlen, &dummy, NULL);
-- 
2.12.2.windows.2.800.gede8f145e06


