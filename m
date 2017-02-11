Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C617F1FAF4
	for <e@80x24.org>; Sat, 11 Feb 2017 13:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753634AbdBKN7C (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 08:59:02 -0500
Received: from mout.web.de ([212.227.15.3]:58409 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753519AbdBKN7B (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 08:59:01 -0500
Received: from [192.168.178.36] ([79.197.218.233]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MhOpG-1cpFn82T3q-00Me13; Sat, 11
 Feb 2017 14:58:48 +0100
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] cocci: detect useless free(3) calls
Message-ID: <7e10f934-f084-ceb4-00eb-b75cdb01886b@web.de>
Date:   Sat, 11 Feb 2017 14:58:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:E/S9c906UWadDKvOK5ix+yKOPsCTQgZUYLANFlWOBBUszBQghuq
 Ey0jM9JtifUKNUteZfdlCAU8X0FO9bR2xcRD77EEzs3KX0M4hdUKMT+igc2SuXqYHYTxqlI
 vDH4ybhmUSqYopUb1xUATJQMkv0Wrpsnp2Aj/Bj3iOC/tfXkoDfug+/sygmGgTShvPKof51
 Ok5HfkaD141jJI+B6o+rg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OLwwvfUnsi4=:GdWFn1p+4SyTABgsMZisW1
 Ilud6j8VXvmrvyks36cvNYoUhtkpo1g5pozZHYFYrpd3+zKY/DVJHiTIGQ/6E0ry2RhpXE0tD
 5T8oeOIrWA0cym0qtfnVhFeZig+RBxhLXBhJHmEqdib2AeJcWtDQ8tyLp0A2nckPEjlGdmeq8
 /FOjkzszfwzQUMVufFOXBG/RazJlm+FnXDyQl80jrFD6q7bbIyMZzPsKgZNF5p0ovKpY8EQv/
 judhrKbRmLytm9c7bDD90wNHl0R3nIBuOyW2HM08ziaZgaS46645HYu3qqO6Hz7KmC82Ya65p
 vwk6lsXPRAIdbKdKUdXZtUqwLv8WW7H+Op0aONzObnU/1UktK4kH6KMgIUeGonC+GwKP+sz++
 JwHTOE8TdLGH8Qbh/JA2Fb2es/HbA6cwDKLUi4BsRytP4cmtB5vALlBtAHjSvrtOv/hjccIDV
 G7FU5t8gQtaP6KxIJw4ITGNbrlje9aO2LfpOeFkZpqOnGsOaFFzFQihFz62eovfHW9xIJ9L+0
 jWSaxEVkkrGdSuhDU+0r0/zf1vvG7ts3wfgE3k1x0JzeOWy8+6gEjgQTOgFsS8BE5aqtmAt6j
 SnfUZuAuaEmthdPz3mP9SbpdocYx/xXJ9na7WngL3eJ+p8OTOcNhyHBPuFcrmN0HNDcSe2XfM
 a/qM44Igv9NlODB7V0cx4v9Rh88+cHxHkbC5wItzDJuaH1EG+LXdPS/SpzLPmXAQN67Ntl6ow
 iFK7pcGLlsEdgh+P5Wx/l2FKY9L8uTd9ioVWXJydeid8x/lio1FBz5d0e7/vKI3hyMo+jloIt
 jIBf9nY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a semantic patch for removing checks that cause free(3) to only be
called with a NULL pointer, as that must be a programming mistake.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
No cases are found in master or next, but 1d263b93 (bisect--helper:
`bisect_next_check` & bisect_voc shell function in C) introduced four
of them to pu.

 contrib/coccinelle/free.cocci | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
index e28213161a..c03ba737e5 100644
--- a/contrib/coccinelle/free.cocci
+++ b/contrib/coccinelle/free.cocci
@@ -3,3 +3,9 @@ expression E;
 @@
 - if (E)
   free(E);
+
+@@
+expression E;
+@@
+- if (!E)
+  free(E);
-- 
2.11.1

