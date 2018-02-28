Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64DFA1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 21:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934796AbeB1V1H (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 16:27:07 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41524 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933745AbeB1V1G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 16:27:06 -0500
Received: by mail-wr0-f196.google.com with SMTP id f14so3938734wre.8
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 13:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=wJC1uRb5tdMKS774OkeDfTk8/8Nd3cqolN7vzWKYjwM=;
        b=htzLJwz6q8dyk7fpjytjJ+7GdK0yPE0MKQ50CYJYAJD1cYwbvBua200vCZI3MbNDSs
         4WWedkq702vHnkIrHMlzvjgEAEOyKAfJl6OmJtbcV7fs1LPkBAVC8tL/a8l3tLelB1LE
         9RQv0OxdCUIrzHH7y5n1WnEfpo87d6yjM+/yGoCr2vr9nuyTjnRkxBZWHkvGx7Hz1n13
         qCY/qY6RWXvJDNIIcqnz7kOdYPg0gMleOr65OoFPxsJ5scWJn9ZcF//oa2vsGQf52inr
         xAd8Tv4dO4DX2/h/tiLI/zPW6+95Nn3ULzwfAF9TE8zRaegAgaqTt6Jvmj1XZ1FIeVHN
         JyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=wJC1uRb5tdMKS774OkeDfTk8/8Nd3cqolN7vzWKYjwM=;
        b=GennRuDi/HR9jz9uIloiGTQcGSekFGjRz4jj2y50FifIER6xShHiDo3CD7DSIWExH9
         2jubGx1r9PbxpubCKhiV4Kl4OB8zsG3ZX65xXctJivV4R3z5d2Uj7K0HSSzrhXn5B4jk
         wmK0lA0X1GI7uE+V0IbGumeP4YDr8Kwy0eLacG9bU9vB1gj2sa2FdOtiSyx0Z+ugQ8RR
         O/JVoB4u9s0WXtIVozOYnEARtExJqsV+/d9TAtqnJ7BjDRFw/MnzY6Xurf75CWyCbBUC
         cyYxr9rzQ59yvKhTBM5m3AzYnIJV02YEbaG2Tj6OwyoI06Hmt90UdShSKokJ398yQEND
         pEQw==
X-Gm-Message-State: APf1xPCpMrqdIj8QhjB8lwpTvI/Rr3jalk4PQ6/zBZm4UtNOYTztB9gu
        qHM43gMdn48t11O43rzHq1I=
X-Google-Smtp-Source: AH8x224i/sTth9f8PWlN3I3K4VvlJXcnV+VjPS1jVFzdsB+dQrRkatQfJ+V7OrOce/zqwe9j7zBq3A==
X-Received: by 10.223.160.157 with SMTP id m29mr17173004wrm.119.1519853224459;
        Wed, 28 Feb 2018 13:27:04 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 55sm4414314wrz.6.2018.02.28.13.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 13:27:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        pclouds@gmail.com, bmwill@google.com, avarab@gmail.com
Subject: Re: [PATCH v1] dir.c: don't flag the index as dirty for changes to the untracked cache
References: <20180205195619.31064-1-benpeart@microsoft.com>
        <20180208103356.GA30524@sigill.intra.peff.net>
Date:   Wed, 28 Feb 2018 13:27:03 -0800
In-Reply-To: <20180208103356.GA30524@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 8 Feb 2018 05:33:56 -0500")
Message-ID: <xmqqk1uwkdp4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> A minor nit, but please use something like:
>
>   if (git_env_bool("GIT_TEST_UNTRACKED_CACHE", 0) && ...
>
> so that:
>
>   GIT_TEST_UNTRACKED_CACHE=false
>
> does what one might expect, and not the opposite.
>
> Two other thoughts:
>
>   - it may be worth memo-izing it with a static variable to avoid
>     repeatedly calling the possibly-slow getenv()
>
>   - I agree with the sentiment elsewhere that something like
>     GIT_FORCE_UNTRACKED_CACHE is probably a better name
>
> (The idea itself seems sound to me, but it's not really my area).

Somehow this topic has been hanging without getting further
attention for too long.  It's time to wrap it up and moving it
forward.  How about this?

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Wed, 28 Feb 2018 13:21:09 -0800
Subject: [PATCH] untracked cache: use git_env_bool() not getenv() for customization

GIT_DISABLE_UNTRACKED_CACHE and GIT_TEST_UNTRACKED_CACHE are only
sensed for their presense by using getenv(); use git_env_bool()
instead so that GIT_DISABLE_UNTRACKED_CACHE=false would work as
naïvely expected.

Also rename GIT_TEST_UNTRACKED_CACHE to GIT_FORCE_UNTRACKED_CACHE
to express what it does more honestly.  Forcing its use may be one
useful thing to do while testing the feature, but testing does not
have to be the only use of the knob.

While at it, avoid repeated calls to git_env_bool() by capturing the
return value from the first call in a static variable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c                             | 14 ++++++++++++--
 t/t7063-status-untracked-cache.sh |  4 ++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index da93374f0c..d445d77e62 100644
--- a/dir.c
+++ b/dir.c
@@ -2164,8 +2164,13 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 						      const struct pathspec *pathspec)
 {
 	struct untracked_cache_dir *root;
+	static int untracked_cache_disabled = -1;
 
-	if (!dir->untracked || getenv("GIT_DISABLE_UNTRACKED_CACHE"))
+	if (!dir->untracked)
+		return NULL;
+	if (untracked_cache_disabled < 0)
+		untracked_cache_disabled = git_env_bool("GIT_DISABLE_UNTRACKED_CACHE", 0);
+	if (untracked_cache_disabled)
 		return NULL;
 
 	/*
@@ -2287,7 +2292,12 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 	}
 
 	if (dir->untracked) {
+		static int force_untracked_cache = -1;
 		static struct trace_key trace_untracked_stats = TRACE_KEY_INIT(UNTRACKED_STATS);
+
+		if (force_untracked_cache < 0)
+			force_untracked_cache =
+				git_env_bool("GIT_FORCE_UNTRACKED_CACHE", 0);
 		trace_printf_key(&trace_untracked_stats,
 				 "node creation: %u\n"
 				 "gitignore invalidation: %u\n"
@@ -2297,7 +2307,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 				 dir->untracked->gitignore_invalidated,
 				 dir->untracked->dir_invalidated,
 				 dir->untracked->dir_opened);
-		if (getenv("GIT_TEST_UNTRACKED_CACHE") &&
+		if (force_untracked_cache &&
 			dir->untracked == istate->untracked &&
 		    (dir->untracked->dir_opened ||
 		     dir->untracked->gitignore_invalidated ||
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 6ef520e823..9cb16ca36d 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -14,8 +14,8 @@ test_description='test untracked cache'
 # See <20160803174522.5571-1-pclouds@gmail.com> if you want to know
 # more.
 
-GIT_TEST_UNTRACKED_CACHE=true
-export GIT_TEST_UNTRACKED_CACHE
+GIT_FORCE_UNTRACKED_CACHE=true
+export GIT_FORCE_UNTRACKED_CACHE
 
 sync_mtime () {
 	find . -type d -ls >/dev/null
-- 
2.16.2-325-g2fc74f41c5

