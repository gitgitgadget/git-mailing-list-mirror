Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53E9D1FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 10:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1037866AbdDUKqK (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 06:46:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:50368 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1037782AbdDUKqH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 06:46:07 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M08ia-1c9QRy2dY4-00uK2z; Fri, 21
 Apr 2017 12:46:02 +0200
Date:   Fri, 21 Apr 2017 12:46:01 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v4 8/9] Use uintmax_t for timestamps
In-Reply-To: <cover.1492771484.git.johannes.schindelin@gmx.de>
Message-ID: <b59a414793492786937e910f6cd588b8e1751b4b.1492771484.git.johannes.schindelin@gmx.de>
References: <cover.1492721487.git.johannes.schindelin@gmx.de> <cover.1492771484.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xLlCXm7yS9fR5UYSRU7qpfZv57UGCK5KIJivcjAQ+Pv1DbL7FE3
 Vgu1BqUQsyefGuQQHygll5ZLukzsn9oJoTweA/MIvtaqP3HIUnWrHzOF9PbO6Pd65pJIsrU
 fF+HhOtMf5Tweaxjnp0/wTVp7TRdb5I76v2dt3cXtLBgdLsKJym8RQsgB1vVkTQQujf7Q+W
 VV5VGHJaRQP2Dotp8/j/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:31V/qFKJQQI=:3LqVOmhGUqiVRdbMoYvKgk
 73BT3DIM7enfhVMJ9yzwIXQ5RBpOESqrfaVeOyaDy9973qzfQinQ9PZyk+NwBh2lZH6bdde8A
 ew5lWoGL7jnomlcWVhniVioPAs68Q713h6CPbjcgsfGNtXn3AubOMzMIeBK+oC/KosDF4VW6+
 qCCo4VgO37fnlAEA+hb1ZjIa0fIDnY4gy+vFDKtNy8juSScpKJ0xuDWCWNqHoMeNS/sjmEpFZ
 scDNLbSGaUmCP4QD2lJ3nflSiiJOuyOMB+hYoQwYMwDJYbgWNhjNJTWnd8DVuG0jW4jCg/FPc
 UIr+BcoLuyZnN3KCu+ld4OjfsH4R8ymvyZ0f/e3Y7GdzZB5IdVS+xD8jDFVGKYwHxhQoUpeff
 0YFOC8c2HfdeZqMKJUd8+1yo8cNBdCYnhYy1+mD6aPwyODuqR44udg7ekK6qVNbcjSRr6I4Q8
 xsIBK/u2cC4lILIm984TFXoB3STfejCkgtQH82zCmAsT+vnfS2qCiIqUOjdlBRacNTuaJ96jd
 ndUVY8naxEw10UyN3dE695fz0dVB+Qc73LzzqTo0MYjV5Q7UFiFywpTIY6QO/YCHxZKGNSBgg
 0l6FzgFkFxffdVZsEWfTgoVxtvnihpREWD9aDTdwUn+T0R11QKTEkRQ1j/WaWfXYz/taWQm4l
 EOxErXI3gr9+tsIYfpYA4cIPTeJkm0aGHFfZ6LCQREJU5QN/GH3uqGqHYOqo7+hZSUqEOHO+j
 PhGveYYgtq0XnmhJXALB2QiFL2AensGmyhEyPZ6rnoSBaqbvNB0cLEqijyfucQ+UKXnyTcg5K
 D4mrXKB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, we used `unsigned long` for timestamps. This was only a good
choice on Linux, where we know implicitly that `unsigned long` is what is
used for `time_t`.

However, we want to use a different data type for timestamps for two
reasons:

- there is nothing that says that `unsigned long` should be the same data
  type as `time_t`, and indeed, on 64-bit Windows for example, it is not:
  `unsigned long` is 32-bit but `time_t` is 64-bit.

- even on 32-bit Linux, where `unsigned long` (and thereby `time_t`) is
  32-bit, we *want* to be able to encode timestamps in Git that are
  currently absurdly far in the future, *even if* the system library is
  not able to format those timestamps into date strings.

So let's just switch to the maximal integer type available, which should
be at least 64-bit for all practical purposes these days. It certainly
cannot be worse than `unsigned long`, so...

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-compat-util.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 72c12173a14..c678ca94b8f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -319,10 +319,14 @@ extern char *gitdirname(char *);
 #define PRIo32 "o"
 #endif
 
-typedef unsigned long timestamp_t;
-#define PRItime "lu"
-#define parse_timestamp strtoul
+typedef uintmax_t timestamp_t;
+#define PRItime PRIuMAX
+#define parse_timestamp strtoumax
+#ifdef ULLONG_MAX
+#define TIME_MAX ULLONG_MAX
+#else
 #define TIME_MAX ULONG_MAX
+#endif
 
 #ifndef PATH_SEP
 #define PATH_SEP ':'
-- 
2.12.2.windows.2.406.gd14a8f8640f


