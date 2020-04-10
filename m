Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18801C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 11:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7529208E4
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 11:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZIm9W6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgDJL3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:29:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44837 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgDJL3A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 07:29:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id cb27so2046697edb.11
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 04:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u83eHuGKTEMgPQ21K/GK75STsl33icmSBJhibh1PP6Y=;
        b=WZIm9W6Qq9mhuIfd2FO6nCG7KWMRe+q1hu/82xMEpYBon+ZcWehQQ3Pqx7+YAhOMoO
         FHLX79i7DwZd+2XZn0lyWDxKDpRhJNZkACmsPjzhWorJrsnGAW7o5NneHSBOYQGiTNiE
         yemgFS1vxaVrFIO0QTQAFr15zctp5h7aOlB7r94X2j+lrmWJnHfF4EoJ50sdb8Wm9Ohv
         vSP47zNEAPllLFRB4lRNq7jSPnYn6notj6KtHiuYF2zVgJL708hJmzj0jKa3jVJ5W87u
         njHzmwEv2afwAqlzUvwON93jOU+FO8U7xqfnDIN/8YJX4UT9l1lDlLYARM7P/C+eH6sw
         lkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u83eHuGKTEMgPQ21K/GK75STsl33icmSBJhibh1PP6Y=;
        b=fved8ZrdIy7PBQw43YYNwNkfN+ARqlZKKwXgBlm6V7VzwyqEBtz0TR4sQilZDBgn/n
         Sgon5uSVJbKwrLZxBAYvMr3Wusp5Fpon5FvalUu0Xq9oiH/v7/H7qDJdFViCsZBuzDWX
         vjHSjKMDGniVzwLVu5tBYLOcOhNAlX9+dbqTNzwqSHl2y067EUMkL6U71DRdlb1UDaVH
         kp+h4u9R1MXtt0bTQMcV256Ijn0UDaMDPSNwVv3zJEYHOesCGwatQ6d132PVuAY06kEU
         5xjLebP6OlUB1XNz7DH6aQXmHYpkl1I0QHAywUuJyrZFx49UPeRADmly7Bn+c26U0sdg
         UVnQ==
X-Gm-Message-State: AGi0PuZs/eKiZFtqizsSKZyXEs1ibbQfotKYO3OUifMSUak1CpcY6iYA
        KivkUkohwKC3p+KBBHPhx0V+mUpd
X-Google-Smtp-Source: APiQypLWUy8iY+/zV30XKqyHu7Qz3YdRBXD578nD1OwYOA/UF+qp9a9jLbwd3UoPVUY4Bt8GkDpoqA==
X-Received: by 2002:a17:906:2cd5:: with SMTP id r21mr3521705ejr.222.1586518137918;
        Fri, 10 Apr 2020 04:28:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a17sm84698edj.53.2020.04.10.04.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 04:28:57 -0700 (PDT)
Message-Id: <pull.756.v2.git.git.1586518136956.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.git.git.1586427853403.gitgitgadget@gmail.com>
References: <pull.756.git.git.1586427853403.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Apr 2020 11:28:56 +0000
Subject: [PATCH v2] mingw: cope with the Isilon network file system
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nathan Sanders <spekbukkem@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nathan Sanders <spekbukkem@gmail.com>

On certain network filesystems (currently encountered with Isilon, but
in theory more network storage solutions could be causing the same
issue), when the directory in question is missing,
`raceproof_create_file()` fails with an `ERROR_INVALID_PARAMETER`
instead of an `ERROR_PATH_NOT_FOUND`.

Since it is highly unlikely that we produce such an error by mistake
(the parameters we pass are fairly benign), we can be relatively certain
that the directory is missing in this instance. So let's just translate
that error automagically.

This fixes https://github.com/git-for-windows/git/issues/1345.

Signed-off-by: Nathan Sanders <spekbukkem@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    mingw: cope with the Isilon network file system
    
    Yet another patch that has lived in Git for Windows for a while.
    
    Changes since v1:
    
     * fixed a typo in the commit message ("encounterd")
     * re-wrapped the first paragraph of the commit message to fit inside 72
       columns/line
     * fixed a typo in the code comment ("a unknow")
     * reworded the code comment to read less like a commit message
     * avoided the comma operator
     * added some white-space to structure the code better

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-756%2Fdscho%2Fwork-around-isilon-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-756/dscho/work-around-isilon-v2
Pull-Request: https://github.com/git/git/pull/756

Range-diff vs v1:

 1:  e49df0e07fb ! 1:  c9b1d5c46cc mingw: cope with the Isilon network file system
     @@ Metadata
       ## Commit message ##
          mingw: cope with the Isilon network file system
      
     -    On certain network filesystems (currently encounterd with Isilon, but in
     -    theory more network storage solutions could be causing the same issue),
     -    when the directory in question is missing, `raceproof_create_file()`
     -    fails with an `ERROR_INVALID_PARAMETER` instead of an
     -    `ERROR_PATH_NOT_FOUND`.
     +    On certain network filesystems (currently encountered with Isilon, but
     +    in theory more network storage solutions could be causing the same
     +    issue), when the directory in question is missing,
     +    `raceproof_create_file()` fails with an `ERROR_INVALID_PARAMETER`
     +    instead of an `ERROR_PATH_NOT_FOUND`.
      
          Since it is highly unlikely that we produce such an error by mistake
          (the parameters we pass are fairly benign), we can be relatively certain
     @@ compat/mingw.c: static int mingw_open_append(wchar_t const *wfilename, int oflag
      -		return errno = err_win_to_posix(GetLastError()), -1;
      +	if (handle == INVALID_HANDLE_VALUE) {
      +		DWORD err = GetLastError();
     ++
      +		/*
      +		 * Some network storage solutions (e.g. Isilon) might return
      +		 * ERROR_INVALID_PARAMETER instead of expected error
     -+		 * ERROR_PATH_NOT_FOUND, which results in a unknow error. If
     -+		 * so, the error is now forced to be an ERROR_PATH_NOT_FOUND
     -+		 * error instead.
     ++		 * ERROR_PATH_NOT_FOUND, which results in an unknown error. If
     ++		 * so, let's turn the error to ERROR_PATH_NOT_FOUND instead.
      +		 */
      +		if (err == ERROR_INVALID_PARAMETER)
      +			err = ERROR_PATH_NOT_FOUND;
     -+		return errno = err_win_to_posix(err), -1;
     ++
     ++		errno = err_win_to_posix(err);
     ++		return -1;
      +	}
       
       	/*


 compat/mingw.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index d14065d60ec..0c71a223a97 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -460,8 +460,21 @@ static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
 	handle = CreateFileW(wfilename, FILE_APPEND_DATA,
 			FILE_SHARE_WRITE | FILE_SHARE_READ,
 			NULL, create, FILE_ATTRIBUTE_NORMAL, NULL);
-	if (handle == INVALID_HANDLE_VALUE)
-		return errno = err_win_to_posix(GetLastError()), -1;
+	if (handle == INVALID_HANDLE_VALUE) {
+		DWORD err = GetLastError();
+
+		/*
+		 * Some network storage solutions (e.g. Isilon) might return
+		 * ERROR_INVALID_PARAMETER instead of expected error
+		 * ERROR_PATH_NOT_FOUND, which results in an unknown error. If
+		 * so, let's turn the error to ERROR_PATH_NOT_FOUND instead.
+		 */
+		if (err == ERROR_INVALID_PARAMETER)
+			err = ERROR_PATH_NOT_FOUND;
+
+		errno = err_win_to_posix(err);
+		return -1;
+	}
 
 	/*
 	 * No O_APPEND here, because the CRT uses it only to reset the

base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
-- 
gitgitgadget
