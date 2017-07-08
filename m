Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81996202AE
	for <e@80x24.org>; Sat,  8 Jul 2017 08:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbdGHI7d (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 04:59:33 -0400
Received: from mout.web.de ([212.227.15.4]:58198 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752712AbdGHI7c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 04:59:32 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LoHKz-1e9fy30viD-00gJZW; Sat, 08
 Jul 2017 10:59:10 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] sha1_file: add slash once in for_each_file_in_obj_subdir()
Message-ID: <f59c8256-716b-9305-2a4f-d4fe49f666ff@web.de>
Date:   Sat, 8 Jul 2017 10:59:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:n7LnmoU68akuelOneDOo59kSPGZYxOs5FUeJUDg8n1fkuzrbMst
 U2Uu975b+W+J9h3qrH9Qf+ng7szlKBs2HvDrtPThVWPJTGH1EOtcCx7ef+Z7S13bGx2X946
 JMdfxmYk3EtD/Kk4eZ0xlQVTyqWTjziszC5CAoedhJsq1HdNhWzGzYdoFo/rNMdkfytQfyy
 PRXoNo71IVgmhyePUXIDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:koPNvbtreew=:m370HSDpn5VjeR4FS2KXu4
 TbILBTjvf1WdYcKDN8iACtTjNVoLDpSvGjCAR1VBWxZRfvfO2Nlmo97J7pEhs180wPDeo5uqO
 fGwuvnFp9GNRx57xPalUZ70GysyEDdb07xctDUVj+iqTYB3zcF7MwO/LVP7zXbLFV4++g2/8U
 hRnqE/3weRKVx5TpsrqDxaSpSAWChOtfuSjV3iy4M1Af53OWW7NO0lYvUe4r6YF87FQJGI4I3
 /NJlWJ8M0g513Rec0/cpHH3JtHgFXz8nucXm8Y4x9b5iLh4sBHZ26XF8MfzBj8q7DpkEIDWFf
 OTfNmC+n3WqaC1jRy1KNlxF/gj6k3xZISVzEbqIm+SWwX0b5nHi5ovnsNEkck6XUhfls+hzdm
 rew8q5Ve1GLgm60zxJPIY+0ZLnDpf+iLz69YtEZoydULir/F6bbVlzYInWrq0+LarBy4P1he+
 xbvgnGWe41XID5UmUIIP5arpPe+4HRLyKzTb+IX+2pIZOUGe2TbHBLlMnxxfvYi1/xfMvdwUL
 wLXhJG2IBo78NC51JnRsGVFWeGnE1r7Z26MjLtnGjRkT3r2x0/pFW7m3iZTB6Bn3502PsQnTH
 NLXWNsBiPEtN2S12MO+a3fQocCGa/mN8DXtUIUCt0JT1w2iVPERpRfeUFEBv6lQeBjugorEHX
 SXd2ddpsJDnp83htkC45rNVbTGIK7YgdVA3+W7EHJyHFpX3eSoRkVfX7l6zjpMr487BSIwmH9
 VQBHdyhIlplNgzmNnlAm+5olNxet8af+p/6CN/QJviHFsufdoR/PWeD4eKTgjLZRmp8+hCRKo
 QFLvWoC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the slash between loose object subdirectory and file name just once
outside the loop instead of overwriting it with each readdir call.
Redefine baselen as the length with that slash, and add dirlen for the
length without it.  The result is slightly less wasteful and can use the
the cheaper strbuf_addstr instead of strbuf_addf without losing clarity.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 sha1_file.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 5862386cd0..6a9deb9e68 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3749,7 +3749,7 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 				each_loose_subdir_fn subdir_cb,
 				void *data)
 {
-	size_t origlen, baselen;
+	size_t origlen, dirlen, baselen;
 	DIR *dir;
 	struct dirent *de;
 	int r = 0;
@@ -3760,7 +3760,7 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 	origlen = path->len;
 	strbuf_complete(path, '/');
 	strbuf_addf(path, "%02x", subdir_nr);
-	baselen = path->len;
+	dirlen = path->len;
 
 	dir = opendir(path->buf);
 	if (!dir) {
@@ -3770,12 +3770,15 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 		return r;
 	}
 
+	strbuf_addch(path, '/');
+	baselen = path->len;
+
 	while ((de = readdir(dir))) {
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
 
 		strbuf_setlen(path, baselen);
-		strbuf_addf(path, "/%s", de->d_name);
+		strbuf_addstr(path, de->d_name);
 
 		if (strlen(de->d_name) == GIT_SHA1_HEXSZ - 2)  {
 			char hex[GIT_MAX_HEXSZ+1];
@@ -3801,7 +3804,7 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 	}
 	closedir(dir);
 
-	strbuf_setlen(path, baselen);
+	strbuf_setlen(path, dirlen);
 	if (!r && subdir_cb)
 		r = subdir_cb(subdir_nr, path->buf, data);
 
-- 
2.13.2
