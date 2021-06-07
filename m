Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03ECC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 20:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA947601FC
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 20:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhFGUVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 16:21:44 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:41629 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhFGUVo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 16:21:44 -0400
Received: by mail-wr1-f52.google.com with SMTP id o3so623697wri.8
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 13:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ova/Ky4LYvApBLKxA8ptZ/s6Vov9dsFP+aJ2sKTPEpw=;
        b=RPqUpKuxEHdcbkc0AvCnY/wgSBUxLtcqgLsNKCOPT88EVhu+XXQ58PMo9Eo7ZQzKXE
         mx72O+2uwgMNPsCZf9WzSMzt/M2X8cso5nuQKTBsFIg+49m3xfMa7j11OnjCF1jqjB/a
         5/Ag9xogVF1A6zsPUrY12b1SGyeu1CaiBkd9AJSCGGJq79QsAFIaxrL3tvbvlCD0xqQ0
         UqlTnTDW/E/ygIZwfjvgXsHTZdCddaed+LejNYHbAlr224BXELy3Mz5X+rH14aGohVXl
         uFMfXXkTbS4O4lV9hJaCx/RLP/AkVRIA4KqkF64BnWxf9it6lvyviCQn4yWYLxwvf6WZ
         K3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ova/Ky4LYvApBLKxA8ptZ/s6Vov9dsFP+aJ2sKTPEpw=;
        b=P6e+p2I0JLlsl35Up56yuoPDow4URDExpOUv+8IdVpitVATKvQ+dBwFMDgEsGA1aYN
         C0fSjQ+IdiF4FZclvHWgkVNnr0UxHYkaMgYg58IlP1IDVg2VDhaiqmSd9b3cXnGKpjtq
         Azqa8Eij9Yr63nGuUHzoxJcVjybDathX50xaHe/NBpA2yyLcrzO3fAXt4DZxJCyrO3Ng
         IIXkCAhV76xqH2MUWEw0gULdplNCt/e+n9F7q51DYiAlnQ6q1v+bhsmbJ4XjP8ygrxU0
         o60iTF6dFCfsONZkvVEcjFsZ2V9zEEFrduTEEhhNIuagfLUTMbtEwmL5I5WMFfieS6GT
         Ojtg==
X-Gm-Message-State: AOAM530WfDajxF61K4WLWVYBBoa8bRg29vzmD7DMx8/qZld5md+r+YF7
        MkI9qN09CCAlErgrgk4X8y3ihKNOMno=
X-Google-Smtp-Source: ABdhPJz/yYEwTo7PQ2+kx2U5PTlZfmI18+DnOZQeF1D/1H+2Xvu1zIEaD+3+WhXgBMnGH/PKt5S0qw==
X-Received: by 2002:a05:6000:1148:: with SMTP id d8mr16973665wrx.266.1623097115342;
        Mon, 07 Jun 2021 13:18:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm17119139wrr.48.2021.06.07.13.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 13:18:34 -0700 (PDT)
Message-Id: <pull.952.git.git.1623097114277.gitgitgadget@gmail.com>
From:   "Michael Schindler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 20:18:33 +0000
Subject: [PATCH] mergetools/kdiff3: make kdiff3 work on windows too
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael Schindler <michael@compressconsult.com>,
        Michael Schindler <michael@compressconsult.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Schindler <michael@compressconsult.com>

Currently the native kdiff3 mergetool is not found by git mergetool on windows.
The message "The merge tool kdiff3 is not available as 'kdiff3'" is displayed.

But it is important especially for GUI to use this native version on windows.
Kdiff3 for various systems can be downloaded from https://download.kde.org/stable/kdiff3/

Bug cause:
On Windows the executable name has to be translated (kdiff3.exe instead of kdiff) and the windows path has to be searched - similar to winmerge.

Fix:
This change is using mergetool_find_win32_cmd from the library in the translate_merge_tool_path().
This is done the same way as in winmerge.

However this translation must not be made on linux/unix, so a "type kdiff3" test is made on kdiff3 and only if not found the windows search is tried.

Signed-off-by: Michael Schindler michael@compressconsult.com
---
    mergetools/kdiff3: make kdiff3 work on windows too
    
    mergetools/kdiff3: make kdiff3 work on windows too
    
    Currently the native kdiff3 mergetool is not found by git mergetool on
    windows. The message "The merge tool kdiff3 is not available as
    'kdiff3'" is displayed.
    
    But it is important especially for GUI to use this native version on
    windows. Kdiff3 for various systems can be downloaded from
    https://download.kde.org/stable/kdiff3/
    
    Bug cause: On Windows the executable name has to be translated
    (kdiff3.exe instead of kdiff) and the windows path has to be searched -
    similar to winmerge.
    
    Fix: This change is using mergetool_find_win32_cmd from the library in
    the translate_merge_tool_path(). This is done the same way as in
    winmerge.
    
    However this translation must not be made on linux/unix, so a "type
    kdiff3" test is made on kdiff3 and only if not found the windows search
    is tried.
    
    Signed-off-by: Michael Schindler michael@compressconsult.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-952%2Fmichaelcompressconsult%2Fkdiff3_win-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-952/michaelcompressconsult/kdiff3_win-v1
Pull-Request: https://github.com/git/git/pull/952

 mergetools/kdiff3 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mergetools/kdiff3 b/mergetools/kdiff3
index 0264ed5b20b2..520cb914a18b 100644
--- a/mergetools/kdiff3
+++ b/mergetools/kdiff3
@@ -25,3 +25,12 @@ merge_cmd () {
 exit_code_trustable () {
 	true
 }
+
+translate_merge_tool_path() {
+	if type kdiff3 >/dev/null 2>/dev/null
+	then
+		echo kdiff3
+	else
+		mergetool_find_win32_cmd "kdiff3.exe" "Kdiff3"
+	fi
+}

base-commit: c09b6306c6ca275ed9d0348a8c8014b2ff723cfb
-- 
gitgitgadget
