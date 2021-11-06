Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31537C433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168DD61027
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhKFVtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbhKFVtt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:49:49 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF765C061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:47:07 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso871479wml.1
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i1ZKUWt+wGRF1lLN/HSVRlRSIyoxrnicq7H4+Bm75O4=;
        b=aWoNl8PG0tXagEqfBZSihdRkG4FolxRKXou7ypIOeJdlOrbCWCak5gjp05QpeHSD+d
         6R6Hybm0USfr0HmgqthC4Uh7NHa0sCtDgVr7aTeMS1AYJyNg8w6slNjWP4UGcegWgXb0
         rXtVCjiD8GOyGTclhIfH9CFpHlPtf2dRtG6gB3hZmAaQ2GqqEW3dIFNSg8B02REs9Fc8
         65PUvfq3FB9dJFAksIhn0yhPRh+l8nA4/XKP3akUfIdWPfVWo27N4IGiivwd573saGU6
         t68m54I6UHSFufVu94SQk3ENyKTinhTwuG0PD3pV82X7uHpjpaF3IX4KZT3vst+nMCh9
         Zr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i1ZKUWt+wGRF1lLN/HSVRlRSIyoxrnicq7H4+Bm75O4=;
        b=5cKKXHDtAWFflExyYqXLpKZ1bEgnPXpA1hvurVV5h6n7GDkIw9CrA2q3w41m3I6Io5
         TPVF9Qwx1QQh8g9c0xIcVm8ioQLzwZXGvBwAmDXPMipyvY11CscQ/dxhmSMzTsGUazwE
         CCfTH1PyK92rRA/1kYOlvUO5C8OHWQEafuo+SwSXGQJ0ClmeJf9XYNE9lom4aSGSYC/a
         2j9zT0H3NthzjX+2T2a+JvY3pKvIdUkb9HkeCiFGOn/kJp1NauQnBtpyjL+mLf/qdMkn
         jOLfRqKrJ6y1Q/tutGmoxnqsnyGlTHY4z0r83OBplB1Vp/mnUGDJtS2/mNbf0HwG8D63
         4LUA==
X-Gm-Message-State: AOAM530ezpEC5PCApJb22+K89CvitQnDboTMenXDGmfy82Qu57oUe7DR
        wtQ8C82hLJRC4bnGWkOPKBijhuF0n3Lv/g==
X-Google-Smtp-Source: ABdhPJxFJrwjKSmFHxallJkV6sAGlLkfOVwd/hoiQ2poJtJEdXxYElSOyZIniEV1qca7yVzYOytuHQ==
X-Received: by 2002:a7b:c109:: with SMTP id w9mr40902881wmi.114.1636235226242;
        Sat, 06 Nov 2021 14:47:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f19sm12736630wmq.34.2021.11.06.14.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:47:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/10] cat-file tests: test messaging on bad objects/paths
Date:   Sat,  6 Nov 2021 22:46:54 +0100
Message-Id: <patch-02.10-a473185eb97-20211106T214259Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
References: <xmqqlf33i36a.fsf@gitster.g> <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for the output that's emitted when we disambiguate
<obj>:<path> in cat-file. This gives us a baseline for improving these
messages.

For e.g. "git blame" we'll emit:

    $ git blame HEAD:foo
    fatal: no such path 'HEAD:foo' in HEAD

But cat-file doesn't disambiguate these two cases, and just gives the
rather unhelpful:

    $ git cat-file --textconv HEAD:foo
    fatal: Not a valid object name HEAD:foo

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t8007-cat-file-textconv.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.sh
index eacd49ade63..45471cefe73 100755
--- a/t/t8007-cat-file-textconv.sh
+++ b/t/t8007-cat-file-textconv.sh
@@ -19,6 +19,32 @@ test_expect_success 'setup ' '
 	GIT_AUTHOR_NAME=Number2 git commit -a -m Second --date="2010-01-01 20:00:00"
 '
 
+test_expect_success 'usage' '
+	cat >expect <<-\EOF &&
+	fatal: Not a valid object name HEAD2
+	EOF
+	test_must_fail git cat-file --textconv HEAD2 2>actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	fatal: Not a valid object name HEAD2:two.bin
+	EOF
+	test_must_fail git cat-file --textconv HEAD2:two.bin 2>actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	fatal: git cat-file --textconv HEAD: <object> must be <sha1:path>
+	EOF
+	test_must_fail git cat-file --textconv HEAD 2>actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	fatal: Not a valid object name HEAD:two.bin
+	EOF
+	test_must_fail git cat-file --textconv HEAD:two.bin 2>actual &&
+	test_cmp expect actual
+'
+
 cat >expected <<EOF
 bin: test version 2
 EOF
-- 
2.34.0.rc1.741.gab7bfd97031

