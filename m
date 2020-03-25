Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17819C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44BD20777
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFDjkraQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgCYFl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:41:26 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:38928 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCYFlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 01:41:25 -0400
Received: by mail-wr1-f49.google.com with SMTP id p10so1345657wrt.6
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 22:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d+CdihV/MaXlOsmdA1HIYg2dPk7X4+olTFP2vNVSVCU=;
        b=LFDjkraQBPA1YYsh3VQaLaH09ueX9ljAFloJmfT/+ktKh/fDdcAXJoU3nI8pCztd1v
         xuC+ITHUnEeZq6Fun2nMD7vxAgwerUk1CRRuKmYgPJHijdInc6K9GDDm8uI3k6yXc6dC
         XpKtvFZctXEOINKEtXIcn7tQOG5OD3L13S7/3ShmcCWwTwDU/wIkNcmCHbH2sRciyBXH
         LmSM6TP8sedg/znEPnGBl8Bkq9hhwchfph3aGrFuU0SgWXt3lX+kSGZHxNZgJ9CEbVOp
         RX44UeDBAfzY/+yk5XWLspgkkG91k1zHnajZ2+eLNdZaZ+SF5m0OlGJ0bhNZI0KvOO7v
         4U7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d+CdihV/MaXlOsmdA1HIYg2dPk7X4+olTFP2vNVSVCU=;
        b=KhwF85hy1GzqMpOrJiiTGVWZEdoD5YLLlv9SAckMatTTey6IFt4xuDNttnni2+D5zC
         8Qm4lJFDYvU2MVJ7BXJq9iunSQZ/JLlbqekhSr3YPO+cPWEolKvIKbVYWvTf5nr4CZxL
         QAGAtwVPBPL7mUlodRR5To/DBSsvb/UYUlt9iMJqLFDVNVf9d88dopOuBYoakHaycgm0
         hFu4iFPshTBAFl5F8+DJKrglzIjTrnYBFDOUBsoStl2qwiIqTNjHpekBzSCdkiBndzdw
         B1n/OOrQc9w3/bXP84oFNmXzjLM3MmqDF+nxjbxcDje3wKhxdnr912sXZltpnajoeE2y
         43Rg==
X-Gm-Message-State: ANhLgQ0PXchFL/vKU7J0DyXu4xbe1MYLlH+/9Zm8g1PpVP7AX1xigD1i
        IMzQ1Jc9s62tUNcEQ1gbmcmiGYLi
X-Google-Smtp-Source: ADFU+vuT6zHbqiCoymbL5h3gnLaAWHBZSJCFZRfi7sOKAX3iBtIRNMWBaXsDWgVjSI/sjf1CBMT3ZQ==
X-Received: by 2002:adf:e289:: with SMTP id v9mr1391726wri.361.1585114883394;
        Tue, 24 Mar 2020 22:41:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a192sm7987270wme.5.2020.03.24.22.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 22:41:23 -0700 (PDT)
Message-Id: <287a21f1033b2a74420029c529ad4db956051a85.1585114881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
        <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Mar 2020 05:41:17 +0000
Subject: [PATCH v2 1/5] tests(gpg): allow the gpg-agent to start on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In Git for Windows' SDK, we use the MSYS2 version of OpenSSH, meaning
that the `gpg-agent` will fail horribly when being passed a `--homedir`
that contains colons.

Previously, we did pass the Windows version of the absolute path,
though, which starts in the drive letter followed by, you guessed it, a
colon.

Let's use the same trick found elsewhere in our test suite where `$PWD`
is used to refer to the pseudo-Unix path (which works only within the
MSYS2 Bash/OpenSSH/Perl/etc, as opposed to `$(pwd)` which refers to the
Windows path that `git.exe` understands, too).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-gpg.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 8d28652b729..11b83b8c24a 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -29,7 +29,7 @@ then
 		#		> lib-gpg/ownertrust
 		mkdir ./gpghome &&
 		chmod 0700 ./gpghome &&
-		GNUPGHOME="$(pwd)/gpghome" &&
+		GNUPGHOME="$PWD/gpghome" &&
 		export GNUPGHOME &&
 		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
 		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
-- 
gitgitgadget

