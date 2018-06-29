Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9451F516
	for <e@80x24.org>; Fri, 29 Jun 2018 20:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965537AbeF2U2S (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 16:28:18 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:55712 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965491AbeF2U2P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 16:28:15 -0400
Received: by mail-yw0-f201.google.com with SMTP id a200-v6so8712419ywh.22
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 13:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=VDpYI19eLPd6OYlphnveGUM64xppFy5X+tbL8yrKR+k=;
        b=Q8VefNYTbCd8DBXlPlxPbxXYkLBdS1n1PofswnGg2PPdwrsRquiRdkK9EflepG4T1i
         ZII/rukHU02sDteLRRinye5I7QhyepZAGGmWd3Cs3LA1uLxCRBkdjn9Gok0CgLalia+F
         6kE+SLiZpaceTCyDo14u07FdFL7aD24ht1jn5J2s1liuks4YgZ2KbcdT3ZVw5PgjIQep
         XHhRe7c0+e2udTcdkSAb6b2H/9tYbNRh2DtGxHWDXJg1jG5nYighhxpAReAHjz7UyG3b
         Php1yWULrty4+jrC4II/bVjx7o88TjyfgRQaXzCvSFi6oxqnrfr3qDMtG4G44dXPo2lU
         MX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=VDpYI19eLPd6OYlphnveGUM64xppFy5X+tbL8yrKR+k=;
        b=qCSnKYy6o1ZsHAPB1/e2FCieLo3029UnKTnHjtqmtUjmAjT5v5KGCom4Wl9EzPkiNT
         qO9ejSQs+JtWsgyrDsNDB5OyUsQrcD0RtFiSKV7Yxiy+j2tNqrRbZ/FlUtqhXHAXV1ki
         HARKcO7wyWcNsVtlc9sn2FH4/Y/5xJBQVEW2rJ3awCpUp1OvGCI4BnFL0+oyf8xlvk5R
         VQnoPvabVb85WtyRmh2oN4J3ZHRCB19lMI1LNY+XIVWq0H12LMEKp01Mu/okPrXCrort
         VQ/JNAWhE8FnPOMSHOFTfXrwvJmj0QSiMM7GU8Ljb2w86aKSMpbPJGWEw5NF+yO+wgln
         QMfA==
X-Gm-Message-State: APt69E2sRkmFWB5x0DntISUzkCDJd7OzN0tzrA89bqU1eg+pzo+hthaJ
        nPBV6eDH/4VUR96wf07+ecf8Y7pBrjA4
X-Google-Smtp-Source: ADUXVKKX19vx5qWjKG7YqRfDNj7L+nH6CtEIo/b52ZCPFd+J08FGX1Umjz4jJiXUouGUMkb+v4vlSpF2FIV0
MIME-Version: 1.0
X-Received: by 2002:a5b:401:: with SMTP id m1-v6mr4383867ybp.39.1530304095247;
 Fri, 29 Jun 2018 13:28:15 -0700 (PDT)
Date:   Fri, 29 Jun 2018 13:28:11 -0700
In-Reply-To: <CAGZ79kb0FOafEsuXU7c_BTwPtcujFeyWVhzSuzFHRFtQHp9weQ@mail.gmail.com>
Message-Id: <20180629202811.131265-1-sbeller@google.com>
References: <CAGZ79kb0FOafEsuXU7c_BTwPtcujFeyWVhzSuzFHRFtQHp9weQ@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH] xdiff: reduce indent heuristic overhead
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     mhagger@alum.mit.edu, git@vger.kernel.org, jamill@microsoft.com,
        mh@glandium.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch was written originally for mercurial at
https://phab.mercurial-scm.org/rHGc420792217c89622482005c99e959b9071c109c5

    changeset:   36674:c420792217c8
    user:        Jun Wu <quark@fb.com>
    date:        Sat Mar 03 12:39:11 2018 -0800
    files:       mercurial/thirdparty/xdiff/xdiffi.c
    description:
    xdiff: reduce indent heuristic overhead

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

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This applies on our master branch, I have not thought of a
good commit message or if we need to test it.

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

