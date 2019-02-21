Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 711C11F453
	for <e@80x24.org>; Thu, 21 Feb 2019 23:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfBUXuP (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 18:50:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54953 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfBUXuO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 18:50:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so325155wmh.4
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 15:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=N1OZFfRhuB0PuqHD9P97aSJay2E6/hc2QHYtsdRW3Ls=;
        b=SYblRq56cfnj6C0/RgTEfiMssdxJsBxqDgW/Zvj52n8/Mp27QHOj/RLivX9zS0+h3q
         QwsOJbfRXHayDWar4b9adZ2kcaDySnXH1MTntx5htq9CL0oE29qo+hzxfbWbQzpjPcrJ
         soF73c5bC5CijFUhBsBbHwGOjrmQfzz+ZLcI8SLnBeuJz9vwNIR3llJYUGBtXEtMkCQL
         1uAwQPu/PcYe9qbHE5cc4+MTfTDplMNZlO/SUDiq4jwJbatU1aZIfRz1+wIit0Bks01Z
         KjaSif6r88pOOIgUcY7GiLkUekWv3t0GQgmayLl2mevmq6Am1VAa2V2u4uvEv4NVHbul
         iryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=N1OZFfRhuB0PuqHD9P97aSJay2E6/hc2QHYtsdRW3Ls=;
        b=M5b81F0WGUfyB6sgWyrjx6C7ETH4lXzUpowIdh+aC+DfA8Mu2FaUjbYDVRmp/bQyfp
         uHx4RcZmAwpIXM7BwPK9DDO4d/dWIf/kxPcEwfxCV6Hn78sjSfzJIaNQR3qCJOJb8alZ
         PYdRr4vLs7bBbkvh4J5dx9Tnj8uv2GiAivigI0fX/gN20I9E7Cx+TiajrMF1kuzq7gc3
         1KscwEhQszckdmY8Weo/GxRRClqPhYKmleT672gXkl8Qs9jRzidSUpvm6bMFXEvEPUwc
         aaXbfzI0fNCEWp9fWM+OEZTzGDAtZo0io5oOEK6UDpBEUIbfQ+9JY3rjVzXf0tt1dEEP
         X4wA==
X-Gm-Message-State: AHQUAuaQsXNckbdredCpDpq9j8ujCMWjtwTVCML7y2hsoc/GcDVWPPWF
        zOon/Fy6EF9QgdRDFuEEdj4WBnyO
X-Google-Smtp-Source: AHgI3IYQ0CWUcntBiP2ZtuPEf9/DUD4YAzIbYDZqB9THhfC5SLY0Zzi59HJ3+sydlzx7v5JZtRBcsA==
X-Received: by 2002:a1c:2d42:: with SMTP id t63mr597818wmt.9.1550793011913;
        Thu, 21 Feb 2019 15:50:11 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h142sm514791wme.33.2019.02.21.15.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 15:50:11 -0800 (PST)
From:   Junio C Hamano <junio@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] format-patch: notice failure to open cover letter for writing
Date:   Thu, 21 Feb 2019 15:50:11 -0800
Message-ID: <xmqqlg28snv0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The make_cover_letter() function is supposed to open a new file for
writing, and let the caller write into it via FILE *rev->diffopt.file
but because the function does not return anything, the caller does not
bother checking the return value.

Make sure it dies, instead of keep going with a NULL output
filestream and relying on it to cause a crash.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c           | 2 +-
 t/t4014-format-patch.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 3e145fe502..43fc9a07df 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1047,7 +1047,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 
 	if (!use_stdout &&
 	    open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
-		return;
+		die(_("Failed to create cover-letter file"));
 
 	log_write_email_headers(rev, head, &pp.after_subject, &need_8bit_cte, 0);
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 909c743c13..b6e2fdbc44 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -589,6 +589,12 @@ test_expect_success 'excessive subject' '
 	ls patches/0004-This-is-an-excessively-long-subject-line-for-a-messa.patch
 '
 
+test_expect_success 'failure to write cover-letter aborts gracefully' '
+	test_when_finished "rmdir 0000-cover-letter.patch" &&
+	mkdir 0000-cover-letter.patch &&
+	test_must_fail git format-patch --no-renames --cover-letter -1
+'
+
 test_expect_success 'cover-letter inherits diff options' '
 	git mv file foo &&
 	git commit -m foo &&
