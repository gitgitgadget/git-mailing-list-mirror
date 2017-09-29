Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 868E520281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbdI2UMf (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:12:35 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:50256 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752628AbdI2UMb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:12:31 -0400
Received: by mail-pg0-f54.google.com with SMTP id p5so349220pgn.7
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=onVjHtgiZBlZshqbwV7uTOmVYxH1XyqW+mb5Cfvn+Zk=;
        b=YhqDCHgynrOk1niNk2nV33vSzGZkWY7dSdbgJOJFcTB0RDfo4aH2IuBxguEuHyBm+M
         hXuO2x/bXogWSGlxnfoUazk+1PClLgTi0nqxFs++8ue8JUejCRy6VEBje4+9z2OxrfmQ
         AXz0dQzodZEMOdJSFAF0v5PpktSkXhMp8pKX7kZvdk4GcqXtymZ0vGP8UzeeSBLpPM3W
         fic9yyrsuu7jqREasrfA2oFY4LswjZdXKtTArC1W3eTU2LN1r5zlHh0UYQkGeFcfCE8u
         0G+CpkCtEvNGml49GLmdB8oldy0mqRsJH+kNl49IpXRD4YUBa1+CyrcwQ7O1MOxDaLvE
         1o0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=onVjHtgiZBlZshqbwV7uTOmVYxH1XyqW+mb5Cfvn+Zk=;
        b=PBtyJa0GNdykbbR3X8eyvydiGPPvLKd4675+NmOE94O8byvLJYk8HqlF2nXicd84hb
         BOg74b8nk3vaZ5ZgmOreReGaicOsbNEOy7Oe/9MliTCRGTuSHwb/oVNC4Z9wCRoaesca
         mJH21ZGRRdjr8oNHE9GL1PM+dFuSAP5Msb+3lRuS2V0vBDqXGd0NPKklH/ewYEw76Mds
         AV8dmnHfgZs0rAmhxLUsZu9kaFD7AhsiEKkiSF854uAY4/bJTa4rgg9zxxKp9+T9RAZ+
         i6tmL8TMYCzBMgpuml4TgQYGK6xxupx1nq3xt9VawVP4Uo+BLA/nrZ4WPx/6VH6JDkF7
         c/Jw==
X-Gm-Message-State: AHPjjUj03Edw7hz1tQ2gRCpttZLtA8w9VMSktna4VPO0+olM7laQzEdf
        olR6/fbu1WItGZY+j4LNohNh5qgU2xw=
X-Google-Smtp-Source: AOwi7QDYyHQQ0XQok6BxFyg/8xp3q4HtHYmb0z2SrlevSGYT5mJaG90POap1Jtf5vAfd6mEQttNMhw==
X-Received: by 10.159.194.10 with SMTP id x10mr8350300pln.47.1506715950747;
        Fri, 29 Sep 2017 13:12:30 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id g5sm9280561pgo.66.2017.09.29.13.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 13:12:30 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        git@jeffhostetler.com, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 18/18] fetch-pack: restore save_commit_buffer after use
Date:   Fri, 29 Sep 2017 13:11:54 -0700
Message-Id: <b88725476d9f13ba4381d85e5fe049f6ef93f621.1506714999.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.748.g20475d2c7
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In fetch-pack, the global variable save_commit_buffer is set to 0, but
not restored to its original value after use.

In particular, if show_log() (in log-tree.c) is invoked after
fetch_pack() in the same process, show_log() will return before printing
out the commit message (because the invocation to
get_cached_commit_buffer() returns NULL, because the commit buffer was
not saved). I discovered this when attempting to run "git log -S" in a
partial clone, triggering the case where revision walking lazily loads
missing objects.

Therefore, restore save_commit_buffer to its original value after use.

An alternative to solve the problem I had is to replace
get_cached_commit_buffer() with get_commit_buffer(). That invocation was
introduced in commit a97934d ("use get_cached_commit_buffer where
appropriate", 2014-06-13) to replace "commit->buffer" introduced in
commit 3131b71 ("Add "--show-all" revision walker flag for debugging",
2008-02-13). In the latter commit, the commit author seems to be
deciding between not showing an unparsed commit at all and showing an
unparsed commit without the message (which is what the commit does), and
did not mention parsing the unparsed commit, so I prefer to preserve the
existing behavior.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index 19b8e9322..8e6f54547 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -719,6 +719,7 @@ static int everything_local(struct fetch_pack_args *args,
 {
 	struct ref *ref;
 	int retval;
+	int old_save_commit_buffer = save_commit_buffer;
 	timestamp_t cutoff = 0;
 
 	save_commit_buffer = 0;
@@ -786,6 +787,9 @@ static int everything_local(struct fetch_pack_args *args,
 		print_verbose(args, _("already have %s (%s)"), oid_to_hex(remote),
 			      ref->name);
 	}
+
+	save_commit_buffer = old_save_commit_buffer;
+
 	return retval;
 }
 
-- 
2.14.2.822.g60be5d43e6-goog

