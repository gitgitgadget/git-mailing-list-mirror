Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C17E20229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbcJWJBS (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:01:18 -0400
Received: from mout.web.de ([212.227.15.3]:57956 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752097AbcJWJBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:01:16 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0M0QlZ-1cm4341jbh-00uaTH; Sun, 23 Oct 2016 11:00:51
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] hex: use unsigned index for ring buffer
To:     Git List <git@vger.kernel.org>
Message-ID: <ebf769d4-771f-499e-c7fc-f0377d8df18e@web.de>
Date:   Sun, 23 Oct 2016 11:00:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:tpjozSIrMSrAbtauyL+h0bVPX6NOJN4Z/X+54PPp0qcCbKmNtlF
 51jLA7gEfqtNNki835c80lvSTMc1jxeZg3+1IsIyyYvBOj28xkRpygVg/VOV80yNPKTqi4H
 OU7NLldnuFt37eryGYWgfOmanL4aOScJFFFN7mqJcrJQtJVFiU0R33Id4eWl/hG7WWZzw2Z
 GpN3jpvzZyDWmS68bNBww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ODQxPaHm6Fs=:j2ZT7hSL68TziiAYMHk+4c
 EqtyHTRwNM0N1160nlaa6tYaKoWp3urcpF6F4s2bpVskswlKrANhzsJr7OL5fTdMP3bNTunMW
 Rv4oU208+ifYww2D8Up+NrCtUTJ7FdpDZxIoxBYnDht0LC/gBVfhv7Snrgwsyhs3Zz3KW41Bu
 d48wEjMiBm8XYLCIc6z9U30NdjFj/aJFDfo4aY5+DUoKkiwychkMCNZ2Ak6NWI11NPewbaeec
 PSOi0/wDMwtf5dgIgDG9DIiATLD2WsRtDSmS5r4euM6CFrAS6aMwtvpQ16pTWlaUBDfjqEDRk
 j19tE0UM7juTdPmbnDlPf2XDA4b1pHY6jRrocyDrih3Q+ruR0tu1ofVb87ujk4q8+sma20xmY
 PHA7tqwbTmAFc9zzQK3B8kItnCwlD5RfE9V556ns2y+Smc2cYPMJNQkkko5hOOCfa6iXW58ci
 s9/tmiZsyejJQVMP2fAeG301bGJU+WiXFxr3GLCkp7XWCnX/a7pins5+2ZtbkLj4iN+Pd+izf
 K6Ba/grBViWdBUFSTK3S417FkaTTER988RL6LOZ11UCgyGPdmMsuI/Fnj05ps9shtqG+5bLgr
 +5KuGmvRM2OC/mbclK4bjk3IPFRsrh4QGVu8sEa8dcy66T3g+At8nv19s1gBqRD7AdRkg5cpe
 ApC4YNH97DS3ZlXXC8vux9ozj+Q/JutWTZlwbKySJQU/jGI37Uo2WS5IxuEeTK1Ob46NPj8uM
 CIHd7bUfC1m3NFo/g/vzZ3jcCqUkGHnNK6vc6+onR7FWoYkArU3hqBCFVXQFa0y28HUHHElyy
 s3axK24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Overflow is defined for unsigned integers, but not for signed ones.
Make the ring buffer index in sha1_to_hex() unsigned to be on the
safe side.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Hard to trigger, but probably even harder to diagnose once someone
somehow manages to do it on some uncommon architecture.

 hex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hex.c b/hex.c
index ab2610e..8c6c189 100644
--- a/hex.c
+++ b/hex.c
@@ -76,7 +76,7 @@ char *oid_to_hex_r(char *buffer, const struct object_id *oid)
 
 char *sha1_to_hex(const unsigned char *sha1)
 {
-	static int bufno;
+	static unsigned int bufno;
 	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
 	return sha1_to_hex_r(hexbuffer[3 & ++bufno], sha1);
 }
-- 
2.10.1

