Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5E8C433DF
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 10:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4324A20663
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 10:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYwdz+O4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgFGKVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 06:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgFGKVR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 06:21:17 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60668C08C5C2
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 03:21:16 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id y1so12385198qtv.12
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 03:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mjMnr0GpZS7TYETtlFK5d4k1NS7KXm71zDNbytvtx1A=;
        b=WYwdz+O4SK5Vw7Sq7xUD9E+WuZvu6ZSDC+MiP5xZmohrBWqArBk5Eusko3r4r3M3S8
         L2jylflREHJveVZxiwJS3bDFFPGy4v+EYl/cybiI90+rExU2gcz3/jQXZActBpVBRDdd
         RsXVg9Jnq97SQyIw7EUuyfi1CcwjWr9SQeL91nxudK3rRxEVruFsUIcymIEHDwKrqVRg
         oI31kJ9fawf0Q55vMELqJYy4CzaPBbcn6Vsno6wNarV8oCPL5dFDudCK7p0ZfbcmM4Pu
         17492Ns+QGbk0MDLnZFa66PXodbz7jhoHa0cPPGVnuIXdG7kvvhdziWzq25ihgA5P6QX
         3gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mjMnr0GpZS7TYETtlFK5d4k1NS7KXm71zDNbytvtx1A=;
        b=oJsIyPOviDZk46zjEO+E/ALnEBcCSeSoCREALLCB2BnNhrV2g9DXb8ScDvRWCWrgxE
         8jROYxc9QYrbabj86dBcZwlpMVjomwCJPE4qTKMI8Ac3ZuLZO/2wJeDZJDpZebJ+zHvo
         BOUSbQiMPH3mKv+9Zxll2SQq4Gkh474ndmhBsvKDV702f1ZumAD8HaaAgJY2WF+bAjvX
         dgrcqF4RmTHUxOMlFMVha6I8FTgCycUvJNxteUMamr1h3NX3lJuIYIhOz7DRfYHgm9Nf
         uheQkGAj/7vJjVExF4cFfDOmi7JbbW9LFhBVkZ9dDz8/IcPA1gkPwwbRl6R08lztypvv
         /foQ==
X-Gm-Message-State: AOAM532Gu6VLVhvzoE/1n/DTPG5lvxh1Vi7Ihm8T4e2UZMAvi03i288D
        STyx6UhKxdsailzzQZkZX5dD/WwW
X-Google-Smtp-Source: ABdhPJwXpRc7N1e1Py7m2D5ZFZpiGHc9UbOJK2JparIeagIZJbQBM3QhaIxSTVNthtVjHXIZ4cNGFw==
X-Received: by 2002:ac8:44b3:: with SMTP id a19mr18333614qto.285.1591525274490;
        Sun, 07 Jun 2020 03:21:14 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id p11sm4599813qtq.75.2020.06.07.03.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 03:21:14 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Luke Diamand <luke@diamand.org>
Subject: [PATCH] CodingGuidelines: specify Python 2.7 is the oldest version
Date:   Sun,  7 Jun 2020 06:21:06 -0400
Message-Id: <b5028351ca011bc7834444b05fb13d1a28dd088d.1591525231.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.107.g134631ef42
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 0b4396f068 (git-p4: make python2.7 the oldest supported version,
2019-12-13), git-p4 was updated to only support 2.7 and newer. Since
Python 2.6 is pretty much ancient history, update CodingGuidelines to
show that 2.7 is the oldest version supported.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Notes:
    This patch is somewhat conservative. Python 2.7 has been EOL'd (although
    it's still in common use). Would it make sense, instead, to say that
    Python 3.x (the earliest non-EOL'd version) is the minimum version we
    support and it would be _nice_ to support 2.7 as well?
    
    On the topic of Python 3.x, 3.1 has been EOL'd since 2012. Would it make
    sense to update this version to 3.5 which is the earliest supported
    version of Python?

 Documentation/CodingGuidelines | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 227f46ae40..45465bc0c9 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -489,16 +489,11 @@ For Python scripts:
 
  - We follow PEP-8 (http://www.python.org/dev/peps/pep-0008/).
 
- - As a minimum, we aim to be compatible with Python 2.6 and 2.7.
+ - As a minimum, we aim to be compatible with Python 2.7.
 
  - Where required libraries do not restrict us to Python 2, we try to
    also be compatible with Python 3.1 and later.
 
- - When you must differentiate between Unicode literals and byte string
-   literals, it is OK to use the 'b' prefix.  Even though the Python
-   documentation for version 2.6 does not mention this prefix, it has
-   been supported since version 2.6.0.
-
 Error Messages
 
  - Do not end error messages with a full stop.
-- 
2.27.0.107.g134631ef42

