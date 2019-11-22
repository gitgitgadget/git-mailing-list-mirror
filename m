Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2955C43215
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 14:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6F92071F
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 14:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dREM6uWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKVOlL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:41:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51279 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfKVOlK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 09:41:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id g206so7445138wme.1
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 06:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a5/4SnLiOBteb8N0+2klqseFF0BuFqll9XXKoppPzIg=;
        b=dREM6uWAcDb9fqV6gjBeeKzrn4MYuZE0lwgZ3mmdmR+OIM3YuWpVV6HGg58QDnQAaR
         HJ9ykw3g3/+5kmYVPB85Y+XG+f/RS6+w6JtATouSbkGmScNCDDhF0Wb/TSmUJbvM3DPV
         rhGTuy14/IzlLpFDCkqdIRhzJ7zdSzzEwL15MjPnzhwZB5XxQ3jUuoG8MhfBmz6MckXR
         AHaPCOigP4+DtS/JFJAfGBdTo5gHfxY4nQTgHOit3ztrUjJE6oXVUlEsYfTBbHZ4FKBc
         f7fkkh515vlxCTfR5/4lS7FJMff6Q0T7/akw9lfMV86sn4Vbvp85EAw6l+2PozJpNHiI
         BebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a5/4SnLiOBteb8N0+2klqseFF0BuFqll9XXKoppPzIg=;
        b=X/EUSx+PJw+d/3+0nqMUaIfklhaISPw0gd74/LApNlaoxmWO9ufknAfNurbCEZ42X9
         xACcodLVRWi5jBfjBltHss3KVHIf0LSPZxjy62Wx2rpuxX+2qbzE8wlp9toj9C0GVOyh
         Ajm0u1ACgWkPRNlXHzkFCEg8kE4vbtvdFz/fYlczibnJBSR6M5+0tt34gdpOKp1nKgI3
         XNNQBQhhX6yh1LnYVSgTBY4/QgHoS1f0eM/aGJ+gW9krR1ai83fP9pk+r3GlbzsSJcj2
         Meer0WIPRrgpvGFbxuJxzuKB5NPjF5a7AmufEPpyGNYS4Xej6eK2UJI3zKQrm5BHhMRU
         Nw2Q==
X-Gm-Message-State: APjAAAVS4STHv7VOPWBDzjaS8bwbkBfe5819ZNRSifCPd8uX7gOxdHiQ
        RURuoi+0PHQC2Iq9H30mG4Krg905
X-Google-Smtp-Source: APXvYqyCYfLopIFM1wiSfONEn0NROB6Zq9f4Z/ZS1MTFV7JhcYXFrX9tUqydPJnsoeioInXSfGIWNw==
X-Received: by 2002:a05:600c:230d:: with SMTP id 13mr10445718wmo.12.1574433668525;
        Fri, 22 Nov 2019 06:41:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d67sm3648694wmd.13.2019.11.22.06.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 06:41:08 -0800 (PST)
Message-Id: <f68b4094a2985217a0229fd6432cece9d91b25e5.1574433665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.670.git.git.1574433665.gitgitgadget@gmail.com>
References: <pull.670.git.git.1574433665.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Nov 2019 14:41:03 +0000
Subject: [PATCH 2/4] mingw: work around incorrect standard handles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

For some reason, when being called via TortoiseGit the standard handles,
or at least what is returned by _get_osfhandle(0) for standard input,
can take on the value (HANDLE)-2 (which is not a legal value, according
to the documentation).

Even if this value is not documented anywhere, CreateProcess() seems to
work fine without complaints if hStdInput set to this value.

In contrast, the upcoming code to restrict which file handles get
inherited by spawned processes would result in `ERROR_INVALID_PARAMETER`
when including such handle values in the list.

To help this, special-case the value (HANDLE)-2 returned by
_get_osfhandle() and replace it with INVALID_HANDLE_VALUE, which will
hopefully let the handle inheritance restriction work even when called
from TortoiseGit.

This fixes https://github.com/git-for-windows/git/issues/1481

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 54fd701cbf..c27b20a79d 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -662,10 +662,20 @@ void winansi_init(void)
  */
 HANDLE winansi_get_osfhandle(int fd)
 {
+	HANDLE ret;
+
 	if (fd == 1 && (fd_is_interactive[1] & FD_SWAPPED))
 		return hconsole1;
 	if (fd == 2 && (fd_is_interactive[2] & FD_SWAPPED))
 		return hconsole2;
 
-	return (HANDLE)_get_osfhandle(fd);
+	ret = (HANDLE)_get_osfhandle(fd);
+
+	/*
+	 * There are obviously circumstances under which _get_osfhandle()
+	 * returns (HANDLE)-2. This is not documented anywhere, but that is so
+	 * clearly an invalid handle value that we can just work around this
+	 * and return the correct value for invalid handles.
+	 */
+	return ret == (HANDLE)-2 ? INVALID_HANDLE_VALUE : ret;
 }
-- 
gitgitgadget

