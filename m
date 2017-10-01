Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E63820A10
	for <e@80x24.org>; Sun,  1 Oct 2017 14:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbdJAO5L (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 10:57:11 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:51569 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbdJAO5I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 10:57:08 -0400
Received: by mail-wm0-f47.google.com with SMTP id i131so6373361wma.0
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 07:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MeTfR+vhm964VDHnFOwb+BkdAtXj8mLInwiSFFPGwX0=;
        b=JrCbltRhVVKTsmx7Xj65Se83SyiY3UzDv6mhbDMXYBmiYh+ynk4NcKW+o62vh8Yucf
         SmSmHRlaZ22UklwP2w9+NKPfxASmg2pMuH/NBcIuGSJtNq7ZeKA/dt86yo991ancUz6n
         Gj89ldO+rBSwVbEdlz4WkVUIZRdSmf1IL6z9tciiCyAu8Rc6CRioJZ+Za5jfJeUjPUBI
         bcX29uOjMj7mkw21LYjVYgNCoKw6DbXY7lN/douJykhPpwuwvESYGFnP68ofblexZDJt
         jQlKK8rDI0iOi2EdRp6IXUI8zxPdqL+FtruwJFRlmFChnvxle46T1s3siFtMk7b9jHHB
         J56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MeTfR+vhm964VDHnFOwb+BkdAtXj8mLInwiSFFPGwX0=;
        b=MJjjVb4il6Wxb6efQBbybSSvPZGJC4n/lSn1TrxMDzXgGmHa05Fudq4swHnnUOFcA0
         DeKo++L2WmBzs3MSBWVaz1//xzLkmRGm+2XE43t8uEpMhSGjOUk67qmBdaQXXQpQP7/9
         kPGXaA/ByBcmlnOO9PEYZf8r2cdP76NRd9IiiOx+YW8Gk/mofFVm/19iK3xgway4G52P
         A7OLfJ7FSSYfKlXstZF6Nj6CDjnVy5awF80WUtwtdTmcut7uMc1RnUq2qyng+d5hxk9u
         HLAr9APuR6cPma0akdM1wPU5yL9eB8i0eETpTmVxZINfjA2oW3rX4quUy/FNtTdiFUuk
         b5ow==
X-Gm-Message-State: AMCzsaU37/KSu9MlZwsGzfTz+TAiturvghxBv8nODeXJhx0BlvdQiwep
        nCmPEszy/fk1h0MFDKK2VWvYDg==
X-Google-Smtp-Source: AOwi7QCgZslJdBNoPmjF3wOjAXKa4AprB0BQxXXcJKZbmCFagDI3Tc42qztmDklUxGEwc7OGuD+VVQ==
X-Received: by 10.28.19.10 with SMTP id 10mr8462939wmt.87.1506869826842;
        Sun, 01 Oct 2017 07:57:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id w82sm10473516wme.5.2017.10.01.07.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Oct 2017 07:57:06 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/11] read-cache: don't leave dangling pointer in `do_write_index()`
Date:   Sun,  1 Oct 2017 16:56:11 +0200
Message-Id: <6d36f0a8e3c7b81e8c815782fb67fc69f86f2837.1506862824.git.martin.agren@gmail.com>
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

If `do_write_index(..., struct tempfile *, ...)` fails to close the
temporary file, it deletes it. This resets the pointer to NULL, but only
the pointer which is local to `do_write_index()`, not the pointer that
the caller holds. If the caller ever dereferences its pointer, we have
undefined behavior (most likely a crash). One of the two callers tries
to delete the temporary file on error, so it will dereference it.

We could change the function to take a `struct tempfile **` instead. But
we have another problem here. The other caller, `write_locked_index()`,
passes in `lock->tempfile`. So if we close the temporary file and reset
`lock->tempfile` to NULL, we have effectively rolled back the lock. That
caller is `write_locked_index()` and if it is used with the
`CLOSE_LOCK`-file, it means the lock is being rolled back against the
wishes of the caller. (`write_locked_index()` used to call
`close_lockfile()`, which would have rolled back on error. Commit
83a3069a3 (lockfile: do not rollback lock on failed close, 2017-09-05)
changed to not rolling back.)

Note also that if we would ever have failed to close the lockfile,
either with `COMMIT_LOCK` or with `CLOSE_LOCK`, that would have happened
already in `do_write_index()` and we would have left the lock in such a
state that trying to, e.g., roll it back or reopen the file would most
likely have crashed.

Do not delete the temporary file in `do_write_index()`. One caller will
avoid rolling back the lock, the other caller will delete its temporary
file anyway, and for both callers we will avoid crashes.

Expand the documentation on `write_locked_index()` to note that the lock
will never be rolled back when using `CLOSE_LOCK`. We can not yet make a
similar claim about `COMMIT_LOCK`; we'll fix that in the next commit.

It does feel a bit unfortunate that we simply "happen" to close the lock
by way of an implementation-detail of lockfiles. But note that we need
to close the temporary file before `stat`-ing it, at least on Windows.
See 9f41c7a6b (read-cache: close index.lock in do_write_index,
2017-04-26).

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 cache.h      | 2 ++
 read-cache.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 32aa8afdf..4d09da792 100644
--- a/cache.h
+++ b/cache.h
@@ -617,6 +617,8 @@ extern int read_index_unmerged(struct index_state *);
  * adjust its permissions and rename it into place, then write the
  * split index to the lockfile. If the temporary file for the shared
  * index cannot be created, fall back to the normal case.
+ *
+ * With `CLOSE_LOCK`, the lock will be neither committed nor rolled back.
  */
 extern int write_locked_index(struct index_state *, struct lock_file *lock, unsigned flags);
 
diff --git a/read-cache.c b/read-cache.c
index 1ec2e8304..8e498e879 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2314,7 +2314,6 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		return -1;
 	if (close_tempfile_gently(tempfile)) {
 		error(_("could not close '%s'"), tempfile->filename.buf);
-		delete_tempfile(&tempfile);
 		return -1;
 	}
 	if (stat(tempfile->filename.buf, &st))
-- 
2.14.1.727.g9ddaf86

