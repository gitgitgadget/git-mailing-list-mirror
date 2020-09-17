Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11DDC433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 15:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC32222D9
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 15:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecrLB9tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgIQP3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 11:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbgIQP17 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 11:27:59 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D8AC061756
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 08:27:41 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y15so2481601wmi.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 08:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=dDJLjeKpb37ozIH87UIRjD7kVItDqN0uQy7ZQaCpwKs=;
        b=ecrLB9txopdAoWKLhsZYpNj5x5AC8u5c3nE3hGcFvs/n2L6ic0wF/yjOBwNtC48Tsy
         4NfSYS2sRzjq6vMI+NfqI7zbF59uh0XTkg1z4o8GatGjX49JbCBhhPux70rzoPEAjsoV
         uPnOcrgtP3806xakDBRTTHynWt2G0n33Wkf/mcX7dnUyK9F8Lde4HnoaLhAwD7Pv4bom
         fI7rRQd9VvVXwoHk/N2ihdLT//dnhGJd5KVBvKYpvYajR+kNZBdawtTWKOqLtxVM2dWh
         vSJKSb9GTN/F8iLvQd43IKQB4p+vA9lx9iR6TByBqmJuaJBtoyrWD4mWCr4iMFg2ZJIS
         PU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dDJLjeKpb37ozIH87UIRjD7kVItDqN0uQy7ZQaCpwKs=;
        b=ojTfxbAZG1sWxG2HFgR1BxAUrpoJBL14nMtHQHfawgzKl0BWl/Ux4SvhaX5vBTa67P
         T1kXCtLxVyY5efzJtRJw9wWWKLHI9RqWpPpS8jyn8ilLBEPhZN4wNJhNg0u0qvkfbrPZ
         HenzC+hRhrDLD9ui7HoKMP5ymwUYzYEHGG7VIpy4fgD8EnOyxKDfOvzhdIfrdiqHoSSF
         yPmlRXyh0X9mH5nUrkDMlWtI/zryU1C05MX5KPPuGjA+oMj9yHVR2CIAzt7cNRwfewS+
         86Y9wuFt6nGI6qwGNMrBG60haxWTo/yTpGtitpb8Zl49M4rBEGH9P56aAN2R6S0hIqrK
         mvlg==
X-Gm-Message-State: AOAM5305mygjTxpXo/hqZ7yTUhHnB/uY4CW0+ECEAlNv6uDCtMZJV6Rt
        3i0iieYxbSrxd/2R1OE6NINSp/QjwwE=
X-Google-Smtp-Source: ABdhPJwmqsvszxSIINoMpMa5LXzXjAv34iyd28D3qgraNeZY58dmL5bz1trCruhCDKlyRAPXzfurlA==
X-Received: by 2002:a05:600c:2312:: with SMTP id 18mr4236975wmo.141.1600356460138;
        Thu, 17 Sep 2020 08:27:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u12sm11641385wrt.81.2020.09.17.08.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 08:27:39 -0700 (PDT)
Message-Id: <pull.848.git.git.1600356459092.gitgitgadget@gmail.com>
From:   "Christian Schlack via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Sep 2020 15:27:38 +0000
Subject: [PATCH] remote: in case of error don't show success message.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Schlack <christian@backhub.co>,
        Christian Schlack <christian@backhub.co>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Schlack <christian@backhub.co>

Suppress the message 'origin/HEAD set to master' in case of an error.

  $ git remote set-head origin -a
  error: Not a valid ref: refs/remotes/origin/master
  origin/HEAD set to master

Signed-off-by: Christian Schlack <christian@backhub.co>
---
    remote: in case of error don't show success message.
    
    Expected behaviour
    
    $ git remote set-head origin -a
    error: Not a valid ref: refs/remotes/origin/master
    
    Actual behaviour
    
    $ git remote set-head origin -a
    error: Not a valid ref: refs/remotes/origin/master
    origin/HEAD set to master
    
    I believe ... set to master should not be shown in case of an error.
    That's why I added an else to the if-condition.
    
    Signed-off-by: Christian Schlack christian@backhub.co
    [christian@backhub.co]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-848%2Fcschlack%2Fremote-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-848/cschlack/remote-v1
Pull-Request: https://github.com/git/git/pull/848

 builtin/remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 542f56e387..64b4b551eb 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1356,7 +1356,7 @@ static int set_head(int argc, const char **argv)
 			result |= error(_("Not a valid ref: %s"), buf2.buf);
 		else if (create_symref(buf.buf, buf2.buf, "remote set-head"))
 			result |= error(_("Could not setup %s"), buf.buf);
-		if (opt_a)
+		else if (opt_a)
 			printf("%s/HEAD set to %s\n", argv[0], head_name);
 		free(head_name);
 	}

base-commit: 54e85e7af1ac9e9a92888060d6811ae767fea1bc
-- 
gitgitgadget
