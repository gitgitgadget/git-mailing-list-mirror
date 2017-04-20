Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084B7207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 20:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947134AbdDTU7I (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 16:59:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:65467 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S947085AbdDTU7H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 16:59:07 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lh6sJ-1cGPdB0GYx-00oaR4; Thu, 20
 Apr 2017 22:59:02 +0200
Date:   Thu, 20 Apr 2017 22:59:01 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 8/8] Use uintmax_t for timestamps
In-Reply-To: <cover.1492721487.git.johannes.schindelin@gmx.de>
Message-ID: <b80136aa71dca8d6e6e977e0aa8b28228529ec7a.1492721487.git.johannes.schindelin@gmx.de>
References: <cover.1491159939.git.johannes.schindelin@gmx.de> <cover.1492721487.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zgrg6f/4z4aLANtvgTu7Ddfyn1a+7ILsVyca2YnRtQKxL4XkOiV
 Wohu0q6OD+kbHrG6bpVIsYVJKZCY8ihMFBwiGpFS5TL+RSg0Qg2uCtOOpBJabQ3yZRU7ElT
 lwQA2fWIV/Sg94XYTq6NVd58dTe27Dj26Gi5MuC24UmVQMB+5V6gUwTuq6+LwUlIzdI+ser
 VFkGwi+d3/Z2jwojMMutA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Cfr65aWbw4U=:T80T8TR+AVpWDNpfU+UZed
 Ot6RqyFpXJfjb7vhAuwwvCXt7o/rmYOIMY6kR1NnwBxS/4Mclf9aRl3tyTYVJuSg5c7HhFOqi
 KRY5yPCDRuyQvBNQXJXA1WE2Ijhy/PrT+GAqGLrVnmIyRy0gnU3EmEInROjq8L731gEOXd33l
 xZ1h9X0y5k/O5sZCgHjWLfsOF3Bc6Pf7amJ4f/mnv5uAuKTE6gMmE9lvWKWnhr3q7nm7J+6vj
 NIht9E78PY2LjvNpMoVUZf+g6N4/Y4CcoduATY5Xng/UyTk+cZrHGP30Cw7a9yFyeXfgwCVWt
 Q4vbZ9kmX7qm6nmBZzXPpn4k8XkduJosGP25y/z6ay8Mv1wWfF0YWTu8cCmrWKZ6zxku9lAci
 soPZniq5BiK52EVYzkYPeFcMCh50n4ebWnw6HMeXaCpvEBL+VMtHh+CRU5QR0eyd9w11F7BtW
 OC2XYbuEvg3uSy21S6wgdQ5EqQSLn8sU6KYHWxlihf5eSPPYvWq7oo9SIwr7FOhjUlMZtDzIN
 s4uDqj7rMi/BycL78CvXndy+qAsC+4ErZN7TYHyvKTJeCl6a5/FwedDIQoHSjE6xqPIYG5qGI
 bDiRMpDNHDMMsOGuWp2/41s0/6YrmcbyJqGhmutViz48IY0lIWx3Sc9Oj5H2NkspcbMVe4IFO
 kxs3UE4KncLBzZtBjULsSWcZviutIPVhZkWQ1mPUz0J4uhFBtzjOIpuLGws1+NMJndxJOjAS+
 hyfYlSzdFcxuFYivq+4XaKsIVynjmfpsV8S3MLuhnSwfMV+3wZhZsLk619soHLPzcZlT81oJE
 TE1Yb9q
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
