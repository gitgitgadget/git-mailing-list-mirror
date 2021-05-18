Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B82FC43461
	for <git@archiver.kernel.org>; Tue, 18 May 2021 18:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00EC96124C
	for <git@archiver.kernel.org>; Tue, 18 May 2021 18:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351599AbhERSeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 14:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351602AbhERSeK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 14:34:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E12C06175F
        for <git@vger.kernel.org>; Tue, 18 May 2021 11:32:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v12so11307266wrq.6
        for <git@vger.kernel.org>; Tue, 18 May 2021 11:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yIaSykTHkZm7kVR794lpGSXGwJW8B3o4eXrOf0WDx9w=;
        b=uqDhagkDqQFXOL3stfNyUoMSf6njY8mBMg0v6ENWMYEOkac4drH3/GnOzeKfYDmpM8
         ZMQ8J2QzIET8eotKUZbe5Pn1Rbobe50mSGpNLT1XP9F0VxkJw4S/W/1rt9YPwDKbfJsi
         Rq3DF4ppAGLKUt/YzmUAHhbpuCWCoU7ZM3FLPX5ARpdlFiZuut5It/ZULwB8j7KZ/iUv
         zj4p+EkNSbh5Zs51hY7xG04Uwm+azrLNScDqJBjy4QfsAcuEf6fFfYDgCxwiVNwTZCx2
         aO2jNLX0h28VSRuABoPjZYr3TJ3G7BB6us2D7p2HNkJ5kzaTbWnpHcYbEQYf3T7ez/n0
         yBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yIaSykTHkZm7kVR794lpGSXGwJW8B3o4eXrOf0WDx9w=;
        b=HNE3z7fZb5fVeqO18BYqdyykbdRkZM2tN456c8wmYbMlD8xMrojkpdv6Z0//AALQ2S
         5/flSKWzJtquxAgTKzrLT8Sj6o1x7fNsBjeeyGSL9LF+A7KuNyERFpqsRAFoODBsqso7
         /dANcaKEKKXrx0crt2OEixGtdVWHyBi9+0AERq6h6g2oHyZH7pA3qaGbOQmRIhwD5Uem
         /2VgYhtitz5uBl8nkmuGg03UqiGWjx+UBk0Qy0JpvWxLK8a8fWh3L7AEuWqP14HE8ps8
         iUPW5gTVzJKpv930SfUENedI4VV0fs7l4snlg77If1ftLDXeECNR1Ty3z23lPr1VoLLV
         3DLQ==
X-Gm-Message-State: AOAM5312OZ+17CnwZFOWzM/DjWbK5+9qfJwXdTI/jCjqxwttHg9X8Ij5
        xMlGeEfTthC23AOhzHo9tzFjBBN0PuY=
X-Google-Smtp-Source: ABdhPJyVnKddi1k+PiP8rTVn9I9BSmxV/HMfvZoQbkODI4T9GwjgfWDHk7BZgzuKXIO2QuvTM7Yrhg==
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr8843184wru.94.1621362770503;
        Tue, 18 May 2021 11:32:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y5sm22848977wrp.5.2021.05.18.11.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:32:50 -0700 (PDT)
Message-Id: <b3e578ac0365fba9ef015f2e9a06593ce85d2814.1621362768.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.916.v3.git.1621362768.gitgitgadget@gmail.com>
References: <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
        <pull.916.v3.git.1621362768.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 May 2021 18:32:45 +0000
Subject: [PATCH v3 1/4] hashfile: use write_in_full()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, stolee@gmail.com,
        git@jeffhostetler.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The flush() logic in csum-file.c was introduced originally by c38138c
(git-pack-objects: write the pack files with a SHA1 csum, 2005-06-26)
and a portion of the logic performs similar utility to write_in_full()
in wrapper.c. The history of write_in_full() is full of moves and
renames, but was originally introduced by 7230e6d (Add write_or_die(), a
helper function, 2006-08-21).

The point of these sections of code are to flush a write buffer using
xwrite() and report errors in the case of disk space issues or other
generic input/output errors. The logic in flush() can interpret the
output of write_in_full() to provide the correct error messages to
users.

The logic in the hashfile API has an additional set of logic to augment
the progress indicator between calls to xwrite(). This was introduced by
2a128d6 (add throughput display to git-push, 2007-10-30). It seems that
since the hashfile's buffer is only 8KB, these additional progress
indicators might not be incredibly necessary. Instead, update the
progress only when write_in_full() complete.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 csum-file.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 7510950fa3e9..3c26389d4914 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -25,21 +25,14 @@ static void flush(struct hashfile *f, const void *buf, unsigned int count)
 			die("sha1 file '%s' validation error", f->name);
 	}
 
-	for (;;) {
-		int ret = xwrite(f->fd, buf, count);
-		if (ret > 0) {
-			f->total += ret;
-			display_throughput(f->tp, f->total);
-			buf = (char *) buf + ret;
-			count -= ret;
-			if (count)
-				continue;
-			return;
-		}
-		if (!ret)
+	if (write_in_full(f->fd, buf, count) < 0) {
+		if (errno == ENOSPC)
 			die("sha1 file '%s' write error. Out of diskspace", f->name);
 		die_errno("sha1 file '%s' write error", f->name);
 	}
+
+	f->total += count;
+	display_throughput(f->tp, f->total);
 }
 
 void hashflush(struct hashfile *f)
-- 
gitgitgadget

