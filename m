Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4974B20A10
	for <e@80x24.org>; Sun,  1 Oct 2017 14:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbdJAO5G (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 10:57:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:48735 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbdJAO5F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 10:57:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id i82so4272466wmd.3
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 07:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8myDfMUrjdDG8Qo/pY4fBUUKk5JVv0cZoVStcOXRFw=;
        b=h/E9xSUTsm7fhWDHfm5ou6qo0kjjQoiV5nZlmm45A3piJyRohHAyhXRVtsa+FyZ3Zl
         u3td4W5ZKIbSw4YpJfoIlb6QZz3+50YZZL3A9wy1tJFwFBnG4Cw0Jbdjp4/HedVbUsUp
         7vLloa3EVGEjrNlAZrZTKwDPx0z5b7tNQWVlKG28C4jSJSxYcBlqcJ4LuxqE47KklPWy
         b52O0U8hK4lFguF5oPPGGB4Ipd9pwJhBR09pGrrtg11jYRlQtf6keC8fVLgow2S/EGrP
         Qgnm43ZBkI+613DqYeyoEqtNsTqHPTVDvqJXAoY8kUCK29uaqGLerrZU2LsXv/R1MMbj
         uDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8myDfMUrjdDG8Qo/pY4fBUUKk5JVv0cZoVStcOXRFw=;
        b=paRHATZVv5FptuayFN2LQubEcqM/tcJBVEkEKoDPepcUSJB+S50D1RqAhKV5NzG4Hk
         Q8ROR85W5vUL3nDI+W+c36ATQwcPk5HOzeSyjQQAer+KPJX4q51kzwBLcf+dA0OGX44u
         wNeDKzBVjR8tnm9K5wvURT3lINN+0tHc9nGviVPIJfqeWFEi4ZVaa+29Lzl4YAwZ++6b
         35nCMtKDLi+kkPRG+yttkS4c1ZrtCQvsgoTEGoklthD9StyV3SJtdctW+LAoJf7QL7Bt
         IqaTRSiKgv6YoKTRHIjiXd2w3V04eMMD4tiHFJHT8atiNycOhnBUT8m50m3UBoCoCLFo
         ob7A==
X-Gm-Message-State: AMCzsaXtZF5uZK36rnDxYeNP1Rke0VM00cGgoyXv9LJYwVxhNqDgTDPs
        NRG7iErYVse+zTcWTheYRvoH7w==
X-Google-Smtp-Source: AOwi7QBx+x48em44QXiIPJ9KWdfNw8YaJgrdiLh1QE/55Uclk8EM8+tDhVXZXPwxy5RdNiIH/6CJhw==
X-Received: by 10.28.150.82 with SMTP id y79mr7994275wmd.54.1506869823581;
        Sun, 01 Oct 2017 07:57:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id w82sm10473516wme.5.2017.10.01.07.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Oct 2017 07:57:02 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/11] read-cache: require flags for `write_locked_index()`
Date:   Sun,  1 Oct 2017 16:56:10 +0200
Message-Id: <d912e33a1395ff25c1496715d0a537858daa885a.1506862824.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.727.g9ddaf86
In-Reply-To: <cover.1506862824.git.martin.agren@gmail.com>
References: <cover.1506862824.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`write_locked_index()` takes two flags: `COMMIT_LOCK` and `CLOSE_LOCK`.
At most one is allowed. But it is also possible to use no flag, i.e.,
`0`. But when `write_locked_index()` calls `do_write_index()`, the
temporary file, a.k.a. the lockfile, will be closed. So passing `0` is
effectively the same as `CLOSE_LOCK`, which seems like a bug.

We might feel tempted to restructure the code in order to close the file
later, or conditionally. It also feels a bit unfortunate that we simply
"happen" to close the lock by way of an implementation detail of
lockfiles. But note that we need to close the temporary file before
`stat`-ing it, at least on Windows. See 9f41c7a6b (read-cache: close
index.lock in do_write_index, 2017-04-26).

So let's punt on the restructuring. Instead, require that one of the
flags is set. Adjust documentation and the assert we already have for
checking that we don't have too many flags. Add a macro `HAS_SINGLE_BIT`
(inspired by `HAS_MULTI_BITS`) to simplify this check and similar checks
in the future.

When (if) we need "write the index and leave the lockfile open", we can
revisit this.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 cache.h           |  4 ++--
 git-compat-util.h |  7 ++++++-
 read-cache.c      | 12 ++++++------
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index 4605e8228..32aa8afdf 100644
--- a/cache.h
+++ b/cache.h
@@ -607,8 +607,8 @@ extern int read_index_unmerged(struct index_state *);
 #define CLOSE_LOCK		(1 << 1)
 
 /*
- * Write the index while holding an already-taken lock. The flags may
- * contain at most one of `COMMIT_LOCK` and `CLOSE_LOCK`.
+ * Write the index while holding an already-taken lock. The flags must
+ * contain precisely one of `COMMIT_LOCK` and `CLOSE_LOCK`.
  *
  * Unless a split index is in use, write the index into the lock-file,
  * then commit or close it, as indicated by `flags`.
diff --git a/git-compat-util.h b/git-compat-util.h
index cedad4d58..fa8a5a95c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -111,7 +111,12 @@
 #endif
 
 #define MSB(x, bits) ((x) & TYPEOF(x)(~0ULL << (bitsizeof(x) - (bits))))
-#define HAS_MULTI_BITS(i)  ((i) & ((i) - 1))  /* checks if an integer has more than 1 bit set */
+
+/* Checks if an integer has more than 1 bit set. */
+#define HAS_MULTI_BITS(i)  ((i) & ((i) - 1))
+
+/* Checks if an integer has precisely 1 bit set. */
+#define HAS_SINGLE_BIT(i)  ((i) && !HAS_MULTI_BITS(i))
 
 #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
 
diff --git a/read-cache.c b/read-cache.c
index 65f4fe837..1ec2e8304 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2343,14 +2343,14 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	int ret = do_write_index(istate, lock->tempfile, 0);
 	if (ret)
 		return ret;
-	assert((flags & (COMMIT_LOCK | CLOSE_LOCK)) !=
-	       (COMMIT_LOCK | CLOSE_LOCK));
+	assert(HAS_SINGLE_BIT(flags & (COMMIT_LOCK | CLOSE_LOCK)));
 	if (flags & COMMIT_LOCK)
 		return commit_locked_index(lock);
-	else if (flags & CLOSE_LOCK)
-		return close_lock_file_gently(lock);
-	else
-		return ret;
+	/*
+	 * Otherwise it's CLOSE_LOCK. The lockfile already happens
+	 * to have been closed, but let's be specific.
+	 */
+	return close_lock_file_gently(lock);
 }
 
 static int write_split_index(struct index_state *istate,
-- 
2.14.1.727.g9ddaf86

