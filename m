Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 316891F516
	for <e@80x24.org>; Fri, 29 Jun 2018 23:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936061AbeF2Xhq (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 19:37:46 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:39789 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934025AbeF2Xhp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 19:37:45 -0400
Received: by mail-oi0-f73.google.com with SMTP id s200-v6so1047884oie.6
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 16:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=bAu7OmNNoSgo6J6VZx35rDq3pFP/dc2X+79HWpPlmh8=;
        b=vcG3g5K7gcVemT+rV6r46J/NemBJ/7yfsTtIwtSE102VbfGQRkTKyTFEnmjO3mQ6L3
         p9p4iTT8tExxWHJFVNQOZlbU0zLSfWkK1sqb6o4DVfDh0AIuQHz+H2U9vJgePgNY4X10
         pvmQTY3kbWCABHUTBKldG20Od4//19rleF1BumMLu7QaEN+7u1LjzdOmnRTEJWEThzcy
         5NhbZBHGCaNUTd7r0x1qtxKBxSQ4sxW7vCDFK0d1GZpYW4OJOKVn82T2swfYYmdrktF9
         AyDuffV/KqSxNpKrBWVBsIDJwD5MUDGUbV9rbfKvHXlJ2yUj2m3Vit4zwAJvbLc+Yl77
         eEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=bAu7OmNNoSgo6J6VZx35rDq3pFP/dc2X+79HWpPlmh8=;
        b=kBl+gy7aJKhA9239mi3/UinVv32rXBC5T38RC+ooy4QrQNdt0iGffFPy65ucNKP7XD
         LJ9xXGIrQ8iXks8ruhgfgwSd4b0aRXuWURTVmHI5k0d3cuDZtThRgfFcJDS01aEUItGi
         Rrorhk00t+Bi8MiLLD4mo6t/oN3ZVYN79rq6qdstyRiY2+HIXonHL2oiejThEauCLNJ+
         xWkjrbdKFFgV/FmqzBaZgmLIwL0BX67yvGs+KjaQmc2EhWOq7EOD8e+3zcLrFEvbYMhU
         bfbMbRXP2rUy7EC+88UC1o5Djo88jcGCb/rHcwAAsfoarlezd6eK7D5dpU6nt1wdca3g
         7K9w==
X-Gm-Message-State: APt69E1USzNaNXlj8/UDcTJzo/YxQCHoE9dn7lJ9q504WmfD4GBLdP2Z
        47esUdPTtWyQ1/kVEsqnXbOb0q/qm4fG
X-Google-Smtp-Source: AAOMgpdXyTWK5XmYNXX6vxNQtqOdSBW0/NQOyFsuuOauiIdcanySUtytq8D51NpNMw+WFrpAyEp8b1C8lml8
MIME-Version: 1.0
X-Received: by 2002:a9d:303c:: with SMTP id d57-v6mr6618835otc.7.1530315464739;
 Fri, 29 Jun 2018 16:37:44 -0700 (PDT)
Date:   Fri, 29 Jun 2018 16:37:41 -0700
In-Reply-To: <xmqqfu15thr8.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180629233741.173309-1-sbeller@google.com>
References: <xmqqfu15thr8.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH] xdiff: reduce indent heuristic overhead
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jamill@microsoft.com, mh@glandium.org,
        mhagger@alum.mit.edu, sbeller@google.com, quark@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jun Wu <quark@fb.com>

This patch was written originally for mercurial at [1],
adding a limit on how long we'd be looking for an
optimal indent heuristic. Choose the limit high enough
to only limit edge cases.

    Adds some threshold to avoid expensive cases, like:

    ```
    #!python
    open('a', 'w').write(" \n" * 1000000)
    open('b', 'w').write(" \n" * 1000001)
    ```

    The indent heuristic is O(N * 20) (N = 1000000) for the above case, and
    makes diff much slower.

    Before this patch (system git 2.14.2):

    ```
    git diff --no-indent-heuristic a b  0.21s user 0.03s system 100% cpu 0.239 total
    git diff --indent-heuristic a b     0.77s user 0.02s system 99% cpu 0.785 total
    ```

    After this patch (git 2fc74f41, with xdiffi.c patched):

    ```
    # with the changed xdiffi.c
    git diff --indent-heuristic a b      0.16s user 0.01s system 90% cpu 0.188 total
    git diff --no-indent-heuristic a b   0.18s user 0.01s system 99% cpu 0.192 total
    ```

    Now turning on indent-heuristic has no visible impact on performance.

    Differential Revision: https://phab.mercurial-scm.org/D2601

[1] https://phab.mercurial-scm.org/rHGc420792217c89622482005c99e959b9071c109c5

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Jun, Junio

By changing the authorship we'd want to have a sign off from the original author,
before applying; in the previous attempt, I was merely taking the code from
mercurial as their copy of xdiff is also LGPLv2 so we are free to use that.

Thanks,
Stefan

 xdiff/xdiffi.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 0de1ef463bf..c74ec77da58 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -807,6 +807,14 @@ static void xdl_bug(const char *msg)
 	exit(1);
 }
 
+/*
+ * For indentation heuristic, skip searching for better slide position after
+ * checking MAX_BORING lines without finding an improvement. This defends the
+ * indentation heuristic logic against pathological cases. The value is not
+ * picked scientifically but should be good enough.
+ */
+#define MAX_BORING 100
+
 /*
  * Move back and forward change groups for a consistent and pretty diff output.
  * This also helps in finding joinable change groups and reducing the diff
@@ -903,19 +911,43 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			long shift, best_shift = -1;
 			struct split_score best_score;
 
-			for (shift = earliest_end; shift <= g.end; shift++) {
+			/*
+			 * This is O(N * MAX_BLANKS) (N = shift-able lines).
+			 * Even with MAX_BLANKS bounded to a small value, a
+			 * large N could still make this loop take several
+			 * times longer than the main diff algorithm. The
+			 * "boring" value is to help cut down N to something
+			 * like (MAX_BORING + groupsize).
+			 *
+			 * Scan from bottom to top. So we can exit the loop
+			 * without compromising the assumption "for a same best
+			 * score, pick the bottommost shift".
+			 */
+			int boring = 0;
+			for (shift = g.end; shift >= earliest_end; shift--) {
 				struct split_measurement m;
 				struct split_score score = {0, 0};
+				int cmp;
 
 				measure_split(xdf, shift, &m);
 				score_add_split(&m, &score);
 				measure_split(xdf, shift - groupsize, &m);
 				score_add_split(&m, &score);
-				if (best_shift == -1 ||
-				    score_cmp(&score, &best_score) <= 0) {
+
+				if (best_shift == -1) {
+					cmp = -1;
+				} else {
+					cmp = score_cmp(&score, &best_score);
+				}
+				if (cmp < 0) {
+					boring = 0;
 					best_score.effective_indent = score.effective_indent;
 					best_score.penalty = score.penalty;
 					best_shift = shift;
+				} else {
+					boring += 1;
+					if (boring >= MAX_BORING)
+						break;
 				}
 			}
 
-- 
2.18.0.399.gad0ab374a1-goog

