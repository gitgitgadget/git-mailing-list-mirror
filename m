Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAF051FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 19:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932266AbdBJTtL (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 14:49:11 -0500
Received: from mout.web.de ([212.227.15.14]:63304 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932212AbdBJTtK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 14:49:10 -0500
Received: from [192.168.178.36] ([79.197.218.233]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXHcb-1cxWrL2HcD-00WEUy; Fri, 10
 Feb 2017 20:42:30 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] ls-files: pass prefix length explicitly to prune_cache()
Message-ID: <f480bd26-f74e-9088-844d-26cde0843baa@web.de>
Date:   Fri, 10 Feb 2017 20:42:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:xdojRHCGFlobJDB8MwZO9OXI+QB/jEi09rpHzA/dJZ/H9WtU20m
 zl3DEskdKNB9lHDuJAitID8Lj71Lyf3mAl+VKTJ592y5R+5YaVivGSsRoh+zOKeVdjLBB3o
 d0vdwdf3Rz8g3iXbCli593LX62mdpr4wSfbq7QVkg+nJxbDIqTpKwuV0pQTMwtAGeWd1lVu
 WqhuI2uv5iRRSs+wNhqCQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E987uJlyxFE=:3RHg/sZhNVdrdJPe7jDuN1
 IUK/sumu7QesE98AC3YkFW0GBoPVVwuegYf16sfCVQUrK0cm+xXSd157/m2MXQtmMZ1GyOc3H
 Ti5sVAUwWfxNgbxoFuSA8xm9klLYhsAKhhH1Cwitf0+bJ3JOXckpwD+3YaMp+cjE21go+K+jx
 WqUQpxnXPxuI0O8ZJuY7NRCdP3eNlxnV9a5ZDSknglDULxgXJdV7pjuknJpVLPro3pVdFB42L
 q9lBB3tw80+t3/XUEucaPjwObtd2a934J5gM1pNPNatQYi3vVsK8dc862qvqDB4FUqjAqWbnz
 o5hxLGVg1ditZIrP0ThA/cuQLu/rwqFh9VL82JBGT5PsaMN+dG7icLLyd6t71Rgun3sqQqGYM
 Eno5PjLOGghBvSLUIwiNuRFXvYDxejIAkpeldhRyd/PWgCcVY7wdQERNQQZaw/xSpD+1VWpIn
 AdMQx78yziFAgprWN+jnALU28fNQ9SGoB4QU73TY53+CCj4EizsB3ux+CCd61skB0kD7rxmTb
 p2/N94dK4xxkSGlEjf5nSY5LEypjpdr95rjhYxjEOPxA/FHxZVnuZ8McPcwW8hhT0lDsyVrpB
 Jc0kO5ttCL7GXiRBupG9BY5CwBJHevsX+ev2G1b+L6+L+y17Z5nFSnyhn/ucxDGQ4aC0ObSQp
 Sy+dsJDqzP1ww96NU8QozEYJv7kG3cacjdPnezr9p9rud1ps7BOT8mFPVdWrvnLHIweSOM2GW
 h7A5+ZEV31AkZ8JHJ56zfNzxqkp40LF1btmsDptQUw575O38AQDGwYnRgxRuwhxp7lAwRIj97
 ENwtbLP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function prune_cache() relies on the fact that it is only called on
max_prefix and sneakily uses the matching global variable max_prefix_len
directly.  Tighten its interface by passing both the string and its
length as parameters.  While at it move the NULL check into the function
to collect all cache-pruning related logic in one place.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Not urgent, of course.

 builtin/ls-files.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 1592290815..18105ec7ea 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -369,11 +369,14 @@ static void show_files(struct dir_struct *dir)
 /*
  * Prune the index to only contain stuff starting with "prefix"
  */
-static void prune_cache(const char *prefix)
+static void prune_cache(const char *prefix, size_t prefixlen)
 {
-	int pos = cache_name_pos(prefix, max_prefix_len);
+	int pos;
 	unsigned int first, last;
 
+	if (!prefix)
+		return;
+	pos = cache_name_pos(prefix, prefixlen);
 	if (pos < 0)
 		pos = -pos-1;
 	memmove(active_cache, active_cache + pos,
@@ -384,7 +387,7 @@ static void prune_cache(const char *prefix)
 	while (last > first) {
 		int next = (last + first) >> 1;
 		const struct cache_entry *ce = active_cache[next];
-		if (!strncmp(ce->name, prefix, max_prefix_len)) {
+		if (!strncmp(ce->name, prefix, prefixlen)) {
 			first = next+1;
 			continue;
 		}
@@ -641,8 +644,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	      show_killed || show_modified || show_resolve_undo))
 		show_cached = 1;
 
-	if (max_prefix)
-		prune_cache(max_prefix);
+	prune_cache(max_prefix, max_prefix_len);
 	if (with_tree) {
 		/*
 		 * Basic sanity check; show-stages and show-unmerged
-- 
2.11.1

