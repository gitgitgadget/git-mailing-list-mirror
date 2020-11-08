Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04435C56201
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C0B206F4
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbI4ZzK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgKHVli (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbgKHVlf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:35 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F62C0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:34 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id s9so6094399ljo.11
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iPZBgNe/CnnTJLkmODqda//1HtZVycy3DAT/Qha+4cE=;
        b=vbI4ZzK2+TBkoJcMebIrv2BbalV92yP2AzMIiMqHf1/3pHAmLj048+4w+ZM+X4uj+O
         7RTjQqvIbRDqas6c+il2GIQpXfKHITgUmqaMItfpqnxNa+JJgACqVRDkXbCfoWNLv5M7
         bzqsKaZp9aSDLly0FA1Wo+jNP+9CVsAV1D4o4+oJKPK9d8AZR/iiCTI28da2+9/ew9ZU
         89I7ImOp9nNMu/W7BfWWt2R1bPPn7zEJLWWHWSTfAYQJz1aZ7G3gHWUtXMYDb3CHPxkD
         JFY0+qs+mZ2/zXrs/95dizYBs/CdRFsR2PKaN7mXwle0denmGaZ1Iva7Ibl7RTBOi+i/
         KwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iPZBgNe/CnnTJLkmODqda//1HtZVycy3DAT/Qha+4cE=;
        b=CflqOZ3H1OcEOcxu9fRjELnchnXmJdJjM+qkM+nwQeM4iAuVpMpQpKPsnB9eMnnEUg
         23OyOaUCbH1L3yEICCplamc4VTadTy17MlhWE7kOo9T/MHU3CitcWsTTkkKy2PlOqxb+
         g5bMsXZwsRlFW+ox6R2CAlRXK3M194AH44KwMtKLsjSw0fdFaMzGgsc4dKE9LSTxHF9W
         8BCf9Y48Uojb8Okz8qIWQ71m0cAm7bJS8OfEGwfVrld2kbpRjm1QjF47Tx9SxP2NRFza
         W6Cydv/gm6uR0UIDV0B/H2SW3n17bx0tKlB8FAVdqQ/OwOEXavJLqTuUihKi6Susvlaj
         dOFA==
X-Gm-Message-State: AOAM531Jmtd3OLbB8H83pFCZSFWbPFaubDhSRY7eDoLwP/whPv2Ca/5k
        8vwMngL0Nss+t6tWvATGzLw=
X-Google-Smtp-Source: ABdhPJxl9g+OvGtrJx+cgtBxzv9Z6g8TVclBCsxxequgV72kogBebaXHuHkh/JHuqoH6W/AMOCnhmg==
X-Received: by 2002:a05:651c:1b7:: with SMTP id c23mr1410083ljn.112.1604871693250;
        Sun, 08 Nov 2020 13:41:33 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:32 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 14/27] t4013: support test_expect_failure through ':failure' magic
Date:   Mon,  9 Nov 2020 00:38:25 +0300
Message-Id: <20201108213838.4880-15-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support to be able to specify expected failure, through :failure
magic, like this:

:failure cmd args

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5c7b0122b4f1..935d10ac0572 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -174,6 +174,7 @@ process_diffs () {
 V=$(git version | sed -e 's/^git version //' -e 's/\./\\./g')
 while read magic cmd
 do
+	status=success
 	case "$magic" in
 	'' | '#'*)
 		continue ;;
@@ -182,6 +183,10 @@ do
 		label="$magic-$cmd"
 		case "$magic" in
 		noellipses) ;;
+		failure)
+			status=failure
+			magic=
+			label="$cmd" ;;
 		*)
 			BUG "unknown magic $magic" ;;
 		esac ;;
@@ -194,7 +199,7 @@ do
 	expect="$TEST_DIRECTORY/t4013/diff.$test"
 	actual="$pfx-diff.$test"
 
-	test_expect_success "git $cmd # magic is ${magic:-(not used)}" '
+	test_expect_$status "git $cmd # magic is ${magic:-(not used)}" '
 		{
 			echo "$ git $cmd"
 			case "$magic" in
-- 
2.25.1

