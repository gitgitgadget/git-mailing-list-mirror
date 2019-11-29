Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD72C43215
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017802464A
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+aW7i5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfK2Vol (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:44:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36843 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfK2Vok (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 16:44:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so36752635wru.3
        for <git@vger.kernel.org>; Fri, 29 Nov 2019 13:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CrSydzkPorkY70NIIf7uu/gw8DgyVylJRX2zcH6xkII=;
        b=a+aW7i5htM9HNlWY/0TpDuQabIVRoR2ZBr94sc1esc7w4VnzdEMPxLqTCPgyAfsJG0
         Hn+K4Mh85dJDw8QQxGohmg6/6SagAhx60UW6LaAQF2ic0JiwXTFdnpmPF1ftKL8JGFFd
         Kw1O30d0X8kIWpE1nBPYo+/SnX1+0ygBZukCzijam7wVghvV8OPb6N0aT7PzPlx7XF2w
         zVMxyUMMmPas8dg17r+WyGnx3raC4HqhYmjfGzKKdxsNW+FsLiZkHaeD9rJh7T1fMrJg
         M38zFoyL6elzYDZBBIbSEPp5fhqHBmssrMFtv1mRNB2AQQ64H0uBLAcULvRbDWMTTtdz
         06EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CrSydzkPorkY70NIIf7uu/gw8DgyVylJRX2zcH6xkII=;
        b=LgN4tryApnB6ZansqTLHBVpgtdQUH+hd3teqCKb2AW9tqrOjZ9mNGg3WfnFESz0bQY
         fTH0T41k3BG50B46S5BniRg2ltPwHmGSsmdl/fXetCCBmJfVMmBJBH5eG3IPidIe2JmH
         fc6m5OTiM8liMqOTPEsvqTH+O+5ujUtvSFXroARWwOYvJiBl2h08WNKGfQH7jlkY8R9k
         WF8alJaTUL4tFsKMeQYtxsV8/AuEB8EQ/Y+mSa3Hegwzkkjj2NoI0EAedA+fvuAU4/fm
         EHirhonu/k+Oy91Epw28g3/TfdvJFPcvBZDLMTYabN9J3/ZzKcKkn5CM46n0aGod9apP
         3KSQ==
X-Gm-Message-State: APjAAAVCrBhKpWN6jP2m3/ErKiqcvjy6azU5+vHct70ZZT8OcLLyCmP5
        SJlxJf3RYUeTLjvihsXDnKspwk7y
X-Google-Smtp-Source: APXvYqxm8RQDZuaJ3UxBcOMSZhqw9ZBUvHR8J58/onPHC7eCu6cQhANua6CBVE/1NMXeGdEVbblcVg==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr12139503wrv.269.1575063878268;
        Fri, 29 Nov 2019 13:44:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6sm15360606wmb.1.2019.11.29.13.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 13:44:37 -0800 (PST)
Message-Id: <685360f735e35e837bc9ef684cbde33564c81666.1575063876.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.480.git.1575063876.gitgitgadget@gmail.com>
References: <pull.480.git.1575063876.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Nov 2019 21:44:36 +0000
Subject: [PATCH 1/1] mingw: do set `errno` correctly when trying to restrict
 handle inheritance
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 9a780a384de (mingw: spawned processes need to inherit only standard
handles, 2019-11-22), we taught the Windows-specific part to restrict
which file handles are passed on to the spawned processes.

Since this logic seemed to be a bit fragile across Windows versions (we
_still_ support Windows Vista in Git for Windows, for example), a
fall-back was added to try spawning the process again, this time without
restricting which file handles are to be inherited by the spawned
process.

In the common case (i.e. when the process could not be spawned for
reasons _other_ than the file handle inheritance), the fall-back attempt
would still fail, of course.

Crucially, one thing we missed in that code path was to set `errno`
appropriately.

This should have been caught by t0061.2 which expected `errno` to be
`ENOENT` after trying to start a process for a non-existing executable,
but `errno` was set to `ENOENT` prior to the `CreateProcessW()` call:
while looking for the config settings for trace2, Git tries to access
`xdg_config` and `user_config` via `access_or_die()`, and as neither of
those config files exists when running the test case (because in Git's
test suite, `HOME` points to the test directory), the `errno` has the
expected value, but for the wrong reasons.

Let's fix that by making sure that `errno` is set correctly.

It would be nice if we could somehow fix t0061 to make sure that this
does not regress again. One approach that seemed like it should work,
but did not, was to set `errno` to 0 in the test helper that is used by
t0061.2.

However, when `mingw_spawnvpe()` wants to see whether the file in
question is a script, it calls `parse_interpreter()`, which in turn
tries to `open()` the file.0/compat/mingw.c#L1134. Obviously,
this call fails, and sets `errno` to `ENOENT`, deep inside the call
chain started from that test helper.

Instead, we force re-set `errno` at the beginning of the function
`mingw_spawnve_fd()`, which _should_ be safe given that callers of that
function will want to look at `errno` if -1 was returned. And if that
`errno` is 0 ("No error"), regression tests like t0061.2 will kick in.

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 2b6eca2f56..bb4eb4211a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1423,6 +1423,9 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 	const char *(*quote_arg)(const char *arg) =
 		is_msys2_sh(*argv) ? quote_arg_msys2 : quote_arg_msvc;
 
+	/* Make sure to override previous errors, if any */
+	errno = 0;
+
 	if (restrict_handle_inheritance < 0)
 		restrict_handle_inheritance = core_restrict_inherited_handles;
 	/*
@@ -1580,8 +1583,8 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 		ret = CreateProcessW(*wcmd ? wcmd : NULL, wargs, NULL, NULL,
 				     TRUE, flags, wenvblk, dir ? wdir : NULL,
 				     &si.StartupInfo, &pi);
+		errno = err_win_to_posix(GetLastError());
 		if (ret && buf.len) {
-			errno = err_win_to_posix(GetLastError());
 			warning("failed to restrict file handles (%ld)\n\n%s",
 				err, buf.buf);
 		}
-- 
gitgitgadget
