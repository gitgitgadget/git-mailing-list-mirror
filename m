Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B39CC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiCUXKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbiCUXJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:09:59 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A63F36E831
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:58:19 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id m26-20020a05600c3b1a00b0038c8b999f58so432747wms.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=34jVkjkIbsYdHX1BGp85Hz0fS5XIuCU638HAbVldiBA=;
        b=SRo7iuw1VXpqK4FxE8/CKIBRDyAqza/8tyyqpHF6KOh6lNprVKP/mNGpp7rb/V092k
         lBiS0MN7bN4UV5CfKOV5P3zIKCTSzMCRyCzBjqUmM8wfKT3n+Mp6LW1bp+q1+OQAUxDc
         BPCtw7NpvjgB7Q607+yCsc+B8aAliFG1iedSwqt7xl1rB75QSpVPhcM8ZGa9uKemmg89
         PxaOalZ4fAOpdXmPK+38clbh/X1jimQy52WAfTudCeeKmO2hPpRFsyUestzn+iNKJnYn
         kzP9N2NbsiNf7bLFgOQXzb/RsJUerQXY/mtiZQPxVnoTwNF+J3iNa4BoItPdG2cFRjM0
         J9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=34jVkjkIbsYdHX1BGp85Hz0fS5XIuCU638HAbVldiBA=;
        b=kvw+zGSk43ndLXRfppfWdrSPrbphSIWCu+xWRXCT9l0PBxTplxplLhbft8Z3pXrF/L
         6BCY9qZKxwl19HmXig5MpTjnFFu2ciQbYMizXGj/Dy4umTDUzbohR77s6CZGjxaaxDRb
         LkBzKquCmb+J+EHUWfS+iUPJ1p38fAL272uzRZ5x+4YV0U0ir5zZSl+LOuW0xNcz1hUs
         L8csQOy7ECy52Dil0JbS54TcVa8HNm31KYhQsOXMPuThdTfQBOj1CVgaRyByzaa01kan
         oTv0lJg8OLbXSHHMmUstcfwAa6zXzAsouhHwSzV8nO1hX3QC2c8DhXXB/VRQW0zsKymw
         ANvg==
X-Gm-Message-State: AOAM531dEWFkk+3zyOuvs9k+oweeR9s0hYYUR/Sg+9u5eIeXPmLk70rA
        4IXE591L+cxiZCb2IK6a68nOothne8I=
X-Google-Smtp-Source: ABdhPJwIYHzadlWxrWjHyrDlHbGJ4eSirJpw6gSfEsoFd+rLXqDcYPitbER36PYuvTM/lr0BWC+qUA==
X-Received: by 2002:a05:600c:4f4f:b0:38c:a460:c82 with SMTP id m15-20020a05600c4f4f00b0038ca4600c82mr1159184wmq.53.1647903363480;
        Mon, 21 Mar 2022 15:56:03 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:56:03 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 24/41] git-credential-osxkeychain.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:06 +0000
Message-Id: <20220321225523.724509-25-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Use the C standard EXIT_SUCCESS and EXIT_FAILURE to indicate the program exit
status instead of "0" or "1", respectively. In <stdlib.h> EXIT_FAILURE has the
value "1": use EXIT_FAILURE even if the program uses exit(-1), ie 255, for
consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 contrib/credential/osxkeychain/git-credential-osxkeychain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 0b44a9b7cc..169cbff821 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -19,7 +19,7 @@ static void die(const char *err, ...)
 	vsnprintf(msg, sizeof(msg), err, params);
 	fprintf(stderr, "%s\n", msg);
 	va_end(params);
-	exit(1);
+	exit(EXIT_FAILURE);
 }
 
 static void *xstrdup(const char *s1)
@@ -143,7 +143,7 @@ static void read_credential(void)
 			else if (!strcmp(v, "smtp"))
 				protocol = kSecProtocolTypeSMTP;
 			else /* we don't yet handle other protocols */
-				exit(0);
+				exit(EXIT_SUCCESS);
 		}
 		else if (!strcmp(buf, "host")) {
 			char *colon = strchr(v, ':');
-- 
2.35.1

