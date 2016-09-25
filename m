Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAE8E207EC
	for <e@80x24.org>; Sun, 25 Sep 2016 07:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034033AbcIYHQB (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 03:16:01 -0400
Received: from mout.web.de ([217.72.192.78]:60971 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033983AbcIYHQA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 03:16:00 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MduMb-1bbapD3Bsr-00Pg5Z; Sun, 25 Sep 2016 09:15:46
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] add COPY_ARRAY
Message-ID: <6f402d35-b483-7552-2fb2-a5350112b8a6@web.de>
Date:   Sun, 25 Sep 2016 09:15:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:1nBwtojTgOyjXDyx5jbkfqZ8VP5YHhHgR0RfZzXBJJkgZP/XYA1
 4u7gX52qQyxg6mTAq9XikXdgzJb0thhWFZdAMUXHhShmOqTXNuMykEEI0T/gFrnK5jpbNpF
 C6HAjJT98riPPWao8QbqJ0BRlzA7cH3VnliuU0TCijCyLKJMIGTi1IeLNnjBj/cENRe2qkn
 d/iwGpqdlmQpEtnp7kQWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wABqBMIN0Cs=:qRr0SnOHIVdHtMezA/09is
 HuYNF+yM9yXTEZRraqJvZ9Yv0t7wR6miWHIBrpGRQS8i4D1jFMX4648/0VL3q2KJP1YNxFqmW
 PaRddJUxPRrURbjFKESTaWNURd9lqU1pBxPLn0UTLWb/AzeyGopsPK3rzCOkvVDBY3vn6gyAp
 oMdvtvwUtfwEOVXCrYHbxHSrFis+duaLnm4rXHRXEhz5jUsOMgDaaNn4S3BzVg/glATx2jaBG
 ReIiFY1rj33fcIJfJHd5WFV9JOHZ3u4bw9/5niA2xu6cqcbtPDpJNWYvBuiMOmlf+Ur9GJPXO
 cw+r1GebSft7OXg8bO15gNvh+bxttLb9BuiyZsr0cC9BwgNL/JJP+kr4z9a2W4PpwYS1wUTeA
 r8CbFwZSz3dlWdWZKbFbBW2I2hD0zlEsTqOsz7oFukT/GYh4Ya7ujEanzWdne/6a2Na3VfCec
 H3ncWcgN6K5dY3bI9IgKe2Q1Huo5oR3FDx1XUC4hPCqU7Lxz6svLw41vd9vwxapkyIDHMFHXn
 dNuUxuyvHlDVBDS+hnwk3+MhahaEppJwuGQVjgHFU/P9JUn2E/zM9+HxoBXd+Mi+j0bz/SPup
 tl1MI1AoesMVysRxRTAdR6N2JgeqaY6TLoD23P3Qt8ZgEmC7waEAHpCzTkuImE0lG2HOZuSIc
 cpQAC4ZTVRFpfJT9b9BZj3QRLMzbQwsxEzl7LzJIxNC/eYQouv6GqfYQC6JReRrwgZ+UngSsJ
 KB7q7oK4qgYFv/2ojIy1qteOeNyTdU5lCZvYenpSNWrg7x1vkf3G3XKnAv1ZrgmzIx1LC84Y9
 letmG83
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add COPY_ARRAY, a safe and convenient helper for copying arrays,
complementing ALLOC_ARRAY and REALLOC_ARRAY.  Users just specify source,
destination and the number of elements; the size of an element is
inferred automatically.

It checks if the multiplication of size and element count overflows.
The inferred size is passed first to st_mult, which allows the division
there to be done at compilation time.

As a basic type safety check it makes sure the sizes of source and
destination elements are the same.  That's evaluated at compilation time
as well.

COPY_ARRAY is safe to use with NULL as source pointer iff 0 elements are
to be copied.  That convention is used in some cases for initializing
arrays.  Raw memcpy(3) does not support it -- compilers are allowed to
assume that only valid pointers are passed to it and can optimize away
NULL checks after such a call.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 git-compat-util.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 37cce07..91775ce 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -801,6 +801,14 @@ extern FILE *fopen_for_writing(const char *path);
 #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
 #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
 
+#define COPY_ARRAY(dst, src, n) copy_array((dst), (src), (n), sizeof(*(dst)) + \
+	BUILD_ASSERT_OR_ZERO(sizeof(*(dst)) == sizeof(*(src))))
+static inline void copy_array(void *dst, const void *src, size_t n, size_t size)
+{
+	if (n)
+		memcpy(dst, src, st_mult(size, n));
+}
+
 /*
  * These functions help you allocate structs with flex arrays, and copy
  * the data directly into the array. For example, if you had:
-- 
2.10.0

