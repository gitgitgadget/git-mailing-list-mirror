Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FEAC35670
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 10:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46461208C3
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 10:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa5cev1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgBWKPG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 05:15:06 -0500
Received: from mail-yw1-f44.google.com ([209.85.161.44]:37125 "EHLO
        mail-yw1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWKPG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 05:15:06 -0500
Received: by mail-yw1-f44.google.com with SMTP id l5so3852253ywd.4
        for <git@vger.kernel.org>; Sun, 23 Feb 2020 02:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U/WDZK+zVSB2YGwKLpDvMxT/bEyjh7Bx4tnDu44Nsps=;
        b=Aa5cev1/LKorZ/h+s3QqgWVFCpNbX1qn3q9/GbSuhL/GZhC03bGoI06vL6BofJsWrJ
         fvZoXot2Zq6rudkJmbYSU2n9MFi2fc4soRuIQ1WZluSqjcCtJ+PDGOj2SUA4t7FQ2SWo
         kbr/CdruwoBcqoKOXnzFT1pcPlavDzyMiKtHuUD43EQ4HKTOqCIEZQHcpbNqydYd3feU
         iugDkVP9+LdHfT3Dsjn+9TCqNxu+VHfaZJva/JjhndzIt3Reskocvz2lZ6TiqQPXmKOG
         t4XVJEIZbbPkkbIBlo0ZbKZIRxtpc6+f+UuTuKxMs2FBRpsy1sgz9KXtRKmFmHu+ND0Q
         lbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=U/WDZK+zVSB2YGwKLpDvMxT/bEyjh7Bx4tnDu44Nsps=;
        b=blSN8FP73xVCfgsxmNVXrZo1t+PAxJqAK8dgHmPlHjjesKR+XkiCy1WSDNR9jwIU1W
         TLbv7pizZ8U6RBQgxrekFasV+SVymVV2Mdr+D3464joSAyDYDWKwxavIaOi2EH6ilE6A
         wDLrAcJO8x317WdqcCVTkJouMx9ejgt2CRRvQ/uIRq7zB7vwIMIc8rm+vKG7GLiqQDky
         1VP72vMDAKdL0+67Z3g75tgyyUa/wurgFLu3q3PBntD09a7vtQhCIcGLPGOMgVrdCccd
         JjbAMj7dWxv9mLbWMqYrS3tfXOnAWkcWHXFMimoQKctHKbdRTHt8yD4ZNKx1mPEv45RJ
         MDWQ==
X-Gm-Message-State: APjAAAUPYOEsO8HBdlPXtN1LrvOsLkZbea3ZRFbG/L4JEfUZdPcfwQAz
        Mk5n72LrRs48ulMgWI2VC4ZOXp3o
X-Google-Smtp-Source: APXvYqyZBm5CKl6scULov29lptPSwM5NvGBHLHZ7oXDwkSk/FsOfRAmW9ic0YWXRHeukks/sEOmPjg==
X-Received: by 2002:a0d:c245:: with SMTP id e66mr21805549ywd.32.1582452904870;
        Sun, 23 Feb 2020 02:15:04 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id j11sm3621767ywg.37.2020.02.23.02.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Feb 2020 02:15:04 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Mike Hommey <mh@glandium.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/2] t3400: make test clean up after itself
Date:   Sun, 23 Feb 2020 05:14:06 -0500
Message-Id: <20200223101407.77036-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.25.1.526.gf05a752211
In-Reply-To: <20200223101407.77036-1-sunshine@sunshineco.com>
References: <20200220002932.5jws6qpnivlvxckw@glandium.org>
 <20200223101407.77036-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test intentionally creates a file which causes rebase to fail, thus
it is important that this file be deleted before subsequent tests are
run which are not expecting such a failure. In the past, the common way
to ensure cleanup (regardless of whether the test succeeded or failed)
was either for the next test to perform the previous test's cleanup as
its first step or to do the cleanup at global scope outside of any
tests. With the introduction of 'test_when_finished', however, tests can
be responsible for their own cleanup. Therefore, update this test to
clean up after itself.

A bit of history: This 'rm' invocation was moved from within the body of
the following test to global scope by bffd750adf (rebase: improve error
message when upstream argument is missing, 2010-05-31), which postdates,
by about a month, introduction of 'test_when_finished' in 3bf7886705
(test-lib: Let tests specify commands to be run at end of test,
2010-05-02).
---
 t/t3400-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 221b35f2df..6e746dca00 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -143,11 +143,11 @@ test_expect_success 'setup: recover' '
 
 test_expect_success 'Show verbose error when HEAD could not be detached' '
 	>B &&
+	test_when_finished "rm -f B" &&
 	test_must_fail git rebase topic 2>output.err >output.out &&
 	test_i18ngrep "The following untracked working tree files would be overwritten by checkout:" output.err &&
 	test_i18ngrep B output.err
 '
-rm -f B
 
 test_expect_success 'fail when upstream arg is missing and not on branch' '
 	git checkout topic &&
-- 
2.25.1.526.gf05a752211

