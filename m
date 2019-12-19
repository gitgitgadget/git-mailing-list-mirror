Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452EAC2D0C1
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159D224680
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWEoi0sQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfLSWVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:21:48 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38820 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfLSWVn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:21:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so4078235pfc.5
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 14:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x2mUy2uXMcc2KMq6HG3rtk0SZXxq/MwIutBy33gHbX0=;
        b=YWEoi0sQ9wp3I5J7LOixShziX+k9ducn4oC45w74JLU2zGImkzIYl+j2T4R9JhSI6I
         kbhvf/lxpkGO2yau35IR7h9T4dkwYS9ojI/YsqxlMopmMS5yKVSIgTGXHCA7dGfm/ooF
         48B0lecWRXopX/zigVfatq6BrqPPLrHweHORC1Rhrylecm7BjmwR6ke6fS66P1gr47bD
         zQfsAIrdw/uhIeFtpNldqsPV+KrI5XKPenmsajwFZVsefjcq/ObcRg0L3Gs4/Ggys/Ml
         0FkcJtlrE5naiPEpKevERrg4kGDp/R1XKysJ1md6/IFBgfa01TaD9oIjPTU0PdjfvEaY
         WqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x2mUy2uXMcc2KMq6HG3rtk0SZXxq/MwIutBy33gHbX0=;
        b=RTt5c2QpCBroJhOUY1WNOk+QyOZPJeE6BKUUd/xfkqBZa+RxaJK7p5zBRquauhG6Cz
         QPvWEsb1lXGYbAagIkafSTPCKKGME53TZjp3y48eODk81IKC4s02bbLK/xmhldX57VwQ
         pnk0RV7wziE06SV5R1hAPF5DrinyG6x7fVz6EVe4rOn674d6AcVs8JOj6GbXh1sOQHDA
         KS665Eq2i3wzDY0oj8JIjlkA3LgA75HFoGip1XjRPt4C0DPSct44q+A8Tcb1oJR5pbmu
         EBjTZNxYhuYFZdvfNqq2ghWrLJ7MjrpNhLiosaPoyEFc6r+8F0ArIGApP8v/U6nVJQQh
         7FOw==
X-Gm-Message-State: APjAAAWXKfBmLV4oYK2Pdo/uXT1Oh6xuaROUxfPvwEUVHZ44BiUthFyS
        FVZH6IVbr3PLolOidTEivU7PBelt
X-Google-Smtp-Source: APXvYqw3UtplD9cX/l9QZvzTsAsnMETQ1MBClwHG5YjgA5nxcGAY5m+Y1H1DZDOGzx2+25AeaM9/+Q==
X-Received: by 2002:aa7:9d87:: with SMTP id f7mr12181115pfq.138.1576794103091;
        Thu, 19 Dec 2019 14:21:43 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id o19sm11428528pjr.2.2019.12.19.14.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 14:21:42 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/16] t1306: convert `test_might_fail rm` to `rm -f`
Date:   Thu, 19 Dec 2019 14:22:44 -0800
Message-Id: <c19f6344a4f76ec00c88581c1f05f4f48baaea39.1576794144.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576794144.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com> <cover.1576794144.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail() family of functions (including test_might_fail())
should only be used on git commands. Replace `test_might_fail rm` with
`rm -f` so that we don't use `test_might_fail` on a non-git command.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1306-xdg-files.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 21e139a313..dd87b43be1 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -153,7 +153,7 @@ test_expect_success 'Checking attributes in both XDG and local attributes files'
 
 
 test_expect_success 'Checking attributes in a non-XDG global attributes file' '
-	test_might_fail rm .gitattributes &&
+	rm -f .gitattributes &&
 	echo "f attr_f=test" >"$HOME"/my_gitattributes &&
 	git config core.attributesfile "$HOME"/my_gitattributes &&
 	echo "f: attr_f: test" >expected &&
@@ -165,7 +165,7 @@ test_expect_success 'Checking attributes in a non-XDG global attributes file' '
 test_expect_success 'write: xdg file exists and ~/.gitconfig doesn'\''t' '
 	mkdir -p "$HOME"/.config/git &&
 	>"$HOME"/.config/git/config &&
-	test_might_fail rm "$HOME"/.gitconfig &&
+	rm -f "$HOME"/.gitconfig &&
 	git config --global user.name "write_config" &&
 	echo "[user]" >expected &&
 	echo "	name = write_config" >>expected &&
@@ -183,8 +183,8 @@ test_expect_success 'write: xdg file exists and ~/.gitconfig exists' '
 
 
 test_expect_success 'write: ~/.config/git/ exists and config file doesn'\''t' '
-	test_might_fail rm "$HOME"/.gitconfig &&
-	test_might_fail rm "$HOME"/.config/git/config &&
+	rm -f "$HOME"/.gitconfig &&
+	rm -f "$HOME"/.config/git/config &&
 	git config --global user.name "write_gitconfig" &&
 	echo "[user]" >expected &&
 	echo "	name = write_gitconfig" >>expected &&
-- 
2.24.1.703.g2f499f1283

