Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA01C433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 14:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E27B21919
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 14:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgL3OxT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 09:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgL3OxS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 09:53:18 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDE3C061799
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 06:52:37 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id h4so14081868qkk.4
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 06:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5D4H9/vwxrMJB3tXEYvNEkCh6/wz0nULkuKqlAVxNfQ=;
        b=v5ciF/CwM2J+4NtefZkT+K71uYqjbr5mOgaG0JoLIxJmXPGsM3neXz0Yum9aEnF6TD
         L3y9wV5F2BWE1F39Z4CaqiIPwOtRVl6B0cJk878KKCM7bUI9ZmexCtQxuE5pSPCcNPuy
         fWU7QLILOXt1FK24hbMFWxN7tSROKpYMs5vj1sY0b2BtAWB01p3z1laUXC6b+bghCHLX
         v0S2E4CEdcgD6lKmhVFJjk8MEdyeQLni/ldcHKNuDcVIxVDtVo4GtYqjsHHzdPkHfUl4
         Qbhe2RM0vtxdS92x8wXd+b59VIW5TBSNs5woYAddrXY/WH44Az9LpmfFTTWOBFd4v74H
         2Hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5D4H9/vwxrMJB3tXEYvNEkCh6/wz0nULkuKqlAVxNfQ=;
        b=qRBBSxaY5AJJV3RQzp88IOg/xsGMrZ08jO0FRY5A9aV/6kbCV9oEY7JeM0wPUm5kIc
         dsQ07uH6/Tx//4FPfmsJ/AyQ4LklryxsrApphhcjgAcvZVPWSKUQQCNPCheYhPDAGOru
         gAlt06tCPjnR9Wqh30b9HOtFhPICzEDBxrRpZGtyPBxCZcwG1sAigTZejiEJ2pTWcQJD
         xFBWBwXNuCWfKeh28/2mXGupAV5jafJcyWdlvrJvgU+MWF7pqZ7l9ijZARGZTWFmyc/0
         4bHW7gEwo/lbPuJvc1LVO6VpQ3f6sueP9l2bzy4jjro/uvfFtZBYNdtD+fH3JZnvwtWQ
         3D/g==
X-Gm-Message-State: AOAM533mykTh7BGsFuUDSdy/Ljyc+TfD0oMBzDh5BpById1dO528F/uX
        N502Wu9eB8WVabk9M7aU2mLXZaoU6rn6sw==
X-Google-Smtp-Source: ABdhPJwhiMu96+3iQqUaeql6R+g/UNVTdoNmESAu67Fv9Y7RSLH0n9dCm8eTmhrQ2dbOJ509O9gk8w==
X-Received: by 2002:a37:a312:: with SMTP id m18mr54006204qke.268.1609339956431;
        Wed, 30 Dec 2020 06:52:36 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id t68sm28712388qkd.35.2020.12.30.06.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 06:52:35 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     me@ikke.info
Subject: [PATCH] t4129: don't fail if setgid is set in the parent directory
Date:   Wed, 30 Dec 2020 11:52:25 -0300
Message-Id: <88398ff952a68e8d134dcd50ef0772bb6fc3b456.1609339792.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <X+xtAR87vWuNiLoE@alpha>
References: <X+xtAR87vWuNiLoE@alpha>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last test of t4129 creates a directory and expects its setgid bit
(g+s) to be off. But this makes the test fail when the parent directory
has the bit set, as setgid's state is inherited by newly created
subdirectories. Make the test more robust by accepting the presence of
the setgid bit on the created directory. We only allow 'S' (setgid on
but no executable permission) and not 's' (setgid on with executable
permission) because the previous 'umask 0077' shouldn't allow the second
scenario to happen.

Note that only subdirectories inherit this bit, so we don't have to make
the same change for the regular file that is also created by this test.
But checking the permissions using grep instead of test_cmp makes the
test a little simpler, so let's use it for the regular file as well.

Also note that the sticky bit (+t) and the setuid bit (u+s) are not
inherited, so we don't have to worry about those.

Reported-by: Kevin Daudt <me@ikke.info>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/t4129-apply-samemode.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index 41818d8315..3818398ca9 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -90,12 +90,10 @@ test_expect_success POSIXPERM 'do not use core.sharedRepository for working tree
 		rm -rf d f1 &&
 		git apply patch-f1-and-f2.txt &&
 
-		echo "-rw-------" >f1_mode.expected &&
-		echo "drwx------" >d_mode.expected &&
-		test_modebits f1 >f1_mode.actual &&
-		test_modebits d >d_mode.actual &&
-		test_cmp f1_mode.expected f1_mode.actual &&
-		test_cmp d_mode.expected d_mode.actual
+		test_modebits f1 >f1_mode &&
+		test_modebits d >d_mode &&
+		grep "^-rw-------$" f1_mode &&
+		grep "^drwx--[-S]---$" d_mode
 	)
 '
 
-- 
2.29.2

