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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E52C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 17:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B58E6108E
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 17:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhHSRRX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 13:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhHSRRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 13:17:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D8EC061760
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 10:16:39 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q6so10183833wrv.6
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NGktP2lQ/G+rINOHe8IE1y7do7gjQ3m9nzw9ELZcGWY=;
        b=c1cHDV87IQMwB7DQfkIXoXU52U4eK74KhHEp1WdDeLlPRaKeeLbz+heD1ZM+xBLftC
         bNWuLZgCKVZgUWLbk2NweV76ro3Zfe37g85H1J7cMR/wZjQCySSHaHZ+HDwLzEOr6HvL
         ETTUxiZcev0bQEbI25XrcyrU4ftDVJIWPw5ikMHJ8a+zEE29G8pBTgk6X3kkARaz3ssl
         VCQQla6AvpR03Q/EGsIcCISROQikprq3LjXmHJ8dVbwMrF2VBOaK7fwiAXgnAGAGvILO
         MvYBkIbchc8bCZWYgdbb6OsjqiBRb3RfTB8PijtyjuGW61EV9owTS2YDv5ZqjwbeuuY1
         5lag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NGktP2lQ/G+rINOHe8IE1y7do7gjQ3m9nzw9ELZcGWY=;
        b=pqYwQQxoVdM41666Z6XgeS+zpY9lpXJQkS+KAfvtvzWDnOwvoKkmY9BA6+Wj2zc7BO
         gIg39ElfEHxVxtdwHQqeDrvM+0HWmzQq4pqOU9KhL5ZlClFewm8s1Lk7Ccfd29++i8rR
         bMbmh/mJdRm7BrMxh29UyYcxD55AxO6gx2xTA/O1B/IBQgWp1tpPZlEOLr543Yt7/1Uf
         mnRQSJcZDInQhRCT0heYhFduxkvHYMMQunrbt4d3qxXJ+HdCfIuaJwis7mIbj2IzBta2
         dNeBVbv3xGu2g8nyAHj3TFAfMOOktfXi8C/8bfe6uxJOo3x0kZCY87r9jsVZNhspl8vV
         R+xg==
X-Gm-Message-State: AOAM5307RcU/4HKBvrLwit0/ZcJdjHmPqyBVERmgs9eUY5GC1Fu+gzHz
        U/OsCwWUOJpPotkwCNxVrJ/ujC1gjiY=
X-Google-Smtp-Source: ABdhPJwxG8/3SIbO0xRfNDUn5j4bztR+0rPYDv/HS7W0kiw+XH+elMJ7aZdQtWa8+AJbO1EOZFQGEg==
X-Received: by 2002:adf:c681:: with SMTP id j1mr5060544wrg.119.1629393398155;
        Thu, 19 Aug 2021 10:16:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v12sm3520920wrq.59.2021.08.19.10.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 10:16:37 -0700 (PDT)
Message-Id: <d51d0db6e250c118b2d0f6eff571e1a7642da00e.1629393395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
References: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Aug 2021 17:16:35 +0000
Subject: [PATCH 2/2] test-lib-functions: use user's TERM and HOME for 'debug'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The 'debug' function in test-lib-functions.sh is used to invoke a
debugger at a specific line in a test. It inherits the value of HOME and
TERM set by 'test-lib.sh': HOME="$TRASH_DIRECTORY" and TERM=dumb.

Changing the value of HOME means that any customization configured in a
developers' debugger configuration file (like $HOME/.gdbinit or
$HOME/.lldbinit) are not available in the debugger invoked by
'test_pause'.

Changing the value of TERM to 'dumb' means that colored output
is disabled in the debugger.

To make the debugging experience with 'debug' more pleasant, leverage
the variables USER_HOME and USER_TERM, added in the previous commit, to
set HOME and TERM before invoking the debugger.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 662cfc4c3e0..86680b1177d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -163,7 +163,7 @@ debug () {
 		GIT_DEBUGGER=1
 		;;
 	esac &&
-	GIT_DEBUGGER="${GIT_DEBUGGER}" "$@" <&6 >&5 2>&7
+	TERM="$USER_TERM" HOME="$USER_HOME" GIT_DEBUGGER="${GIT_DEBUGGER}" "$@" <&6 >&5 2>&7
 }
 
 # Usage: test_commit [options] <message> [<file> [<contents> [<tag>]]]
-- 
gitgitgadget
