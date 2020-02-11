Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9A4C3B187
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 18:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C452168B
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 18:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3YHPO6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbgBKS6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:58:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45558 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730696AbgBKS6J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 13:58:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id g3so12715376wrs.12
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 10:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RsZglsNnw4Dxu30zclNRqvtGtTwNRbIm2GiByo9/2uU=;
        b=J3YHPO6KilYgg5cI+4lInW2cHkJ7u1jWQvJX9gGhBCkHy8AN/l3rsdk8S2JH6TdUV5
         d5+PcrOXUpgZSJUXcIAHst6wcz1SPS4nXMLXUQDTL0K7sBsv7mJwEeNB5pNfhtfEMpFF
         dciwr8JO6fYDxKyDS/GGOIz+25b/DWULr36KKWfplafKjYKtM3YXlvhKQDRQa5wkut74
         GqbHTW52zNOAndlDgiDiK4EzxiH+hG0v657a+PKheE3lEf5nNVPuvTyvOPnd6QpjT9xx
         IM9ZHyrMXTJca21jJDSE7DxXFVeHyTliSJBfrHF4NXNJc+JiXWRYFdqSPxIUHlaFRrPu
         pVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RsZglsNnw4Dxu30zclNRqvtGtTwNRbIm2GiByo9/2uU=;
        b=smLC+ULhRNe9mNqXdaXHKJyfjvfAUCIPdHdLbdFDanDGUN4wuhUD8X0FB0Pav5KQVl
         +Htg9s9e7VXHsV9YXS1SeOwzczkV1EGcqePCXYSN3L8uSmoiyH2f9ESabdCcUHKNa5s9
         ZYfznF4jIlBnKyW/W0IdB+rvyJlxeW63kp0ntYC55DGuqWVfFA8vosH0oISRyU2OIfsV
         5S5TLa4XaPW4dTgcohSHZhFqjwzflMiBxPhoQIFQUrob039peJo6W0N/VWTEPARXaHtq
         ERZBefiohz9aRd+wNTrHntn/X2T1fgOw2pbSrBM6rS9lBfpnsgcKaHtqv9eaaoxXfZZt
         KFng==
X-Gm-Message-State: APjAAAXvq2NuIMa6XF6M+nQj7IUd11efxvCH5qEdY+zSx5IKp+wsvn0v
        gAsCk2Hwm0ApQ3mrSheThxGD+Byf
X-Google-Smtp-Source: APXvYqyQLgSHITmf9kZC4F+kOXeNBtWkBLlwLr4R1BEiOY/XuZmF2YvC/PTQ41+LijkeFRiBW5BEPA==
X-Received: by 2002:adf:d850:: with SMTP id k16mr9796724wrl.216.1581447487104;
        Tue, 11 Feb 2020 10:58:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6sm6516160wrm.69.2020.02.11.10.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 10:58:06 -0800 (PST)
Message-Id: <71c51ccfb0c53fdac67ba35d474c51a9da0c28e0.1581447484.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
References: <pull.698.v4.git.git.1581372376.gitgitgadget@gmail.com>
        <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Feb 2020 18:57:58 +0000
Subject: [PATCH v5 1/7] git-p4: rewrite prompt to be Windows compatible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

The existing function prompt(prompt_text) does not work correctly when
run on Windows 10 bash terminal when launched from the sourcetree
GUI application. The stdout is not flushed properly so the prompt text
is not displayed to the user until the next flush of stdout, which is
quite confusing.

Change this method by:
* Adding flush to stderr, stdout, and stdin
* Use readline from sys.stdin instead of raw_input.

The existing strip().lower() are retained.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 40d9e7c594..65b6d4dca0 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -175,7 +175,10 @@ def prompt(prompt_text):
     """
     choices = set(m.group(1) for m in re.finditer(r"\[(.)\]", prompt_text))
     while True:
-        response = raw_input(prompt_text).strip().lower()
+        sys.stderr.flush()
+        sys.stdout.write(prompt_text)
+        sys.stdout.flush()
+        response=sys.stdin.readline().strip().lower()
         if not response:
             continue
         response = response[0]
-- 
gitgitgadget

