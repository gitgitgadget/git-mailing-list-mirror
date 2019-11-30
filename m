Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E258C43141
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 10:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2321F20732
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 10:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3AqyWWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfK3Kgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 05:36:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55357 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfK3Kgq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 05:36:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id a131so12128749wme.5
        for <git@vger.kernel.org>; Sat, 30 Nov 2019 02:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FAqdag2eM1gcJCQe/0t7E8QlT7KMpIFt0T9Yj6hTxvg=;
        b=I3AqyWWwe1BCAIXcQroC/aP7O371ylRbGvJ/rAD3dBNon76v/W4+v7mPPS/3G3zoqv
         9S/3V03bC0ssT5cc7Idr61gKMi70vLWcSuJF0S7k5aFeMEeip6JwR8VrRZaQAtnh04dG
         qLNs2nPDUs2n+M+Ls7mfYBFJ4StIpBptla6HDka9mBK4zjJ/d/bj43729KoiM5aQUmGI
         KNeksW0vsjiOuxZx5wQxIB5jgUh0pHYmMVoiKw/Rt7XJmkyqCfPalcgZ8ZdZTOOBEba9
         z4maUUlIhIDHRWW2tgJ6NYBf0J4r1h3hCOjTj01xobKTYkeeCUIQyaYQqbdAxebfZIOD
         wt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FAqdag2eM1gcJCQe/0t7E8QlT7KMpIFt0T9Yj6hTxvg=;
        b=TPWilafCDUUuUThYruXjW0oOp9CMtC9QDbMfN/T9bqrtnacHsEBOFzU5k1oGTGF1A1
         wRMrSe54qoSToboa3hTAzGIwrEGUHH0CIo8xJw8fodkxM0hfR/+4gdo32o57JxuXMGT6
         EKM7DGnoCODBfTvgQ1ty9cDFpYyVFVV5161ZWRrXU5O6aznI5aNqxuwBQU6OKIpVIMQm
         9x4PMJTDdpNoqGaGXB7EbzE7HrSLkae9bEKWyZ2rYyayLTBdJ63SsoqWGNGsGUluuo3t
         rz8OSI5o9FZoJEEe8dALtFbks0lb132ZouiFiWLMg6b9D/O9QaARyE4JKCb0pTFib4aH
         5JqQ==
X-Gm-Message-State: APjAAAVfbAJ/8BTfMX/jj26HRqdsc67JfL2R7luj4B4z0hC8+1WV57iH
        fq73DN3T+/SqouLfPgFsXgR1Zi/Z
X-Google-Smtp-Source: APXvYqx5E0Iganr26tCGKBU8SuwLdLZdmXgyvR709IBxCrX9laBAc7o12YZlo4HqD1SBKBlVTA1RFg==
X-Received: by 2002:a1c:2186:: with SMTP id h128mr19745246wmh.14.1575110204832;
        Sat, 30 Nov 2019 02:36:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12sm946174wmd.1.2019.11.30.02.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Nov 2019 02:36:44 -0800 (PST)
Message-Id: <c3dea00fb10f1ffd393488f8fcc9081abd5a1647.1575110200.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.480.v2.git.1575110200.gitgitgadget@gmail.com>
References: <pull.480.git.1575063876.gitgitgadget@gmail.com>
        <pull.480.v2.git.1575110200.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 30 Nov 2019 10:36:40 +0000
Subject: [PATCH v2 2/2] mingw: translate ERROR_SUCCESS to errno = 0
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

Johannes Sixt pointed out that the `err_win_to_posix()` function
mishandles `ERROR_SUCCESS`. This commit fixes that.

Technically, we try to only assign `errno` to the corresponding value of
`GetLastError()` (which translation is performed by that function) when
a Win32 API call failed, so this change is purely defensive and is not
expected to fix an existing bug in our code base.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 432adc1aed..8dc45808a3 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -114,6 +114,7 @@ int err_win_to_posix(DWORD winerr)
 	case ERROR_SHARING_BUFFER_EXCEEDED: error = ENFILE; break;
 	case ERROR_SHARING_VIOLATION: error = EACCES; break;
 	case ERROR_STACK_OVERFLOW: error = ENOMEM; break;
+	case ERROR_SUCCESS: error = 0; break;
 	case ERROR_SWAPERROR: error = ENOENT; break;
 	case ERROR_TOO_MANY_MODULES: error = EMFILE; break;
 	case ERROR_TOO_MANY_OPEN_FILES: error = EMFILE; break;
-- 
gitgitgadget
