Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D39CC432C3
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 11:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44897215E5
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 11:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEX3zPoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfLBLdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 06:33:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35305 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfLBLde (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 06:33:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id u8so7301587wmu.0
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 03:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VHcKo6z3SUU9qF3WHhAITjhsf0gwlwLshM5Ogo6j27w=;
        b=gEX3zPozcgAZUW0MWDwfOhCt5cV8nO6ApKJUJk/XXjvjJHJfDzOQSWEvHnE4zSNxvX
         A5rpvdPgdImmoj3sqxj+nGenblnmJPCYeA9SNybIpYPwW+h+7c6LoRh6/J9PzWZc/4gO
         H1z9YnX4BRLogo0/us+Pf0vOcqJ5u6pWVg2AWKMuAnx8n5YgqKZ0d5F6LdhgZ7Ee2DRR
         5T/ARZm1ciLhufKLLvVuL6gvjAVrgo0tvt3fo7+DgCll9Y/7iTRnc2XfaJP+D58ovtQk
         U5D2HOFEsXOdMfBF35xtn4nEqcnB8NvRyIWD7nWGgCl57UzYm3XVslsZv0D8ODxTATwc
         8N8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VHcKo6z3SUU9qF3WHhAITjhsf0gwlwLshM5Ogo6j27w=;
        b=a6sW4zzgbcLn9ywVplL6ejaz0z38G0akBVGQwdPWraTtY9JuHTF466WIm0UhhglpCj
         YtbZrZiupMjpcXAhw5x2l+DjaGESfLwdkrtt5An7y1VIk6kwv11kpy9+xxi0dfX+YjJm
         8BNIydDNl6IQXsrSdaRKo0HohNgknTuqna/6MXwFj8g7EuvDAP174BrZIxC8IhM+rWfl
         QimA/DCT8RY9cdtpeBIX4DqA44EIuI0kPisRH52JiCAUVwYv9WRGr9/DhIzRKOeQGHIj
         5f2Z87soxb6BKX53f3gmX0LmhncRrxfN8YlTi+rdEvMHCO5lG/hT3l/VbWKagKpsvTue
         e5wg==
X-Gm-Message-State: APjAAAVpXLjDs1d5xoGKonGBMXfCyr7rVXzGGksImA8VGfqvXwrWeCbI
        ivH7xm10nI0K5lRn8AVJgSFtAx6C
X-Google-Smtp-Source: APXvYqxBEGFvGUbKQMjgZg/si0Hbeu+PZUZFAfaPIatRuvBrmgPQE88lFKn/22AJLFJNDoQvSINd5w==
X-Received: by 2002:a7b:c632:: with SMTP id p18mr18824141wmk.175.1575286411226;
        Mon, 02 Dec 2019 03:33:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b17sm14891288wrx.15.2019.12.02.03.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 03:33:30 -0800 (PST)
Message-Id: <280b6d08a4cdae7af168371670f41585aa4778d4.1575286409.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.480.v3.git.1575286409.gitgitgadget@gmail.com>
References: <pull.480.v2.git.1575110200.gitgitgadget@gmail.com>
        <pull.480.v3.git.1575286409.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Dec 2019 11:33:28 +0000
Subject: [PATCH v3 1/2] mingw: do set `errno` correctly when trying to
 restrict handle inheritance
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

Let's fix that by making sure that `errno` is set correctly. It even
appears that `errno` was set in the _wrong_ case previously:
`CreateProcessW()` returns non-zero upon success, but `errno` was set
only in the non-zero case.

It would be nice if we could somehow fix t0061 to make sure that this
does not regress again. One approach that seemed like it should work,
but did not, was to set `errno` to 0 in the test helper that is used by
t0061.2.

However, when `mingw_spawnvpe()` wants to see whether the file in
question is a script, it calls `parse_interpreter()`, which in turn
tries to `open()` the file. Obviously, this call fails, and sets `errno`
to `ENOENT`, deep inside the call chain started from that test helper.

Instead, we force re-set `errno` at the beginning of the function
`mingw_spawnve_fd()`, which _should_ be safe given that callers of that
function will want to look at `errno` if -1 was returned. And if that
`errno` is 0 ("No error"), regression tests like t0061.2 will kick in.

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 2b6eca2f56..432adc1aed 100644
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
@@ -1580,8 +1583,9 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 		ret = CreateProcessW(*wcmd ? wcmd : NULL, wargs, NULL, NULL,
 				     TRUE, flags, wenvblk, dir ? wdir : NULL,
 				     &si.StartupInfo, &pi);
-		if (ret && buf.len) {
+		if (!ret)
 			errno = err_win_to_posix(GetLastError());
+		if (ret && buf.len) {
 			warning("failed to restrict file handles (%ld)\n\n%s",
 				err, buf.buf);
 		}
-- 
gitgitgadget

