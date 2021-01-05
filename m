Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D024CC433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 15:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8FAF22CA0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 15:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbhAEPsf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 10:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbhAEPsc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 10:48:32 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7872CC061574
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 07:47:51 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id 19so26807919qkm.8
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 07:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WyDAhi9T6mZgIDSz+iUf104x7RzXBj3ZEWycSenTtVE=;
        b=ikBO719j7Q+nUpAkrXVASAWQKYWJSFaxlB4U45tyJVDqJB7pqGkhknSdc7uBr8tf/n
         VH5wyUoIaBDeZYNL6t0epLFZCU1lcQ26XTOMZkh3RWIPSQIl8sWbX/EcMs0CVsS+4Mde
         cNH+Yp/axTRkcgL780ES72G8NlSq/2r5UK4bIUDsjt1PoRCb4nFMiLj/VK16zu35hWZL
         lZXoBipaq7UUaeAycpsbVWFwrvsprpQiSLwb6Jb7TqbJ9fssQh5N4Y4RQmIse2QssxcW
         xNqk+1fbhlv6+lNtzP8moPX79pjsIKzEjz8aZ04QvhAmya2AYAOUVYb1YqDkOV1QAd7H
         DAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WyDAhi9T6mZgIDSz+iUf104x7RzXBj3ZEWycSenTtVE=;
        b=o3G4k58xLDkOGb2A9ffCuHh1YnZHdAl5jy2uLCmzjwtgyPuXAHiVSOh7QEZFd/mAfa
         W9kfcV+lFVLMW6uhvJJ6szY9yp0pWnNH9mPmNXsc41wjsgxqPlM2d31wDIzqvj39t8pD
         Q9cZ+dhoGPK0LNRHer69UuGDxe6IPKEolghBq/1sgI+BcbJ1pYzKOg18f8ePgf/evSTJ
         rJqwLxRvt/sLp6eI+H7elVgPupzPM+8FuglQVjJ/KrK/fYGwJ+++15hTXFYFG4cxzER7
         TeSVqyqRB6EizBAiEgqO35udWjk9AewxCGBfunpcJ6eltjP2NTs+wb5E+YJ3ESsgacwy
         A4AA==
X-Gm-Message-State: AOAM530UvCfJp01Qx243YFHGA1eh4cFrPuGuF8CZ6xGod3EbzjYmLkXk
        9sIEnusEN9YX0mmbrfsVB6uB1Jnq7YmXJg==
X-Google-Smtp-Source: ABdhPJwOWaX/t4L+0AxU2QlmaY3ab/BdcF1p7yCvkSqOpV+K7coTlacbzS1Jl8igGEZXJKtAVWfTlw==
X-Received: by 2002:a37:9a84:: with SMTP id c126mr92377qke.155.1609861670640;
        Tue, 05 Jan 2021 07:47:50 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id y10sm163484qkb.115.2021.01.05.07.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 07:47:49 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     me@ikke.info, git@vger.kernel.org
Subject: [PATCH v2] t4129: don't fail if setgid is set in the test directory
Date:   Tue,  5 Jan 2021 12:47:39 -0300
Message-Id: <b734425e3235651e738e6eac47eae0db7db92e7e.1609861567.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <88398ff952a68e8d134dcd50ef0772bb6fc3b456.1609339792.git.matheus.bernardino@usp.br>
References: <88398ff952a68e8d134dcd50ef0772bb6fc3b456.1609339792.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last test of t4129 creates a directory and expects its setgid bit
(g+s) to be off. But this makes the test fail when the parent directory
has the bit set, as setgid's state is inherited by newly created
subdirectories.

One way to solve this problem is to allow the presence of this bit when
comparing the return of `test_modebits` with the expected value. But
then we may have the same problem in the future when other tests start
using `test_modebits` on directories (currently t4129 is the only one)
and forget about setgid. Instead, let's make the helper function more
robust with respect to the state of the setgid bit in the test directory
by removing this bit from the returning value. There should be no
problem with existing callers as no one currently expects this bit to be
on.

Note that the sticky bit (+t) and the setuid bit (u+s) are not
inherited, so we don't have to worry about those.

Reported-by: Kevin Daudt <me@ikke.info>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/test-lib-functions.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 999982fe4a..2f08ce7cba 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -367,9 +367,14 @@ test_chmod () {
 	git update-index --add "--chmod=$@"
 }
 
-# Get the modebits from a file or directory.
+# Get the modebits from a file or directory, ignoring the setgid bit (g+s).
+# This bit is inherited by subdirectories at their creation. So we remove it
+# from the returning string to prevent callers from having to worry about the
+# state of the bit in the test directory.
+#
 test_modebits () {
-	ls -ld "$1" | sed -e 's|^\(..........\).*|\1|'
+	ls -ld "$1" | sed -e 's|^\(..........\).*|\1|' \
+			  -e 's|^\(......\)S|\1-|' -e 's|^\(......\)s|\1x|'
 }
 
 # Unset a configuration variable, but don't fail if it doesn't exist.
-- 
2.29.2

