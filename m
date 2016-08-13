Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92B322018E
	for <e@80x24.org>; Sat, 13 Aug 2016 12:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbcHMMVh (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 08:21:37 -0400
Received: from mout.web.de ([212.227.15.4]:55617 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752117AbcHMMVg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 08:21:36 -0400
Received: from [192.168.178.36] ([79.213.114.86]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M3Spk-1bH9Y03acK-00r3lH; Sat, 13 Aug 2016 14:21:28
 +0200
Subject: [PATCH v2 4/4] commit: use FLEX_ARRAY in struct merge_remote_desc
To:	Jeff King <peff@peff.net>
References: <57AEE4F7.7090804@web.de>
 <20160813092330.vmy2hip4papyuula@sigill.intra.peff.net>
 <57AF0D8E.6040309@web.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <57AF10C7.8070001@web.de>
Date:	Sat, 13 Aug 2016 14:21:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <57AF0D8E.6040309@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:E116hrXQB7k46eZXvF6VMbEmupZ/gU0oFQk3r6I5kmryZj6a8ea
 NPu37TjtdTrKQGuWRws/Mn1bndVQoYTB3Gzx5FXiZW7fCIR3qxiyWTarWwXgq0WK2xnFPZW
 eFCKm2xZmzuSfaJoo1jyn2OcZhjDhUs0+SYRdXyHmlrD4I25gl6nwyw9/ShyPkjjuYvW6es
 KMa9CmoY3yvytBXzfqXJA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:FPH0jI5Xdpo=:XZF2D5uB8pkt/+goJ67ESE
 7qy7PA4l3pQBy0uc77lGNNsuBcg5hn2t5mjz9o9MXtZ8aeS+jOBA+RYoFGq6zWya161m0Xr/j
 Us4+1cxSltczhAUZenl7pzoJnjL3uMXR5XPyqAcrSlVncNDDa/27VDnSDGTRH7Vd0gXx2STap
 fNUDrB5hWq8H9wsHOTDh7/xWRI4eMQIUbR8Ni7/DDgFPW2AL04ix7ny5joKdwIm3p06RvAS51
 TTyNCndJGtbhhzwjPdq6eJsuVm7cv41gwZLO/p/3gGPMxrcM628+bEBfG1xmV6O72MxoTRCni
 pJVoa6vy3pJQXAaPNQGdNwjsI94NMcG3vM24rOVG4WqBV2x/5pnNw+pv/+XeYs/bqb/l6ufmT
 4QPHqCMBwUnlUrUHBb2iu0JzDQE/ZnPKKgLJ0xPqksPO42K55AWgKHwen0LexJmD7sw2GtY5M
 6dBxHzE7O47B/UPzAwx2iR/OO3+vq3NzevINmDbhHKC68JxdaSIaQL0BZfNIHjT8fIN2ajWDC
 akQfg5V3iZ8FWlLc05Y+myf1pFIrL79JTKdctWeSurfjygUeKvHqHhbvQfwAUVB5660e6WoYx
 bDKAyEd4rcfL1GiQixcvqXLN1FNF0bCnqJDlCnLdNwsjKWgiFoviwhwHKNGVShTwMmqIpjgGM
 POxNDHX9zYbzuVkkIiT5iJTracNt3+gr5IiQOfUPKVJwwskYHcVwNhdGtQxT1BoyZnHKbCquG
 3ALEtFcy0oOOuS2YiIEe51zECfl4XWURf+Hp8ZAd8airPfdXJMR/71nghoq+bqpJe9fTa6zfU
 d5qNf6F
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Convert the name member of struct merge_remote_desc to a FLEX_ARRAY and
use FLEX_ALLOC_STR to build the struct.  This halves the number of
memory allocations, saves the storage for a pointer and avoids an
indirection when reading the name.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 commit.c | 3 +--
 commit.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index 8bad713..ba6dee3 100644
--- a/commit.c
+++ b/commit.c
@@ -1580,9 +1580,8 @@ void set_merge_remote_desc(struct commit *commit,
 			   const char *name, struct object *obj)
 {
 	struct merge_remote_desc *desc;
-	desc = xmalloc(sizeof(*desc));
+	FLEX_ALLOC_STR(desc, name, name);
 	desc->obj = obj;
-	desc->name = xstrdup(name);
 	commit->util = desc;
 }
 
diff --git a/commit.h b/commit.h
index 84bb507..32e1a11 100644
--- a/commit.h
+++ b/commit.h
@@ -362,7 +362,7 @@ extern void for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *
 
 struct merge_remote_desc {
 	struct object *obj; /* the named object, could be a tag */
-	const char *name;
+	char name[FLEX_ARRAY];
 };
 #define merge_remote_util(commit) ((struct merge_remote_desc *)((commit)->util))
 extern void set_merge_remote_desc(struct commit *commit,
-- 
2.9.3

