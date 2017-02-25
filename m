Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B5C201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 19:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbdBYTWQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 14:22:16 -0500
Received: from mout.web.de ([212.227.17.11]:64901 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751764AbdBYTWP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 14:22:15 -0500
Received: from [192.168.178.36] ([79.237.49.102]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRU72-1csfCU2Hc0-00Sesi; Sat, 25
 Feb 2017 20:21:54 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] commit: be more precise when searching for headers
Message-ID: <23989e76-24ba-90a4-91a9-9f66bfccb7c9@web.de>
Date:   Sat, 25 Feb 2017 20:21:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:kCVR0tuI3fzvgrbMHPyh0nrmie6EdGVKmGbBPSHBBqqhujBAc2W
 ipW11fUOPf+hE8FEd/Ky+QKBwemBRtxiD1M8pLl1LPZ/WO4opcdlOlc4ExfnHWcaK+blEKo
 8LrG3U9CcdUjmqdSsrL7vwKWNDenpyGS3mwTRkp8PRaJCJv7npBJt5tibsI8NwcDXwlTNHt
 2LHK9O2V0uWcao8iUiQpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GeF5plVg3ko=:xdpksALqsi5wWyMSV9v4Kh
 n/sFBKFeGJ+pI9U/XgTUrowLMkenpMvXrwrRRZ6dkw66zKNcSLu00MFjr3JNjPm1YPTCSvrRt
 nQf2xcQ7rfvqj+xJgO8uV4afMY3lg2uoLp6ZbqQK9DSzpoLBO6Sb83CQxr2Z1FGjabRduwVAK
 +vNEVMuKwkNh+miwV5TdYA/1XmfLAOMQLDSKtnjOe1sBJHa5JyxVwL/yQfjbHiLyllxyPL93R
 TAyy57D0ZTJ/WT5lQ+/BQXS27WjtU7hKxqmE/URxpMVv6Joz/H9Kud7YoX/p/Cp+9tmmPVEds
 421yzns39XgWpajM4kqJ6kylMjAGgGqimLAi8tLMZHSZgQAYm5t4Nt5IO1mNarQboS3H0LR6q
 LDcIEgGMR0nZdlLWyTUZe5sibR2LzsGY/92LXO58J3oQKHKgnVY4c4U7eA0SaQGJBg0Xy8CZQ
 oaeR/3xlAPmCYPDCsSHLSHh+c7hOjQa3dldDJMmC9MHY+kjIlEUSwyLww3B2Kx8LZ2SafOjNc
 2votXyNwmkZneC4DuSQxWk4MeIA+yXFr73Bv9ywZp77xy1eLgL/2ELB8TPVINdq/oB/L/hm/G
 IwjZFfh75CHWiDwXqtVRSnOH60LfnamLdHDzQ3OlWKDz7wr46bkAO6hXxddqiQLPac2Tm/8ET
 9mavur6oFCp2jTxoZxqTxYDrrHhk2ZA5/rTEOKyyIJukWp1YcqbgNmblExaCP9/DA3OYaSNCX
 kzMIKWlsgvs/9mHyM/JW8wnF3MER5SGvb7BphNt7UWLTlEnaDaIOfnettRGsaqoUaU7JWggU7
 /krtC/d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Search for a space character only within the current line in
read_commit_extra_header_lines() instead of searching in the whole
buffer (and possibly beyond, if it's not NUL-terminated) and then
discarding any results after the end of the current line.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 2cf85158b4..173c6d3818 100644
--- a/commit.c
+++ b/commit.c
@@ -1354,8 +1354,8 @@ static struct commit_extra_header *read_commit_extra_header_lines(
 		strbuf_reset(&buf);
 		it = NULL;
 
-		eof = strchr(line, ' ');
-		if (next <= eof)
+		eof = memchr(line, ' ', next - line);
+		if (!eof)
 			eof = next;
 
 		if (standard_header_field(line, eof - line) ||
-- 
2.12.0

