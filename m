Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE98C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA1C611EE
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbhKFVNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbhKFVNq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:13:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16100C061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:11:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u18so19513837wrg.5
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mqRMt6KaGEScXIBjp+/xKo1c8g5Yjh+NMPSRiI+phhw=;
        b=nXRYLzV7CaDo9hlAtjNuD8DOBiYrfNCciq69Djz42RyJxvujEYHRxboDZC8dZvGopJ
         nt1envDw0m3pc6bH9Wb8snRvuQ216a061sZObNlVd+QT67ewhFKuT0ByRMToMyho6yBU
         zTWz+9aD2JWdVYWxU2RM173EAgrsSSNgmp4mtGRDFIxIVW54cd/lvE0MmWwSF0mWgG0X
         ARRI290M8YjBYXuKG71eXTRawxHwHVN6Zv4CP5KSoI+Q5KVForH00IJrbqwoNsLXHRDb
         FVLk6yWlWRTnM7lJlFCZj2SLAjyU31fszDoneprdSf74732WW5tDf1okKRg23cp09aO+
         WVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mqRMt6KaGEScXIBjp+/xKo1c8g5Yjh+NMPSRiI+phhw=;
        b=lNv7+BDplH+iVqDxoQCeA+1xmA8thdRJcdsZNHsxLztll7BzXXXKmR5G3Wy6rqIy6N
         TGznAE0J7sl2GBjnH9EZLEgt17yAqt+Mw0FbnPOaF9RjyGRnmVopNFgo9VT5L+7t88/p
         fIPWUiwRqxY+YtinUnNrVRlACh46ewI8RfBSpXRu8oQKxdvTnGs3thG5Fymy/yyi46np
         7a4lL3S4BJsnpf6THEPgkUcomav9OO5DEEjT3prgy9NdawfXsLGm7M9NO7LFptuNpZem
         64W34hwCEdLvDbk/Te9R+AH96Bl/qAA+FB59DjeMBJnN+TfjUeseXh38Xwkl8yVQKlJr
         rb9w==
X-Gm-Message-State: AOAM5332ArdPU8lTUAMxJj+EuXoVaqlwYNfnGiKP5FIv8BAg9qfF790s
        14dvwnrtyn+XexDpbDW2/p8Inqg8ulWFBg==
X-Google-Smtp-Source: ABdhPJxq4JPB+JXSxlWtj9XDa1kJJ8vASFEqOMU9ajGuWqoKUPWohQa163iRBlKCzbnF1MRXTXbaPw==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr44020254wrl.24.1636233063469;
        Sat, 06 Nov 2021 14:11:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4sm9123051wmq.31.2021.11.06.14.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:11:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/8] log tests: check if grep_config() is called by "log"-like cmds
Date:   Sat,  6 Nov 2021 22:10:51 +0100
Message-Id: <patch-5.8-ba9be0b9283-20211106T210711Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the tests added in my 9df46763ef1 (log: add exhaustive tests
for pattern style options & config, 2017-05-20) to check not only
whether "git log" handles "grep.patternType", but also "git show"
etc.

It's sufficient to check whether a PCRE regex matches for the purposes
of this test, we otherwise assume that it's running the same code as
"git log", whose behavior is tested more exhaustively by test added in
9df46763ef1e.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4202-log.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 7884e3d46b3..a114c49ef27 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -449,6 +449,22 @@ test_expect_success !FAIL_PREREQS 'log with various grep.patternType configurati
 	)
 '
 
+for cmd in show whatchanged reflog format-patch
+do
+	myarg=
+	if test "$cmd" = "format-patch"
+	then
+		myarg="HEAD~.."
+	fi
+
+	test_expect_success PCRE "$cmd: understands grep.patternType=perl, like 'log'" '
+		git -c grep.patternType=fixed -C pattern-type $cmd --grep="1(?=\|2)" $myarg >actual &&
+		test_must_be_empty actual &&
+		git -c grep.patternType=perl -C pattern-type $cmd --grep="1(?=\|2)" $myarg >actual &&
+		test_file_not_empty actual
+	'
+done
+
 test_expect_success 'log --author' '
 	cat >expect <<-\EOF &&
 	Author: <BOLD;RED>A U<RESET> Thor <author@example.com>
-- 
2.34.0.rc1.741.gab7bfd97031

