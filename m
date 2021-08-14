Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67679C4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 09:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431BA60F00
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 09:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbhHNJVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 05:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237596AbhHNJVq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 05:21:46 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ADFC06175F
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 02:21:18 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id oa17so18905844pjb.1
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 02:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pm/nMaqR0Pl20fg5zxfF5fAaL0kKKxKfUUjgTRC3aHM=;
        b=s75Lg3DF/HK/jRd4orwgFcfJ1oipYMh4HKsOfurhosDQjlVfFUDRZwxDteOH5IfBWw
         64xiz95qzGhHaE4CD32MqllBXCAoKLlgX1EmZp0N+D1DcweZOEMFcX4e62jStkqXuB56
         p6qlp5eA7ddR06gE5mrioKDI3aBagTtgqQHLfQG2C1Q59RfoyYTToZlXec3A+nHJ0xMy
         Od+lHHjRezQlNVnHqRG7fuPBBcMpYVaKcu3ZbKpnnw9ayYEahcIoYmYxk5i6U/asThmD
         RRtOCj+pE/hmHGiroKB7H5eADcL/CZaiIb4qQ/7h/I5/ghD0VihwkkHSnXb41FZBuPuA
         ig/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pm/nMaqR0Pl20fg5zxfF5fAaL0kKKxKfUUjgTRC3aHM=;
        b=qMxUnJREU/NrF0eoP6/tycD23Z97/6OVkwhu13WIu0jjWymXRVWgwCqHDUSHMQ5DbA
         0MwBOAm8HoXAnJBQDW8ZZmQIk/BE8mbhXAXTLHrHmMDTV+azgOLlr6skqTsnHIdlkuBh
         Pr2iEj3SYi6zDA17kbYEBSQnfnmxWVMtSTZlPz/ybi29gd0Qk6tVmsf/V+GfCA1nt1o2
         sq9/IzA7Q+/X2w3sO6DRg6tIWpeASZeJ+tydRhLz7T72DzMd+MvzneUpCKoHAq+cRdN3
         nK6sEpX7rZALgAP/ss4kN1L2wlnM6nQDdSxjysXLVYsqqasmr121UArfXpfGrPBggiRN
         bBjA==
X-Gm-Message-State: AOAM533BHmwlNlLvVmJcQvKE95DfOUl6B+Kg5zwiGWGE+JXE+t3mRB4/
        TrB3rQ7n07FYs1F118f9PJddZBg8xMk=
X-Google-Smtp-Source: ABdhPJwwjVrOSa+P1uEHpNjmDekD3hSLDwU2UhCbJmfSKNe+hsaeKMr7cUpa4nKUC9oaodZfj1o2hQ==
X-Received: by 2002:a62:6042:0:b029:3e0:86b4:51b with SMTP id u63-20020a6260420000b02903e086b4051bmr6349404pfb.62.1628932878223;
        Sat, 14 Aug 2021 02:21:18 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-93.three.co.id. [180.214.233.93])
        by smtp.gmail.com with ESMTPSA id c23sm6005371pgb.74.2021.08.14.02.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 02:21:17 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     git@matthieu-moy.fr, tom.russello@grenoble-inp.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] send-email: Describe 'ssl' and 'tls' in --smtp-encryption
Date:   Sat, 14 Aug 2021 16:20:36 +0700
Message-Id: <20210814092035.42272-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --smtp-encryption option accepts either 'ssl' or 'tls' value to
enable TLS connection. The latter can cause confusion (for example [1]),
because it means using STARTTLS, whereas users wanting SMTPS should set
to the former instead.

Describe these values, together with difference between SMTPS and
STARTTLS.

[1]:
https://lore.kernel.org/git/f7ee6a03-74f2-152e-5158-4103c744595a@benaaron.dev/T/#t

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/git-send-email.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3db4eab4ba..1207a6a8eb 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -176,8 +176,12 @@ Sending
 	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH.
 
 --smtp-encryption=<encryption>::
-	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
-	value reverts to plain SMTP.  Default is the value of
+	Specify the encryption to use, either 'ssl' (SMTPS or implicit
+	TLS) or 'tls' (STARTTLS or Opportunistic TLS). Any other value
+	reverts to plain SMTP. The difference between SMTPS and STARTTLS
+	is SMTPS uses encrypted connection from beginning of connection,
+	whereas in STARTTLS the existing connection is upgraded to use TLS
+	if SMTP server supports it. Default is the value of
 	`sendemail.smtpEncryption`.
 
 --smtp-domain=<FQDN>::

base-commit: 5d213e46bb7b880238ff5ea3914e940a50ae9369
-- 
2.25.1

